function F = tfderivs(t, co_ords, col_flag, alpha_A, alpha_P, beta, ...
    gamma, h)

    dPdt = co_ords(1) * (alpha_P - beta  * co_ords(1) + ...
        (gamma * h * co_ords(2))/(1 + h * co_ords(2)));
    dAdt = co_ords(2) * (alpha_A - beta  * co_ords(2) + ...
        (gamma * h * co_ords(1))/(1 + h * co_ords(1)));
    if col_flag
        F = [dPdt; dAdt];
    else
        F = [dPdt, dAdt];
    end
end

