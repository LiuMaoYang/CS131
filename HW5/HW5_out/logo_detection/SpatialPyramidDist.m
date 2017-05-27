function D = SpatialPyramidDist( I1, I2, nbins )
%SpatialPyramidDist
%   Compute the spatial pyramid measure for the two given image
%   patches.
%
%Input:
%   I1: image patch 1
%   I2: image patch 2
%   nbins: number of bins for color histograms. Note this is unrelated to 
%   spatial partitioning of the image.
%
%Output:
%   D: spatial pyramid measure (a real number)
%
if nargin == 2
    nbins = 20;
end

numLevel = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE                                %
%                You should fill in D with the weighted distance               %
%                   between histograms of two entire images.                   %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D = 0;
H1 = Histogram (I1, nbins);
H2 = Histogram (I2, nbins);
D= sum(min(H1,H2))/2^numLevel;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                               END OF YOUR CODE                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for l = 1 : numLevel
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE                                %
%             You should fill in numCells with the number of cells             %
%                           along x and y directions.                          %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     numCells = 0;
    numCells=2^l;
    patch_size_I1x=round(size(I1,1)/numCells);
    patch_size_I1y=round(size(I1,2)/numCells);
    patch_size_I2x=round(size(I2,1)/numCells);
    patch_size_I2y=round(size(I2,2)/numCells);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                               END OF YOUR CODE                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1 : numCells
        for j = 1 : numCells
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE                                %
%               You should fill in x_lo1, x_hi1, y_lo1, y_hi1 to               %
%                    extract one cell of I1 in the pyramid.                    %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            x_lo1 = (i-1)*patch_size_I1x+1;
            x_hi1 = min(i*patch_size_I1x,size(I1,1));
            y_lo1 = (j-1)*patch_size_I1y+1;
            y_hi1 = min(j*patch_size_I1y,size(I1,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                               END OF YOUR CODE                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE                                %
%               You should fill in x_lo2, x_hi2, y_lo2, y_hi2 to               %
%                    extract one cell of I2 in the pyramid.                    %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            x_lo2 = (i-1)*patch_size_I2x+1;
            x_hi2 = min(i*patch_size_I2x,size(I2,1));
            y_lo2 = (j-1)*patch_size_I2y+1;
            y_hi2 = min(j*patch_size_I2y,size(I2,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                               END OF YOUR CODE                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                                YOUR CODE HERE                                %
%You should increment D by the weighted distances between patches in this cell.%
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             D = 0;
            H1 = Histogram (I1(x_lo1:x_hi1,y_lo1:y_hi1,:), nbins);
            H2 = Histogram (I2(x_lo2:x_hi2,y_lo2:y_hi2,:), nbins);
            D= D+sum(min(H1,H2))/2^(numLevel-l+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                               END OF YOUR CODE                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end
end

end

