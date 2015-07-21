%this m file is to solve problem b
function case_b(l,r)
for n=5:5:25
  x=linspace(1,n,n);
  x=(x+rand(1,n))*(r-l)/(n-1)+l;
  fprintf('Case a %d nodes\n',n);
  polymodel(x,l,r);
end