# Youtube Archive Tutorial
This tutorial covers setting up and using `youtube-dl` to download videos, playlists and channels.

## Table of Contents
- [Prerequisites](#prerequisites)
  - [Installing chocolatey on Windows](#installing-chocolatey-on-windows)
  - [Installing Python and FFmpeg using chocolatey](#installing-python-and-ffmpeg-using-chocolatey)
  - [Installing yt-dlp](#installing-yt-dlp)
- [Using yt-dlp](#using-yt-dlp)
  - [Downloading videos](#downloading-videos)
  - [Downloading playlists](#downloading-playlists)
  - [Downloading members only videos](#downloading-members-only-videos)
- [Downloading entire channels](#downloading-entire-channels)
- [Downloading livestreams](#downloading-livestreams)
- [FAQ](#faq)

## Prerequisites
### Installing chocolatey on Windows
1. Open PowerShell in elevated mode
    - Open the start menu by pressing the ⊞ windows key, type cmd, right click `Windows PowerShell` and clicking `Run as administrator`.
2. Run the following command in PowerShell by pasting it in(CTRL+V) and pressing enter.
```
Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
3. Verify chocolatey has instealled by running the command then `choco -?`.

### Installing Python and FFmpeg using chocolatey
1. Using the same PowerShell window from before, run the following command by pasting it in(CTRL+V) and pressing enter.
```
choco install -y python ffmpeg
```
2. Verify both programs have been installed by typing `python --version` and `ffmpeg -version`

### Installing yt-dlp
1. Open Command Prompt in elevated mode
    - Open the start menu by pressing the ⊞ windows key, type cmd, right click `Command Prompt` and clicking `Run as administrator`.
2. Run the following command by pasting it in(CTRL+V) and pressing enter.
```
python -m pip install --upgrade yt-dlp
```
3. Verify that yt-dlp has been installed by typing `yt-dlp --version`

## Using yt-dlp
If you wish to learn the CLI commands yourself, use the `yt-dlp -h` command or refer to this [README](https://github.com/yt-dlp/yt-dlp/blob/master/README.md).
### Downloading videos
* You can use [this script to download single videos](scripts/dlsinglevid.ps1) which incorporates all the recommended flags. Save the script to the directory where you want to save the video to and run it.
* You can use [this script to download playlists](scripts/dlsingleplaylist.ps1) which incorporates all the recommended flags. To update a downloaded playlist, simply run the script again with the same playlist URL.

* This is the basic command to download a video to the current directory
```
yt-dlp https://www.youtube.com/watch?v=P8OjkcLzYCM
```

* The `-i` flag simply ignores errors and continues instead of throwing an error (eg. if the video is privated or deleted).

* The `-o` flag is used to download the video to a different directory or to name the download file. To see a list of all the output placeholders, read [this documentation](https://github.com/ytdl-org/youtube-dl#output-template).
> You can add `~\` at the start of `-o` as a shortcut to your home directory (eg. C:\Users\anon). Using `.\` will save it to the current directory of the Command Prompt.

> Using the filename `[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s` is preferred when gathering large amounts of video as it makes the video files more searchable.

* The `-add-metadata` flag is used to add metadata to the video file which may be useful when using a [video organizer](https://www.filebot.net/) or [media centre](https://www.plex.tv/).

* The `--write-thumbnail` flag is used to save the thumbnail as an image file and the `--write-description` flag to save the description as a `.description` file.

* The `--embed-thumbnail` flag is used to embed the original thumbnail of the video into the downloaded video file. `--embed-subs` is used to embed subtitles from YouTube into the video file, this is useful for music videos.

* `--merge-output-format mp4` is used to output an `.mp4` file instead of an `.mkv` file.

* The `-r` flag is used to throttle the download rate so it does not use up all your bandwidth. 100K = 100KB/s, 1M = 1MB/s (eg. -r 10M to limit download rate to 10MB/s)
>Warning! Do not confuse MB/s with Mbps! Read about it [here](https://www.backblaze.com/blog/megabits-vs-megabytes).

* The `-n` flag is used to state the amount of threads to use when downloading fragments. Higher count will result in faster downloads but do not set it above 16 as it does nothing much past that point.

* The flags can be combined to form a single command. Example:
```
yt-dlp https://www.youtube.com/watch?v=P8OjkcLzYCM -i --merge-output-format mp4 --add-metadata --embed-thumbnail --embed-subs -r 10M -o "[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Downloading playlists
* Download a playlist to the current directory
```
yt-dlp https://www.youtube.com/playlist?list=PLZ34fLWik_iAP2AdGLOHthUhAJTrEXqGb
```

* You can use the `%(playlist_index)s` placeholder in `-o` to have the video names ordered according to the playlist order.

* You can use the `%(playlist)s` placeholder to create a folder with the same name as the playlist.

* The `--download-archive` flag saves a list of downloaded videos so that if you decide to update the downloaded playlist in the future it will not redownload the videos listed.

* To download all playlists from a channel, simply copy the channel's URL and add `/playlists` at the end. Unfortunately if used with `--download-archive`, any video that shows up more than once in different playlists will only be downloaded to the playlist with the first download of that video.:

* The flags can be combined to form a single command. Example:
```
yt-dlp https://www.youtube.com/playlist?list=PLZ34fLWik_iAP2AdGLOHthUhAJTrEXqGb -i --merge-output-format mp4 --add-metadata --embed-thumbnail --embed-subs -r 10M --download-archive ".\%(playlist)s\playlist.txt" -o ".\%(playlist)s\%(playlist_index)s - [%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Downloading members only videos
Make sure you have membership of the channel and are logged into YouTube or it will not work.
1. Install the extension `cookies.txt` [for Firefox](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) or [for Chrome](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid). This will let us extract cookies from your YouTube which will be used to authenticate `ytarchive`.
2. Click on the `cookies.txt` extension in the top right hand corner of the browser and click the `Export ↓` button to save the cookies. Move the file to a location of your choice.
> Do not share your cookie file with anyone unless you know what you're doing! They can have complete access to your YouTube channel.
3. Add `--cookies C:\Path\To\youtube.com_cookies.txt` at the end of any command and replace `C:\Path\To\youtube.com_cookies.txt` with the path to your cookie file. Example:
```
yt-dlp https://www.youtube.com/watch?v=_VcYd4EkBR0 --cookies C:\Users\anon\Desktop\youtube.com_cookies.txt
```
>You may find that sometimes authentication will fail. This is most likely due to old cookies which can be caused by logging out. Simply repeat step 2 to replace your current cookie file.

### Setting-up a default config
If you find yourself using the same flags 99% of the time, you can choose to set-up a default config so that you do not need to type the flags you always use.
1. Go to your appdata
    - Open the start menu by pressing the ⊞ windows key, type `%APPDATA%` and clicking on the folder.
2. Make a new folder with the name `yt-dlp`
3. Create a text file in the folder created with the name `config.txt`
4. Edit the `config.txt` file with your desired flags. Feel free to refer to this example [config.txt](config.txt) that has commonly-used flags.
5. Download videos with ease in the future.

## Downloading entire channels
There is a script to simplify the process of downloading an entire channel which you can find [here](scripts/dlentirechannel.ps1)

## Downloading livestreams
Livestreams can be downloaded as they are airing.

This is useful for no archive livestreams or scheduled livestreams.

Refer to [this guide](archiving_livestreams.md).

## FAQ
### How do I get the highest quality video and audio available?
New versions of youtube-dl will automatically pick the best quality available without any extra command options.

### How do I do stuff not mentioned here?
Read the docs.
* https://github.com/yt-dlp/yt-dlp/blob/master/README.md
* https://ffmpeg.org/documentation.html
