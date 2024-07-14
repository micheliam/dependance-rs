clearvars, close all

load spectral_angle_results

% Kdout is the combined spectral angle results for the dependence of Kd
% Kds is the list of Kd scores for which we checked dependence
%
% bbout is the combined spectral angle results for the dependence of bb
% bbs is the list of bb scores for which we checked dependence
%
% Hout is the combined spectral angle results for the dependence of H
% Hs is the list of depths for which we checked dependence
%
% Rbout is the combined spectral angle results for the dependence of coral
% fraction
% coralFraction is the list of coral covers for which we checked dependence

% set coral cover fraction to check
% 11 = 100% coral, 1 = 0% coral
cf = 11;

% master color limit
cax0 = [0 61];

% set to true to use master color limits
useMaster = true;

% colormap to show algae/coral mixture
g = repmat([0.0392 0.5882 0.2784],10,1);
r = repmat([0.9294 0.1216 0.1412],10,1);
f = [0.1:0.1:1]';
g = flipud(f).*g;
r = f.*r;
cmap = r+g;

%% look at Kd
figure

k = Kdout(:,:,cf);
k = cellfun(@mean,k,'uniform',false);
k = k';

ax = gobjects(1,4);

for sp = 1:4
   
   ax(sp) = subplot(2,2,sp);
   kplot = cell2mat(k(:,sp));
   imagesc(Kds,1:10,kplot)
   axis xy
   colormap chlramp
   tst = sprintf('Water Type %d',sp);
   title(tst)
   xlabel('Tested K_d score')
   ylabel('Known Depth (m)')
   
end

ax(1).Position = [0.1 0.625 0.35 0.3];
ax(2).Position = [0.53 0.625 0.35 0.3];
ax(3).Position = [0.1 0.21 0.35 0.3];
ax(4).Position = [0.53 0.21 0.35 0.3];

cbax = colorbar;
cbax.Position = [0.905 0.21 0.02 0.715];
cbax.Label.String = 'Spectral Angle Range (°)';
cbax.Label.Rotation = -90;
cbax.Label.VerticalAlignment = 'bot';
cbax.Label.FontSize = 21;

% coral fraction axes
cfax = axes('pos',[0.1 0.09 0.78 0.02]);
ydata = ones(1,cf-1);
ydata = [ydata;nan(1,cf-1)];
bh = barh(cfax,ydata,'stacked');
set(bh,'BarWidth',1)
xlim(cfax,[0 10])
ylim(cfax,[0.5 1.5])
yticks(cfax,[])
xticklabels(cfax,0:0.1:1)
xlabel(cfax,'Coral Fraction','fontsize',21)

for col = 1:(cf-1)
   bh(col).FaceColor = cmap(col,:);
end


% find color limits for each axes
cax = get(ax,'clim');
cax = cell2mat(cax);

% set color limits of all axes to be the same
cax = [0 max(cax,[],'all')];
fprintf(1,'Kd max = %1.2f\n',cax(2))

% set the color limits
if useMaster
   set(ax,'clim',cax0)
else
   set(ax,'clim',cax)
end

%% look at bb
figure

b = bbout(:,:,cf);
b = cellfun(@mean,b,'uniform',false);
b = b';

ax = gobjects(1,4);

for sp = 1:4
   
   ax(sp) = subplot(2,2,sp);
   bplot = cell2mat(b(:,sp));
   imagesc(bbs,1:10,bplot)
   axis xy
   colormap chlramp
   tst = sprintf('Water Type %d',sp);
   title(tst)
   xlabel('Tested b_b score')
   ylabel('Known Depth (m)')
   
end

ax(1).Position = [0.1 0.625 0.35 0.3];
ax(2).Position = [0.53 0.625 0.35 0.3];
ax(3).Position = [0.1 0.21 0.35 0.3];
ax(4).Position = [0.53 0.21 0.35 0.3];

cbax = colorbar;
cbax.Position = [0.905 0.21 0.02 0.715];
cbax.Label.String = 'Spectral Angle Range (°)';
cbax.Label.Rotation = -90;
cbax.Label.VerticalAlignment = 'bot';
cbax.Label.FontSize = 21;

% coral fraction axes
cfax = axes('pos',[0.1 0.09 0.78 0.02]);
ydata = ones(1,cf-1);
ydata = [ydata;nan(1,cf-1)];
bh = barh(cfax,ydata,'stacked');
set(bh,'BarWidth',1)
xlim(cfax,[0 10])
ylim(cfax,[0.5 1.5])
yticks(cfax,[])
xticklabels(cfax,0:0.1:1)
xlabel(cfax,'Coral Fraction','fontsize',21)

for col = 1:(cf-1)
   bh(col).FaceColor = cmap(col,:);
end


% find color limits for each axes
cax = get(ax,'clim');
cax = cell2mat(cax);

% set color limits of all axes to be the same
cax = [0 max(cax,[],'all')];
fprintf(1,'bb max = %1.2f\n',cax(2))

% set the color limits
if useMaster
   set(ax,'clim',cax0)
else
   set(ax,'clim',cax)
end

%% look at H
figure

h = Hout(:,:,cf);
h = cellfun(@mean,h,'uniform',false);
h = h';

ax = gobjects(1,4);

for sp = 1:4
   
   ax(sp) = subplot(2,2,sp);
   hplot = cell2mat(h(:,sp));
   imagesc(Hs,1:10,hplot)
   axis xy
   colormap chlramp
   tst = sprintf('Water Type %d',sp);
   title(tst)
   xlabel('Tested Depth (m)')
   ylabel('Known Depth (m)')
   
end

ax(1).Position = [0.1 0.625 0.35 0.3];
ax(2).Position = [0.53 0.625 0.35 0.3];
ax(3).Position = [0.1 0.21 0.35 0.3];
ax(4).Position = [0.53 0.21 0.35 0.3];

cbax = colorbar;
cbax.Position = [0.905 0.21 0.02 0.715];
cbax.Label.String = 'Spectral Angle Range (°)';
cbax.Label.Rotation = -90;
cbax.Label.VerticalAlignment = 'bot';
cbax.Label.FontSize = 21;

% coral fraction axes
cfax = axes('pos',[0.1 0.09 0.78 0.02]);
ydata = ones(1,cf-1);
ydata = [ydata;nan(1,cf-1)];
bh = barh(cfax,ydata,'stacked');
set(bh,'BarWidth',1)
xlim(cfax,[0 10])
ylim(cfax,[0.5 1.5])
yticks(cfax,[])
xticklabels(cfax,0:0.1:1)
xlabel(cfax,'Coral Fraction','fontsize',21)

for col = 1:(cf-1)
   bh(col).FaceColor = cmap(col,:);
end


% find color limits for each axes
cax = get(ax,'clim');
cax = cell2mat(cax);

% set color limits of all axes to be the same
cax = [0 max(cax,[],'all')];
fprintf(1,'H max = %1.2f\n',cax(2))

% set the color limits
if useMaster
   set(ax,'clim',cax0)
else
   set(ax,'clim',cax)
end

%% look at Rb
figure

r = Rbout(:,:,cf);
r = cellfun(@mean,r,'uniform',false);
r = r';

ax = gobjects(1,4);

for sp = 1:4
   
   ax(sp) = subplot(2,2,sp);
   rplot = cell2mat(r(:,sp));
   imagesc(coralFraction,1:10,rplot)
   axis xy
   colormap chlramp
   tst = sprintf('Water Type %d',sp);
   title(tst)
   xlabel('Tested Coral Fraction')
   ylabel('Known Depth (m)')
   
end

ax(1).Position = [0.1 0.625 0.35 0.3];
ax(2).Position = [0.53 0.625 0.35 0.3];
ax(3).Position = [0.1 0.21 0.35 0.3];
ax(4).Position = [0.53 0.21 0.35 0.3];

cbax = colorbar;
cbax.Position = [0.905 0.21 0.02 0.715];
cbax.Label.String = 'Spectral Angle Range (°)';
cbax.Label.Rotation = -90;
cbax.Label.VerticalAlignment = 'bot';
cbax.Label.FontSize = 21;

% coral fraction axes
cfax = axes('pos',[0.1 0.09 0.78 0.02]);
ydata = ones(1,cf-1);
ydata = [ydata;nan(1,cf-1)];
bh = barh(cfax,ydata,'stacked');
set(bh,'BarWidth',1)
xlim(cfax,[0 10])
ylim(cfax,[0.5 1.5])
yticks(cfax,[])
xticklabels(cfax,0:0.1:1)
xlabel(cfax,'Coral Fraction','fontsize',21)

for col = 1:(cf-1)
   bh(col).FaceColor = cmap(col,:);
end


% find color limits for each axes
cax = get(ax,'clim');
cax = cell2mat(cax);

% set color limits of all axes to be the same
cax = [0 max(cax,[],'all')];
fprintf(1,'coralFraction max = %1.2f\n',cax(2))

% set the color limits
if useMaster
   set(ax,'clim',cax0)
else
   set(ax,'clim',cax)
end


