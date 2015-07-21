function [ x, istop, itn, rnorm, Arnorm, Anorm, Acond, ynorm ] = ...
           myMINRES( A, b, M, shift, show, check, itnlim, rtol )


%  Initialize                               
 
n      = length(b);
precon = ~isempty(M);


istop = 0;   itn   = 0;   Anorm = 0;    Acond = 0;
rnorm = 0;   ynorm = 0;   done  = false;
x     = zeros(n,1);

%---------------------------------------------------------------------
% Decode A.
%---------------------------------------------------------------------
if isa(A,'double')         % A is an explicit matrix A.
  if c(A)
    nnzA = nnz(A);
    fprintf('\n A is an explicit sparse matrix')
    fprintf('\n nnz(A) =%8g', nnzA)
  else
    fprintf('\n A is an explicit dense matrix' )
  end
elseif isa(A,'function_handle')
  disp(['The matrix A is defined by function_handle ' func2str(A)])
else
  error('minres','A must be a matrix or a function handle')
end

%---------------------------------------------------------------------
% Decode M.
%---------------------------------------------------------------------
if precon
  if isa(M,'double')       % M is an explicit matrix M.
    if issparse(M)
      nnzM = nnz(M);
      fprintf('\n The matrix M is an explicit sparse matrix')
      fprintf('\n nnz(M) =%8g', nnzM)
    else
      fprintf('\n The matrix M is an explicit dense matrix' )
    end
  elseif isa(M,'function_handle')
    disp(['The matrix M is defined by function_handle ' func2str(M)])
  else
    error('minres','M must be a matrix or a function handle')
  end
end

y     = b;
r1    = b;
if precon, y = solveM( M,b ); end
beta1 = b'*y;
                                                
%  Test for an indefinite preconditioner.
%  If b = 0 exactly, stop with x = 0.

if beta1> 0
  beta1  = sqrt(beta1);       % Normalize y to get v1 later.

  % See if M is symmetric.

  if check & precon
    r2     = solveM( M,y );
    s      = y' *y;
    t      = r1'*r2;
    z      = abs(s-t);
    epsa   = (s+eps)*eps^(1/3);
    if z > epsa, istop = 8;  show = true;  done = true; end
  end

  % See if A is symmetric.

  if check
     w    = solveM( A,y );
     r2   = solveM( A,w );
     s    = w'*w;
     t    = y'*r2;
     z    = abs(s-t);
     epsa = (s+eps)*eps^(1/3);
     if z > epsa, istop = 7;  done  = true;  show = true;  end
  end
end

%------------------------------------------------------------------
% Initialize other quantities.
% ------------------------------------------------------------------
oldb   = 0;       beta   = beta1;   dbar   = 0;       epsln  = 0;
qrnorm = beta1;   phibar = beta1;   rhs1   = beta1;
rhs2   = 0;       tnorm2 = 0;       gmax   = 0;       gmin   = realmax;
cs     = -1;      sn     = 0;
w      = zeros(n,1);
w2     = zeros(n,1);
r2     = r1;

if show
  fprintf('\n\n   Itn     x(1)     Compatible    LS       norm(A)  cond(A)')
  fprintf(' gbar/|A|\n')   %%%%%% Check gbar
end

%---------------------------------------------------------------------
% Main iteration loop.
% --------------------------------------------------------------------
if ~done                              % k = itn = 1 first time through
  while itn < itnlim
    itn    = itn+1;

    s = 1/beta;                 % Normalize previous vector (in y).
    v = s*y;                    % v = vk if P = I

    y = solveM( A,v ) - shift*v;
    if itn >= 2, y = y - (beta/oldb)*r1; end

    alfa   = v'*y;              % alphak
    y      = (- alfa/beta)*r2 + y;
    r1     = r2;
    r2     = y;
    if precon,  y = solveM( M,r2 );  end
    oldb   = beta;              % oldb = betak
    beta   = r2'*y;             % beta = betak+1^2
    if beta < 0, istop = 9;  break;  end
    beta   = sqrt(beta);
    tnorm2 = tnorm2 + alfa^2 + oldb^2 + beta^2;

    if itn==1                   % Initialize a few things.
      if beta/beta1 <= 10*eps   % beta2 = 0 or ~ 0.
	istop = -1;             % Terminate later.
      end
    end

    oldeps = epsln;
    delta  = cs*dbar + sn*alfa; % delta1 = 0         deltak
    gbar   = sn*dbar - cs*alfa; % gbar 1 = alfa1     gbar k
    epsln  =           sn*beta; % epsln2 = 0         epslnk+1
    dbar   =         - cs*beta; % dbar 2 = beta2     dbar k+1
    root   = norm([gbar dbar]);
    Arnorm = phibar*root;       % ||Ar{k-1}||

    % Compute the next plane rotation Qk

    gamma  = norm([gbar beta]); % gammak
    gamma  = max([gamma eps]);
    cs     = gbar/gamma;        % ck
    sn     = beta/gamma;        % sk
    phi    = cs*phibar ;        % phik
    phibar = sn*phibar ;        % phibark+1

    % Update  x.

    denom = 1/gamma;
    w1    = w2;
    w2    = w;
    w     = (v - oldeps*w1 - delta*w2)*denom;
    x     = x + phi*w;

    % Go round again.

    gmax   = max([gmax gamma]);
    gmin   = min([gmin gamma]);
    z      = rhs1/gamma;
    rhs1   = rhs2 - delta*z;
    rhs2   =      - epsln*z;

    % Estimate various norms.

    Anorm  = sqrt( tnorm2 );
    ynorm  = norm(x);
    epsa   = Anorm*eps;
    epsx   = Anorm*ynorm*eps;
    epsr   = Anorm*ynorm*rtol;
    diag   = gbar;
    if diag==0, diag = epsa; end

    qrnorm = phibar;
    rnorm  = qrnorm;
    test1  = rnorm/(Anorm*ynorm);    %  ||r|| / (||A|| ||x||)
    test2  = root / Anorm;      % ||Ar{k-1}|| / (||A|| ||r_{k-1}||)

  

    Acond  = gmax/gmin;


    if istop==0
      t1 = 1 + test1;      % These tests work if rtol < eps
      t2 = 1 + test2;
      if t2    <= 1      , istop = 2; end
      if t1    <= 1      , istop = 1; end
      
      if itn   >= itnlim , istop = 6; end
      if Acond >= 0.1/eps, istop = 4; end
      if epsx  >= beta1  , istop = 3; end
     %if rnorm <= epsx   , istop = 2; end
     %if rnorm <= epsr   , istop = 1; end
      if test2 <= rtol   , istop = 2; end
      if test1 <= rtol   , istop = 1; end
    end

    % See if it is time to print something.

    prnt   = false;
    if n      <= 40       , prnt = true; end
    if itn    <= 10       , prnt = true; end
    if itn    >= itnlim-10, prnt = true; end
    if mod(itn,10)==0     , prnt = true; end
    if qrnorm <= 10*epsx  , prnt = true; end
    if qrnorm <= 10*epsr  , prnt = true; end
    if Acond  <= 1e-2/eps , prnt = true; end
    if istop  ~=  0       , prnt = true; end

    if show & prnt
      if mod(itn,10)==0, disp(' '); end
      str1 = sprintf('%6g %12.5e %10.3e', itn,x(1),test1);
      str2 = sprintf(' %10.3e',           test2);
      str3 = sprintf(' %8.1e %8.1e',      Anorm,Acond);
      str4 = sprintf(' %8.1e',            gbar/Anorm);
      str  = [str1 str2 str3 str4];
      fprintf('\n %s', str)

      debug = false;  % true;
      if debug   % Print true Arnorm.
	         % This works only if no preconditioning.
	vv = b - solveM(A,x)  + shift*x;    % vv = b - (A - shift*I)*x
	ww =     solveM(A,vv) - shift*vv;   % ww = (A - shift*I)*vv = "Ar"
        trueArnorm = norm(ww);
        fprintf('\n Arnorm = %12.4e   True ||Ar|| = %12.4e', Arnorm,trueArnorm)
      end
    end % show & prnt

    if istop ~= 0, break; end

  end % main loop
end 

function y = solveM( A,x )
  if isa(A,'double')
    y = A*x;
  else
    y = A(x);
  end


