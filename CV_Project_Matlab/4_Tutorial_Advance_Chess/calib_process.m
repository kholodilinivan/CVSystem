function [c_x,c_y,c_z,l_x,l_y,z_las_dist,Y1,Y2,ocam_model] = calib_process

load('Omni_Calib_Results_116m.mat');
ocam_model = calib_data.ocam_model;
i = calib_data.n_ima;
calib_data.L(i+1)={'TestImages/image.jpg'};
use_corner_find=1;
[callBack,Xp_abs_,Yp_abs_] = ...
    get_checkerboard_cornersUrban(i+1,use_corner_find,calib_data);
Xt = calib_data.Xt;
Yt = calib_data.Yt;
imagePoints = [Yp_abs_,Xp_abs_]; 
% second pattern
[II, name] = Get2ndPattern(i,imagePoints,calib_data);
calib_data.L(i+2)={name};
use_corner_find=1;
[callBack,Xp_abs_1,Yp_abs_1] = ...
    get_checkerboard_cornersUrban(i+2,use_corner_find,calib_data);
imagePoints1 = [Yp_abs_1,Xp_abs_1];
%% first image extrinsic
if max(imagePoints(:,1)) > max(imagePoints1(:,1))
    imagePoints0 = imagePoints;
    imagePoints = imagePoints1;
    imagePoints1 = imagePoints0;
    Xp_abs_ = imagePoints(:,2);
    Yp_abs_ = imagePoints(:,1);
    Xp_abs_1 = imagePoints1(:,2);
    Yp_abs_1 = imagePoints1(:,1);
end
[RRfin,ss]=calibrate(Xt, Yt, Xp_abs_, Yp_abs_, ocam_model); 
RRfin_=FindTransformMatrix(Xp_abs_, Yp_abs_, Xt, Yt, ocam_model, RRfin);
% second image extrinsic
[RRfin1,ss]=calibrate(Xt, Yt, Xp_abs_1, Yp_abs_1, ocam_model); 
RRfin1_=FindTransformMatrix(Xp_abs_1, Yp_abs_1, Xt, Yt, ocam_model, RRfin);
%% obtain camera orientation and distance to patterns from camera
[M,M1] = show_patterns(0,0,0,i,RRfin_,RRfin1_,calib_data); % 0,0,0 – means that camera is not rotated (we don’t know its rotation)
% first pattern
angle_y = atand(diff([M(3,9),M(3,1)])/diff([M(1,9),M(1,1)]));
angle_z = atand(diff([M(2,9),M(2,1)])/diff([M(1,9),M(1,1)]));
angle_x = atand(diff([M(2,46),M(2,1)])/diff([M(3,46),M(3,1)]));
% second pattern
angle_y1 = atand(diff([M1(1,46),M1(1,1)])/diff([M1(3,46),M1(3,1)]));
angle_z1 = atand(diff([M1(1,9),M1(1,1)])/diff([M1(2,9),M1(2,1)]));
angle_x1 = atand(diff([M1(3,9),M1(3,1)])/diff([M1(2,9),M1(2,1)]));
% mean value with regards to the two patterns
camX = sign(angle_x)*(abs(angle_x)+abs(angle_x1))/2;
camY = sign(angle_y)*(abs(angle_y)+abs(angle_y1))/2;
camZ = sign(angle_z)*(abs(angle_z)+abs(angle_z1))/2;
%% find distance
[M,M1] = show_patterns(camX,camY,camZ,i,RRfin_,RRfin1_,calib_data); % camX,camY,camZ - means that camera is rotated (we know its rotation)
Y1 = mean(M(2,:));
Y2 = mean(M1(1,:));
%
t1 = [0;Y1;0];
r1 = [1,0,0;0,1,0;0,0,1];
r1 = [r1(:,1),r1(:,3),t1];
r1_ = compose_rotation(-angle_x, -angle_y, angle_z);
r1 = r1_*r1;

t2 = [Y2;0;0];
r2 = [1,0,0;0,1,0;0,0,1];
r2 = [r2(:,2),r2(:,3),t2];
r2_ = compose_rotation(angle_x1, angle_y1, -angle_z1);
r2 = r2_*r2;
%% image intersections (obtain laser angles)
I1 = imread('TestImages/image1.jpg');
I = las_segm(I1);
[Cent,Cent1] = intersections_2img_curve(I,imagePoints,imagePoints1);
%% world intersections
% first chess
[z_1,x_1] = intersections_world(Cent,r1,ocam_model);
[Z_1,X_1] = intersections_world(imagePoints,r1,ocam_model);
hh = figure;
hh = axes;
set(hh, 'Xdir', 'reverse');
hold on
plot(x_1,z_1,'ro');
xlim([Y2 inf]);
% h = lsline;
plot(X_1,Z_1,'co');
xlim([Y2 inf]);
hold off
% second chess
[z_2,x_2] = intersections_world(Cent1,r2,ocam_model);
[Z_2,X_2] = intersections_world(imagePoints1,r2,ocam_model);
figure;
hold on
plot(x_2,z_2,'ro');
xlim([Y1 inf]);
% h = lsline;
plot(X_2,Z_2,'co');
xlim([Y1 inf]);
hold off
%% fit plane to the world laser points
X_p1 = x_1;
X_p1 = reshape(X_p1,[length(X_p1),1]);
Y_p1 = [];
for j = 1:length(x_1)
    Y_p1(j) = Y1;
end
for j = 1:length(x_2)
    X_p1(length(x_1)+j) = Y2;
end
Y_p1 = [Y_p1, x_2];
Y_p1 = reshape(Y_p1,[length(Y_p1),1]);
Z_p1 = [z_1,z_2];
Z_p1 = reshape(Z_p1,[length(Z_p1),1]);
% https://youtu.be/U4eRSL16KzA
A = [X_p1, Y_p1, ones(size(X_p1))];
v = Z_p1;
result = A\v;
a = result(1);
b = result(2);
c = result(3);
% distance between camera and laser plane
z_las_dist = a*0 + b*0 + c;
lasX_ = -(atand(((a*0+b*0+c)-(a*0+b*300+c))/300));
lasY_ = (atand(((a*0+b*0+c)-(a*300+b*0+c))/300));
lasX = lasX_;
lasY = lasY_;
%% plot plane with the fitted laser points
figure;
plot3(X_p1,Y_p1,Z_p1,'r.');
hold on
[XXX YYY] = meshgrid(-1250:0,-750:450);
Zplot = a*XXX+b*YYY+c;
mesh(XXX,YYY,Zplot)

% send back
c_x = -camY;
c_y=-camX;
c_z=camZ;
l_x=-lasY_;
l_y=-lasX_;