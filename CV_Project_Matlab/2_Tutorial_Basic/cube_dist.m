function [Dist] = cube_dist(image,i_,j_,y,x,las_dist,ocam_model)
   
Z=las_dist;
a = 1;
x1=[];
y1=[];
t = [0;0;Z];
r = compose_rotation(-x, -y, 0);
r = [r(:,1),r(:,2),t];
for i=i_(1):i_(2)     % working image region
    for j=j_(1):j_(2)
        if image(j,i)>0   
            m=[j;i];       % image pixels
            M = cam2world(m,ocam_model); % transform from image plane to the camera plane          
            a1 = M(1)*r(2,1)-M(2)*r(1,1);
            b1 = M(1)*r(2,2)-M(2)*r(1,2);
            c1 = M(1)*r(2,3)-M(2)*r(1,3);
            a2 = M(3)*r(1,1)-M(1)*r(3,1);
            b2 = M(3)*r(1,2)-M(1)*r(3,2);
            c2 = M(3)*r(1,3)-M(1)*r(3,3);
 
            Y = (a2*c1-a1*c2)/(a1*b2-a2*b1);
            X = (-c1-b1*Y)/a1;
                
            y1(a)=-Y;
            x1(a)=X; 
            a=a+1;
        end
    end
end
Dist=[y1',x1'];
end  