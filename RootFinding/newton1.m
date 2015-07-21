%newton method to calculate the root for a nonlinear function
%
function root = newton(f,x0,eps)
iter=0;
root=x0;
dx=-f(x0)/fDeriv(x0);
root=x0+dx;
while(abs(dx)>eps&&abs(f(root))>eps)
    dx=-f(root)/fDeriv(root);
    temp=root;
    root=root+dx;
    div=abs(temp-root);
    iter=iter+1;
end
return

function y=fDeriv(x)
y=1-cos(x);
return
