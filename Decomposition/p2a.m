%this script is written for problem 2
function p2a()
ns=[20,100,200,400,1000];
for n=ns
    x=rand(n,1);
    y=2+rand(n,1);
    for j=1:n
        for i=1:n
            A(j,i)=1/(y(j)-x(i));
        end
    end
    fprintf('size of A: %d\n',n);
    [U,S,V]=svd(A);
    S
end
end