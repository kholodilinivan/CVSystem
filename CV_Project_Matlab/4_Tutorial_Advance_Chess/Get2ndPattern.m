function [I,name] = Get2ndPattern(i,imagePoints,calib_data)
pause(0.8);
figure;
pause(0.8);
% set(gcf,'WindowState','fullscreen');
pause(0.8);
warning('off','Images:initSize:adjustingMag');
imshow(calib_data.L{i+1});
hold on
plot(imagePoints(:,1),imagePoints(:,2),'o-','LineWidth',19);
hold off
export_fig '2ndPattern.jpg' -native;
I = imread('2ndPattern.jpg');
name = '2ndPattern.jpg';
end