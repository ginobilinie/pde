%This function is wrtten to calculate root for a nonlinear function using
%bisection method.
%params:
%f:the equation
%[a,b]:interval which satisifies f(a)f(b)<0
%eps:error 
%output:
%the approximate root
function root = bisection(f,a,b,eps)
iter=0;
mid=(a+b)/2;
fprintf('iter=%d\t\ta=%g\t\tb=%g\t\troot=%g\n',iter,a,b,mid);
while(abs(b-mid)>eps&&abs(f(mid))>eps)
    if (f(mid)*f(a)<0)
        b=mid;
    else
        a=mid;
    end
    temp=mid;
    mid=(a+b)/2;
    div=abs(temp-mid);
    iter=iter+1;
    fprintf('iter=%d\t\ta=%g\t\tb=%g\t\troot=%g\t\tdiv=%g\n',iter,a,b,mid,div);
end
root=mid;
return



function root = newton(f,a,b,eps)
x0=(a+b)/2;
fDeriv=diff(f);
dx=-f(x0)/fDeriv(x0);
root=x0+dx;
while(abs(dx)>eps&&abs(f(root))>eps)
    dx=-f(root)/fDeriv(root);
    root=root+dx;
end
return

