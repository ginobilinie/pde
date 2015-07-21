function root=testbisection()
    root=bisection(@f,1,2,1e-3);
return

function y=f(x)
    y=x-tan(x);
return