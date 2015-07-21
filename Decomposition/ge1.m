%Gaussian Elemination to solve Linear system, and I use pivoting in the
%code
function x=ge(A,b)
n = size(A,1);

for k=1:n
       ak = max(abs(A(k:n,k)));
       index = find(A(:,k)==ak);
       if length(index) == 0
           index = find(A(:,k)==-ak);
       end
       
        temp = A(index,:);
        A(index,:) = A(k,:);
        A(k,:) = temp;
        temp = b(index);b(index) = b(k); b(k) = temp;
       
   for i=k+1:n
       m=A(i,k)/A(k,k);
        A(i,k+1:n)=A(i,k+1:n)-m*A(k,k+1:n);
        b(i)=b(i)-m*b(k);
   end
end
    x(n)=b(n)/A(n,n);
    for  k=n-1:-1:1;
        x(k)=(b(k)-A(k,k+1:n)*x(k+1:n)')/A(k,k);
    end
    x=x';
end