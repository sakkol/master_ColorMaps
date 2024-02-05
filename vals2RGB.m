function [RGB_vals, cmap, vals] = vals2RGB(vals, ColorMaps, MinMax)
% Convert column of data values into RGB values of where they are in the
% selected colormap. MinMax can be set so that all values are bound by
% them. 
% This function works with crameri.m and select_colormaps.mat.
%
% Serdar Akkol, Human Brain Mapping Lab, Feinstein Institutes for Medical
% Research
% December 2020
% 
% Updates:
% May and August 2021: MinMax option updates.
% September 2021: bug fix

%% Admin
if ~isvector(vals)
    error('Only vectors are accepted as input values.')
end
if ~exist('ColorMaps','var') || isempty(ColorMaps)
    ColorMaps = 'inferno';
end

%% Real part
% Choose colormap
[cmap] = master_ColorMaps(ColorMaps,256);

% assign Min and Max values for data
if exist('MinMax','var') && ~isempty(MinMax)
    vals(vals>MinMax(2)) = MinMax(2);
    vals(vals<MinMax(1)) = MinMax(1);
elseif ~exist('MinMax','var') || isempty(MinMax)
    MinMax(1) = min(vals);
    MinMax(2) = max(vals);
end

% some prelim arrangement
vals(end+1) = MinMax(1);
vals(end+1) = MinMax(2);
ran=range(vals); % finding range of data
min_val=min(vals); % finding maximum value of data
y=floor(((vals-min_val)/ran)*length(cmap))+1;
y(end-1:end)=[];vals(end-1:end)=[];
RGB_vals=zeros(length(y),3);
y(y==257)=256;

% assign colors to data
for i=1:length(y)
    a=y(i);
    RGB_vals(i,:)=cmap(a,:);
    % if needed to see the color results:
    %   stem3(i,i,x(i),'Color',alleleccols(i,:))
    %   hold on
end

end