extends Node

@onready var http: HTTPRequest = $HTTPRequest

func send_payload():
	var seeds = ""
	for seed_data in Global.data["seeds"]:
		seeds += "%s: %s seeds\n" % [seed_data["name"], seed_data["history"]]

	var embeds = [
		{
			"title": "GrowJournal Summary!",
			"description": """
			<:TLNwarning:1201665414560759859> Locks and Gems <:TLNwarning:1201665414560759859>
			%s <:WL:880251447470596157> %s <:DL:880251434380165130>
			%s <:gems:1089014830561759345>

			<:TLNwarning:1201665414560759859> Farmables <:TLNwarning:1201665414560759859>
			%s
			""" % [Global.data["wl"], Global.data["dl"], Global.data["gems"], seeds],
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



func on_request_completed(result, _response_code, _headers, _body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Failed to send request")
		return
