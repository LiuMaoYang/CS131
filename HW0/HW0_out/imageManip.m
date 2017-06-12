%reads in the image, converts it to grayscale, and converts the intensities
%from uint8 integers to doubles. (Brightness must be in 'double' format for
%computations, or else MATLAB will do integer math, which we don't want.)
%uint8-->(0,255), double-->(0,1)
clear
close all
clc

dark = double(rgb2gray(imread('u2dark.png')));
[r,c]=size(dark);
figure;imshow(dark);

%%%%%% Your part (a) code here: calculate statistics
averageValue=mean(mean(dark));
minValue=min(min(dark));
maxValue=max(max(dark));

%%%%%% Your part (b) code here: apply offset and scaling
% fixedimg = dark;
% thre=[0 255];
% t=thre(2)-thre(1);
% diffValue=maxValue-minValue;
% for i=1:r
%     for j=1:c
%         fixedimg(i,j)=fixedimg(i,j)*(fixedimg(i,j)-minValue)*t/diffValue/maxValue;
%     end
% end
offset=repmat(-minValue,size(dark));
factor=255/(maxValue-minValue);
fixedimg=(offset+dark)*factor;
fixedimg=uint8(fixedimg);
%displays the image
figure;imshow(fixedimg);

%%%%%% Your part (c) code here: apply the formula to increase contrast,
% and display the image
contrasted = 2*(dark-128)+128;
contrasted=uint8(contrasted);

figure;imshow(contrasted)
