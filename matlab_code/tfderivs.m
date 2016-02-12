function F = tfderivs(t, co_ords, col_flag)
    
    % Plant Parameters
    alpha_P_1 = -0.2;
    beta_P_1_1 = 1.5;
    gamma_P_1_1 = 0.25;
    h_P_1_1 = 0.5;
    
    % Animal Parameters
    alpha_A_1 = -0.29;
    beta_A_1_1 = 1.72;
    gamma_A_1_1 = 0.29;
    h_A_1_1 = 0.75;
    
    dPdt = co_ords(1) * (alpha_P_1 - beta_P_1_1  * co_ords(1) + ...
        (gamma_P_1_1 * h_P_1_1 * co_ords(2))/(1 + h_P_1_1 * co_ords(2)));
    dAdt = co_ords(2) * (alpha_A_1 - beta_A_1_1  * co_ords(2) + ...
        (gamma_A_1_1 * h_A_1_1 * co_ords(1))/(1 + h_A_1_1 * co_ords(1)));
    if col_flag
        F = [dPdt; dAdt];
    else
        F = [dPdt, dAdt];
    end
end

