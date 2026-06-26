function [Bal1, Bal2, Bal3, Bal4] = Cell_Balancing(V1, V2, V3, V4, Charge_Enable)
% #codegen
% Passive Cell Balancing Logic based on Minimum Reference Cell (Vmin)

% Parameters
DeltaV_min = 0.02;     % 20mV Balancing Threshold
V_balance_start = 3.00; % Activation Ceiling

% Default Outputs (Switches Off)
Bal1 = uint8(0); Bal2 = uint8(0); Bal3 = uint8(0); Bal4 = uint8(0);

% Master Activation Condition
if (Charge_Enable == 1) && (V1 > V_balance_start || V2 > V_balance_start || V3 > V_balance_start || V4 > V_balance_start)
    
    % Find Vmin Reference dynamically
    V_array = [V1, V2, V3, V4];
    V_min_ref = min(V_array);
    
    % Compare each cell against Vmin and activate bleed switches
    if (V1 - V_min_ref) > DeltaV_min; Bal1 = uint8(1); end
    if (V2 - V_min_ref) > DeltaV_min; Bal2 = uint8(1); end
    if (V3 - V_min_ref) > DeltaV_min; Bal3 = uint8(1); end
    if (V4 - V_min_ref) > DeltaV_min; Bal4 = uint8(1); end
end
end
