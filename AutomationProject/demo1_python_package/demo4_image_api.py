import requests

url = "https://petstore.swagger.io/v2/pet/5/uploadImage"

payload = {'additionalMetadata': 'image/jpg'}
files=[
  [
    'file',
   ('file',open("C:\\Users\\Balaji_Dinakaran\\Pictures\\demo.jpg",'rb'),'application/octet-stream')
   ]
]
headers = {}

response = requests.request("POST", url, headers=headers, data=payload, files=files)

print(response.text)
print(response.status_code)
