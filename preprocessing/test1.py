#!usr/bin/python3
# TODO:
#       1. Add this to end of edge detection, for auto crop
#       2. Zoom the image for precise crop, for manual crop
#       3. Zoom all the cropped images to a predefined size
#       4. Write back the cropped image to a new file

import cv2
import numpy as np

cropping = False

x_1, y_1, x_2, y_2 = 0, 0, 0, 0

image = cv2.imread('1.JPG')
orig = image.copy()

def m_crop(event, x, y, flags, param):
    # Grab references to the global variables
    global x_1, y_1, x_2, y_2, cropping

    # If left mouse button was pressed, start recording (x,y) coordinates
    if event == cv2.EVENT_LBUTTONDOWN:
        x_1, y_1, x_2, y_2 = x, y, x, y
        cropping = True

    # mouse is moving
    elif event == cv2.EVENT_MOUSEMOVE:
        if cropping == True:
            x_2, y_2 = x, y

    # If mouse button was released
    elif event == cv2.EVENT_LBUTTONUP:
        # Record the end coordinates, and finish cropping
        x_2, y_2 = x, y
        cropping = False

        refPoint = [(x_1, y_1), (x_2, y_2)]

        if len(refPoint) == 2:
            roi = orig[refPoint[0][1]:refPoint[1][1], refPoint[0][0]: refPoint[1][0]]
            cv2.imshow("Cropped", roi)

cv2.namedWindow("image")
cv2.setMouseCallback("image", m_crop)

while True:
    i = image.copy()

    if not cropping:
        cv2.imshow("image", image)

    elif cropping:
        cv2.rectangle(i, (x_1, y_1), (x_2, y_2), (255, 0, 0),2)
        cv2.imshow("image", i)

    cv2.waitKey(1)

cv2.destroyAllWindows()
