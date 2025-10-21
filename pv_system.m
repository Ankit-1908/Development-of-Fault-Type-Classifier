clc
clear all
close all

load -ascii pv_grid_NAGC.gf46\sp2adap_01.out
load -ascii pv_grid_NAGC.gf46\sp2adap_13.out
load -ascii pv_grid_NAGC.gf46\sp2adap_14.out
load -ascii pv_grid_NAGC.gf46\sp2adap_15.out


time = sp2adap_01(:,1);
VaM_mag =  sp2adap_15(:,2);
VbM_mag =  sp2adap_14(:,11);
VcM_mag = sp2adap_14(:,10);

VaM_angle =  sp2adap_14(:,8);
VbM_angle =  sp2adap_14(:,7);
VcM_angle = sp2adap_14(:,6);

IaM_mag =  sp2adap_14(:,2);
IbM_mag =  sp2adap_13(:,11);
IcM_mag = sp2adap_13(:,10);

IaM_angle =  sp2adap_13(:,9);
IbM_angle = sp2adap_13(:,8);
IcM_angle =  sp2adap_13(:,7);

VaM_ph = VaM_mag .* (cos(VaM_angle * (pi / 180)) + 1i * sin(VaM_angle * (pi / 180)));
VbM_ph = VbM_mag .* (cos(VbM_angle * (pi / 180)) + 1i * sin(VbM_angle * (pi / 180)));
VcM_ph = VcM_mag .* (cos(VcM_angle * (pi / 180)) + 1i * sin(VcM_angle * (pi / 180)));

IaM_ph = IaM_mag .* (cos(IaM_angle * (pi / 180)) + 1i * sin(IaM_angle * (pi / 180)));
IbM_ph = IbM_mag .* (cos(IbM_angle * (pi / 180)) + 1i * sin(IbM_angle * (pi / 180)));
IcM_ph = IcM_mag .* (cos(IcM_angle * (pi / 180)) + 1i * sin(IcM_angle * (pi / 180)));

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
phase_delta_Ia1 = angle(Ia1(22000)-Ia1(18000))*180/pi
phase_Ia2 = angle(Ia2(22000))*180/pi
phase_difference_Ia2_Ia1 = phase_Ia2-phase_delta_Ia1
phase_Ia0= angle(Ia0(22000))*180/pi
phase_diff_Ia2_Ia0  = phase_Ia2-phase_Ia0



% --- Plot: Phase Difference Ia2 - Ia1 (No Fault Lines) ---
figure;
plot(time, (angle(Ia2)-angle(Ia1))*(180/pi), 'r', 'LineWidth', 1.5); hold on;
xlabel('Time (s)');
ylabel('$\partial 1^{+}$ (deg)', 'Interpreter', 'latex');
title('Phase Difference (Ia2 - Ia1)');
grid on;

figure;
plot(time, angle(Ia1)*(180/pi), 'b', 'LineWidth', 1.2); hold on;
plot(time, angle(Ia2)*(180/pi), 'r', 'LineWidth', 1.2);
plot(time, angle(Ia0)*(180/pi), 'g', 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Angle (deg)');
legend('Ia1','Ia2','Ia0');
title('Sequence Component Angles');
grid on;

% figure;
% plot(time, angle(Ia1)*(180/pi), 'b', 'LineWidth', 1.2); hold on;
% plot(time, angle(Ia2)*(180/pi), 'r', 'LineWidth', 1.2);
% 
% xlabel('Time (s)');
% ylabel('Angle (deg)');
% legend('Ia1','Ia2');
% title('Sequence Component Angles');
% grid on;