1.
 ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -r 25 -i :0.0 -vcodec mpeg2video -ar 44100 -s wvga -y -qscale 0 sample.mpg
  ffmpeg -i video4linux -vcodec libx264 -vb 300k -preset fast -i /dev/dsp -ar 22400 -ac 2 -acodec aac -strict -2 -ab 32k -f flv rtmp://localhost/live/stream1


2.
