function [ d ] = divdiff( x,y )

if length(x) == 2
    d = y(2) - y(1);
else
    d = (divdiff(x(2:length(x)),y(2:length(y)))-divdiff(x(1:length(x)-1),y(1:length(y)-1))) / (x(length(x))-x(1));
end
