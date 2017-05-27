function [x, y, R] = FitCircle(D)
% FitCircleLeastSquares Fit a circle using at least 3 points.
% Input:
%   D: An N x 2 matrix, where each row is a point in 2D space.
% Output:
%   x, y, R: (x, y) is the center of the fitted circle, R is the radius of
%   the fitted circle
    
    n = size(D, 1);

    if n < 3
        error('You need at least three points to fit a circle.');
    end
    
    x = 0;
    y = 0;
    R = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE:                               %
%        Find the value of the above variables as discussed in part (a). 
%       AX=B
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=[2*D(:,1) 2*D(:,2) ones(size(D,1),1)];
B=D(:,1).^2+D(:,2).^2;
X=A\B;
x=X(1);
y=X(2);
R=sqrt(X(3)+x^2+y^2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                 END YOUR CODE                                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end