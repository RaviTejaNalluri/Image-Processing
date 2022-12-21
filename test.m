clc;
f=imread("gaussian.png");
I=rgb2gray(f);

subplot(2,2,1)
imshow(I);
%%adding gaussian noise
g=  imnoise(I,'gaussian',0.1);
subplot(2,2,2)
imshow(g)

%%%Removing noise from the image

s = 1; %standard deviation
k= zeros(5,5);
w=0;
for i=1:5
    for j=1:5
        dist=(i-3)^2+(j-3)^2;
        k(i,j)=exp(-i*(dist)/(2*s*s));
        w=w+k(i,j);
    end
end

k=k/w;
[m,n]=size(I)
output=zeros(m,n);
Im=padarray(I,[100,5]);
for i=1:n
    for j=1:n
        temp=Im(i:i+4,j:j+4);
        temp=double(temp);
        conv=temp.*k;
        output(i,j)=sum(conv(:));
    end
end
output= uint8(output);
subplot(2,2,3);
imshow(output);