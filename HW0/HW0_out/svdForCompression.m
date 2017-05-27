clear
img=imread('flower.bmp');
figure;imshow(img)

img0=rgb2gray(img);
img0=im2double(img0);
figure;imshow(img0)

[U,S,V]=svd(img0);
value=svd(img0);
t=10;
value=value(1:t);
SComp=diag(value);

imgComp=U*S*V';
figure;imshow(imgComp)

