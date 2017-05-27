function warped_img = ComputeFlowWarpFrame(img0, img1, u0, v0, t)
% Use forward flow warping to compute an interpolated frame.
%
% INPUTS
% img0 - Array of size h x w x 3 containing pixel data for the starting
%        frame.
% img1 - Array of the same size as img0 containing pixel data for the
%        ending frame.
% u0 - Horizontal component of the optical flow from img0 to img1. In
%      particular, an array of size h x w where u0(y, x) is the horizontal
%      component of the optical flow at the pixel img0(y, x, :).
% v0 - Vertical component of the optical flow from img0 to img1. In
%      particular, an array of size h x w where v0(y, x) is the vertical
%      component of the optical flow at the pixel img0(y, x, :).
% t - Parameter in the range [0, 1] giving the point in time at
%     which to compute the interpolated frame. For example, 
%     t = 0 corresponds to img0, t = 1 corresponds to img1, and
%     t = 0.5 is equally spaced in time between img0 and img1.
%
% OUTPUTS
% img - Array of size h x w x 3 containing pixel data for the interpolated
% frame.

    height = size(img0, 1);
    width = size(img1, 2);
    
    % Use forward warping to estimate the velocities at time t.
    [ut, vt] = WarpFlow(img0, img1, u0, v0, t);
    
    warped_img = zeros(size(img0));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE:                               %
%            Use backward warping to compute the interpolated frame.           %
%                 Store the result in the warped_img variable.                 %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for x=1:height
    for y=1:width
        x0=uint8(x-t*ut(x,y));
        y0=uint8(y-t*vt(x,y));
        if InBounds(img0,x0,y0)
            warped_img(x,y,:)=img0(x0,y0,:);
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                 END YOUR CODE                                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    warped_img = uint8(warped_img);
end

function [ut, vt] = WarpFlow(img0, img1, u0, v0, t)
% Use forward warping to transform a flow field.
%
% INPUTS
% img0 - Array of size h x w x 3 containing pixel data for the starting
%        frame.
% img1 - Array of the same size as img0 containing pixel data for the
%        ending frame.
% u0 - Horizontal component of the optical flow from img0 to img1. In
%      particular, an array of size h x w where u0(y, x) is the horizontal
%      component of the optical flow at the pixel img0(y, x, :).
% v0 - Vertical component of the optical flow from img0 to img1. In
%      particular, an array of size h x w where v0(y, x) is the vertical
%      component of the optical flow at the pixel img0(y, x, :).
% t - Parameter in the range [0, 1] giving the point in time at
%     which to compute the interpolated flow field. For example,
%     t = 0 corresponds to img0, t = 1 corresponds to img1, and
%     t = 0.5 is equally spaced in time between img0 and img1.
%
% OUTPUTS
% ut - Horizontal component of the warped flow field; this is an array of
%      the same size as u0.
% vt - Vertical component of the warped flow field; this is an array of the
%      same size as v0.

    height = size(img0, 1);
    width = size(img1, 2);

    ut = zeros(size(u0));
    vt = zeros(size(v0));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE:                               %
%            Use forward warping to compute the velocities ut and vt           %
%               using the procedure described in the problem set.              %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
book=-1*ones(height,width);
for x=1:height
    for y=1:width
        x_new1=x+t*u0(x,y);
        y_new1=y+t*v0(x,y);
        
        xPusU0=uint8(x+u0(x,y));
        yPusV0=uint8(y+v0(x,y));
        color_diff=-1;
        if InBounds(img1,xPusU0,yPusV0)
            color_diff=abs(img0(x,y)-img1(xPusU0,yPusV0));
        end
        
        for x_new2=[floor(x_new1) ceil(x_new1)]
            for y_new2=[floor(y_new1) ceil(y_new1)]
                if InBounds(img1,x_new2,y_new2)
                    if book(x_new2,y_new2)==-1 || book(x_new2,y_new2)>color_diff
                        book(x_new2,y_new2)=color_diff;
                        ut(x_new2,y_new2)=u0(x,y);
                        vt(x_new2,y_new2)=v0(x,y);
                    end
                end
            end
        end
    end
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                 END YOUR CODE                                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    % Use linear interpolation to fill in any unassigned elements of the
    % warped velocities.
    ut = FillInHoles(ut);
    vt = FillInHoles(vt);
end