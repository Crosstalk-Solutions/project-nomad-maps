<div style="width: 100;text-align: center;margin-bottom: 25px;">
<img src="https://raw.githubusercontent.com/Crosstalk-Solutions/project-nomad/refs/heads/master/admin/public/project_nomad_logo.png" width="200" height="200"/>
</div>

# Project N.O.M.A.D. Maps
[Project N.O.M.A.D.](https://github.com/Crosstalk-Solutions/project-nomad), is a self-contained, offline survival computer packed with critical tools, knowledge, and AI to keep you informed and empowered—anytime, anywhere. This repository hosts the map files available for import into Project NOMAD. that are too large to reside in the main respository.

## basemap-assets
This folder contains slightly customized baseline assets for Project NOMAD's natively embedded [MapLibre GL JS](https://maplibre.org/maplibre-gl-js/docs/) renderer. Many thanks to Protomaps for their [original version](https://github.com/protomaps/basemaps-assets).

- `fonts/` subject to the [SIL Open Font License](https://github.com/Crosstalk-Solutions/project-nomad-maps/blob/master/basemaps-assets/fonts/OFL.txt)
- `sprites/` derived from [MIT-licenses tangrams/icons](https://github.com/tangrams/icons/blob/master/LICENSE.md)

## pmtiles
This folder contains regional derivatives of the [Protomaps Basemap](https://docs.protomaps.com/basemaps/downloads), a global basemap derived from OpenStreetMap. The Proptomaps Basemap and these regional derivatives are distributed as [Open Database Licensed](https://docs.protomaps.com/basemaps/downloads) Produced Work(s).

The regional derivatives were created out of convience to allow those running Project NOMAD locally to select and download smaller sections of the full-featured basemap (120GB+) relevant to them. These derivatives were created using the [pmtiles extract](https://docs.protomaps.com/pmtiles/cli#extract) command and regional GeoJSON files (see below).

## geojson
This folder contains the GeoJSON files used to specify the polygon(s) that `pmtiles` should extract to create the regional derivative(s). The GeoJSON boundaries for each state/territory are extracted from the U.S. Census Bureau's [TIGER/Line Shapefile](https://catalog.data.gov/dataset/tiger-line-shapefile-current-nation-u-s-state-and-equivalent-entities)
using GeoPandas in the `convert_shapefile.py` script.

To run the converter, download and unzip the TIGER/Line Shapefile dataset and run `python convert_shapefile.py path_to_shp_file.shp [output_directory]`.

## extract_states.sh
Helper script to run the pmtiles cli `extract` command for all 50 U.S. states given the Protomaps Basemap and the GeoJSON boundaries for each state.

## License
Unless otherwise specified, the content of this repository shall be governed by the MIT license.

Copyright 2025 Crosstalk Solutions, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
