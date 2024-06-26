import requests

url = "https://www.googleapis.com/calendar/v3/users/me/calendarList"

payload = {}
headers = {
  'Authorization':
'Bearer ya29.a0AXooCgsJN8VHudimW_oSEwTju1T3zPULYvfV3rJBYQHqZu_wMiBi3nDQ0ID1awf4aJ1wzpUhN07Biu_Njz_nbUsabKdvs5eO1Xq6sacWGYoudsvX_Q_7wIRR_9lcFOe-Ops2KGoAgP7ltlLcLsOMB18swhF0M4QeoyWJaCgYKAWASARMSFQHGX2MiQbDZO-66VI6CkTC7h60nPw0171'
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)
