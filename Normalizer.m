function normM = Normalizer(M)
% This function takes a matrix as input and outputs normalized matrix
% that is, all values in the matrix will be 0-1

    normM = M./max(M);
    
end