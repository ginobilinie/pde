%this m file is to solve problem a
function case_a(l,r)
for n=5:5:25
  x=linspace(l,r,n);
  fprintf('Case a %d nodes\n',n);
  polymodel(x,l,r);
end