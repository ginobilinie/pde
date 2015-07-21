%This script is written for problem 6 in theoretical part
n=10;
A=diag(ones(n,1))+diag(100*ones(n-1,1),1)
x=pi*ones(n,1)
b=A*x
xhat=A\b
err=x-xhat
max(err)

%this part is for p6b
bhat=A*xhat
err_b=b-bhat