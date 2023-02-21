function BW = poly2mask(x, y, m, n)

if(nargin ~= 4)
error('This function needs 4 arguments');
end

% check x and y
x = round(x(:).');
y = round(y(:).');
if(length(x) < 3)
error('poly2mask: polygon must have at least 3 vertices.');
end
if(length(x) ~= length(y))
error("poly2mask: length of x doesn't match length of y.");
end

% create output matrix
BW = false(m, n);

% close polygon if needed
if((x(1) ~= x(length(x))) ||(y(1) ~= y(length(y))))
x = horzcat(x, x(1));
y = horzcat(y, y(1));
end

% build global edge table
ex = [x(1:length(x) - 1); x(1, 2:length(x))]; % x values for each edge
ey = [y(1:length(y) - 1); y(1, 2:length(y))]; % y values for each edge
idx =(ey(1, :) ~= ey(2, :));                 % eliminate horizontal edges
ex = ex(:, idx);
ey = ey(:, idx);
eminy = min(ey);                               % minimum y for each edge
emaxy = max(ey);                               % maximum y for each edge
t =(ey == [eminy; eminy]);                     % values associated to miny
exminy = ex(t);                            % x values associated to min y
exmaxy = ex(~t);                           % x values associated to max y
emaxy = emaxy.';                                % we want them vertical now...
eminy = eminy.';
m_inv =(exmaxy - exminy)./(emaxy - eminy);     % calculate inverse slope
ge = [emaxy, eminy, exmaxy, m_inv];             % build global edge table
ge = sortrows(ge, [1, 3]);                     % sort on eminy and exminy

% we add an extra dummy edge at the end just to avoid checking
% while indexing it
ge = [-Inf, -Inf, -Inf, -Inf; ge];

% initial parity is even(0)
parity = 0;

% init scan line set to bottom line
sl = ge(size(ge, 1), 1);

% init active edge table
% we use a loop because the table is sorted and edge list could be
% huge
ae = [];
gei = size(ge, 1);
while(sl == ge(gei, 1))
    ae = [ge(gei, 2:4); ae];
    gei = gei-1;
end

% calc minimum y to draw
miny = min(y);
if(miny < 1)
    miny = 1;
end

while(sl >= miny)
% check vert clipping
if(sl <= m)
  % draw current scan line
  % we have to round because 1/m is fractional
  ie = round(reshape(ae(:, 2), 2, size(ae, 1)/2));

  % this discards left border of image(this differs from version at
  % http://www.cs.rit.edu/~icss571/filling/ which discards right
  % border) but keeps an exception when the point is a vertex.
  ie(1, :) =ie(1, :)+(ie(1, :) ~= ie(2, :));

  % we'll clip too, just in case m,n is not big enough
  ie(1,(ie(1, :) < 1)) = 1;
  ie(2,(ie(2, :) > n)) = n;

  % we eliminate segments outside window
  ie = ie(:,(ie(1, :) <= n));
  ie = ie(:,(ie(2, :) >= 1));
      for i = 1:size(ie,2)
        BW(sl, ie(1, i):ie(2, i)) = true;
      end
end

% decrement scan line
sl = sl-1;

% eliminate edges that eymax==sl
% this discards ymin border of image(this differs from version at
% http://www.cs.rit.edu/~icss571/filling/ which discards ymax).
ae = ae((ae(:, 1) ~= sl), :);

% update x(x1=x0-1/m)
ae(:, 2) = ae(:, 2)-ae(:, 3);

% update ae with new values
    while(sl == ge(gei, 1))
      ae = vertcat(ae, ge(gei, 2:4));
      gei = gei-1;
    end

% order the edges in ae by x value
    if(size(ae,1) > 0)
      ae = sortrows(ae, 2);
    end
end