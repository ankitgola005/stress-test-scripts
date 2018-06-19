#!usr/bin/python3

# Import packages
import numpy as np
import argparse
import glob
import cv2

# Function definition
def auto_canny(image, sigma):
    # Compute median
    v = np.median(image)

    #Apply canny
    lower = int(max(0, (1.0 - sigma)*v))
    upper = int(min(255, (1.0 + sigma)*v))
    edged = cv2.Canny(image, lower, upper)

    # Return the edged image
    return edged

# Construct the argument parse and parser the args
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--images", required=True, help="path to input dataset of images")
args = vars(ap.parse_args())

# loop over images
for imagePath in glob.glob(args["images"] + "/*.JPG"):
    # Load image, convert to grayscale, blur slightly
    image = cv2.imread(imagePath)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (3,3), 0)

    # Apply canny with a wide, tight, and auto threshold
    wide = cv2.Canny(blurred, 10, 200)
    tight = cv2.Canny(blurred, 225, 250)
    auto = auto_canny(blurred, 0.33)

    # Display the images
    cv2.imshow("Original", image)
    cv2.imshow("Edges", np.hstack([wide, tight, auto]))
    cv2.waitKey(0)

