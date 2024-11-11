%% Usage: Temperature to Voltage
% RegPara -> Resistor parameters, [R1 R2 R3 R4 RTH1(T_25degc) Beta1 RTH2(T_25degc) Beta2]
% Tdata -> Temperature sample (row) vector
% Vw -> Voltage data matrix for each temperature sample (size = popNum x length(Tdata))

function Vw = temp2volt(RegPara, Tdata)
    % Input voltage
    Vin = 1.1;

    % Thermistors are represented by:
    %   Room temperature is 25degc: T_25
    %   Standard value is at 25degc: RTHx_25
    %   RTHx is the thermistor resistance at various temperature
    % RTH(T) = RTH(T_25degc) / exp (Beta * (T-T_25)/(T*T_25)))
    T_25 = 298.15;
    T_off = 273.15; % Offset to convert from degC to Kelvin
    Beta1 = RegPara(:, 6);
    Beta2 = RegPara(:, 8);
    % size(RTH) = popNum x length(Tdata)
    RTH1 = RegPara(:, 5) ./ exp(Beta1 * ((Tdata+T_off)-T_25)./((Tdata+T_off)*T_25));
    RTH2 = RegPara(:, 7) ./ exp(Beta2 * ((Tdata+T_off)-T_25)./((Tdata+T_off)*T_25));

    % Define equivalent circuits for parallel R's and RTH's
    R1_eq = RegPara(:, 1).*RTH1 ./ (RegPara(:, 1)+RTH1);
    R3_eq = RegPara(:, 3).*RTH2 ./ (RegPara(:, 3)+RTH2);

    % Calculate voltages at Point B
    Vw = Vin * (R3_eq + RegPara(:, 4)) ./ (R1_eq + RegPara(:, 2) + R3_eq + RegPara(:, 4));
end