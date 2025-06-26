import boto3
import json

def lambda_handler(event, context):
    # Initialize Rekognition client
    rekognition = boto3.client('rekognition')
    
    # Collection ID from event or fallback
    collection_id = event.get('collection_id', 'face-rekognition-collection')
    
    try:
        # First, check if collection already exists
        existing_collections = rekognition.list_collections()['CollectionIds']

        if collection_id in existing_collections:
            print(f"Collection {collection_id} already exists. Deleting it first.")
            rekognition.delete_collection(CollectionId=collection_id)
            print(f"Deleted existing collection {collection_id} successfully.")
        
        # Now create a new collection
        response = rekognition.create_collection(CollectionId=collection_id)

        collection_arn = response['CollectionArn']

        print(f"Created collection {collection_id} successfully.")
        return {
            "statusCode": 200,
            "body": json.dumps({ 
                "message": f"Collection {collection_id} recreated successfully.",
                "collection_id": collection_id,
                "collection_arn": collection_arn
            })
        }
    except Exception as e:
        print(f"Error recreating collection {collection_id}: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"message": f"Error recreating collection {collection_id}: {str(e)}"})
        }
