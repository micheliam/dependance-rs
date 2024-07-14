clearvars, close all

% angle between two vectors
x = [0 7;0 7];
y = [0 2;0 5];
x2 = [0 7];
y2 = [0 6];

blue = [0.2235 0.3255 0.6431];
red = [0.9294 0.1216 0.1412];

p = plot(x',y','color',blue,'linewidth',2,'marker','.','markersize',25);
hold on
plot(x2,y2,'color',red,'linewidth',2,'marker','.','markersize',25)
axis square
xlim([0 8])
ylim([0 8])
set(gca,'linewidth',2)
p(2).Color = [0 0 0];

xlabel('x_1')
ylabel('x_2')

u = [2 7];
v = [5 7];
w = [6 7];

costh = dot(u,v)./norm(u)./norm(v);
th = acos(costh);
thd = rad2deg(th);
thd = sprintf('\\theta = %1.2f°',thd);

h1 = text(3,1.5,thd,'fontsize',get(gca,'fontsize'),'color',blue);



costh = dot(w,v)./norm(w)./norm(v);
th = acos(costh);
thd = rad2deg(th);
thd = sprintf('\\theta = %1.2f°',thd);

h1 = text(3,4,thd,'fontsize',get(gca,'fontsize'),'color',red);


% load simulation_results wl R_1_090_03 Rb090
% 
% load AOP_models_v3_full_res Kd_model bb_model
% 
