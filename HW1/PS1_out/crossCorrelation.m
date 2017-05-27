clear
close all
clc

% Read in the main image and the template image.
photo = rgb2gray(imread('u2cuba.jpg'));
template = rgb2gray(imread('trailer.png'));

% Display the image and the template at the same magnification, to make 
% clear that the template is an extremely close match for the relevant 
% section of the image.
figure('Name','Original photo');
imshow(photo, [], 'InitialMagnification', 50);

figure('Name','template');
imshow(template, [] , 'InitialMagnification', 50);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           YOUR CODE HERE: Part (a)                           %
%     Use normxcorr2 to cross-correlate the template image with the photo.     %
c=normxcorr2(template,photo);
figure, surf(c), shading flat
[ypeak, xpeak] = find(c==max(c(:)));
yoffSet = ypeak-size(template,1);
xoffSet = xpeak-size(template,2);
hFig = figure;
hAx  = axes;
imshow(photo,'Parent', hAx);
imrect(hAx, [xoffSet+1, yoffSet+1, size(template,2), size(template,1)]);
%                      (Your code should be very simple.)                      %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
correlationImg = photo(yoffSet+1:yoffSet+size(template,1),xoffSet+1:xoffSet+size(template,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                               END OF YOUR CODE                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Displays correlationImg and draw a rectangle around the highest peak.
figure('Name','Correlation, near-perfect template');
hold on % Allows drawing on top of the displayed image
imshow(correlationImg, [], 'InitialMagnification', 50);

% Find the maximum of correlationImg.
% The max function requires a vector, so we unroll the array with (:).
% The max function returns both the value of the maximum value and its
% linear index within the array. We don't care about the value of the
% maximum, so we discard the first output value with using the ~ notation.
[~, maxValLinearIndex] = max(correlationImg(:));

% We use the ind2sub function to convert a linear back into matrix
% coordinates.
[y, x] = ind2sub(size(correlationImg), maxValLinearIndex);

% Display a rectangle around the peak we just found.
rectangle('Position', [x-15, y-15, 30, 30], 'EdgeColor', 'r')
hold off;

% Load a template which is sized slightly larger than the object appears in 
% the image.
largerTemplate = rgb2gray(imread('trailerSlightlyBigger.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                           YOUR CODE HERE: Part (b)                           %
c1=normxcorr2(largerTemplate,photo);
figure, surf(c1), shading flat
[ypeak1, xpeak1] = find(c1==max(c1(:)));
yoffSet = ypeak1-size(largerTemplate,1);
xoffSet = xpeak1-size(largerTemplate,2);
hFig = figure;
hAx  = axes;
imshow(photo,'Parent', hAx);
imrect(hAx, [xoffSet+1, yoffSet+1, size(largerTemplate,2), size(largerTemplate,1)]);
%             Repeat the process from (a) with the larger template.            %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mismatchedCorrelationImg = photo(yoffSet+1:yoffSet+size(largerTemplate,1),xoffSet+1:xoffSet+size(largerTemplate,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                               END OF YOUR CODE                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Display mismatchedCorrelationImg.
figure('Name', 'Correlation, larger-sized template');
hold on;
imshow(mismatchedCorrelationImg, [], 'InitialMagnification', 50);

% Repeat the same process as above: find the maximum of correlationImg and
% draw a box around it.
[~, maxValLinearIndex] = max(mismatchedCorrelationImg(:));
[y, x] = ind2sub(size(mismatchedCorrelationImg), maxValLinearIndex);
rectangle('Position', [x-15, y-15, 30, 30], 'EdgeColor', 'r')
hold off;