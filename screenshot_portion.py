#!/usr/bin/python3
# This python script screenshots an exact portion of your screen defined by four pixels
from PIL import ImageGrab
import os
region = (752, 42, 1512, 1026) # Define the region to capture (left, top, right, bottom)
screenshot = ImageGrab.grab(bbox=region)
pg_num = 1
for x in range(pg_num, 400, 1):
    if os.path.isfile("{}.png".format(pg_num)):
        #print("file exists, incrementing counter")
        pg_num = pg_num + 1
    else:
        #print("taking the screenshot")
        screenshot.save("{}.png".format(pg_num))
        break
