clc;
fo=imread("image.png","png");
fn=imnoise(fo,"gaussian",0.1);
subplot(2,2,1)
imshow(fo)
subplot(2,2,2)
imshow(fn)
time = 1:1:10;
ss(1)
f=zeros(ss(1),ss(2),length(time));
f2=zeros(ss(1),ss(2),length(time));
f3=zeros(ss(1),ss(2),length(time));
for i=1:1:length(time)
   for j=1:1:ss(1)-1
       for k=2:1:ss(2)-1
           f(j,k,1)=fn(j,k,1);
           f2(j,k,1)=fn(j,k,2);
           f3(j,k,1)=fn(j,k,3);
          f(j,k,i+1)=f(j,k,i)+(f(j+1,k,i)+f(j,k+1,i)-4*f(j,k,i));
          f2(j,k,i+1)=f2(j,k,i)+(f2(j+1,k,i)+f2(j,k+1,i)-4*f2(j,k,i));
          f3(j,k,i+1)=f3(j,k,i)+(f3(j,k+1,i)-4*f3(j,k,i));
       end
   end
end
fimage=zeros(ss(1),ss(2),3);
for j=1:1:ss(1)
    for k=1:1:ss(2)
        fimage(j,k,1)=f(j,k,3);
        fimage(j,k,2)=f2(j,k,3);
        fimage(j,k,3)=f3(j,k,3);
    end
end
subplot(2,2,3)
imshow(fimage)