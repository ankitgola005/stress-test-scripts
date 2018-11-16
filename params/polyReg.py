#!usr/bin/python3

# Libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import pylab
from argparse import ArgumentParser

poly = 0
order = 1
expo = 0
Tambient = 0

# Handle arguments
parser = ArgumentParser()
parser.add_argument("-p", "--poly", help = "Polynomial fit")
parser.add_argument("-e", "--exp", help = "Exponential fit")
parser.add_argument("-t", "--ambient", type=float, help = "Ambient temperature")
args = parser.parse_args()

if args.ambient:
    Tambient = args.ambient
if args.poly:
    poly = 1
if args.exp:
    expo = 1

# Function for polynomail regression
def polyReg(Frequency, Power, order):
    Z = np.polyfit(Frequency, Power, order)
    F = np.poly1d(Z)
    return F

# Function for exponential regression TODO
def expoReg(Frequency, Power):
    Z = np.polyfit(Frequency, np.log(Power), 1, w = np.sqrt(Power))
    # How to use Z as a function as done by polyfit
    return F

# Dataset
Frequency = np.array([200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400])
Pbaseline = np.array([63.1, 75.62, 85.56, 92.27, 112.20, 115.63, 125.20, 134.74, 143.29, 163.81, 176.38, 191.38, 200.14])
Pcpu = np.array([149.29, 245.54, 358.42, 484.86, 627.48, 775.89, 944.78, 1124.78, 1323.83, 1511.29, 1762.39, 1993.87, 2252.85])
Pflash = np.array([104.41, 144.55, 175.31, 247.56, 280.31, 332.26, 385.13, 443.16, 506.47, 582.09, 641.91, 678.67, 724.50])
Pram = np.array([116.27, 163.72, 203.08, 258.29, 308.64, 366.20, 422.44, 484.08, 551.81, 648.79, 722.77, 833.23, 909.29])

# For polynomial fit
if (poly):
    Fbaseline = polyReg(Frequency, Pbaseline, 3);
    Fcpu = polyReg(Frequency, Pcpu, 3);
    Fram = polyReg(Frequency, Pram, 3);
    Fflash = polyReg(Frequency, Pflash, 3);

# For exponential fit
if (expo):
    Fbaseline = expoReg(Frequency, Pbaseline);
    Fcpu = expoReg(Frequency, Pcpu);
    Fram = expoReg(Frequency, Pram);
    Fflash = expoReg(Frequency, Pflash);

# Show function
print("Function for baseline: \n", Fbaseline);
print("Function for CPU: \n", Fcpu);
print("Function for RAM: \n", Fram);
print("Function for Flash: \n", Fflash);

# Show results graphically
Fnew = np.linspace(0, 1500, 10)
Zbnew = Fbaseline(Fnew)
Zcnew = Fcpu(Fnew)
Zfnew = Fflash(Fnew)
Zrnew = Fram(Fnew)

# Plot the data points
plt.plot(Frequency, Pbaseline, '.')
plt.plot(Frequency, Pcpu, 'x')
plt.plot(Frequency, Pflash, 'o')
plt.plot(Frequency, Pram, '*')

# Plot the approximated function
plt.plot(Fnew, Zbnew, label='Baseline')
plt.plot(Fnew, Zcnew, label='CPU')
plt.plot(Fnew, Zfnew, label='Flash')
plt.plot(Fnew, Zrnew, label='RAM')

# Plot
title = "Frequenct vs Power at " + str(Tambient) + "C"
pylab.title(title)
plt.xlabel('Frequency')
plt.ylabel('Total Power')
legend = plt.legend(loc = 'best')
plt.show()
