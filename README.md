# sh-tool

## 日常工具仓库

### ffmpeg_audio_cut_second.sh, ffmpeg_video_cut_second.sh

#### 根据起始时间，时长切割音视频

```shell
# 截取工具为ffmpeg，如果没有安装请先安装
brew install ffmpeg

# 若果没有通过-i指定输入文件，则遍历当前文件夹所有文件，进行切割
# 输出文件名为源文件名，输出文件夹为 ./cut（这里以截取音频为例）

# 01:16:00 为起始时间，截取到视频结束
./ffmpeg_audio_cut_second.sh -f 01:16:00

# 00:00:00 为起始时间，截取到 02:16:00
./ffmpeg_audio_cut_second.sh -t 02:16:00

# 01:16:00 为起始时间 02:16:00为终止时间，截取音视频
./ffmpeg_audio_cut_second.sh -f 01:16:00 -t 02:16:00

# 01:16:00 为起始时间 向后截取20秒
./ffmpeg_audio_cut_second.sh -f 01:16:00 -s 20
```

#### 注意

截取音频时用到了mediainfo，在使用脚本之前先执行 mediainfo.install.sh

此为mac系统安装脚本，其他系统安装请移步至 [MediaArea/MediaInfo](https://github.com/MediaArea/MediaInfo) 与 [macPorts](https://guide.macports.org/#installing.shell)

安装成功之后再执行脚本
