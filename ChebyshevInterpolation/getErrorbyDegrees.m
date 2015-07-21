function getErrorbyDegrees()
%This function is written to calculate the approximation erro given
%different degrees
syms t;
maxdegree=10;
error=zeros(maxdegree);
for degree=1:maxdegree
    chebyf=Chebyshev('1/(1+25*t^2)',degree);
    errorf=1/(1+25*t^2)-chebyf;
    error(degree)=int(errorf,-1,1);%integral
end
figure();
plot(1:maxdegree,error);
title('error dependence on degree');
xlabel('degree');
ylabel('error');
end

