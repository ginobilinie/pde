%newton interpolation: here we use newton interpolation to get a polynomial function with data xi and divided
%difference dd, and then get evaluation value at x=xeval
function yeval=newtoninterpolation(xi,dd,xeval)
n=length(xi);
yeval=linspace(0,0,length(xeval));%����ȫ0������
neval=length(xeval);%�����Ƶ�ĸ���
for j=1:neval
    xx=xeval(j);
    w=1;
    for i=1:n
        yeval(j)=yeval(j)+dd(i)*w;
        w=w*(xx-xi(i));%#update: product of (x-xi)
    end
end