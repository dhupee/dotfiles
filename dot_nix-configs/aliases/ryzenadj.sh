# ADJUSTED ONLY FOR MY ACER NITRO 5 AN515-43

# stamp-limit = Skin Temperature Aware Power Management.
#               This will define the socket power package limit which is used to manage the device boost period. (mW)
# fast-limit = The amount of power the CPU can draw while boost levels on (mW)
# slow-limit = The amount of power the CPU can draw while boost levels off (mW)
# tctl-temp = The temperature the CPU can reach before boost levels off (degs C)

# Keep this
function ryzen-default-mode() {
	sudo ryzenadj --stapm-limit=35000 --fast-limit=50000 --slow-limit=42000 --tctl-temp=100
	echo "Default profile applied"
}

function ryzen-gaming-mode() {
	sudo ryzenadj --stapm-limit=48000 --fast-limit=55000 --slow-limit=50000 --tctl-temp=105 --max-performance
	echo "Gaming profile applied"
}

function ryzen-underwatt-mode() {
	sudo ryzenadj --stapm-limit=15000 --fast-limit=19000 --slow-limit=16000 --tctl-temp=80 --power-saving
	echo "Underwatt profile applied"
}

# Grabbing info for Ryzenadj
function ryzen-info() {
	echo "Current CPU power status:"
	sudo ryzenadj --info
}
