# stamp-limit = Sustain Power Limit (mW)
# fast-limit = Actual Power Draw (mW)
# slow-limit = Average Power Draw (mW)
# tctl-temp = Temperature Limit (degrees C)

function ryzen-default-mode() {
	sudo ryzenadj --stapm-limit=35000 --fast-limit=50000 --slow-limit=42000 --tctl-temp=100
	echo "Default profile applied"
}

function ryzen-gaming-mode() {
	sudo ryzenadj --stapm-limit=15000 --fast-limit=19000 --slow-limit=16000 --tctl-temp=80
	echo "Gaming profile applied"
}

# Grabbing info for Ryzenadj
function ryzen-info() {
	echo "Current CPU power status:"
	sudo ryzenadj --info | grep -E "(STAPM LIMIT|PPT LIMIT|Tctl TEMP)"
}
