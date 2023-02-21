function [Z_1,X_1] = intersections_world(Cent,r,ocam_model)
if length(Cent(:,1)) > 1
    for i = 1:length(Cent)
        x = Cent(i,2);
        y = Cent(i,1);
        m = [x;y];
        M=cam2world(m, ocam_model);
        a1 = M(1)*r(2,1)-M(2)*r(1,1);
        b1 = M(1)*r(2,2)-M(2)*r(1,2);
        c1 = M(1)*r(2,3)-M(2)*r(1,3);
        a2 = M(3)*r(1,1)-M(1)*r(3,1);
        b2 = M(3)*r(1,2)-M(1)*r(3,2);
        c2 = M(3)*r(1,3)-M(1)*r(3,3);
        Z_1(i) = (a2*c1-a1*c2)/(a1*b2-a2*b1);
        X_1(i) = (-c1-b1*Z_1(i))/a1;
    end
end
end