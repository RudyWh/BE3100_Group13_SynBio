function NRMSE = NRMSE_Finder(edge_distanceM_exp,edge_distanceM_model)
    % here, inputs are two n-by-1 matrices, each containing edge distance 
    
    RMSE = RMSE_Finder(edge_distanceM_exp,edge_distanceM_model);
    
    C = horzcat(edge_distanceM_exp, edge_distanceM_model);
    Ymax = max(C,[],"all");
    Ymin = min(C,[],"all");

    NRMSE = RMSE / (Ymax - Ymin);
    
end
    




