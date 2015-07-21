function root = bisection1(f,a,b,eps)
iter=0;
mid=(a+b)/2;
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
end
root=mid;
return

