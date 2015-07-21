%this script is written for p3 of hw1, instead of solving the specific
%problem, I code a general function

function p3_a()
clear;
a=0;
b=1;
ua=1;
ub=exp(1);
n=100;
[x,U]=BVP_oder2(a,b,ua,ub,@f,n);
%Now plot the error
plot(x,U,'o'); hold
u=zeros(n-1,1);
for i=1:n-1,
    u(i) = f(x(i));
end

return

function [x,U] = BVP_oder2(a,b,ua,ub,f,n)
h = (b-a)/n;
h2=h*h;
A = sparse(n-1,n-1);
F = zeros(n-1,1);
for i=1:n-2,
    A(i,i) = -2/h2;
    A(i+1,i) = 1/h2;
    A(i,i+1)= 1/h2;
end
A(n-1,n-1) = -2/h2;
for i=1:n-1,
    x(i) = a+i*h;
    F(i) = f(x(i));
end
F(1) = F(1) - ua/h2;
F(n-1) = F(n-1) - ub/h2;
U = A\F;
return

function y=f(x)
y=exp(x);
return