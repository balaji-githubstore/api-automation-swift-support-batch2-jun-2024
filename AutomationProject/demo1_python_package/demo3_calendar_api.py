import requests
import json
base_url="https://www.googleapis.com/calendar/v3/"
resource = "calendars/698096b0150422f922ec039519d1fbe457e2934df3c79afb79d7538e6248d9d8@group.calendar.google.com"

payload = json.dumps({
  "description": "through api patch"
})
headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ya29.a0AXooCgt-rcbbun5hfafkRASWRgARyuxQjvzsUsnIt4zczuHE_p_ILTN_D5qaUVOF4XBTaSD6zsQpxsqyofGMWSSaySp3eitUAmBLngLsOqyViecMvS69Fo3tKKEUvseMvih1r5NDU_V70OKBw_MuUhbfexxR1lL5gdBraCgYKAVISARMSFQHGX2MigUwA9jfeN-dEgDQaQvtEoQ0171'
}

response = requests.request("PATCH", base_url+resource, headers=headers, data=payload)

print(response.text)