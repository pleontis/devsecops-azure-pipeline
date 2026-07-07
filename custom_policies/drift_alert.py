import os
import urllib.request
import json
import sys

webhook_url = os.getenv("WEBHOOK_URL")

message = {
    "text": "*CRITICAL: Infrastructure Drift Detected!* \nSomeone has manually altered the Azure environment. The live cloud state no longer matches the secure Terraform configurations in GitHub. Please investigate immediately."
}

if webhook_url:
    req = urllib.request.Request(
        webhook_url, 
        data=json.dumps(message).encode('utf-8'), 
        headers={'Content-Type': 'application/json'}
    )
    try:
        urllib.request.urlopen(req)
        print("Security alert sent to team successfully.")
    except Exception as e:
        print(f"Failed to send alert: {e}")
        sys.exit(1)
else:
    print("SIMULATED ALERT: Infrastructure drift detected! (No webhook URL configured)")