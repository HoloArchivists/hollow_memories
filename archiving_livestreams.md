# Archiving Livestreams
This guide covers how to record livestreams as they are occurring. This is useful for streams that will not be archived later.

## Table of Contents
- [Recording Regular Streams](#recording-regular-streams)
  - [Prerequisites](#prerequisites)
  - [Instructions](#instructions)
- [Advanced Scenarios](#advanced-scenarios)
- [Recording Members Only Streams](#recording-members-only-streams)
- [Post Processing](#post-processing)
- [FAQ](#faq)

## Recording Regular Streams
These instructions are for recording publicly available streams using [Streamlink](https://streamlink.github.io/). Youtube-dl can record livestreams as well but Streamlink offers a better user experience in this scenario (it is common for youtube-dl to corrupt livestream recordings). The following steps will record a stream while playing the stream through VLC. Instructions for using alternative media players are provided under [Advanced Scenarios](#advanced-scenarios).

tl;dr for recording livestreams
```
streamlink --retry-streams 10 --player mpv -r stream.mp4 <stream_url> best
```

### Prerequisites
1. Install [Streamlink](https://streamlink.github.io/install.html)
2. Install [VLC](https://www.videolan.org/vlc/) or another video player of your choice.
3. Install [youtube-dl](https://youtube-dl.org/). A simple install and usage guide is provided [here](README.md). This will be used to download the stream's description and thumbnail for a more complete archive.

### Instructions
The example will save the high quality stream available as `stream.mp4` in the folder `C:\Users\anon\stream_folder`.

1. Create a folder where the stream will be saved. You may want to use a temporary folder and then manually move it to the final destination afterwards.
2. Open cmd.
    * right-click ⊞ windows key and click `Command Prompt`
3. Modify the following command by replacing <path_to_folder_from_step_1> with the folder path where you are saving the stream and then running the command in the cmd window by pasting the command into the cmd window and pressing enter
>Example:
If you were to store the stream in `C:\Users\anon\stream_folder` you would run the command `cd "C:\Users\anon\stream_folder"`
```
cd "<path_to_folder_from_step_1>"
```
4. Modify the following command by replacing <name_to_save_stream_as> with the filename you want the stream to be saved as and <stream_url> with the full URL of the livestream.
>Example:
If you were to store the stream with the URL `https://www.youtube.com/watch?v=RPdUErEiRbk` as `livestream.mp4` you would run the command `streamlink -r stream.mp4 https://www.youtube.com/watch?v=RPdUErEiRbk best`
```
streamlink -r <name_to_save_stream_as>.mp4 <stream_url> best
```

## Advanced Scenarios
Make sure to modify the following commands as shown in step 4 of [Instructions](#instructions)
### Save the stream in 720p.
This is useful when you do not have enough bandwidth or storage for 1080p streams.
```
streamlink -r <name_to_save_stream_as>.mp4 <stream_url> 720p
```

### Automatically start saving when the stream goes live
When the waiting room for the livestream is available, you can use this command to have streamlink to try start recording every 10 seconds. This is useful for if you are not present at the start of the stream.
```
streamlink --retry-streams 10 -r <name_to_save_stream_as>.mp4 <stream_url> best
```

### Use MPV or MPC-HC instead of VLC for video playback
You may have to provide the full path of the video player executable instead of just using the short name. To use the short name instead of the full file path, you have to add the file path of the video player to your `PATH`. You can do this by modifying and using the following command in an elevated command prompt.
  * right-click ⊞ windows key and click `Command Prompt (Admin)`
```
setx /M PATH "%PATH%;<C:\Replace\This\With\Path\To\Video_Player>"
```

- To use mpv for playback:
```
streamlink --player mpv -r <name_to_save_stream_as>.mp4 <stream_url> best
```

- To use MPC-HC for playback:
```
streamlink --player mpc-hc64 -r <name_to_save_stream_as>.mp4 <stream_url> best
```

### Save the stream without video playback
Changing `-r` to `-o` in the command makes it save to a video without playing the it back. This is useful when combined with `--retry-streams 10` for if you are not present at the start of the stream.
```
streamlink -o <name_to_save_stream_as>.mp4 <stream_url> best
```
- with `--retry-streams 10`
```
streamlink --retry-streams 10 -o <name_to_save_stream_as>.mp4 <stream_url> best
```

## Recording Members Only Streams
### Recommended: using the streamlink-auth.ps1 script
This script will extract the right value out of a `cookies.txt` file and run `streamlink` with the provided arguments.
1. Get a `cookies.txt` file. Refer to steps 1 to 4 [here](README.md#downloading-a-members-only-video)
2. Download [streamlink-auth.ps1](scripts/streamlink-auth.ps1) and save it as `streamlink-auth.ps1` at where you installed `streamlink`.
   > Default installation location is `C:\Program Files (x86)\Streamlink\bin`
3. Open Powershell.
   * Open the start menu (Windows key), type in powershell, open Windows Powershell
   * ⊞ windows key + type powershell + right click on app and select `Run as administrator`
4. Modify the following command by replacing <COOKIES_TXT_FILE_PATH> with the path to your `cookies.txt` file and <STREAMLINK_ARGUMENTS> with the arguments you want to pass and then running the command in the Powershell window by pasting the command into the cmd window and pressing enter
   * If you are running into issues with `streamlink-auth` not being recognized, copy the script somewhere else, then navigate to that folder in Powershell using the command `cd "<Path to folder containing script>"` and try again.
>Example:
If you were to store `cookies.txt` in `C:\Users\anon\Documents\cookies.txt` and want to save the stream `https://www.youtube.com/watch?v=-hLmfV-wQKo` you would run the command `streamlink-auth C:\Users\anon\Documents\cookies.txt https://www.youtube.com/watch?v=-hLmfV-wQKo best`
```
streamlink-auth COOKIES_TXT_FILE_PATH STREAMLINK_ARGUMENTS
```

### Directly with Streamlink
The streamlink-auth.ps1 script is simply extracting the `__Secure-3PSID` cookie for .youtube.com and setting the `--http-cookie` command line argument in streamlink as `--http-cookie __Secure-3PSID=<cookie value>`. The line in the `cookies.txt` you are looking for looks like this
```
#HttpOnly_.youtube.com	TRUE	/	TRUE	1667272763	__Secure-3PSID	<Some random letters and numbers, this is the cookie value>
```
If you use the same `cookies.txt` with `youtube-dl` then the line might not start with `#HttpOnly_`.

## Post Processing
The previous steps should have given you a working video file but it can be improved with a few simple steps. The following steps will convert the file to a [real `.mp4` file](#real-mp4), add the original stream thumbnail, save the video description with the recording, and give the video a nice name. 

Before and After:
![Post Processing Difference](assets/post_process_difference.jpg)

Do the following in PowerShell instead of command prompt. You can convert a command prompt into PowerShell by using the command `powershell`.
You will have to open a new command prompt for PowerShell while your previous command prompt is busy running Streamlink.

[Script that does everything below](scripts/postprocess.ps1).

1. Generate a nice filename to be used later. Example generated filename: `[Botan Ch.獅白ぼたん][20200830] 5期生より (fCqDv94ZeuA)`. You will want to do this step while the stream is still live.
```
$filename = youtube-dl --write-description --skip-download -o "[%(uploader)s][%(upload_date)s] %(title)s (%(id)s)" --get-filename <stream_url>
``` 
2. Download the livestream's description and thumbnail as `stream.description` and `stream.jpg` respectively. You will want to do this step while the stream is still live, as once the livestream ends, the archive is deleted and you will not have access to the description nor the thumbnail anymore.
```
youtube-dl --write-thumbnail --write-description --skip-download -o stream <stream_url>
```
3. Store the livestream's description as variable `$description`.
```
$description = [IO.File]::ReadAllText(".\stream.description")
```
4. Convert to `.mp4`, add thumbnail, add the description into the video's comment and save the new video with a formatted name.
```
ffmpeg -i .\stream.mp4 -i .\stream.jpg -map 1 -map 0 -c copy -disposition:0 attached_pic -metadata comment=$description $($filename + ".mp4")
```

## FAQ
### Real .mp4?
The original recording from streamlink is saved with a `.mp4` file extension but it is actually a `MPEG-TS` format file. Most modern video players will still be able to play the recording despite the wrong file extension. 

Using the `.mp4` extension is convenient for most people as their video players will be set up to open files with the extension `.mp4` on default, but converting the file to a real `.mp4` file will reduce the file size without affecting quality.

### My thumbnail was downloaded as a .webp file and it's not supported for thumbnails, how do I convert it?
You can convert from `.webp` to `.jpg` using FFmpeg.
```
ffmpeg -i stream.webp stream.jpg
```

### I really really want to use youtube-dl instead of streamlink, how do I record and playback at the same time?
```
youtube-dl -o - <stream_url>  best | tee stream.mp4 | mpv -
```
You can get `tee` by installing [git](https://git-scm.com/downloads). This will not work in PowerShell.

### Why not use AtomicParsley to add the thumbnail?
AtomicParsley only records the first 255 characters of the video's comment. If you want to use it, do it before adding the comment.

### How do I do stuff not mentioned here?
Read the docs.
* https://github.com/ytdl-org/youtube-dl/blob/master/README.md
* https://ffmpeg.org/documentation.html
* https://streamlink.github.io/cli.html
