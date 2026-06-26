function [Charge_Enable, Discharge_Enable, Fault_Code] = BMS_Controller(V, I, T, SOC, Ts)
% #codegen
% Comprehensive BMS Controller with 8-Bit Fault Bit-Mapping

% Thresholds Configuration
V_max = 54.0; V_min = 42.0;
I_chg_max = 5.0; I_dis_max = 8.0; I_short = 20.0;
T_max = 60.0; T_min = 0.0;
SOC_cutoff = 0.20; SOC_recover = 0.25;

% Initialize Flags & Persistent Memory for SOC Hysteresis
OV = 0; UV = 0; OC_Charge = 0; OC_Discharge = 0; SC = 0; OT = 0; UT = 0;
persistent SOC_Low_State;
if isempty(SOC_Low_State)
    SOC_Low_State = 0;
end

% 1. Protection Logic Diagnostics
if V > V_max; OV = 1; end
if V < V_min; UV = 1; end
if I > I_dis_max; OC_Discharge = 1; end
if I < -I_chg_max; OC_Charge = 1; end
if I >= I_short; SC = 1; end
if T > T_max; OT = 1; end
if T < T_min; UT = 1; end

% SOC Hysteresis Protection
if SOC <= SOC_cutoff
    SOC_Low_State = 1;
elseif SOC >= SOC_recover
    SOC_Low_State = 0;
end

% 2. 8-Bit Bitwise Fault Code Generation
Fault_Code = uint8(OV*1 + UV*2 + OC_Charge*4 + OC_Discharge*8 + SC*16 + OT*32 + UT*64 + SOC_Low_State*128);

% 3. Master Contactor Control Enablers
if Fault_Code > 0
    Charge_Enable = uint8(0);
    Discharge_Enable = uint8(0);
else
    Charge_Enable = uint8(1);
    Discharge_Enable = uint8(1);
end
end
