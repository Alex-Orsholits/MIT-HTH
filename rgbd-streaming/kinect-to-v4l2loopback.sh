#!/bin/bash
# This script grabs the content from the kinect and displays it in a stacked
# view with video and (color encoded) depth

gst-launch-1.0 -v k4asrc depth-mode=wfov_2x2_binned timestamp-mode=clock_all enable-color=true rectify-depth=true ! \
 video/rgbd,framerate=30/1 ! \
 rgbddemux name=demux demux.src_depth ! queue ! colorizer near-cut=100 far-cut=6000 preset=hsv ! comp.sink_0 \
 demux.src_color ! queue ! .sink_1 compositor name=comp sink_0::ypos=720 ! \
 'video/x-raw,width=1280,height=1440' ! \
 videoconvert ! video/x-raw,format=NV12 ! v4l2sink device=/dev/video0
