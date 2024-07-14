clearvars, close all

load simulation_results R_1* R_2* R_3* R_4* wl bb Kd Rb*

load AOP_models_v3_full_res Kd_model bb_model


%% set up test ranges
% Kd
Kds = linspace(0,2);
Kdtest = Kd_model(Kds);
Kdtest = permute(Kdtest,[3 2 1]);

% bb
bbs = linspace(0,0.4);
bbtest = bb_model(bbs);
bbtest = permute(bbtest,[3 2 1]);

% H
Htest = 0:0.1:10;
Htest = permute(Htest,[3 1 2]);

% cover
coralFraction = [0:0.01:1]';
algaeFraction = [1:-0.01:0]';
Rb0 = mean(Rb000);
Rb1 = mean(Rb100);
Rbtest = Rb1.*coralFraction + Rb0.*algaeFraction;
Rbtest = permute(Rbtest,[3 2 1]);


%% get "truth"
a = who('R_*');
s = split(a,'_');

waterType0 = str2double(s(:,2));
coralFraction0 = str2double(s(:,3));
H0 = str2double(s(:,4));

%% initialize variables for storage
nWT = length(unique(waterType0));
nH = length(unique(H0));
nRb = length(unique(coralFraction0));

Kdout = cell(nWT,nH,nRb);
bbout = cell(nWT,nH,nRb);
Hout = cell(nWT,nH,nRb);
Rbout = cell(nWT,nH,nRb);

hwb = waitbar(0,'Working');

%% do testing
for k = 1:length(a)
   
   st = sprintf('Rc0 = %s;',a{k});
   eval(st)
   
   % get current truth parameters
   Kdc = Kd(waterType0(k),:);
   bbc = bb(waterType0(k),:);
   Hc = H0(k);
   WTc = waterType0(k);
   switch coralFraction0(k)
      case 0
         Rbc = Rb000;
         Rbci = 1;
      case 10
         Rbc = Rb010;
         Rbci = 2;
      case 20
         Rbc = Rb020;
         Rbci = 3;
      case 30
         Rbc = Rb030;
         Rbci = 4;
      case 40
         Rbc = Rb040;
         Rbci = 5;
      case 50
         Rbc = Rb050;
         Rbci = 6;
      case 60
         Rbc = Rb060;
         Rbci = 7;
      case 70
         Rbc = Rb070;
         Rbci = 8;
      case 80
         Rbc = Rb080;
         Rbci = 9;
      case 90
         Rbc = Rb090;
         Rbci = 10;
      case 100
         Rbc = Rb100;
         Rbci = 11;
   end
   
   % test Kd
   Rinf = bbc./2./Kdtest;
   
   Rtest = Rinf + (Rbc - Rinf) .* exp(-2.*Kdtest.*Hc);
   
   Rc = repmat(Rc0,1,1,length(Kds));
   
   th = acos(dot(Rtest,Rc,2)./vecnorm(Rtest,2,2)./vecnorm(Rc,2,2));
   thd = rad2deg(th);
   thd = squeeze(thd);
   
   Kdout{WTc,Hc,Rbci} = thd;
   
   
   % test bb
   Rinf = bbtest./2./Kdc;
   
   Rtest = Rinf + (Rbc - Rinf) .* exp(-2.*Kdc.*Hc);
   
   Rc = repmat(Rc0,1,1,length(bbs));
   
   th = acos(dot(Rtest,Rc,2)./vecnorm(Rtest,2,2)./vecnorm(Rc,2,2));
   thd = rad2deg(th);
   thd = squeeze(thd);
   
   bbout{WTc,Hc,Rbci} = thd;
   
   
   % test H
   Rinf = bbc./2./Kdc;
   
   Rtest = Rinf + (Rbc - Rinf) .* exp(-2.*Kdc.*Htest);
   
   Rc = repmat(Rc0,1,1,length(Htest));
   
   th = acos(dot(Rtest,Rc,2)./vecnorm(Rtest,2,2)./vecnorm(Rc,2,2));
   thd = rad2deg(th);
   thd = real(squeeze(thd));
   
   Hout{WTc,Hc,Rbci} = thd;
   
   
   % test coralFraction
   Rinf = bbc./2./Kdc;
   
   Rtest = Rinf + (Rbtest - Rinf) .* exp(-2.*Kdc.*Hc);
   Rtest = repmat(Rtest,100,1,1);
   
   Rc = repmat(Rc0,1,1,length(coralFraction));
   
   th = acos(dot(Rtest,Rc,2)./vecnorm(Rtest,2,2)./vecnorm(Rc,2,2));
   thd = rad2deg(th);
   thd = squeeze(thd);
   
   Rbout{WTc,Hc,Rbci} = thd;
   
   waitbar(k./length(a),hwb);
   
end

delete(hwb);

Hs = squeeze(Htest);

% probably best to now save the results, so you don't need to run the program
% each time
% For example
% >> save spectral_angle_results Kdout bbout Hout Rbout Kds bbs Hs coralFraction
%
% now, to examine the data in the future, just do this:
% >> load spectral_angle_results

%% example plotting
% first, get the spectral angle data from the cell array
% here, use water-type = 3, depth = 2 m, and coral fraction is 50%
%
% load spectral_angle_results
% 
% theta_Kd = Kdout{3,2,6};
% theta_bb = bbout{3,2,6};
% 
% subplot(1,2,1)
% plot(Kds,theta_Kd')
% subplot(1,2,2)
% plot(bbs,theta_bb')