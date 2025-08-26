function encode_video -d "Encode Video with x264 encoder" -a target
    set command ffmpeg -i \"$target\" -vcodec libx264 -crf 28 \"{$target}_encoded.mp4\"
    echo $command
    eval $command
end
