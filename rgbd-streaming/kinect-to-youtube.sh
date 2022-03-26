#!/bin/bash
# This script grabs the content from the kinect and sends it
# encoded as H.264 to YouTube

if [ -z "${YT_KEY}" ]; then
    echo "Please set the YT_KEY env var to your stream key"
    exit 1
fi

YT_SERVER="rtmp://a.rtmp.youtube.com/live2/x/${YT_KEY} app=live2"

gst-launch-1.0 k4asrc depth-mode=wfov_2x2_binned timestamp-mode=clock_all enable-color=true rectify-depth=true ! \
 rgbddemux name=demux demux.src_depth ! queue ! colorizer near-cut=100 far-cut=6000 preset=hsv ! comp.sink_0 \
 demux.src_color ! queue ! .sink_1 compositor name=comp sink_0::ypos=720 ! video/x-raw,width=1280,height=1440 ! \
 videoconvert ! x264enc bitrate=2000 tune=zerolatency speed-preset=faster key-int-max=5 ! \
 'video/x-h264, profile=baseline, level=(string)4' ! h264parse config-interval=-1 ! \
 queue max-size-buffers=0 max-size-bytes=0 max-size-time=300000000 min-threshold-buffers=1 leaky=upstream ! mux. \
 alsasrc  ! audio/x-raw, rate=44100, channels=1 ! audioconvert ! avenc_aac bitrate=44100 ! aacparse ! audio/mpeg, mpegversion=4 ! \
 queue max-size-buffers=0 max-size-bytes=0 max-size-time=300000000 min-threshold-buffers=1 ! mux. \
 flvmux name=mux streamable=true latency=3000000000 ! rtmpsink location="$YT_SERVER"
