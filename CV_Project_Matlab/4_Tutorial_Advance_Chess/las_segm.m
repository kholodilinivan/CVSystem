function BW = las_segm(img)
% http://matlabtricks.com/post-35/a-simple-image-segmentation-example-in-
warning('off','Images:initSize:adjustingMag'); 
image = img;     % read image
[height, width, planes] = size(image);
rgb = reshape(image, height, width * planes);
imagesc(rgb);                   % visualize RGB planes 
r = image(:, :, 1);             % red channel
g = image(:, :, 2);             % green channel
b = image(:, :, 3);             % blue channel
threshold = 100;                % threshold value
imagesc(r < threshold);         % display the binarized image
blueness = double(r) - max(double(g), double(b));
imagesc(blueness);              % visualize RGB planes
mask = blueness < 78;
imagesc(mask);
% labels = bwlabel(mask);
R(~mask) = 255;
G(~mask) = 255;
B(~mask) = 255;
J = cat(3,R,G,B);
BW = ~mask;
% Skeletonization
% BW = im2bw(J,0.4);
% BW = bwmorph(BW,'skel',Inf);
imshow(~BW);
end