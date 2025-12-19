#!/bin/bash

# Defaults
PMTILES_BIN=""
INPUT_MAP=""
OUTPUT_DIR="pmtiles"
GEOJSON_DIR="geojson"

usage() {
    echo "Usage: $0 --pmtiles-bin=<path> --input-map=<path> [OPTIONS]"
    echo ""
    echo "Required arguments:"
    echo "  --pmtiles-bin=PATH     Path to the pmtiles binary (e.g., ./pmtiles)"
    echo "  --input-map=PATH       Path to the input map file (.pmtiles type) that the states will be extracted from"
    echo ""
    echo "Optional arguments:"
    echo "  --output-dir=PATH      Directory to save extracted pmtiles files to"
    echo "  --geojson-dir=PATH     Directory containing GeoJSON files (default: geojson_output)"
    echo ""
    echo "Example:"
    echo "  $0 --pmtiles-bin=./pmtiles --input-map=v4.pmtiles"
    echo "  $0 --pmtiles-bin=./pmtiles --input-map=v4.pmtiles --output-dir=output --geojson-dir=geojson"
    exit 1
}

# Parse named args
for arg in "$@"; do
    case $arg in
        --pmtiles-bin=*)
            PMTILES_BIN="${arg#*=}"
            shift
            ;;
        --output-dir=*)
            OUTPUT_DIR="${arg#*=}"
            shift
            ;;
        --geojson-dir=*)
            GEOJSON_DIR="${arg#*=}"
            shift
            ;;
        --input-map=*)
            INPUT_MAP="${arg#*=}"
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Error: Unknown argument '$arg'"
            echo ""
            usage
            ;;
    esac
done

# Check required args
if [ -z "$PMTILES_BIN" ] || [ -z "$INPUT_MAP" ]; then
    echo "Error: Missing required arguments"
    echo ""
    usage
fi

# Check pmtiles binary exists and is executable
if [ ! -f "$PMTILES_BIN" ]; then
    echo "Error: pmtiles binary not found at $PMTILES_BIN"
    exit 1
fi

if [ ! -x "$PMTILES_BIN" ]; then
    echo "Error: $PMTILES_BIN is not executable"
    exit 1
fi

# Check input map exists
if [ ! -f "$INPUT_MAP" ]; then
    echo "Error: Input map file not found at $INPUT_MAP"
    exit 1
fi

# All 50 U.S. states (lowercase, underscore-separated)
states=(
    "alabama"
    "alaska"
    "arizona"
    "arkansas"
    "california"
    "colorado"
    "connecticut"
    "delaware"
    "florida"
    "georgia"
    "hawaii"
    "idaho"
    "illinois"
    "indiana"
    "iowa"
    "kansas"
    "kentucky"
    "louisiana"
    "maine"
    "maryland"
    "massachusetts"
    "michigan"
    "minnesota"
    "mississippi"
    "missouri"
    "montana"
    "nebraska"
    "nevada"
    "new_hampshire"
    "new_jersey"
    "new_mexico"
    "new_york"
    "north_carolina"
    "north_dakota"
    "ohio"
    "oklahoma"
    "oregon"
    "pennsylvania"
    "rhode_island"
    "south_carolina"
    "south_dakota"
    "tennessee"
    "texas"
    "utah"
    "vermont"
    "virginia"
    "washington"
    "west_virginia"
    "wisconsin"
    "wyoming"
)

# Ensure output dir
mkdir -p "$OUTPUT_DIR"

echo "Configuration:"
echo "  pmtiles binary: $PMTILES_BIN"
echo "  Input map: $INPUT_MAP"
echo "  GeoJSON directory: $GEOJSON_DIR"
echo "  Output directory: $OUTPUT_DIR"
echo ""
echo "Starting extraction of 50 states..."
echo ""

for state in "${states[@]}"; do
    echo "Processing $state..."
    "$PMTILES_BIN" extract "$INPUT_MAP" "$OUTPUT_DIR/${state}.pmtiles" --region="$GEOJSON_DIR/${state}.geojson"

    if [ $? -eq 0 ]; then
        echo "✓ Successfully extracted $state"
    else
        echo "✗ Failed to extract $state"
    fi
    echo ""
done

echo "Done processing all states!"
