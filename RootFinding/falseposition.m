function root = falseposition(f,a,b,eps)
iter=0;
root=(a*f(b)-b*f(a))/(f(b)-f(a));
fprintf('iter=%d\t\ta=%g\t\tb=%g\t\troot=%g\n',iter,a,b,root);
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
    fprintf('iter=%d\t\ta=%g\t\tb=%g\t\troot=%g\t\tdiv=%g\n',iter,a,b,root,div);
end
root=root;
return