function f = real(f)
%REAL   Real part of a FOURTECH.
%   REAL(F) is the real part of F.
%
% See also ISREAL, IMAG, CONJ.

% Copyright 2014 by The University of Oxford and The Chebfun Developers. 
% See http://www.chebfun.org/ for Chebfun information.

% If f is real then there is nothing to do:
if ( isreal(f) )
    return;
end

% Compute the real part of the values and update vscale:
f.values = real(f.values);
f.vscale = max(abs(f.values), [], 1);

if ( ~any(f.values(:)) )
    % Input was imaginary, so output a zero FOURTECH:
    data.vscale = f.vscale;
    data.hscale = f.hscale;
    f = f.make(zeros(1, size(f.values, 2)), data);
    f.ishappy = 1;
else
    % Compute the coefficients.
    f.coeffs = f.vals2coeffs(f.values);
end

f.isReal = true(1, size(f, 2));

% Simplify the result in case the imaginary part was contributing more to
% the length.
f = simplify(f);

end
