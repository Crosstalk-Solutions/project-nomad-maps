#!/usr/bin/env python3
"""
Convert TIGER/Line Shapefile to individual GeoJSON files per state using GeoPandas.

Installation:
    pip install geopandas

Usage:
    python convert_states.py <path_to_shp_file> [output_directory]
"""

import geopandas as gpd
import os
import sys
from pathlib import Path


def convert_shapefile_to_geojson(shp_path, output_dir='./geojson_output'):
    os.makedirs(output_dir, exist_ok=True)
    
    print(f"Reading shapefile: {shp_path}")
    
    gdf = gpd.read_file(shp_path)
    
    print(f"Found {len(gdf)} features")
    print(f"Columns: {', '.join(gdf.columns)}")
    print(f"CRS: {gdf.crs}")
    
    # Determine which column to use for naming files
    # Common field names in TIGER/Line state files
    name_fields = ['NAME', 'STUSPS', 'STATEFP', 'GEOID', 'name', 'stusps']
    name_column = None
    
    for field in name_fields:
        if field in gdf.columns:
            name_column = field
            break
    
    if name_column is None:
        print("Warning: Could not find a standard name field. Using index for filenames.")
    else:
        print(f"Using '{name_column}' field for filenames")
    
    print("\nSaving individual state files:")
    for idx, row in gdf.iterrows():
        # Determine filename to use
        if name_column and row[name_column]:
            filename = str(row[name_column]).replace(' ', '_').replace('/', '_')
        else:
            filename = f"feature_{idx:03d}"
        filename = filename.lower()
        output_path = os.path.join(output_dir, f"{filename}.geojson")
        
        # Create a GeoDataFrame with just this row
        single_state = gpd.GeoDataFrame([row], crs=gdf.crs)
        
        # Save to GeoJSON file
        single_state.to_file(output_path, driver='GeoJSON')
        
        print(f"  ✓ {filename}.geojson")
    
    # Also save all states in a single file
    all_states_path = os.path.join(output_dir, "all_states.geojson")
    gdf.to_file(all_states_path, driver='GeoJSON')
    print(f"\n✓ All states saved to: all_states.geojson")
    
    print(f"\nSuccess! Created {len(gdf)} GeoJSON files in: {output_dir}")
    
    print("\nSummary:")
    if name_column:
        print(f"  States: {', '.join(sorted(gdf[name_column].tolist()))}")
    print(f"  Total features: {len(gdf)}")
    print(f"  Geometry types: {', '.join(gdf.geometry.geom_type.unique())}")


def main():
    if len(sys.argv) < 2:
        print("Usage: python convert_states.py <path_to_shp_file> [output_directory]")
        print("\nExamples:")
        print("  python convert_states.py tl_2024_us_state.shp")
        print("  python convert_states.py tl_2024_us_state.shp ./my_output")
        sys.exit(1)
    
    shp_path = sys.argv[1]
    output_dir = sys.argv[2] if len(sys.argv) > 2 else './geojson_output'
    
    if not os.path.exists(shp_path):
        print(f"Error: Shapefile not found: {shp_path}")
        sys.exit(1)
    
    convert_shapefile_to_geojson(shp_path, output_dir)


if __name__ == "__main__":
    main()
