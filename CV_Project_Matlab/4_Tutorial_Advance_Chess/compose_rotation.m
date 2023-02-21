function R = compose_rotation(x, y, z)
	X = eye(3,3);
	Y = eye(3,3);
	Z = eye(3,3);

    X(2,2) = cosd(x);
    X(2,3) = -sind(x);
    X(3,2) = sind(x);
    X(3,3) = cosd(x);

    Y(1,1) = cosd(y);
    Y(1,3) = sind(y);
    Y(3,1) = -sind(y);
    Y(3,3) = cosd(y);

    Z(1,1) = cosd(z);
    Z(1,2) = -sind(z);
    Z(2,1) = sind(z);
    Z(2,2) = cosd(z);

	R = Z*Y*X;
end