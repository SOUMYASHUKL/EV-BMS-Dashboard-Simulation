# EV Battery Management System (BMS) Dashboard & Cell Balancing Simulation
## Project Images
![Full Simulink Model](Screenshots/Screenshots/model.png)

## Project Overview
This repository contains a Battery Management System (BMS) developed using MATLAB and Simulink for Electric Vehicle (EV) applications. The project focuses on battery monitoring, safety protection, fault detection, passive cell balancing, and battery state estimation. The simulation demonstrates how a BMS can monitor battery health, protect the battery pack, and improve operational safety.

---

## Key Features

### Battery Safety & Protection

The BMS continuously monitors battery operating conditions and applies protection logic when abnormal conditions are detected.

Protection functions include:

* Over Voltage (OV)
* Under Voltage (UV)
* Over Current during Charging
* Over Current during Discharging
* Short Circuit Detection
* Over Temperature (OT)
* Under Temperature (UT)
* Low State of Charge (SOC)

When a fault is detected, the controller automatically disables charging or discharging to protect the battery pack.

---

### State Estimation

The simulation estimates important battery parameters including:

* State of Charge (SOC)
* State of Voltage (SOV)

SOC is estimated using Coulomb Counting, while SOV is continuously monitored to evaluate battery operating conditions.

---

### Battery Fault Logging

The controller combines multiple protection events into an 8-bit Fault Code.

Fault Mapping:

| Fault                    | Bit   |
| ------------------------ | ----- |
| Over Voltage             | Bit 0 |
| Under Voltage            | Bit 1 |
| Over Current (Charge)    | Bit 2 |
| Over Current (Discharge) | Bit 3 |
| Short Circuit            | Bit 4 |
| Over Temperature         | Bit 5 |
| Under Temperature        | Bit 6 |
| Low SOC                  | Bit 7 |

Example:

If an Over Temperature fault occurs:

* OT = 1
* Charge Enable = 0
* Discharge Enable = 0
* Fault Code = 32

---

### Passive Cell Balancing

The project implements passive balancing for a four-cell battery pack.

Balancing algorithm:

* Detects the minimum cell voltage (Vmin)
* Compares each cell with the minimum voltage
* Activates balancing for cells whose voltage exceeds the balancing threshold
* Stops balancing automatically after voltage equalization

This improves battery life and maintains voltage uniformity among cells.

---

## MATLAB & Simulink Features

* MATLAB Function Blocks
* Simulink Modeling
* Simscape Battery Components
* Dashboard Blocks
* Scope Visualization
* Signal Routing using Bus and Mux Blocks

---

## Simulation Results

The simulation successfully demonstrates:

* Battery protection logic
* Charge and discharge enable control
* SOC estimation
* SOV monitoring
* Fault detection
* Bit-mapped fault codes
* Passive cell balancing
* Dashboard visualization

---

## Folder Structure

```text
EV-BMS-Dashboard-Simulation

├── Simulink_Model/
│   └── BMS_Controller.slx
│
├── MATLAB_Code/
│   ├── BMS_Controller.m
│   └── Cell_Balancing.m
│
├── Screenshots/
│   ├── Full_Model.png
│   ├── Dashboard.png
│   ├── Fault_Detection.png
│   ├── Cell_Balancing.png
│   └── Simulation_Results.png
│
├── Report/
│   └── BMS_Project_Report.pdf
│
└── README.md
```

---

## Technologies Used

* MATLAB
* Simulink
* Simscape Electrical
* MATLAB Function Blocks
* Dashboard Components

---

## Future Improvements

* CAN Bus Communication
* Real-Time Dashboard
* Hardware Integration using Arduino or STM32
* Battery State of Health (SOH) Estimation
* Cloud-based Battery Monitoring

---

## Author

**Soumya Shukla**

B.Tech Electrical & Electronics Engineering (6th Semester)

Interested in:

* Electric Vehicles (EV)
* Battery Management Systems (BMS)
* Embedded Systems
* MATLAB & Simulink
* Power Electronics


