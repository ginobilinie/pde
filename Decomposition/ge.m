%Gaussian Elemination to solve Linear system, and I use pivoting in the
%code
function x=ge(A,b)
%A is required to be not singular %
n = size(A,1);
if abs(det(A))<= 1e-8
    error('A is singular');
    return;
end
%
for k=1:n
       ak = max(abs(A(k:n,k)));
       index = find(A(:,k)==ak);
       if length(index) == 0
           index = find(A(:,k)==-ak);
       end
       %exchange pivot variable
        temp = A(index,:);
        A(index,:) = A(k,:);
        A(k,:) = temp;
        temp = b(index);b(index) = b(k); b(k) = temp;
       %eleminate vairable
   for i=k+1:n
       m=A(i,k)/A(k,k);
       %eleminate column element
        A(i,k+1:n)=A(i,k+1:n)-m*A(k,k+1:n);
        b(i)=b(i)-m*b(k);
   end
end
   %trace back
    x(n)=b(n)/A(n,n);
    for  k=n-1:-1:1;
        x(k)=(b(k)-A(k,k+1:n)*x(k+1:n)')/A(k,k);
    end
    x=x';
end