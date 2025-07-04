# Aliases and functions for FFMPEG

# Function to convert to 720p (16:9)
function ff720p16:9() {
	ffmpeg -i "$1" -vf "scale=1280:720,setsar=1:1" -c:a copy -aspect 16:9 "$2"
}

# Function to convert to 480p (16:9)
function ff480p16:9() {
	ffmpeg -i "$1" -vf "scale=854:480,setsar=1:1" -c:a copy -aspect 16:9 "$2"
}

# Function to convert to 360p (16:9)
function ff360p16:9() {
	ffmpeg -i "$1" -vf "scale=640:360,setsar=1:1" -c:a copy -aspect 16:9 "$2"
}

# Extracting frames from video
ff_extract_frames() {
	local input_file="$1"
	local output_dir="$2"

	# Ensure the output directory exists
	mkdir -p "$output_dir"

	# Extract frames
	ffmpeg -i "$input_file" "$output_dir/frame_%04d.png"
}

# Basic Aliases
alias ffconv="ffmpeg -i"

# Turn the functions into aliases
alias ff360p16:9="ff360p16:9"
alias ff480p16:9="ff480p16:9"
alias ff720p16:9="ff720p16:9"
alias ff_extract_frames="ff_extract_frames"
