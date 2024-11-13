%% Usage: function to find the least loss value and its index
% array: A numeric array of any dimension
% minValue: The minimum value in the array
% minCoords: The coordinates of the minimum value in the array

function [minValue, minCoords] = findMinWithCoords(array)    
    % Find the minimum value in the array
    [minValue, linearIndex] = min(array(:));
    
    % Convert linear index to subscripts (coordinates)
    minCoords = cell(1, ndims(array));
    [minCoords{:}] = ind2sub(size(array), linearIndex);
    minCoords = cell2mat(minCoords);  % Convert cell array to a numeric vector
end