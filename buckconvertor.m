% written for EAC3041-N module
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vd= 12; % input Voltage;
Vo= 5; % output Voltage;
io_max=2; %max output current
ESR =0.025; % capacitor resistance
ESL= 0.042; % inductor resistance
fs= 20e3; %switching frequency
VF= 0.4; % diode forward Voltage
Rdson= 2e-3; % MOSFET on resistance
Ro=Vo/io_max; % output resistance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta_iL= 0.3* io_max; % inductor ripple 30% of iL
delta_Vo= 0.1* Vo; %output ripple 10% of Vo
delta_ESR= delta_iL* ESR; % ripple of ESR capacitor
delta_v_total= delta_ESR+ delta_Vo; % total ripple
D= Vo/Vd; % duty ratio
%%%%% calculate the inductor of buck converter
L = (Vo* (1-D))/(fs*delta_iL); %inductor value
Imax= io_max+(delta_iL/2); % inductor peak current without saturation
PL_loss= io_max* ESL; % Inductor_power_loss
%%%%%% power diode%%%%%%%%%%%%%%%%%%%%%%%
PD_F= VF*io_max*(1-D); % diode power; conduction loss at off time
%%%%%%%%%%%power MOSFET at synchronous circuit%%%%%%%%%%%%%%
%P_MOSFET_off= io_max* Rdson (1-D); % at synchronous operation
%P_MOSFET_gate_off= Q_gate*VGS*fs; % gate charge loss.
%%%%% Power MOSFET%%%%%%%%%
P_MOSFET_on= io_max*Rdson*D;
%P_MOSFET_gate_on= Q_gate*VGS*fs; % assumed zero here
%%% output capacitor%%%%%%%%%%%%%%%%%%%%%%%%%%%
C= Vo*(1-D)/(8*L*fs^2*delta_v_total);% output capacitor
PC_loss= delta_iL* ESR; % capacitor power loss
%%%%%%%%efficiency%%%%%%%%%%%%%%
Po=io_max*Vo; %ouptut power
Ploss_total= PC_loss+P_MOSFET_on+PD_F+PL_loss;% total power loss
Pin=Po+Ploss_total; % power input
eff=(Po/Pin)*100; % converter efficiency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%