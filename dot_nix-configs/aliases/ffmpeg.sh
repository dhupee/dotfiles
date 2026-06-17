# Aliases and functions for FFMPEG

# ------------------------------------------------------------
# Function: convert to 720p (16:9)
# Usage: ff720p16:9 <input_file> <output_file>
# ------------------------------------------------------------
function ff720p16:9() {
  if [[ -z "$1" && -z "$2" ]]; then
    echo "Input and output files not provided."
    echo "Usage: ff720p16:9 <input_file> <output_file>"
    return 1
  elif [[ -z "$1" ]]; then
    echo "Input file not provided."
    echo "Usage: ff720p16:9 <input_file> <output_file>"
    return 1
  elif [[ -z "$2" ]]; then
    echo "Output file not provided."
    echo "Usage: ff720p16:9 <input_file> <output_file>"
    return 1
  fi

  ffmpeg -i "$1" -vf "scale=1280:720,setsar=1:1" -c:a copy -aspect 16:9 "$2"
}

# ------------------------------------------------------------
# Function: convert to 480p (16:9)
# Usage: ff480p16:9 <input_file> <output_file>
# ------------------------------------------------------------
function ff480p16:9() {
  if [[ -z "$1" && -z "$2" ]]; then
    echo "Input and output files not provided."
    echo "Usage: ff480p16:9 <input_file> <output_file>"
    return 1
  elif [[ -z "$1" ]]; then
    echo "Input file not provided."
    echo "Usage: ff480p16:9 <input_file> <output_file>"
    return 1
  elif [[ -z "$2" ]]; then
    echo "Output file not provided."
    echo "Usage: ff480p16:9 <input_file> <output_file>"
    return 1
  fi

  ffmpeg -i "$1" -vf "scale=854:480,setsar=1:1" -c:a copy -aspect 16:9 "$2"
}

# ------------------------------------------------------------
# Function: convert to 360p (16:9)
# Usage: ff360p16:9 <input_file> <output_file>
# ------------------------------------------------------------
function ff360p16:9() {
  if [[ -z "$1" && -z "$2" ]]; then
    echo "Input and output files not provided."
    echo "Usage: ff360p16:9 <input_file> <output_file>"
    return 1
  elif [[ -z "$1" ]]; then
    echo "Input file not provided."
    echo "Usage: ff360p16:9 <input_file> <output_file>"
    return 1
  elif [[ -z "$2" ]]; then
    echo "Output file not provided."
    echo "Usage: ff360p16:9 <input_file> <output_file>"
    return 1
  fi

  ffmpeg -i "$1" -vf "scale=640:360,setsar=1:1" -c:a copy -aspect 16:9 "$2"
}

# ------------------------------------------------------------
# Function: extract frames from video
# Usage: ff_extract_frames <input_video> <output_directory>
# ------------------------------------------------------------
ff_extract_frames() {
  if [[ -z "$1" && -z "$2" ]]; then
    echo "Input file and output directory not provided."
    echo "Usage: ff_extract_frames <input_video> <output_directory>"
    return 1
  elif [[ -z "$1" ]]; then
    echo "Input file not provided."
    echo "Usage: ff_extract_frames <input_video> <output_directory>"
    return 1
  elif [[ -z "$2" ]]; then
    echo "Output directory not provided."
    echo "Usage: ff_extract_frames <input_video> <output_directory>"
    return 1
  fi

  local input_file="$1"
  local output_dir="$2"

  mkdir -p "$output_dir"
  ffmpeg -i "$input_file" "$output_dir/frame_%04d.png"
}

# ------------------------------------------------------------
# Function: scale image by percentage
# Usage: ff_downscale_img <input_file> <scale_percent> <output_file>
# ------------------------------------------------------------
ff_downscale_img() {
  if [[ -z "$1" && -z "$2" && -z "$3" ]]; then
    echo "Input file, scale %, and output file not provided."
    echo "Usage: ff_downscale_img <input_file> <scale_percent> <output_file>"
    return 1
  elif [[ -z "$1" ]]; then
    echo "Input file not provided."
    echo "Usage: ff_downscale_img <input_file> <scale_percent> <output_file>"
    return 1
  elif [[ -z "$2" ]]; then
    echo "Scale percentage not provided."
    echo "Usage: ff_downscale_img <input_file> <scale_percent> <output_file>"
    return 1
  elif [[ -z "$3" ]]; then
    echo "Output file not provided."
    echo "Usage: ff_downscale_img <input_file> <scale_percent> <output_file>"
    return 1
  fi

  local input_file="$1"
  local scale="$2"
  local output_file="$3"

  ffmpeg -i "$input_file" -vf "scale=iw*$scale/100:ih*$scale/100" -q:v 1 "$output_file"
}

# ------------------------------------------------------------
# Basic alias for quick conversion
# ------------------------------------------------------------
alias ffconv="ffmpeg -i"

# Self‑aliases (they just point to the functions)
alias ff360p16:9="ff360p16:9"
alias ff480p16:9="ff480p16:9"
alias ff720p16:9="ff720p16:9"
alias ff_extract_frames="ff_extract_frames"
alias ff_downscale_img="ff_downscale_img"

