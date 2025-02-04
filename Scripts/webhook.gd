extends Node

@onready var http: HTTPRequest = $HTTPRequest

func SendPayload():
	var embeds = [
		{
			"title": "GrowJournal Summary!",
			"description": """
			World Locks: %s
			Diamond Locks: %s
			
			Gems: %s
			""" % [Global.data["wl"], Global.data["dl"], Global.data["gems"]],
			"color": 16239871
		}
	]
	
	var payload = {
		"embeds": embeds,
		"username": "GrowJournal"
	}
		
	var json_payload = JSON.stringify(payload)
	var error = http.request(
		Global.webhook_data["url"],
		["Content-Type: application/json"],
		HTTPClient.Method.METHOD_POST,
		json_payload
	)
	
	if error != OK:
		print("Failed to complete http request")



func _on_http_request_request_completed(result, _response_code, _headers, _body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Failed to send request")
		return
