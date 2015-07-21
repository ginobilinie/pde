%Here I use Householder transformation to do QR decomposition
function x=qr_h(A,b)
n=length(b);
Q=eye(n);
H=A;
for i=1:n-1
    c=H(:,1);
    normc=norm(c,2);
    c(1)=c(1)-c;
    c1=transpose(c);
    Q1=eye(n-i+1)-2/(c1*c)*c*c1;
    H1=Q1*H;
    Q1=blkdiag(eye(i-1),Q1);
    Q=Q*transpose(Q1);
    if i<n-1
        H1(1,:)=[];
        H1(:,1)=[];
        H=H1;
    end
end
R=transpose(Q)*A;
%Ax=b<=>QRx=b<=>Qy=b&&Rx=y
x=R\(Q\b);
end