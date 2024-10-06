#!/bin/bash
# Switch default audio sink between HDMI and headset
DEFAULT=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep "node.name" | cut -d " " -f 6 | cut -d "\"" -f 2)
echo "Default audio sink: $DEFAULT"

DEFAULT_ID=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep id | grep PipeWire | cut -d " " -f 2 | cut -d "," -f 1)
echo "Default sink ID: $DEFAULT_ID"

HDMI_SINK_ID=$(wpctl status | grep "Navi 31 HDMI/DP Audio Digital Stereo (HDMI 2)" | cut -d "." -f 1 | cut -c 11-)
echo "HDMI sink ID: $HDMI_SINK_ID"

HEADSET_SINK_ID=$(wpctl status | grep "Starship/Matisse HD Audio Controller Analog Stereo" | head -1 | cut -d "." -f 1 | cut -c 11-)
echo "Headset sink ID: $HEADSET_SINK_ID"

if [ $DEFAULT_ID -eq $HDMI_SINK_ID ] ; then
  echo "Setting default sink to $HEADSET_SINK_ID"
  wpctl set-default $HEADSET_SINK_ID
else
  echo "Setting default sink to $HDMI_SINK_ID"
  wpctl set-default $HDMI_SINK_ID
fi
