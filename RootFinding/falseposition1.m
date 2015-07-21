function root = falseposition1(f,a,b,eps)
iter=0;
root=(a*f(b)-b*f(a))/(f(b)-f(a));
while(abs(b-root)>eps&&abs(f(root))>eps)
    if (f(root)*f(a)<0)
        b=root;
    else
        a=root;
    end
    temp=root;
    root=(a*f(b)-b*f(a))/(f(b)-f(a));
    div=abs(temp-root);
    iter=iter+1;
end
root=root;
return