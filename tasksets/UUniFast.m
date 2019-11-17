function vectU = UUniFast(n, U)
%UUNIFAST generate syntethic task utilizations with uniform distribution
%   An explanation of the method can be found in
%       E Bini, GC Buttazzo, Measuring the Performance of Schedulability
%       Tests, Real-Time Systems 30 (1-2), pp. 129-154, May 2005. 
%   Syntax:
%      vectU = UUniFast(n, U)
%   Input:
%      n, number of tasks in the set
%      U, total utilization of the task set
%   Output:
%      vectU, vector of individual task utilizations

sumU = U; % the sum of n uniform random variables
vectU = zeros(1,n);  % initialization

for i = 1:n - 1,
   nextSumU = sumU .* rand^(1 / (n - i)); % the sum of n-i uniform random variables
   vectU(i) = sumU - nextSumU;
   sumU = nextSumU;
end
vectU(n) = sumU;