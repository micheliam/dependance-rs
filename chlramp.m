function rb = chlramp(n)

if nargin < 1
   n = size(get(gcf,'colormap'),1);
end

x = [1 94 190 250 314 438 497]' - 1;
x = x ./ max(x);

r = [145 0 0 0 255 255 106]./255;
g = [0 0 255 255 255 0 0]./255;
b = [110 255 255 0 0 0 0]./255;

rgb = [r;g;b]';

x = x .* (n-1);

xi = 0:(n-1);
xi = xi';

rb = interp1(x,rgb,xi);