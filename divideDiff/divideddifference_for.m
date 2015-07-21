%define diviede difference function
function dd=divideddifference(xi,yi)
n=length(xi);
dd=zeros(n);
for i=1:n
    dd(i)=yi(i);
end
for j=1:n%compute divided difference in reverse order
    for i=n:-1:j
        dd(i)=(dd(i)-dd(i-1))/(xi(i)-xi(i-j))
    end
end
