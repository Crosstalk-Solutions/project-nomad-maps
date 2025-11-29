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
This folder contains the GeoJSON files used to specify the polygon(s) that `pmtiles` should extract to create the regional derivative(s).

- [California](https://data.ca.gov/dataset/california-state-boundary) [No restrictions on public use]
- Global min - Extracted from the Protomaps Basemap using `maxzoom=3`
- [Oregon](https://geohub.oregon.gov/datasets/oregon-state-boundary/about) [No restrictions on public use]
- [Washington](https://geo.wa.gov/datasets/wadnr::wa-county-boundaries/about) [Custom, see washington.license.md]