%this script is written for p1 of hw1

A=[7,10;5,7];
%a)
invA=inv(A);
%b)
normA=norm(A,2);
%c)
condA=normA*norm(invA,2);
%d)
[~,D]=eig(A);
