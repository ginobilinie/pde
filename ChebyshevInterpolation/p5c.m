%This script is written to construct the the B ?spline approximation of the Runge function.
addpath('./chebfun');
M=20;
N=100;
x = chebfun('x');
f=1./(1+25*x.^2);
B0 = 1+0*x;
B1 = conv(B0,B0);
B2 = conv(B0,B1);
B3 = conv(B0,B2);
B4 = conv(B0,B3);


for n=1:N
    B(1,n)=B0(-1+2*n/N);
    B(2,n)=B1(-1+2*n/N);
    B(3,n)=B2(-1+2*n/N);
    B(4,n)=B3(-1+2*n/N);
    B(5,n)=B4(-1+2*n/N);
    y(n)=f(-1+2*n/N);
end

a=B*y';
b=B*B';
coef=b\a;

for i=1:M
    fitY(i)=B0(-1+2*i/M)*coef(1)+B1(-1+2*i/M)*coef(2)+B2(-1+2*i/M)*coef(3)+B3(-1+2*i/M)*coef(4)+B4(-1+2*i/M)*coef(5);
    realY(i)=f(-1+2*i/M);
    realX(i)=-1+2*i/M;
end

plot(f),hold on;
plot(realX,fitY,'r'),hold on;
maxerror=norm(realY-fitY,'inf')