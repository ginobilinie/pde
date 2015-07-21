%this m file is to solve problem c
function case_c(l,r)
for n=5:5:25
  x=-5.*cos(pi*(0:2*n)/(2*n));
  fprintf('Case a %d nodes\n',n);
  polymodel(x,l,r);
end