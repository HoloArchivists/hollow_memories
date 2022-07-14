# Youtube Archiving Tutorial <!-- omit in toc -->

This tutorial covers setting up `yt-dlp` and `ytarchive` to download livestreams, videos, playlists and channels.

## Table of Contents <!-- omit in toc -->

- [Prerequisites](#prerequisites)
  - [Installing chocolatey on Windows](#installing-chocolatey-on-windows)
  - [Installing Python and FFmpeg using chocolatey](#installing-python-and-ffmpeg-using-chocolatey)
  - [Installing yt-dlp](#installing-yt-dlp)
- [Using yt-dlp](#using-yt-dlp)
  - [Downloading videos](#downloading-videos)
  - [Downloading playlists](#downloading-playlists)
  - [Downloading members only videos](#downloading-members-only-videos)
  - [Setting-up a default config](#setting-up-a-default-config)
- [Downloading entire channels](#downloading-entire-channels)
- [Downloading livestreams](#downloading-livestreams)
- [Content Sharing](#content-sharing)
- [HoloTools/HoloStats](#holotoolsholostats)
- [Troubleshooting/FAQ](#troubleshootingfaq)
  - [When I run a command in Command Prompt, I get `'xxxx' is not recognized as an internal or external command, operable program or batch file`](#when-i-run-a-command-in-command-prompt-i-get-xxxx-is-not-recognized-as-an-internal-or-external-command-operable-program-or-batch-file)
  - [How do I get the highest quality video and audio available?](#how-do-i-get-the-highest-quality-video-and-audio-available)
  - [I get a Conversion failed! error from FFmpeg](#i-get-a-conversion-failed-error-from-ffmpeg)
  - [How do I do stuff not mentioned here?](#how-do-i-do-stuff-not-mentioned-here)

## Prerequisites

### Installing chocolatey on Windows

1. Open PowerShell in elevated mode
    - Open the start menu by pressing the ⊞ windows key, type cmd, right click `Windows PowerShell` and clicking `Run as administrator`.
2. Run the following command in PowerShell by pasting it in(CTRL+V) and pressing enter.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

3. Restart PowerShell, then verify chocolatey has been installed by running the command `choco -?`.

### Installing Python and FFmpeg using chocolatey

1. Using the same PowerShell window from before, run the following command by pasting it in(CTRL+V) and pressing enter.

```powershell
choco install -y python ffmpeg
```

2. Restart PowerShell, then verify both programs have been installed by typing `python --version` and `ffmpeg -version`

### Installing yt-dlp

1. Open PowerShell or CMD whatever you prefer

2. Run the following command by pasting it in(CTRL+V) and pressing enter.

```powershell
python -m pip install --upgrade yt-dlp
```

3. Restart CMD/PowerShell, then verify that yt-dlp has been installed by typing `yt-dlp --version`

## Using yt-dlp

If you wish to learn the CLI commands yourself, use the `yt-dlp -h` command or refer to this [README](https://github.com/yt-dlp/yt-dlp/blob/master/README.md).

### Downloading videos

- This is the basic command to download a video to the current directory

```powershell
yt-dlp https://www.youtube.com/watch?v=P8OjkcLzYCM
```

- The `-o` flag is used to download the video to a different directory or to name the download file. To see a list of all the output placeholders, read [this documentation](https://github.com/yt-dlp/yt-dlp#output-template).

> Using a filename like `[%(upload_date)s] %(title)s [%(uploader)s] (%(id)s).%(ext)s` is preferred when gathering large amounts of video as it makes the video files more searchable.

- The `--write-thumbnail` flag is used to save the thumbnail as an image file and the `--write-description` flag to save the description as a `.description` file.

- The `--embed-thumbnail` flag is used to embed the original thumbnail of the video into the downloaded video file. `--embed-subs` is used to embed subtitles from YouTube into the video file, this is useful for music videos.

> `--embed-thumbnail` will show the thumbnail as file preview depending on the container and if your file explorer supports it, as example on windows mp4 files will show it but .mkv will not.

![Preview](https://raw.githubusercontent.com/Lytexx/hollow_memories/master/assets/post_process_difference.png)

- The `--embed-metadata` flag is used to add metadata to the video file which is a nice way to save the description without the need of an additional file

> The description will be saved as `Comment` to view or copy it open the files propeties and then go to the datails tab

- `--merge-output-format mp4` is used to output an `.mp4` file instead of an `.mkv` file.

- The `-r` flag is used to throttle the download rate so it does not use up all your bandwidth. 100K = 100KB/s, 1M = 1MB/s (eg. -r 10M to limit download rate to 10MB/s)

>Warning! Do not confuse MB/s with Mbps! Read about it [here](https://www.backblaze.com/blog/megabits-vs-megabytes).

- The `-N` flag is used to state the amount of threads to use when downloading fragments.
Higher count will result in faster downloads but anything beyond 32 won't help much.

- The `-S` flag is used to sort video and audio formats to use from first to last order. It is has a lot of options that you can read about [here](https://github.com/yt-dlp/yt-dlp#sorting-formats).

- The flags can be combined to form a single command. Example:

```powershell
yt-dlp https://www.youtube.com/watch?v=P8OjkcLzYCM --merge-output-format mp4 --embed-metadata --embed-thumbnail --embed-subs --extractor-args "youtube:skip=dash" -r 10M -o "[%(upload_date)s] %(title)s [%(uploader)s] (%(id)s).%(ext)s"
```

### Downloading playlists

- Download a playlist to the current directory

```powershell
yt-dlp https://www.youtube.com/playlist?list=PLZ34fLWik_iAP2AdGLOHthUhAJTrEXqGb
```

- You can use the `%(playlist_index)s` placeholder in `-o` to have the video names ordered according to the playlist order.

- You can use the `%(playlist)s` placeholder to create a folder with the same name as the playlist.

- The `--download-archive` flag saves a list of downloaded videos so that if you decide to update the downloaded playlist in the future it will not redownload the videos listed.

- To download all playlists from a channel, simply copy the channel's URL and add `/playlists` at the end. Unfortunately if used with `--download-archive`, any video that shows up more than once in different playlists will only be downloaded to the playlist with the first download of that video.:

- The flags can be combined to form a single command. Example:

```powershell
yt-dlp https://www.youtube.com/playlist?list=PLZ34fLWik_iAP2AdGLOHthUhAJTrEXqGb --merge-output-format mp4 --embed-metadata --embed-thumbnail --embed-subs -r 10M --download-archive ".\%(playlist)s\playlist.txt" -o ".\%(playlist)s\%(playlist_index)s - [%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Downloading members only videos

Make sure you have membership of the channel and are logged into YouTube or it will not work.
use `--cookies-from-browser <BROWSER>` and it will automatically use any cookies you have in your browser
the syntax for it is `--cookies-from-browser BROWSER[+KEYRING][:PROFILE]`

```powershell
yt-dlp https://www.youtube.com/watch?v=_VcYd4EkBR0 --cookies-from-browser chrome
```

### Setting-up a default config

if you have settings you always use and don't want to type them in everytime then you can use a config file
please refer to the yt-dlp documentation here <https://github.com/yt-dlp/yt-dlp#configuration>
you can find and example config there and one that I made [here](config.txt)

## Downloading entire channels

[WIP]

## Downloading livestreams

Livestreams can be downloaded as they are airing.

They can also be downloaded from the beginning even if you start downloading mid-stream.

This is useful for unarchived livestreams or scheduled livestreams.

Refer to [this guide](archiving_livestreams.md).

## Content Sharing

The Most Convinient way to share content is by using cloud storage i will list a few providers here

Storage Provider | Free Storage | Recommended Paid Plan | Notes
------------ | ------------- | ------------- | -------------
Gofile.io | Unlimited (Temporary) | None | Files on gofile get deleted after 10 days of inactivity, Great if you don't have much space since you can watch videofiles directly on the website
Mega.nz | 20GB | Pro I (10$/M) | Fast,Easy has a build in Videoplayer and a [CLI Tool](https://megatools.megous.com) but not recommended for big files as there is a download limit (~5GB) for normal user
Google Drive | 15GB | 2TB (10$/M) | Can't say much to this, great storage provider besides the Unknown Traffic limit and compression on the filepreview
Youtube | Unlimited | - | Not cloud storage but a good alternative if you don't care about the quality loss

## HoloTools/HoloStats

Holo Tools and HoloStats are amazing to keep track of all the ongoing livestreams in hololive

You can see all the running,upcoming and recently ended streams of all hololive channels
<https://hololive.jetri.co> (HoloTools)
<https://holo.poi.cat> (HoloStats)

HoloTools updates thumbnails so if a stream gets unavailable you can see it
![image](https://raw.githubusercontent.com/Lytexx/hollow_memories/master/assets/holotools.png)

HoloStats doesnt do that this way you can get the thumbnail even when the stream gets deleted
it also shows how long a stream was

![image](https://raw.githubusercontent.com/Lytexx/hollow_memories/master/assets/holostats.png)

## Troubleshooting/FAQ

### When I run a command in Command Prompt, I get `'xxxx' is not recognized as an internal or external command, operable program or batch file`

- Try reopening a new Command Prompt in administrator mode and verify if they work.
- Make sure you followed the instructions and installed everything correctly.
- Try adding `.exe` behind the command (eg. `ytarchive.exe` instead of `ytarchive`).

### How do I get the highest quality video and audio available?

New versions of yt-dlp will automatically pick the best quality available without any extra command options.

### I get a Conversion failed! error from FFmpeg

- this should be fixed with an up to date ffmpeg version (5.0 or higher)
- if you still have that problem then you can fix this by using `-S quality,res,fps,proto,codec:vp9.2` which will prefer https+avc over dash+vp9
  or use `--extractor-args "youtube:skip=dash"` to completly ignore dash formats

### How do I do stuff not mentioned here?

Read the docs.

- <https://github.com/yt-dlp/yt-dlp/blob/master/README.md>
- <https://ffmpeg.org/documentation.html>
