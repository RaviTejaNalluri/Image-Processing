clc;
I = imread('image.png');
Img = rgb2gray(I)
[m,n] = size(Img)
f=1;

noisy2 = padarray(noisy,[f,f],'symmetric')
