clear all; close all; clc

niiFilename='C:\Users\Jacek\Documents\MATLAB\stanford\data\nl0011\rrun06_markerT1_15807_10_1.nii';

roast(niiFilename,{'Cz',1,'Oz',-1});