# master_ColorMaps
A collection of colormaps from other resources including those from Crameri and MatPlotLib

# Crameri 6.0: 
https://www.fabiocrameri.ch/colourmaps/
Crameri, F. (2018). Scientific colour maps. Zenodo. http://doi.org/10.5281/zenodo.1243862

# MatPlotLib:
https://matplotlib.org/stable/gallery/color/colormap_reference.html

# Several use cases:
1. To get 20 colors from 'plasma' colormap (included in MatPlotLib).
cmap=master_ColorMaps('plasma',20);

2. To directly change the colormap of a figure
colormap(master_ColorMaps('plasma'))

3. Just to see how the colors look like
master_ColorMaps('plasma',[],1);

# Colormaps that are included in addition to regular MATLAB colormaps
<img src="colormaps/crameri6.0.png?raw=true" title="All MatPlotLib colors"/>
<img src="colormaps/all_matplotlib_colormaps.png?raw=true" title="All MatPlotLib colors"/>


# Future goals: 
- adding the circular option from crameri
- adding the mid point for divergent color for crameri