function [contour] = simple_contours(sgram, pt, varargin)
% SIMPLE_CONTOURS Find the contour with less effort.
% Parameters:
%   sgram: Spectrogram with contours you want to find
%   pt (optional): Find the contour nearest to this point

s = zeros(size(sgram));
contour = cell(size(sgram,2));

for i=1:size(sgram,2)
    % Current slice of spectrogram
    cs = sgram(1:end,i);
    [val, contour{i}] = findpeaks(abs(cs));
end

contour = cell_to_points(contour);

if nargin >= 2
    % "pt" was passed; find contour that goes through that point
    
    if numel(pt) ~= 2
        error(['Error for variable "pt": ', mat2str(pt), ' is invalid. Requires form [x,y]']);
    end
    
    contour = collect_points_to_contour(contour, pt);
end

if nargin > 2 && passed('plot', varargin)
    figure; imagesc(abs(sgram));
    hold on; plot(contour(1:end,1), contour(1:end,2),'k-')
end

end