mem_total=$(sed -n "1s/[^0-9]//gp" /proc/meminfo)  # First line of /proc/meminfo set as total memory.
mem_used=$(sed -n "2s/[^0-9]//gp" /proc/meminfo)   # Second line of /proc/meminfo set as used memory.
percent=$(( (mem_used * 100) / mem_total ))
echo "Total Memory: $mem_total kB
Memory Used: $mem_used kB
Percent: $percent %"                               # Output the current RAM usage.
if [  "$percent" -gt 80 ]; then                    # Check if more than 80% of the RAM is being used. 
    echo "Memory usage is above threshold. Rebooting..."
	datetime=$(date '+%Y-%m-%d %H:%M:%S')          # Set the current date and time. 
	echo "$datetime - Reboot" >> "reboot.log"      # Save datetime line to file for log.
	sleep 2                                        # Give a little time for user to read the output.
	reboot
fi