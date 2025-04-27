#!/bin/bash

# Full Mac Health Check Script

# Check if the user has sudo privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run the script with sudo privileges."
  exit 1
fi

# SSD Health Information
echo ""
echo "=== 💾 SSD Health Information ==="
diskutil list

# Run smartctl to get more detailed health metrics
echo "Fetching SSD Health Data..."
sudo smartctl -a /dev/disk0 | grep -E 'Temperature_Celsius|Reallocated_Sector_Ct|Wear_Leveling_Count|Power_On_Hours'

# Memory Information
echo ""
echo "=== 💻 Memory Information ==="
vm_stat | grep -E 'Pages free|Pages active|Pages inactive'

# Battery Health (for laptops)
echo ""
echo "=== 🔋 Battery Health ==="
system_profiler SPPowerDataType | grep -E 'Cycle Count|Condition|Full Charge'

# Disk Usage
echo ""
echo "=== 📂 Disk Usage ==="
df -h / | grep "/"

# System Information
echo ""
echo "=== 🖥️ System Information ==="
system_profiler SPHardwareDataType | grep -E 'Model Identifier|Processor Name|Processor Speed|Total Number of Cores|Memory'

# Running Processes
echo ""
echo "=== 🔄 Running Processes ==="
ps aux | sort -rk 3,3 | head -n 10

# CPU Temperature, Fan Speed, and Power
echo ""
echo "=== 🌡️ CPU Temperature, Fan Speed and Power ==="
sudo powermetrics --samplers smc | grep -E 'CPU die temperature|Fan|CPU Power' | awk '{print $1, $2, $3}'

# End of Full Health Check
echo ""
echo "=== ✅ Full System Health Check Complete ==="
