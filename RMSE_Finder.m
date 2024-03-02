%% Compute RMSE

function RMSE = RMSE_Finder(expM,theM) 
% here, expM is final1, final2, or final3 (10-by-1)
% here, theM is found with another function (Day_2_updated) (10-by-1)

% This function takes inputs 1) matrix of experimental data and 2) matrix
% of theoretical value corresponding to the same concentrations, and
% outputs RMSE

   % find n
   n = length(expM);

   % compute RMSE
   sum = 0;
   for i = 1:n
       % experimental value
       Y_exp = expM(i);

       % theoretical value
       Y_the = theM(i);

       sum = sum + (Y_the - Y_exp)^2;
   end

   RMSE = sqrt(sum/n);

end