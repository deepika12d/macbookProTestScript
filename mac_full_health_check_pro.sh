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

# Check if /dev/disk0 exists before attempting smartctl
if [ ! -e /dev/disk0 ]; then
  echo "Error: /dev/disk0 not found."
  exit 1
fi

# Run smartctl to get more detailed health metrics
echo "Fetching SSD Health Data..."
sudo smartctl -a /dev/disk0 | grep -E 'Temperature_Celsius|Reallocated_Sector_Ct|Wear_Leveling_Count|Power_On_Hours'

# Memory Information
echo ""
echo "=== 💻 Memory Information ==="
vm_stat | grep -E 'Pages free|Pages active|Pages inactive'

# RAM Information
echo ""
echo "=== 🧠 RAM Information ==="
system_profiler SPMemoryDataType | grep -E "Size:|Type:|Speed:"

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

# GPU Information
echo ""
echo "=== 🎮 Graphics (GPU) Information ==="
# GPU Model and VRAM
system_profiler SPDisplaysDataType | grep -E 'Chipset Model|VRAM (Dynamic,Max)'

# If you want to get the GPU temperature (for some GPUs)
echo "Fetching GPU temperature (if available)..."
sudo powermetrics --samplers smc | grep -E 'GPU die temperature'


# CPU Temperature, Fan Speed, and More
echo ""
echo "=== 🌡️ CPU Temperature, Fan Speed and Power ==="
sudo powermetrics --samplers smc | egrep "CPU die temperature|Fan:|CPU Power|GPU die temperature"

# CPU Throttling
echo ""
echo "=== 🚀 CPU Throttling Info ==="
pmset -g thermlog | grep CPU_Speed_Limit


# End of Full Health Check
echo ""
echo "=== ✅ Full System Health Check Complete ==="
