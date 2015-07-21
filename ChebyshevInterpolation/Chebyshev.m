function f=Chebyshev(y,k,x0)
%This function is using Chebyshev polynomials as bisis functions to get
%approximation for given function y. In other words, using Chebyshev nodes
%as interpolation nodes. But Note: this function is written for
%approximation(fitting) instead of interpolation
%T is chebyshev polynomials, c is coeffients for chebyshev polynomials
syms t;
T(1)=sym(1);
T(2)=t;
c(1)=int(subs(y,findsym(sym(y)),t)*T(1)/sqrt(1-t^2),t,-1,1)/pi;
c(2)=2*int(subs(y,findsym(sym(y)),t)*T(2)/sqrt(1-t^2),t,-1,1)/pi;
f=c(1)+c(2)*t;
for i=3:k+1       
    T(i)=2*t*T(i-1)-T(i-2);       
    c(i)=2*int(subs(y,findsym(sym(y)),t)*T(i)/sqrt(1-t^2),t,-1,1)/pi;      
    f=f+c(i)*T(i);       
    f=simple(vpa(f,6));           
    if(i==k+1)              
        if(nargin==3)                     
            f=simple(vpa(subs(f,'t',x0),6));                     
        end
    end
end