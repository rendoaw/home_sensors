#!/bin/bash

cd /home/pi/home_sensors
. venv/bin/activate
res=`./raspi_dht22_m2x.py`

temp_f=`echo ${res} | awk '{print$1}'`
humid=`echo ${res} | awk '{print$2}'`

key=`cat config.json | python -c 'import sys, json; print json.load(sys.stdin)["key"]'`
device_id=`cat config.json | python -c 'import sys, json; print json.load(sys.stdin)["device_id"]'`
temperature_id=`cat config.json | python -c 'import sys, json; print json.load(sys.stdin)["temperature_id"]'`
humidity_id=`cat config.json | python -c 'import sys, json; print json.load(sys.stdin)["humidity_id"]'`

curl -i -X PUT https://api-m2x.att.com/v2/devices/${device_id}/streams/${temperature_id}/value -H "X-M2X-KEY: ${key}" -H "Content-Type: application/json" -d "{ \"value\": \"${temp_f}\" }"
curl -i -X PUT https://api-m2x.att.com/v2/devices/${device_id}/streams/${humidity_id}/value -H "X-M2X-KEY: ${key}" -H "Content-Type: application/json" -d "{ \"value\": \"${humid}\" }"
echo $temp_f
echo $humid

