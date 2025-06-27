from flask import Flask, render_template, request
import boto3
import io
from PIL import Image
import json
import logging

app = Flask(__name__)

# Configure logging: both file and console
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s [%(levelname)s] %(message)s',
    handlers=[
        logging.FileHandler("flask-debug.log"),      # log file
        logging.StreamHandler()                      # console
    ]
)

# AWS Clients
rekognition = boto3.client('rekognition', region_name='us-east-1')
dynamodb = boto3.client('dynamodb', region_name='us-east-1')

# Constants (must match Lambda + DynamoDB config)
REKOGNITION_COLLECTION = 'face-rekognition-collection'
DYNAMODB_TABLE = 'Faceprints-Table'


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        try:
            image_file = request.files['image_path']
            if not image_file or not image_file.filename.lower().endswith(('jpg', 'jpeg', 'png')):
                logging.warning("Invalid file type uploaded.")
                return render_template('result.html', error="Invalid file type. Please upload a valid image.")

            # Read image into memory
            image = Image.open(image_file)
            stream = io.BytesIO()
            image.save(stream, format="JPEG")
            image_binary = stream.getvalue()

            # Call Rekognition
            logging.debug("Calling Rekognition with uploaded image...")
            response = rekognition.search_faces_by_image(
                CollectionId=REKOGNITION_COLLECTION,
                Image={'Bytes': image_binary},
                FaceMatchThreshold=85
            )

            logging.debug("Rekognition Response:\n%s", json.dumps(response, indent=2))

            face_matches = response.get('FaceMatches', [])
            if not face_matches:
                logging.info("No matching faces found.")
                return render_template('result.html', error="No matching faces found.")

            recognized_faces = []
            for match in face_matches:
                face_id = match['Face']['FaceId']
                logging.debug("Matched FaceId: %s", face_id)

                # Query DynamoDB with the FaceId
                db_response = dynamodb.get_item(
                    TableName=DYNAMODB_TABLE,
                    Key={'Rekognitionid': {'S': face_id}}
                )

                logging.debug("DynamoDB response:\n%s", json.dumps(db_response, indent=2))

                if 'Item' in db_response:
                    full_name = db_response['Item'].get('FullName', {}).get('S', 'Unknown')
                    recognized_faces.append(full_name)
                    logging.info("Recognized: %s", full_name)
                else:
                    logging.warning("FaceId %s not found in DynamoDB.", face_id)
                    recognized_faces.append(f"(FaceId: {face_id}, name not found)")

            return render_template('result.html', recognized_faces=recognized_faces)

        except Exception as e:
            logging.exception("Unhandled error during face recognition:")
            return render_template('result.html', error=f"An error occurred: {e}")

    return render_template('index.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=81, debug=True)
