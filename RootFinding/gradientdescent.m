%This script is to roots for nonlinear equations with gradient descent
%method, as gradient desent have to combine the two equations first, we
%here directly give the gradient of the given functions
function [n,x,y,div]=gradientdescent(eps,MaxIter)
n=0;            %initialize iteration counter 
div=1;          %initialize error 
lambda=0.09;    %learing rate
x=0;
y=0.2;%the initial guess


%Computation loop 
while div>eps&n<MaxIter 
    gradfx=sin(x)*cos(x)+cos(x)*tan(y)-0.3*cos(x)+exp(2*x)+exp(x)*cos(y)-2*exp(x);%gradf(x)
    gradfy=-sin(x)*cot(y)+1-0.3*cot(y)-exp(x)*sin(y)-sin(y)*cos(y)+2*sin(y);  %gradf(y) 
    div=abs(gradfx)+abs(gradfy);                             %error 
    temp=[x,y]-lambda*[gradfx,gradfy];      %iterate       
    x=temp(1);
    y=temp(2);
    n=n+1;                                                       %counter+1 
end 

       %display end values
end