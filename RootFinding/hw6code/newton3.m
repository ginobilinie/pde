%this is a script to solve multiple equations
%       fx       The symbolic row array of eqs.
%       x        The symbolic variables of eqs.
%       x0       Initial values of guess x.
%       eps      The tolerance for iteration.
%       MaxIter        The maximum steps for iteration.
% EXAMPLES:
%syms x y;
%f1=sin(x)+tan(y)-0.3;
% f2=exp(x)+cos(y)-2;
%fx=[f1,f2];%equations
%x=[x,y];%variables
%x0=[0,0];%initial guess
%[X,t]=newton3(fx,x,x0,1e-4,100)%call function
% 
% ALGORITHM:
%           X(n+1)=X(n)- F(X(n)) / DF(X(n)) ,
% where DF(X(n)) is the derivation value of X(n).
% The iteration stop when max(X(n+1)-X(n))
% or maximum step MaxIter reaching.
function [xi i]=newton3(fx,x,x0,eps,MaxIter)

if nargin==3
    eps=1.0e-5;
    MaxIter=10;
elseif nargin==4
    MaxIter=10;
elseif nargin~=5
    error('Must have 5 arguments!')
end
lx=length(x0);
for i=1:lx
    dfx(i,:)=diff(fx,x(i));
end
for i=1:MaxIter        
        xi=x0-subs(fx,x,x0)/subs(dfx,x,x0);
        if abs(max(xi-x0))
            break;
        end
        x0=xi;
end