import requests

url = "https://petstore.swagger.io/v2/pet/5"

payload = {}
headers = {}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)
print(response.json())
print(response.status_code)
print(response.url)
print(response.cookies)





