%calculate the divided difference
function [dtable,d]=mydivdiff(x,y)
if length(x)~=length(y)
    disp('not the same length with the two vectors');
end
n=length(x);
dtable=zeros(n,n);
dtable(:,1)=y;%the first col of d is original y

%compute the divided difference from x2
for i=2:n%i column is the i order divided difference
    for j=i:n%compute the i order dd at row j
        dtable(j,i)=(dtable(j,i-1)-dtable(j-1,i-1))/(x(j)-x(j-i+1));
    end
end

d=linspace(0,0,n);
for i=1:n
    d(i)=dtable(i,i);
end


