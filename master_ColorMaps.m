function [cmap] = master_ColorMaps(ColorMaps,NLevels,PlotCMAP)
% Create colormap values from either:
% 1-matplotlib colormaps (in select_colormaps.mat file),
% 2-crameri colormaps (color options are in crameri6.0.png picture)
% 3-one of the Matlab default colormaps.
% For all of these, there is an option to reverse the colormap by placing
% "-" to the beginning of the ColorMap name. 
% 
% Several use cases:
% 1. To get 20 colors from 'plasma' colormap (included in MatPlotLib).
% cmap=master_ColorMaps('plasma',20);
% 2. To directly change the colormap of a figure
% colormap(master_ColorMaps('plasma'))
% 3. Just to see how the colors look like
% master_ColorMaps('plasma',[],1);
%
% by Serdar Akkol, 2022 May, Human Brain Mapping Lab
% Share with the world February 2023, University of Alabama at Birmingham
%
% Future goals: 
% - adding the circular option from crameri
% - adding the mid point for divergent color for crameri

%% Admin
if ~exist('ColorMaps','var') || isempty(ColorMaps)
    ColorMaps = 'inferno';
elseif strcmpi(ColorMaps,'showall')
    fullpath = which('master_ColorMaps');
    fullpath = erase(fullpath,'master_ColorMaps.m');
    dirs = dir(fullfile(fullpath, 'colormaps',  '*.png'));
    for i=1:3
        img=imread(fullfile(dirs(i).folder,dirs(i).name));
        figure, imshow(img);
    end
    return
end
if ~exist('NLevels','var') || isempty(NLevels)
    NLevels = 256;
end
if ~exist('PlotCMAP','var') || isempty(PlotCMAP)
    PlotCMAP = 0;
end

%% Create cmap values
% first try if one of the default colormaps is selected (in select_colormaps.mat)
tmp=load('select_colormaps.mat');tmp=tmp.matplotlib_maps;
if ~strcmp(ColorMaps(1),'-') && isfield(tmp,ColorMaps)
    cmap = tmp.(ColorMaps);clear tmp
elseif strcmp(ColorMaps(1),'-') && isfield(tmp,ColorMaps(2:end))
    cmap = tmp.(ColorMaps(2:end));clear tmp
    cmap = cmap(end:-1:1,:);
else
    try % try if one of the crameri colormaps is selected
        cmap = crameri(ColorMaps);
    catch % last chance: Matlab default colormaps
        if strcmp(ColorMaps(1),'-')
            cmap=[];
            eval(['cmap = ' ColorMaps(2:end) '(' num2str(NLevels) ');'])
            cmap = cmap(end:-1:1);
        else
            eval(['cmap = ' ColorMaps '(' num2str(NLevels) ');'])
        end
    end
end

%% Interpolate if necessary:
if NLevels~=size(cmap,1)
    cmap = interp1(1:size(cmap,1), cmap, linspace(1,size(cmap,1),NLevels),'linear');
end

%% Plot if asked

if PlotCMAP
    figure('Units','normalized','Position', [0 0  1 .5]);
    for i = 1:length(cmap)
        plot(i,0, 'o', 'MarkerFaceColor', cmap(i,:), 'MarkerEdgeColor', 'none', 'MarkerSize', 40)
        hold on
    end
    set(gca,'XColor','none', 'YColor','none')
    xlim([0 i+1])
end

end