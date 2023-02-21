function [x1,y1] = mapping(image,y,x,las_dist,ocam_model)
[height,width] = size(image);
Z=las_dist;
a = 1;
x1=[];
y1=[];
t = [0;0;Z];
r = compose_rotation(-x, -y, 0);
r = [r(:,1),r(:,2),t];
for i=1:height      % working image region
    for j=1:width
        if image(i,j)>0 
            m=[i;j];       % image pixels
            M = cam2world(m,ocam_model); % transform from image plane to the camera plane          
            a1 = M(1)*r(2,1)-M(2)*r(1,1);
            b1 = M(1)*r(2,2)-M(2)*r(1,2);
            c1 = M(1)*r(2,3)-M(2)*r(1,3);
            a2 = M(3)*r(1,1)-M(1)*r(3,1);
            b2 = M(3)*r(1,2)-M(1)*r(3,2);
            c2 = M(3)*r(1,3)-M(1)*r(3,3);

            Y = (a2*c1-a1*c2)/(a1*b2-a2*b1);
            X = (-c1-b1*Y)/a1;
              
            y1(a)=X;
            x1(a)=-Y; 
            a=a+1;
        end
    end
end
end