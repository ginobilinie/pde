%Here I use modified gram-schmidt to do QR decomposition
function x=qr_mgs(A,b)
n=size(A,2);
m=size(A,1);
for k=1:n
    s=0;
    for j=1:m
       s=s+A(j,k)^2; 
    end
    R(k,k)=sqrt(s);
    for j=1:m
        Q(j,k)=A(j,k)/R(k,k);
    end
    for i=k+1:n
        s=0;
        for j=1:m
            s=s+A(j,i)*Q(j,k);
        end
        R(k,i)=s;
        for j=1:m
            A(j,i)=A(j,i)-R(k,i)*Q(j,k);
        end
    end
end
%Ax=b<=>QRx=b<=>Qy=b&&Rx=y
x=R\(Q\b);
end