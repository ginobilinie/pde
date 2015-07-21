function test1( A, b, shift, M )
%        test1( A, b, shift, M );
% test1 uses minres.m to solve (A - shift*I)x = b.
% A  is assumed to be a dense or sparse matrix.
% M  must be positive definite (or []).
%
% Examples:
% n     = 10;
% [A,b] = diagA(n);    % generates A = sparse posdef diag(1:n), b = ones(n,1);
%
% test1( A,b,0,[] )    % solves      Ax = b.  % posdef system, no preconditioning
% test1( A,b,2,[] )    % solves (A-2I)x = b.  % indef  system, no preconditioning
% shift = A(1);
% test1( A,b,shift,[]) % solves singular system in least-squares sense.
%
% M = A;
% for i=2:4,  M(i,i) = 1; end
% test1( A,b,0,M )     % solves      Ax = b with good preconditioner M.
% test1( A,b,2,M )     % solves (A-2I)x = b with good preconditioner M.
% shift = A(1);
% test1( A,b,shift,M)  % solves singular system in least-squares sense.

% 17 Oct 2003: First version for testing minres.
% 10 May 2009: Updated for modified minres.
%------------------------------------------------------------------

n      = length(b);
show   = true;
check  = true;
itnlim = n*5;
%itnlim = 9;              % TEST
rtol   = 1.0e-10;

[ x, istop, itn, rnorm, Arnorm, Anorm, Acond, ynorm ] = ...
  minres( A, b, M, shift, show, check, itnlim, rtol );

%  Print the solution and some clue about whether it is ok.

fprintf('\n Solution:')
for j = 1:n
   fprintf('\n %22.14e', x(j))
end
disp(' ')

keyboard
%  End of test1
