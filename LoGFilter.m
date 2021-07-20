function [detected, ImOut] = LoGFilter(ImIn)
%% Preprocessing
% Optional: Preprocess image to remove bright pixels
%rawimg = imread('ImIn.jpg');
%ImIn=rgb2gray(rawimg);
%ImIn = uint8(uint8(ImIn<50).*ImIn);
%% Main part
% Choose sigma value, calculate size of kernel and construct LoG kernel
sigma = 1.5;
cutoff = ceil(3*sigma);
h = fspecial('log', 2*cutoff+1, sigma);
% Filter image
ImFiltered = conv2(ImIn,h,'same');
% Threshold image (choose parameter wisely)
ImThresholded = ImFiltered < - 0.5;
% Do connectivity analysis and remove small objects, and, optionally, large objects.
ImOut = bwareaopen(ImThresholded, 35) - bwareaopen(ImThresholded, 225);
%% Postprocessing
% Remove edges
ImOut(1:20,:) = 0;
ImOut(:,1:20) = 0;
ImOut(972-20:972,:) = 0;
ImOut(:,1296-20:1296) = 0;
% Output true if any object remains.
hits = sum(sum(ImOut));
if (hits > 0);
detected = true;
else
detected = false;
end
end
