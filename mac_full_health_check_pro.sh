#!/bin/bash

echo "=========================================="
echo "         🍏 MAC FULL HEALTH CHECK PRO      "
echo "=========================================="

# Battery Health Percentage
echo ""
echo "=== 🔋 Battery Wear Percentage ==="
system_profiler SPPowerDataType | awk '/Full Charge 
Capacity/{fcc=$NF}/Design Capacity/{dc=$NF}END{if (fcc && dc) 
printf("Battery Health: %.2f%%\n", (fcc/dc)*100)}'

# Battery Cycle Count and Condition
echo ""
echo "=== 🔋 Battery Cycle Count and Condition ==="
system_profiler SPPowerDataType | grep -i "cycle count\|condition"

# SSD Info
echo ""
echo "=== 💾 SSD Information ==="
diskutil list internal

# CPU Temperature, Fan Speed, and More
echo ""
echo "=== 🌡️ CPU Temperature, Fan Speed and Power ==="
sudo powermetrics --samplers smc | egrep "CPU die temperature|Fan:|CPU 
Power|GPU die temperature"

# CPU Throttling
echo ""
echo "=== 🚀 CPU Throttling Info ==="
pmset -g thermlog | grep CPU_Speed_Limit

# RAM Information
echo ""
echo "=== 🧠 RAM Information ==="
system_profiler SPMemoryDataType | grep -E "Size:|Type:|Speed:"

echo ""
echo "=========================================="
echo "            ✅ PRO CHECK COMPLETE          "
echo "=========================================="

