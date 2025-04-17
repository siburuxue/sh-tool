#!/bin/bash
# ./ffmpeg_audio_cut_second.sh -f 01:16:00
# ./ffmpeg_audio_cut_second.sh -t 02:16:00
# ./ffmpeg_audio_cut_second.sh -f 01:16:00 -t 02:16:00
# ./ffmpeg_audio_cut_second.sh -f 01:16:00 -s 20
# ./ffmpeg_audio_cut_second.sh -f 01:16:00 -i 1.mp3 -o 1.mp3
# ./ffmpeg_audio_cut_second.sh -t 02:16:00 -i 1.mp3 -o 1.mp3
# ./ffmpeg_audio_cut_second.sh -f 01:16:00 -t 02:16:00 -i 1.mp3 -o 1.mp3
# ./ffmpeg_audio_cut_second.sh -f 01:16:00 -s 20 -i 1.mp3 -o 1.mp3
# 文件名中不能含有空格

if [ $# == 0 ];then
    ./ffmpeg_audio_cut_second.sh -h
    exit
fi

from="00:00:00"
to=""
seconds=0
filename=$0
filename=${filename#./}
output=""
input=""
while getopts ":i:o:f:t:s:h" optname
do
    case "$optname" in
        "f")
            from="$OPTARG"
            ;;
        "t")
            to="$OPTARG"
            ;;
        "s")
            seconds="$OPTARG"
            ;;  
        "o")
            output="$OPTARG"
            ;;
        "i")
            input="$OPTARG"
            ;;
        "h")
            echo "cut media file by timestamp"
            echo "if no file is specified by the -i parameter, all files in the current folder will be traversed"
            echo "if the -i parameter specifies an input file and the -o parameter is not entered, the default output file name is the one specified by the -i parameter"
            echo " -i input file name"
            echo " -o output file name"
            echo " -f the start timestamp 00:00:55, it will cut from the 00:00:00 if empty"
            echo " -t the start timestamp 00:12:44, it will cut end of the media file duration if empty"
            echo " -s the seconds time line will be cut"
            echo "example:"
            echo " ./ffmpeg_audio_cut_second.sh -f 01:16:00"
            echo " ./ffmpeg_audio_cut_second.sh -t 02:16:00"
            echo " ./ffmpeg_audio_cut_second.sh -f 01:16:00 -t 02:16:00"
            echo " ./ffmpeg_audio_cut_second.sh -f 01:16:00 -s 20"
            echo " ./ffmpeg_audio_cut_second.sh -f 01:16:00 -i 1.mp3 -o 1.mp3"
            echo " ./ffmpeg_audio_cut_second.sh -t 02:16:00 -i 1.mp3 -o 1.mp3"
            echo " ./ffmpeg_audio_cut_second.sh -f 01:16:00 -t 02:16:00 -i 1.mp3 -o 1.mp3"
            echo " ./ffmpeg_audio_cut_second.sh -f 01:16:00 -s 20 -i 1.mp3 -o 1.mp3"
            exit 0;
            ;;      
        *)
            echo "unknow options $optname"
            exit 1
            ;;       
    esac
done  

if [ ! -f "./cut" ] ; then
    mkdir "./cut"
fi
# 如果没有-i参数 则循环当前文件夹中所有文件进行分割
# 如果存在-i参数 则之对输入文件进行分割
if [ -z "$input" ] ; 
then
    for item in `ls|grep -v "cut"|grep -v "$filename"`
    do
        duration=`ffmpeg -i "$item" 2>&1|grep Duration|awk -F', ' '{print $1}'|awk -F'Duration: ' '{print $2}'`
        if [ -z "$to" ] ; then
            to=$duration
        fi
        if [ $seconds -gt 0 ] ; then
            ffmpeg -i "$item" -ss $from -t $seconds -acodec copy "cut/$item"
        else
            ffmpeg -i "$item" -ss $from -to $to -acodec copy "cut/$item"
        fi
    done
else
     duration=`ffmpeg -i "$input" 2>&1|grep Duration|awk -F', ' '{print $1}'|awk -F'Duration: ' '{print $2}'`
    if [ -z "$to" ] ; then
        to=$duration
    fi
    if [ -z "$output" ] ; then
        output=$input
    fi
    if [ $seconds -gt 0 ] ; then
        ffmpeg -i "$input" -ss $from -t $seconds -acodec copy "cut/$output"
    else
        ffmpeg -i "$input" -ss $from -to $to -acodec copy "cut/$output"
    fi
fi


