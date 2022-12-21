clc;
time = 1:1:10;

uo=imread('image.png');
u1=rgb2gray(uo);

[m,n]=size(u1);
u=zeros(m,n,length(time));
u2=imnoise(u1,'gaussian',0.1);
u(:,:,1)=u2(:,:);
imshow(u2(:,:))
imshow(u(:,:,1))

u_x=0;
u_y=0;
u_xx=0;
u_yy=0;



 for k=1:1:length(time)-1
  for j=2:1:n-1
     for i=2:1:m-1
            u_x=u(i+1,j,k)-u(i,j,k);
            u_y=u(i,j+1,k)-u(i,j,k);
            u_xx=u(i+1,j,k)+u(i-1,j,k)-2*u(i,j,k);
            u_yy=u(i,j+1,k)+u(i,j-1,k)-2*u(i,j,k);
            ux_pow2=u_x^2;
            uy_pow2=u_y^2;
            u(i,j,k+1)=u(i,j,k)+0.01*(exp(-1*(ux_pow2+uy_pow2))*((u_xx*(1-2*ux_pow2))+(u_yy*(1-2*uy_pow2))));
        end
    end
end
imshow(u(:,:,2))