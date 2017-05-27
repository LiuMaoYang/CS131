clear
close all
clc

img=imread('lena.JPG');
img=rgb2gray(img);
F1=[0,0,0;0,1,0;0,0,0];
F2=[0,0,0;0,0,1;0,0,0];
F3=ones(3)/9;
F4=2*F1-F3;

F5=[1,0,-1;2,0,-2;1,0,-1];
F6=rot90(F5);

img0=imfilter(img,F5);
img1=imfilter(img,F5,'conv');
img00=imfilter(img,F6);
img11=imfilter(img,F6,'conv');
imshow(cat(2,img,img0+img00,img1+img11,img0+img00+img1+img11))

% % (a) Convolve the following I and F. Assume we use zero-padding where necessary.
% I=[2,0,1;1,-1,2];
% F=[1,-1;1,-1];
% g=rot90(F,2);
% [r,c]=size(I);
% I0=[zeros(1,c);I];
% I0=[I0;zeros(1,c)];
% I0=[zeros(r+2,1),I0]; 
% I0=[I0,zeros(r+2,1)]; 
% 
% [r,c]=size(I0);
% [r0,c0]=size(g);
% for i=2:r-1
%     for j=2:c-1
%         for k=1:r0
%             for w=1:c0
%                 I(i-1,j-1)=
%         
% % conv2(I,F)