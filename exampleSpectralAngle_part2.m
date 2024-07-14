clearvars, close all


load simulation_results wl R_1_090_03 Rb090

load AOP_models_v3_full_res Kd_model bb_model

Robs = mean(R_1_090_03);

Rb = mean(Rb090);

Kd = Kd_model(0.15);
bb = bb_model(0.02);

H = [1 3 7]';

Rmod = bb./2./Kd + (Rb - bb./2./Kd).*exp(-2.*Kd.*H);

plot(wl,Robs,'linewidth',2,'color',[0 0 0])
hold on
plot(wl,Rmod,'linewidth',2)

co = colororder;

Robs = repmat(Robs,3,1);

th = acos(dot(Robs,Rmod,2)./(vecnorm(Robs,2,2).*vecnorm(Rmod,2,2)));
thd = rad2deg(th);

thst{1} = sprintf('\\theta = %1.2f°',thd(1));
thst{2} = sprintf('\\theta = %1.2f°',thd(2));
thst{3} = sprintf('\\theta = %1.2f°',thd(3));

t = text(425,0.0625,thst,'fontsize',get(gca,'fontsize'));

xlabel('wavelength (nm)')
ylabel('R(0^-;H)')