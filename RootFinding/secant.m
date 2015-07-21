function c = secant(f,x0, x1, eps)
iter=0;
fx0 = f(x0);                   
fx1 = f(x1);                   
if abs(fx1) < abs(fx0),         %% c is the current best approx to a root.
  c = x1;  fc = fx1;
else
  c = x0;  fc = fx0;
end;
fprintf('iter=%d\t\troot=%g\n',iter,x1)
if abs(fc) <= eps             
  return;                                        
end;

while abs(fc) > eps,
  fpc = (fx1-fx0)/(x1-x0);     
  if fpc==0,                   
    error('fprime is 0')        
  end;
  temp=x1;
  x0 = x1;  fx0 = fx1;             
  x1 = x1 - fx1/fpc;               
  fx1 = f(x1);
  if abs(fx1) < abs(fx0),          
    c = x1;  fc = fx1;
  else
    c = x0;  fc = fx0;
  end;
  iter=iter+1;
  div=x1-temp;
  fprintf('iter=%d\t\troot=%g\t\tdiv=%g\n',iter,x1,div)
end;
return