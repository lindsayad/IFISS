function C = int_setdiff(A,B)
% INT_SETDIFF set difference of two sets of positive integers 
% much faster than built-in setdiff)
% C = int_setdiff(A,B)
% C = A \ B = { things in A that are not in B }
%
if isempty(A)
    C = [];
    return;
elseif isempty(B)
    C = A;
    return;
else % both non-empty
    bits = zeros(1, max(max(A), max(B)));
    bits(A) = 1;
    bits(B) = 0;
    C = A(logical(bits(A)));
end

