# The "GPU Power Limit" Script 
# (NVIDIA Lifespan)During long AI training sessions, your RTX 40-series card can run very hot. You can actually reduce the power limit (e.g., from 100W to 80W). 
# You lose $\sim5\%$ performance but drop temperatures by $10^\circ\text{C}-15^\circ\text{C}$."



#!/bin/bash
# Set GPU to Persistence Mode (Needed for power limits)
sudo nvidia-smi -pm 1

# Set Power Limit to 80 Watts (Adjust based on your GPU model)
# Check max wattage with 'nvidia-smi -q -d POWER'
sudo nvidia-smi -pl 80

echo "GPU Power Limit set to 80W. Stay cool!"
