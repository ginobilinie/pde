%newton method to calculate the root for a nonlinear function
%
function root = newton(f,x0,eps)
iter=0;
root=x0;
fprintf('iter=%d\t\troot=%g\n',iter,root);
dx=-f(x0)/fDeriv(x0);
root=x0+dx;
while(abs(dx)>eps&&abs(f(root))>eps)
    dx=-f(root)/fDeriv(root);
    temp=root;
    root=root+dx;
    div=abs(temp-root);
    iter=iter+1;
    fprintf('iter=%d\t\troot=%g\t\tdiv=%g\n',iter,root,div);
end
return

function y=fDeriv(x)
%y=1-cos(x);
y=5*x^4 - 260*x^3 + 18*x^2 - 72*x + 5;
return

function y=gDeriv(x)
y=5*x^4 - 260*x^3 + 18*x^2 - 72*x + 5;
return

