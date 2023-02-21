clc
clear all
[camX,camY,camZ,lasX_,lasY_,z_las_dist,Y1,Y2,ocam_model] = calib_process;
% mapping
image = imread('TestImages/image2.jpg');
figure;
img = las_segm(image);
[x,y] = mapping(img,camX,camY,camZ,lasX_,lasY_,-z_las_dist,ocam_model);
CVsyst_x = 0; % CV System position
CVsyst_y = 0; % CV System position
% Finally figure:
figure;
scatter(x,y,5,'filled'); % Laser intersections
hold on;
plot(CVsyst_x,-CVsyst_y,'r*'); % CV System location
grid on;
% Results validation
% Left Cube
i=[428;521]; % working image region - column
j=[623;878]; % working image region - row
[Cube_L] = cube_dist(img,i,j,camX,camY,camZ,lasX_,lasY_,z_las_dist,ocam_model);
Cube_L = mean(Cube_L(:,1));
% Up Cube
i=[620;800]; % working image region - column
j=[269;330]; % working image region - row
[Cube_Up] = cube_dist(img,i,j,camX,camY,camZ,lasX_,lasY_,z_las_dist,ocam_model);
Cube_Up = mean(Cube_Up(:,2));
% Right Cube
i=[1151;1319]; % working image region - column
j=[368;530]; % working image region - row
[Cube_R] = cube_dist(img,i,j,camX,camY,camZ,lasX_,lasY_,z_las_dist,ocam_model);
[x,y] = mapping(img,camX,camY,camZ,lasX_,lasY_,z_las_dist,ocam_model);
Cube_R = mean(Cube_R(:,1)); 