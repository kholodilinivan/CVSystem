function [Cent,Cent1] = intersections_2img_curve(I,imgPoints0,imgPoints1)
[height,width] = size(I);
% first image
% Change matrix of the checkherboard
b=1;
d=1;
for c=1:9
    d = c;
    for i=1:6
        Im(b,:) = imgPoints0(d,:);
        b = b+1;
        d = d+9;
    end
end
Xp_abs_1 = Im(:,2);
Yp_abs_1 = Im(:,1);
imgPoints0 = [Yp_abs_1,Xp_abs_1];
% mask http://qaru.site/questions/13446091/creating-a-mask-using-a-binary-image-matlab
% poly mask https://ww2.mathworks.cn/help/images/ref/poly2mask.html
img = I;
img = im2double(img);
y=Yp_abs_1;
x=Xp_abs_1;
xi = [y(1);y(2);y(3);y(4);y(5);y(6);y(12);y(18);y(24);y(30);y(36);y(42);...
      y(48);y(54);y(53);y(52);y(51);y(50);y(49);y(43);y(37);y(31);y(25);...
      y(19);y(13);y(7)];
yi = [x(1);x(2);x(3);x(4);x(5);x(6);x(12);x(18);x(24);x(30);x(36);x(42);...
      x(48);x(54);x(53);x(52);x(51);x(50);x(49);x(43);x(37);x(31);x(25);...
      x(19);x(13);x(7)];
bw = poly2mask(xi,yi,height,width);
a1=round(min(Xp_abs_1));
a2=round(max(Xp_abs_1));
b1=round(min(Yp_abs_1));
b2=round(max(Yp_abs_1));
res2 = img.*bw;
res2 = ~res2;
imshow(res2);
export_fig Test.png -native;
RGB = imread('Test.png');
RGB = ~RGB;
imshow(RGB);
image = RGB;
a = 1;
x_1=[];
z_1=[];
for j = a1:a2     % working image region
    for i= b1:b2
        if image(j,i)>0
            m=[j;i];       % image pixels
            z_1(a) = j;
            x_1(a) = i;
            a=a+1;
        end
    end
end
plot(z_1,x_1,'mo');
hold on
% fitobject=fit(z_1',x_1','poly2','Normalize','on','Robust','Bisquare');
fitobject=polyfit(z_1',x_1',2); % f(x) = p1*x^2 + p2*x + p3
plot(fitobject);
v = 1;
z_1 = sort(z_1); 
for i = z_1(1):z_1(length(z_1))
	x(v) = i;
    % y(v) = fitobject(x(v));
    y(v) = fitobject(1)*(x(v))^2+fitobject(2)*x(v)+fitobject(3);
    v = v+1;
end
plot(x,y,'bo');
hold off
Cent=[y,x];
b=1;
d=1;
for c=1:9
    d = c;
    for i=1:6
        Im(b,:) = imgPoints1(d,:);
        b = b+1;
        d = d+9;
    end
end
Xp_abs_1 = Im(:,2);
Yp_abs_1 = Im(:,1);
imgPoints1 = [Yp_abs_1,Xp_abs_1];
% mask http://qaru.site/questions/13446091/creating-a-mask-using-a-binary-image-matlab
% poly mask https://ww2.mathworks.cn/help/images/ref/poly2mask.html
img = I;
img = im2double(img);
y=Yp_abs_1;
x=Xp_abs_1;
xi = [y(1);y(2);y(3);y(4);y(5);y(6);y(12);y(18);y(24);y(30);y(36);y(42);...
      y(48);y(54);y(53);y(52);y(51);y(50);y(49);y(43);y(37);y(31);y(25);...
      y(19);y(13);y(7)];
yi = [x(1);x(2);x(3);x(4);x(5);x(6);x(12);x(18);x(24);x(30);x(36);x(42);...
      x(48);x(54);x(53);x(52);x(51);x(50);x(49);x(43);x(37);x(31);x(25);...
      x(19);x(13);x(7)];
bw = poly2mask(xi,yi,height,width);
a1=round(min(Xp_abs_1));
a2=round(max(Xp_abs_1));
b1=round(min(Yp_abs_1));
b2=round(max(Yp_abs_1));
res2 = img.*bw;
res2 = ~res2;
imshow(res2);
export_fig Test.png -native;
RGB = imread('Test.png');
RGB = ~RGB;
imshow(RGB);
image = RGB;
a = 1;
x_1=[];
z_1=[];
for j = a1:a2     % working image region
    for i= b1:b2
        if image(j,i)>0
            m=[j;i];       % image pixels
            z_1(a) = j;
            x_1(a) = i;
            a=a+1;
        end
    end
end
plot(x_1,z_1,'mo');
hold on
% fitobject=fit(x_1',z_1','poly2','Normalize','on','Robust','Bisquare');
fitobject=polyfit(x_1',z_1',2); % f(x) = p1*x^2 + p2*x + p3
plot(fitobject);
v = 1;
x_1 = sort(x_1); 
for i = x_1(1):x_1(length(x_1))
	x(v) = i;
    % y(v) = fitobject(x(v));
    y(v) = fitobject(1)*(x(v))^2+fitobject(2)*x(v)+fitobject(3);
    v = v+1;
end
plot(x,y,'bo');
hold off
Cent1=[x,y];
end