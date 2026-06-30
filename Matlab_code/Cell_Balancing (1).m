function [Bal1, Bal2, Bal3, Bal4] = Cell_Balancing(V1, V2, V3, V4, Charge_Enable)
%#codegen

% Initialize outputs
Bal1 = 0; Bal2 = 0; Bal3 = 0; Bal4 = 0;

% Thresholds
DeltaV = 0.03;        % 30mV 
Balance_Start = 3.00; 

% Find the Minimum Cell Voltage 
Vmin = min([V1 V2 V3 V4]);

% Balancing logic 
if Charge_Enable
    if V1 >= Balance_Start && (V1 - Vmin) >= DeltaV; Bal1 = 1; end
    if V2 >= Balance_Start && (V2 - Vmin) >= DeltaV; Bal2 = 1; end
    if V3 >= Balance_Start && (V3 - Vmin) >= DeltaV; Bal3 = 1; end
    if V4 >= Balance_Start && (V4 - Vmin) >= DeltaV; Bal4 = 1; end
end
end