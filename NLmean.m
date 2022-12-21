clc;
clear all;
 
I = imread('image.png');
Img = rgb2gray(I);
[m,n] = size(Img)
 
f=1;
%neighborhood window size = 2f+1 , ie 5x5
t=3;
% similarity window size = 2t+1 , ie 11x11

% Making gaussian kernel
sd=1;          %standard deviation of gaussian kernel
sm=0;          % sum of all kernel elements (for normalization)
ks= 2*f+1;     % size of kernel (same as neighborhood window size)
% Initiating kernel
ker = zeros(ks,ks);
for x=1:ks
    for y=1:ks
        ab = x-f-1;   %horizontal distance of pixel from center(f+1, f+1)
        cd = y-f-1;   % vertical distance of pixel from center (f+1, f+1)
        ker(x,y) = 100*exp(((ab*ab)+(cd*cd))/(-2*(sd*sd)));
        sm = sm + ker(x,y);
    end
end
kernel = ker ./ f;
kernel = kernel / sm; 

 
addnoise = imnoise(Img,'gaussian');
convert = double(addnoise);
 
removnoise = zeros(m,n);
 
%Degree of filtering
h=40;
% Replicate boundaries of noisy image
noisy2 = padarray(convert,[f,f],'symmetric');
 
for i=1:m
    for j=1:n
        im = i+f;   % to compensate for shift due to padarray function
        jn= j+f;
        % neighborhood of pixel
        W1 = noisy2(im-f:im+f , jn-f:jn+f);
        % Boundaries of similarity window for that pixel
        rmin = max(im-t, f+1);
        rmax = min(im+t, m+f);
        cmin = max(jn-t, f+1);
        cmax = min(jn+t, n+f);
        % Calculate weighted average next
        NL=0;    
        Z=0;   %normalizing constant
        % Run loop through all the pixels in similarity window
        for r=rmin:rmax
            for s=cmin:cmax
                % neighborhood of pixel 'j' being compared for similarity
                W2 = noisy2(r-f:r+f, s-f:s+f);
                % square of weighted euclidian distances
                d2 = sum(sum(kernel.*(W1-W2).*(W1-W2)));
                % weight of similarity between both pixels : s(i,j)
                pij = exp(-d2/(h*h));
                Z = Z + pij;
                NL = NL + (pij*noisy2(r,s));
            end
        end
        % normalization of NL
        removnoise(i,j) = NL/Z;
    end
end
removnoise = uint8(removnoise);
figure(1);
set(gcf, 'Position', get(0,'ScreenSize'));%This function is used to get the full screen
subplot(1,2,1);
imshow(addnoise);
title('noisy Image');
subplot(1,2,2);
imshow(removnoise);
title('NL mean');