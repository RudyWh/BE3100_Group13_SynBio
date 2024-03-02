% define function that generates a gui for a provided image, and return pixel distance between two manually selected points 

function p12 = readPoints_dist(image, n)
% initialize array to contain n points of coordinates 
if nargin < 1
    n = Inf;
    pts = zeros(1, 0);
else
    pts = zeros(1, n);
end

% show the image 
imshow(image);
% initialize variables to keep track of coordinate info/looping 
xold = 0;
yold = 0;
k = 0;

hold on;
% while not all of the points have been selected...
while 1
    % get a point based on mouse click 
    [xi, yi, but] = ginput(1);
    if ~isequal(but, 1)             
        break
    end

    % update looping/coordinate info 
    k = k + 1;
    pts(1,k) = xi;
    pts(2,k) = yi;

    % draw selected points on the image and keep them there for duration of gui
      if xold
          plot([xold xi], [yold yi], 'go-');
      else
          plot(xi, yi, 'go');
      end
      if isequal(k, n)
          break
      end
      xold = xi;
      yold = yi;
end

% resize array containing points if number actually selected was less than number anticipated to be selected 
hold off;
if k < size(pts,1)
    pts = pts(:, 1:k);
end

% determine distance between two selected points (value that is returned by this function) 
p12 = sqrt((pts(1,1) - pts(1,2))^2 + (pts(2,1) - pts(2,2))^2);
end