%% Usage: The loss function (L2-norm squared) for the thermistor problem 
% x -> 6-dim point in the search space (index of the components)
% StdRes -> List of register candidates in .mat
% StdTherm_Val -> List of nominal thermistor resistances candidates in .mat
% StdTherm_Beta -> List of thermistor temeperature coefficients candidates in .mat
% Tdata -> Temperature samples
% Vdata -> Expected Voltage values for each temperature sample
% G -> Loss function value

function G = objectiveFunction(x, StdRes, StdTherm_Val, StdTherm_Beta, Tdata, Vdata)
    % Extract component values from tables using integers in x as indices
    y = zeros(8,1);
    y(1) = StdRes(x(1));
    y(2) = StdRes(x(2));
    y(3) = StdRes(x(3));
    y(4) = StdRes(x(4));
    y(5) = StdTherm_Val(x(5));
    y(6) = StdTherm_Beta(x(5));
    y(7) = StdTherm_Val(x(6));
    y(8) = StdTherm_Beta(x(6));

    % Calculate temperature curve for a particular set of components
    F = tempCompCurve(y, Tdata);

    % Calculate L2-norm squared
    Residual = F(:) - Vdata(:);
    Residual = Residual(1:2:26); % Speed up loss function evaluation
    G = Residual'*Residual; % sum of squares
end