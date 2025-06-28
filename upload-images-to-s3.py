import boto3

s3 = boto3.resource('s3')

# Get list of objects for indexing
images=[('image_01.jpg','Virat Kohli'),
      ('image_02.jpg','Virat Kohli'),
      ('image_03.jpg','Virat Kohli'),
      ('image_04.jpg','Virat Kohli'),
      ('image_05.jpg','Mahendra singh dhoni'),
      ('image_06.jpg','Mahendra singh dhoni'),
      ('image_07.jpg','Mahendra singh dhoni'),
      ('image_08.jpg','Mahendra singh dhoni'),
      ('image_09.jpg','Rohit sharma'),
      ('image_10.jpg','Rohit sharma'),
      ('image_11.jpg','Rohit sharma'),
      ('image_12.jpg','Rohit sharma'),
      ('image_13.jpg','Ben stokes'),
      ('image_14.jpg','Ben stokes'),
      ('image_15.jpg','Ben stokes'),
      ('image_16.jpg','Kane Williamson'),
      ('image_17.jpg','Jos Buttler'),
      ('image_18.jpg','Ravindra Jadeja'),
      ('image_19.jpg','Yashasvi Jaiswal'),
      ('image_20.jpg','Yashasvi Jaiswal'),
      ('image_21.jpg','Stephen Curry'),
      ('image_22.jpg','Stephen Curry'),
      ('image_23.jpg','Stephen Curry'),
      ('image_24.jpg','Stephen Curry'),
      ('image_25.jpg','Stephen Curry'),
      ('image_26.jpg','Stephen Curry'),
      ('image_27.jpg','Virat Kohli'),
      ('image_28.jpg','Virat Kohli'),
      ('image_29.jpg','Virat Kohli'),
      ('image_30.jpg','Virat Kohli'),
      ('image_31.jpg','Virat Kohli'),
      ('image_32.jpg','Cristiano Ronaldo'),
      ('image_33.jpg','Cristiano Ronaldo'),
      ('image_34.jpg','Cristiano Ronaldo'),
      ('image_35.jpg','Cristiano Ronaldo'),
      ('image_36.jpg','Cristiano Ronaldo'),
      ]

# Iterate through list to upload objects to S3   
for image in images:
    file = open(image[0],'rb')
    object = s3.Object('face-rekognition-source-bucket','index/'+ image[0])
    ret = object.put(Body=file,
                    Metadata={'FullName':image[1]})