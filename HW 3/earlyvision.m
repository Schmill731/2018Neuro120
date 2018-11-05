clear all

%% Make mach band image

sz = 1000;
slope = -.003;
[x,y]=meshgrid(-sz/2:sz/2,-sz/2:sz/2);
im_mach = max(-.5,min(.5,x*slope));

imagesc(im_mach)
colormap gray


%% Create and plot DoG filter

%dog = ???
surf(dog)

%% Convolve image and plot the result

%res = ???

imagesc(res)
colormap gray


%% Create checkerboard image

sz = 1000;
stripe_width = 10;
num_stripes = 10;

im_cb = -.5*ones(sz,sz);

for c = round(linspace(1,sz,num_stripes));
    c
    im_cb(c:c+stripe_width,:) = .5;
    im_cb(:,c:c+stripe_width) = .5;
end

imagesc(im_cb)
colormap gray

% Convolve image and plot the result

%res = ???

imagesc(res)
colormap gray

%% Load built-in natural image
im_natural = double(rgb2gray(imread('peppers.png')));
imagesc(im_natural)
colormap gray

%% Convolve and plot the result

%res = ???
imagesc(res)
colormap gray