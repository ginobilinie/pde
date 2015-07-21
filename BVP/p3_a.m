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
%%%%%%%%%%%%%%%%%%% Plot and show the error %%%%%%%%%%%%%%%%%%%
plot(x,U,'o'); hold
u=zeros(n-1,1);
for i=1:n-1,
    u(i) = f(x(i));
end
plot(x,u);
saveas(gcf,'estimatedU-bvpoder2.png');
%%%%%%% Plot error
figure(2); plot(x,U-u)
saveas(gcf,'plotoferror-bvpoder2.png');
norm(U-u,inf) %%% Print out the maximum error
return

function [x,U] = BVP_oder2(a,b,ua,ub,f,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab function BVP_oder2 solves the following two-point 
% boundary value problem: u''(x) = f(x) using the center finite 
% difference scheme, and suppose it can give a 2nd order convergence 
% Input: 
% a, b: Two end points. 
% ua, ub: Boundary value 
% f: external function f(x). %
% n: number of 'estimate' points. %
% Output: %
% x: x(1),x(2),...x(n-1) are 'estimate' points %
% U: U(1),U(2),...U(n-1) are approximate solution at 'estimate' points %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%--------- End of the program -------------------------------------

function y=f(x)
y=exp(x);
return
