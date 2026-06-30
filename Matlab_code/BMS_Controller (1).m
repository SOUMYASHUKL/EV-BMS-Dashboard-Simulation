function [SOC, SOH, Charge_Enable, Discharge_Enable, ...
    OV, UV, OC_Charge, OC_Discharge, SC, ...
    OT, UT, SOC_Low, Fault_Code] = ...
    BMS_Controller(I, V, T, Ts, SOC_prev, SOH_prev)

%#codegen
% Comprehensive Day 10 Final BMS Controller Architecture

%% Persistent variable for SOC hysteresis (Internal Memory)
persistent SOC_Low_mem
if isempty(SOC_Low_mem)
    SOC_Low_mem = 0;
end
if ~(SOC_Low_mem == 0 || SOC_Low_mem == 1)
    SOC_Low_mem = 0;
end

%% Safe Initialization Guard
if isempty(SOC_prev) || SOC_prev <= 0.01
    SOC_prev = 1.0;
end
if isempty(SOH_prev) || SOH_prev <= 0.01
    SOH_prev = 1.0;
end

%% Battery Parameters
C_nom = 50;          %% Nominal Capacity (Ah)
SOC_cutoff = 0.20;   %% 20%% Cutoff threshold
SOC_recover = 0.25;  %% 25%% Recovery threshold

V_min = 42;          %% Minimum Pack Voltage (V)
V_max = 54;          %% Maximum Pack Voltage (V)

I_chg_max = 5;       %% Max Charge Current Limit (A)
I_dis_max = 8;       %% Max Discharge Current Limit (A)
I_short   = 20;      %% Short Circuit Threshold (A)

T_min = 0;           %% Minimum Temperature Limit (°C)
T_max = 60;          %% Maximum Temperature Limit (°C)

%% SOC Estimation (Simplified Coulomb Counting)
SOC = SOC_prev - (I * Ts) / (3600 * C_nom);
SOC = max(0.0, min(1.0, SOC));

%% SOH Estimation (Aging based on Total Throughput)
SOH = SOH_prev - (abs(I) * Ts) / (3600 * 200000);
SOH = max(0.70, min(1.0, SOH));

%% Protection Logic (Voltage & Temperature Flags)
OV = double(V > V_max);
UV = double(V < V_min);
OT = double(T > T_max);
UT = double(T < T_min);

%% Advanced Current Protection (SC and OC Separation)
SC           = 0;
OC_Discharge = 0;
OC_Charge    = 0;

if abs(I) >= I_short
    SC = 1;               
elseif I > I_dis_max
    OC_Discharge = 1;     
elseif I < -I_chg_max
    OC_Charge = 1;        
end

%% SOC Hysteresis Protection Logic
if SOC <= SOC_cutoff
    SOC_Low_mem = 1;
elseif SOC >= SOC_recover
    SOC_Low_mem = 0;
end
SOC_Low = SOC_Low_mem;

%% Contactors Control Logic (Enable/Disable Paths)
Discharge_Enable = double(~(UV || OC_Discharge || SC || OT || SOC_Low));
Charge_Enable    = double(~(OV || OC_Charge || SC || OT || UT));

%% Fault Code (Professional Bit-Mapped Output)
Fault_Code = double( ...
    OV               * 1   ... %% Bit 0 (Value: 1)
    + UV             * 2   ... %% Bit 1 (Value: 2)
    + OC_Charge      * 4   ... %% Bit 2 (Value: 4)
    + OC_Discharge   * 8   ... %% Bit 3 (Value: 8)
    + SC             * 16  ... %% Bit 4 (Value: 16)
    + OT             * 32  ... %% Bit 5 (Value: 32)
    + UT             * 64  ... %% Bit 6 (Value: 64)
    + SOC_Low        * 128);   %% Bit 7 (Value: 128)

end
