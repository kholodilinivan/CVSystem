clc
clear all
% Laser Segmentation
image = imread('TestImages/image.jpg');
image1 = imread('TestImages/image1.jpg');
img = las_segm(image);
img1 = las_segm(image1);
% Configuration
load('Omni_Calib_Results_116m.mat'); % Calib parameters
ocam_model = calib_data.ocam_model; % Calib parameters
camX =-2.5; % Camera parameters
camY = 6; % Camera parameters
camZ = 3; % Camera parameters
lasX = 1.5; % Laser Plane parameters
lasY = -2.5; % Laser Plane parameters
las_dist = 950; % Laser Plane parameters
CVsyst_x = 0; % CV System initial position
CVsyst_y = 0; % CV System initial position 
CVsyst_rot = 0; % CV System initial rotation
CVsyst_x1 = 200; % CV System second position
CVsyst_y1 = 1600; % CV System second position 
CVsyst_rot1 = 20; % CV System second rotation
% Mapping
[x,y] = mapping(img,CVsyst_rot,CVsyst_x,CVsyst_y,camX,camY,camZ,lasX,lasY,...
    las_dist,ocam_model); % mapping function
[x1,y1] = mapping(img1,CVsyst_rot1,CVsyst_x1,CVsyst_y1,camX,camY,camZ,lasX,...
    lasY,las_dist,ocam_model); % mapping function
% Finally figure:
figure;
scatter(x,y,5,'filled'); % Laser intersections, first image
hold on;
plot(CVsyst_x,CVsyst_y,'r*'); % CV System location, first image
scatter(x1,y1,5,'filled'); % Laser intersections, second image
plot(CVsyst_x1,CVsyst_y1,'r*'); % CV System location, second image
grid on;