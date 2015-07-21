%This script is used to test Romberg algorithm written by me.
function [ya,yb,yc]=testRomberg()
eps=1e-7;

%Now solve a)
l=0;
r=pi/2;
f=@fa;%get handle of function a
ya=romberg(f,l,r,eps);
ya=vpa(ya,8);

%Now solve b)
l=0;
r=4;
f=@fb;%get handle of function b
yb=romberg(f,l,r,eps);
yb=vpa(yb,8);

%Now solve c)
l=0;
r=1;
f=@fc;%get handle of function c
yc=romberg(f,l,r,eps);
yc=vpa(yc,8);
return

function y=fun(x)
y=4/(1+x^2);
return

function y=fa(x)
y=x;
return

function y=fb(x)
if x==0
    y=1;
else
    y=sin(x)/x;
end
return

function y=fc(x)
if x==0
    y=-1;
else
    y=(cos(x)-exp(x))/(sin(x));
end
return

%This is the code for romberg algorithm
function [R,k,T]=romberg(fun,a,b,tol)
%(Romberg integration algorithm)
% parameters:
% fun：the function to be integrated
% a/b：integration interval
% tol：integration error
% R：value for integration
% k：number of interations 
% T：the whole interation process
%

k=0; % 迭代次数
n=1; % 区间划分个数
h=b-a;
T=h/2*(fun(a)+fun(b));
err=1;
while err>=tol
    k=k+1;
    h=h/2;
    tmp=0;
    for i=1:n
        tmp=tmp+fun(a+(2*i-1)*h);
    end
    T(k+1,1)=T(k)/2+h*tmp;
    for j=1:k
        T(k+1,j+1)=T(k+1,j)+(T(k+1,j)-T(k,j))/(4^j-1);
    end
    n=n*2;
    err=abs(T(k+1,k+1)-T(k,k));
end
%R=T(k+1,4);
R=T(k+1,k+1);
return