clc
clear all
close all
load -ascii two_Bus2.gf46\twb_01.out
load -ascii two_Bus2.gf46\twb_02.out
time = twb_01(:,1);
VaM_mag = twb_01(:,7);
VbM_mag = twb_01(:,6);
VcM_mag = twb_01(:,5);

VaM_angle = twb_01(:,4);
VbM_angle = twb_01(:,3);
VcM_angle = twb_01(:,2);

IaM_mag = twb_02(:,3);
IbM_mag = twb_02(:,2);
IcM_mag = twb_01(:,11);

IaM_angle = twb_01(:,10);
IbM_angle = twb_01(:,9);
IcM_angle = twb_01(:,8);

VaM_ph = VaM_mag.*(cos(VaM_angle.*(pi/180))+(sin(VaM_angle.*(pi/180)))*1i);
VbM_ph = VbM_mag.*(cos(VbM_angle.*(pi/180))+(sin(VbM_angle.*(pi/180)))*1i);
VcM_ph = VcM_mag.*(cos(VcM_angle.*(pi/180))+(sin(VcM_angle.*(pi/180)))*1i);
IaM_ph = IaM_mag.*(cos(IaM_angle.*(pi/180))+(sin(IaM_angle.*(pi/180)))*1i);
IbM_ph = IbM_mag.*(cos(IbM_angle.*(pi/180))+(sin(IbM_angle.*(pi/180)))*1i);
IcM_ph = IcM_mag.*(cos(IcM_angle.*(pi/180))+(sin(IcM_angle.*(pi/180)))*1i);
l = exp(1i*2*pi/3);
Ia1 = (IaM_ph+l*IbM_ph+l^2*IcM_ph)/3;
Ia2 = (IaM_ph+l^2*IbM_ph+l*IcM_ph)/3;
Ia0 = (IaM_ph+IbM_ph+IcM_ph)/3;
Va1 = (VaM_ph+l*VbM_ph+l^2*VcM_ph)/3;
Va2 = (VaM_ph+l^2*VbM_ph+l*VcM_ph)/3;
Va0 = (VaM_ph+VbM_ph+VcM_ph)/3;
%Line Impedance
%--------------------------------------------------------------------------
% Z1 = 0.02 + (0.2867)*1i; %positive sequence impedance per Km
% Z0 = 0.10645 + (0.836989)*1i; %zero sequence impedance per Km
%--------------------------------------------------------------------------
%Line Length 78
%--------------------------------------------------------------------------
% line_length78 = 200;
% line_length89 = 120;
% Z1L = Z1*line_length78;
% Z0L = Z0*line_length78;
% Z2L=Z1L;
% Z_L = [abs(Z1L) angle(Z1L)*180/pi; abs(Z0L) angle(Z0L)*180/pi];
% Zone_178 = 0.8*(Z1)*line_length78;
% Zone_278 = (Z1)*line_length78 + 0.5*Z1*line_length89;
% % Zone_378 = Z1*line_length78 + 1.2*Z1*line_length89;
% xx79 = 0:real(Z1L)/100:real(Z1L);
% yy79 = 0:imag(Z1L)/100:imag(Z1L);
% fault_dist = 80;
%%fault_dist = input('fault location: ');
%%--------------------------AG_start---------------------------%%
% Zapp = (Va_ph./(Ia_ph+(((Z0L-Z1L)/Z1L)*Ia0)));
%%--------------------------BC_start---------------------------%%
%%Zapp = ((Vb_ph-Vc_ph)./(Ib_ph-Ic_ph));
%Zapp = (((Vb1+Vb2+Vb0)-(Vc1+Vc2+Vc0))./((Ib1+Ib2+Ib0)-(Ic1+Ic2+Ic0)))
%%--------------------------BCG_start---------------------------%%
%%Zapp = ((Vb_ph-Vc_ph)./(Ib_ph-Ic_ph));
%Zapp = (((Vb1+Vb2+Vb0)-(Vc1+Vc2+Vc0))./((Ib1+Ib2+Ib0)-(Ic1+Ic2+Ic0)));
% Xact = (0.2867*fault_dist);
% Ract = (0.02*fault_dist);
% Zapp_cal = Zapp(6000);
% X_cal = imag(Zapp_cal);
% R_cal = real(Zapp_cal);
ia1 = (Ia1(6000));
threshold_zero=0.1;
phase_delta_Ia1 = angle(Ia1(6000)-Ia1(2000))*180/pi
ia2 = (Ia2(7000));
a=abs(ia2)
phase_Ia2 = angle(Ia2(6000))*180/pi
phase_difference_Ia2_Ia1 = phase_Ia2-phase_delta_Ia1
ia0= (Ia0(6000));
b=abs(ia0)
phase_Ia0= angle(Ia0(6000))*180/pi
phase_diff_Ia2_Ia0  = phase_Ia2-phase_Ia0
% --- Plot: Phase Difference Ia2 - Ia1 (No Fault Lines) ---
figure;
plot(time, (angle(Ia2)-angle(Ia1))*(180/pi), 'r', 'LineWidth', 1.5); hold on;
xlabel('Time (s)');
ylabel('$\partial 1^{+}$ (deg)', 'Interpreter', 'latex');
title('Phase Difference (Ia2 - Ia1)');
grid on;
% figure;
% plot(time, angle(Ia1)*(180/pi), 'b', 'LineWidth', 1.2); hold on;
% plot(time, angle(Ia2)*(180/pi), 'r', 'LineWidth', 1.2);
% plot(time, angle(Ia0)*(180/pi), 'g', 'LineWidth', 1.2);
% xlabel('Time (s)');
% ylabel('Angle (deg)');
% legend('Ia1','Ia2','Ia0');
% title('Sequence Component Angles');
% grid on;
figure;
plot(time, angle(Ia1)*(180/pi), 'b', 'LineWidth', 1.2); hold on;
plot(time, angle(Ia2)*(180/pi), 'r', 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Angle (deg)');
legend('Ia1','Ia2');
title('Sequence Component Angles');
grid on;

a = arduino('COM3','Uno'); % Replace COM3 with your Arduino port
configurePin(a,'D2','DigitalOutput'); % Fault A LED 
configurePin(a,'D3','DigitalOutput'); % Fault B LED 
configurePin(a,'D4','DigitalOutput'); % Fault C LED 
configurePin(a,'D5','DigitalOutput'); % Ground LED% After computing Ia1, Ia2, Ia0 
angle_diff = phase_difference_Ia2_Ia1 ; % example


if(abs(ia2)>threshold_zero)
    if (angle_diff > -15 && angle_diff < 15 && abs(ia0) > threshold_zero)
        % Phase-A + Ground
        writeDigitalPin(a,'D2',1);
        writeDigitalPin(a,'D5',1);
        pause(2);
        writeDigitalPin(a,'D2',0);
        writeDigitalPin(a,'D5',0);
    elseif (angle_diff > 105 && angle_diff < 135 && abs(ia0) > threshold_zero)
        % Phase-B + Ground
        writeDigitalPin(a,'D3',1);
        writeDigitalPin(a,'D5',1);
        pause(2);
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D5',0);
    elseif (angle_diff > 225 && angle_diff < 255 && abs(ia0) > threshold_zero)
        % Phase-C + Ground
        writeDigitalPin(a,'D4',1);
        writeDigitalPin(a,'D5',1);
        pause(2);
        writeDigitalPin(a,'D4',0);
        writeDigitalPin(a,'D5',0);
    elseif (angle_diff > 45 && angle_diff < 75 && abs(ia0) > threshold_zero)
        % ABG fault
        writeDigitalPin(a,'D2',1);
        writeDigitalPin(a,'D3',1);
        writeDigitalPin(a,'D5',1);
        pause(2);
        writeDigitalPin(a,'D2',0);
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D5',0);
        elseif (angle_diff > 45 && angle_diff < 75 && abs(ia0) < threshold_zero)
        % AB fault
        writeDigitalPin(a,'D2',1);
        writeDigitalPin(a,'D3',1);
       
        pause(2);
        writeDigitalPin(a,'D2',0);
        writeDigitalPin(a,'D3',0);
       
    elseif (angle_diff > 165 && angle_diff < 195 && abs(ia0) > threshold_zero)
        % BCG fault
        writeDigitalPin(a,'D3',1);
        writeDigitalPin(a,'D4',1);
        writeDigitalPin(a,'D5',1);
        pause(2);
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D4',0);
        writeDigitalPin(a,'D5',0);
           
    elseif (angle_diff > 165 && angle_diff < 195 && abs(ia0) < threshold_zero)
        % BC fault
        writeDigitalPin(a,'D3',1);
        writeDigitalPin(a,'D4',1);
      
        pause(2);
        writeDigitalPin(a,'D3',0);
        writeDigitalPin(a,'D4',0);
        
    elseif (angle_diff > 285 && angle_diff < 315 && abs(ia0) > threshold_zero)
        % ACG fault
        writeDigitalPin(a,'D2',1);
        writeDigitalPin(a,'D4',1);
        writeDigitalPin(a,'D5',1);
        pause(2);
        writeDigitalPin(a,'D2',0);
        writeDigitalPin(a,'D4',0);
        writeDigitalPin(a,'D5',0);
       
    elseif (angle_diff > 285 && angle_diff < 315 && abs(ia0) < threshold_zero)
        % AC fault
        writeDigitalPin(a,'D2',1);
        writeDigitalPin(a,'D4',1);
      
        pause(2);
        writeDigitalPin(a,'D2',0);
        writeDigitalPin(a,'D4',0);
        
    end
   
elseif (abs(ia2) < threshold_zero)
    % Three-phase fault (no ground)
    writeDigitalPin(a,'D2',1);
    writeDigitalPin(a,'D3',1);
    writeDigitalPin(a,'D4',1);
    writeDigitalPin(a,'D5',1);
    pause(2);
    writeDigitalPin(a,'D2',0);
    writeDigitalPin(a,'D3',0);
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D5',0);
end