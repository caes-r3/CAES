#!/usr/bin/env python3
import random
import json
from flask import Flask, Response

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/health', methods=['GET'])
def status():
    #state = random.choice(['online', 'error'])
    state = "online"
    rt = {
        "status": state
    }
    response = Response(json.dumps(rt),  mimetype='application/json')
    response.status_code = 200

    return response

app.run( host='0.0.0.0', port=30000)

