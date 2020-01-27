date=""
if test $(date +'%M') -gt 3
   then
	date=$(date +'%Y:%m:%d:%H')":"$(expr $(date +'%M') - 3)
   else
   	date=$(date +'%Y:%m:%d:%H:%M')
fi