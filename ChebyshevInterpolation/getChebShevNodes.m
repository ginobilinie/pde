%get ChebyShev points of 1st kind
function xc=getChebShevNodes(n,l,r)
%here n means the number of chebypoints
%[l,r] means the interval chebypoints are in, usually are symmetry,[-5,5]
if l+r!=0% the value interval are not symmetry
	disp('the value interval are not symmetry');
	return;
end
xc=l*cos((2*(1:n)-1)*pi/2/n);
end