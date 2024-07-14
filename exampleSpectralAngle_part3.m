clearvars, close all


load simulation_results wl R_2_090_03 Rb090 Rb000 Rb100 bb Kd

load AOP_models_v3_full_res Kd_model bb_model

Robs = mean(R_2_090_03);

Rb0 = mean(Rb090);
bb0 = bb(2,:);
Kd0 = Kd(2,:);
H0 = 3;
R0 = bb0./2./Kd0 + (Rb0 - bb0./2./Kd0).*exp(-2.*Kd0.*H0);

coralFraction = [0:0.01:1]';
algaeFraction = [1:-0.01:0]';
Rb = mean(Rb100).*coralFraction + mean(Rb000).*algaeFraction;

% Kd
Kds = linspace(0,2);

Kd = Kd_model(Kds);
Rmod = bb0./2./Kd + (Rb0 - bb0./2./Kd).*exp(-2.*Kd.*H0);

figure
% fullfig3

ax(1) = subplot(2,3,1:3);
plot(wl,Robs,'linewidth',2);
xlabel('wavelength (nm)')
ylabel('R(0^-;H)')

ax(2) = subplot(2,3,4);
plot(wl,Kd0,'linewidth',2)
xlabel('wavelength (nm)')
ylabel('K_d (m^-^1)')

ax(3) = subplot(2,3,5);
plot(wl,bb0,'linewidth',2)
xlabel('wavelength (nm)')
ylabel('b_b (m^-^1)')

ax(4) = subplot(2,3,6);
plot(wl,Rb0,'linewidth',2)
xlabel('wavelength (nm)')
ylabel('R_b')

drawnow

pos1 = plotboxpos(ax(1));
pos2 = plotboxpos(ax(2));
pos3 = plotboxpos(ax(3));
pos4 = plotboxpos(ax(4));

pos2(1) = pos1(1);
pos2(3) = pos3(3);
ax(2).Position = pos2;

set(ax,'linewidth',2)

axes(ax(1))
h = text(650,0.05,'H = 3 m','fontsize',get(gca,'fontsize'));


figure
% fullfig3

clear ax

ax(1) = subplot(4,3,[4 7]);
plot(wl,Kd,'color',[blue 0.5])
xlabel('wavelength (nm)')
ylabel('K_d (m^-^1)')

ax(2) = subplot(4,3,[5 8]);
plot(wl,Rmod,'color',[blue 0.2])
hold on
plot(wl,Robs,'color',blue,'linewidth',2)
xlabel('wavelength (nm)')
ylabel('R(0^-;H)')

Robs = repmat(Robs,100,1);
th = acos(dot(Robs,Rmod,2)./vecnorm(Robs,2,2)./vecnorm(Rmod,2,2));
thd = rad2deg(th);

ax(3) = subplot(4,3,[6 9]);
plot(Kds,thd,'color',blue,'linewidth',2)
xlabel('K_d score')
ylabel('\theta (°)')

set(ax,'linewidth',2)