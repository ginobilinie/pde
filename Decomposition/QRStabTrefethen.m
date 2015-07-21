R=triu(randn(50));
[Q,X]=qr(randn(50));
A=Q*R;

[Q2,R2]=qr(A);

normA=norm(A)
condA=cond(A)

normerrQ=norm(Q2-Q)
normerrR=norm(R2-R)

normerrA=norm(A-Q2*R2)

normreErrA=norm(A-Q2*R2)/norm(A)