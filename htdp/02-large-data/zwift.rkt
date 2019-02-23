adb shell "while true; do screenrecord --output-format=h264 --size 1280x720 -; done" | ffplay -framerate 60 -probesize 32 -vf scale=iw*2:ih -sync video -
