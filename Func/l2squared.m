%% Usage: The loss function (L2-norm squared) for the thermistor problem 
% RegPara -> Register parameter vector of size (popNum, 8)
% Tdata -> Temperature samples in row vector
% Vdata -> Expected Voltage values for each temperature sample in row vector
% L -> Loss function vector of size (popNum, 1)

function L = l2squared(RegPara, Tdata, Vdata)
    % Calculate voltage
    Vw = temp2volt(RegPara, Tdata);

    % Calculate L2-norm squared
    Residual = Vw - Vdata;
    Residual = Residual(:, 1:2:length(Tdata)); % Speed up loss function evaluation
    L = sum(Residual.^2, 2);
end