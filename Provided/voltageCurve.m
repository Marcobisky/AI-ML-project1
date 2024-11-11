%% Usage:
% Tdata -> Temperature samples
% idx -> indices
% Res -> List of register candidates in .mat
% ThVal -> List of nominal thermistor resistances candidates in .mat

function Vdata = voltageCurve(Tdata, idx, Res, ThVal, ThBeta)
    % Calculate Voltage Curve given Indices (x)
    % Index into Resistor and Thermistor arrays to extract component values
    RegPara(1) = Res(idx(1));
    RegPara(2) = Res(idx(2));
    RegPara(3) = Res(idx(3));
    RegPara(4) = Res(idx(4));
    RegPara(5) = ThVal(idx(5));
    RegPara(6) = ThBeta(idx(5));
    RegPara(7) = ThVal(idx(6));
    RegPara(8) = ThBeta(idx(6));

    % Calculate temperature curve for a particular set of components
    Vdata = tempCompCurve(RegPara, Tdata);
end