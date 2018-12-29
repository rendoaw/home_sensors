#!/usr/bin/env python

import Adafruit_DHT

sensor = Adafruit_DHT.DHT22
pin = 4
humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
temperature_f = temperature * 9/5.0 + 32

print str(temperature_f)+" "+str(humidity)
