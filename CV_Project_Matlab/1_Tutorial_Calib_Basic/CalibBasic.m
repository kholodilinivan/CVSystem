clc
clear all
load('Omni_Calib_Results_116m.mat'); % Calib parameters
ocam_model = calib_data.ocam_model; % Calib parameters
i = calib_data.n_ima;
calib_data.L(i+1)={'TestImages/image.jpg'};
use_corner_find=1;
[callBack,Xp_abs_,Yp_abs_] = ...
    get_checkerboard_cornersUrban(i+1,use_corner_find,calib_data);
Xt = calib_data.Xt;
Yt = calib_data.Yt;
imagePoints = [Yp_abs_,Xp_abs_];
% first image extrinsic
[RRfin,ss]=calibrate(Xt, Yt, Xp_abs_, Yp_abs_, ocam_model);
RRfin_=FindTransformMatrix(Xp_abs_, Yp_abs_, Xt, Yt, ocam_model, RRfin);
% find distance
Y1 = RRfin_(1,3)
%% second image
i = calib_data.n_ima;
calib_data.L(i+1)={'TestImages/image1.jpg'};
use_corner_find=1;
[callBack,Xp_abs_,Yp_abs_] = ...
    get_checkerboard_cornersUrban(i+1,use_corner_find,calib_data);
Xt = calib_data.Xt;
Yt = calib_data.Yt;
imagePoints = [Yp_abs_,Xp_abs_];
% first image extrinsic
[RRfin,ss]=calibrate(Xt, Yt, Xp_abs_, Yp_abs_, ocam_model);
RRfin_=FindTransformMatrix(Xp_abs_, Yp_abs_, Xt, Yt, ocam_model, RRfin);
% find distance
Y2 = RRfin_(2,3)