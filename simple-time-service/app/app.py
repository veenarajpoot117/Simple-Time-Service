from flask import Flask, jsonify, request, Response
from datetime import datetime
import json

app = Flask(__name__)

@app.route('/')
def get_time():
    # Get current time
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    # Get visitor's IP address
    visitor_ip = request.remote_addr
    response = {
        "timestamp": current_time,
        "ip": visitor_ip
    }
    # Use json.dumps to pretty-print the JSON response
    json_response = json.dumps(response, indent=4)
    
    # Return the response with the correct content type
    return Response(json_response, content_type='application/json')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)