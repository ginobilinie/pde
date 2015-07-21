%train the polynomial model and test the error for given data xi and real
%function f in the interval of [l,r]. Note: f is f(x)=1/(x^2+1)
function err=polymodel(xi,l,r)
precision=1.0e-3;
nevalmax=1e+5;
n=length(xi);
yi=f(xi);%if xi is a vector, then yi is a corresponding vector
%[dd,tdd]=divdiff(xi,yi)
[dtable,dd]=mydivdiff(xi,yi);%it's right this time
err=0;%error
neval=100;
xeval=linspace(l,r,neval);
converged=0;
maxeval=0;
while (converged==0&&maxeval==0)
    yeval=newtoninterpolation(xi,dd,xeval);%get the evaluation value for xeval points
    nyeval=length(yeval);
    yreal=f(xeval);% get the real value for xeval points
    nyreal=length(yreal);
    currenterr=max(abs(yreal-yeval));
    currentprecision=abs(err-currenterr)/err;
    if currentprecision<precision
        converged=1;
    end
    err=currenterr;
    neval=2*neval;%2 times number of the evaluated points
    if nevalmax<neval
        maxeval=1;%it means we have reached the max numbers
    end
    fprintf('With %d evalution points, model error = %f\n',neval,err);     
end