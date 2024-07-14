clearvars, close all

load simulation_results

load AOP_models_v3_full_res

co = colororder;

figure

%% check Kd

cover = 30;

st = sprintf('Rb0 = Rb%3.3d;',cover);
eval(st);
   
H0 = 8;

Kdscore = linspace(0,2,1000);
Kdtest = Kd_model(Kdscore);

theta = zeros(100,1000,4);

subplot(2,2,1)
hold on

for water_type = 1:4

   bb0 = bb(water_type,:);

   st = sprintf('R0 = R_%d_%3.3d_%2.2d;',water_type,cover,H0);
   eval(st);

   Rinftest = bb0./2./Kdtest;

   for k = 1:length(Kdscore)

      Rtest = Rinftest(k,:) + (Rb0 - Rinftest(k,:)) .* exp(-2.*Kdtest(k,:).*H0);

      theta(:,k,water_type) = acos(dot(Rtest,R0,2)./vecnorm(Rtest,2,2)./vecnorm(R0,2,2));

   end
   
   plot(Kdscore,rad2deg(theta(:,:,water_type)),'color',co(water_type,:))
   
end

theta = rad2deg(theta);

r = range(theta,2);
r = squeeze(r);

subplot(2,2,3)

boxplot(r)

ylim([0 40])

%% check bb

bbscore = linspace(0,0.4,1000);
bbtest = bb_model(Kdscore);

theta = zeros(100,1000,4);

subplot(2,2,2)
hold on

for water_type = 1:4

   Kd0 = Kd(water_type,:);

   st = sprintf('R0 = R_%d_%3.3d_%2.2d;',water_type,cover,H0);
   eval(st);

   Rinftest = bbtest./2./Kd0;

   for k = 1:length(Kdscore)

      Rtest = Rinftest(k,:) + (Rb0 - Rinftest(k,:)) .* exp(-2.*Kd0.*H0);

      theta(:,k,water_type) = acos(dot(Rtest,R0,2)./vecnorm(Rtest,2,2)./vecnorm(R0,2,2));

   end
   
   plot(bbscore,rad2deg(theta(:,:,water_type)),'color',co(water_type,:))
   
end

theta = rad2deg(theta);

r = range(theta,2);
r = squeeze(r);

subplot(2,2,4)

boxplot(r)

ylim([0 40])

%% check H

% bbscore = linspace(0,0.4,1000);
% bbtest = bb_model(Kdscore);
% 
% theta = zeros(100,1000,4);
% 
% subplot(2,2,2)
% hold on
% 
% for water_type = 1:4
% 
%    Kd0 = Kd(water_type,:);
% 
%    st = sprintf('R0 = R_%d_%3.3d_%2.2d;',water_type,cover,H0);
%    eval(st);
% 
%    Rinftest = bbtest./2./Kd0;
% 
%    for k = 1:length(Kdscore)
% 
%       Rtest = Rinftest(k,:) + (Rb0 - Rinftest(k,:)) .* exp(-2.*Kd0.*H0);
% 
%       theta(:,k,water_type) = acos(dot(Rtest,R0,2)./vecnorm(Rtest,2,2)./vecnorm(R0,2,2));
% 
%    end
%    
%    plot(bbscore,rad2deg(theta(:,:,water_type)),'color',co(water_type,:))
%    
% end
% 
% theta = rad2deg(theta);
% 
% r = range(theta,2);
% r = squeeze(r);
% 
% subplot(2,2,4)
% 
% boxplot(r)
% 
% ylim([0 40])