# Youtube Archive Tutorial
This tutorial covers setting up and using `youtube-dl` to download videos, playlists and channels.

## Table of Contents
- [Prerequisites](#prerequisites)
  - [Installing chocolatey on Windows](#installing-chocolatey-on-windows)
  - [Installing youtube-dl and FFmpeg using chocolatey](#installing-youtube-dl-and-ffmpeg-using-chocolatey)
- [Using youtube-dl](#using-youtube-dl)
  - [Downloading videos](#downloading-videos)
  - [Downloading playlists](#downloading-playlists)
  - [Downloading a members only video](#downloading-a-members-only-video)
  - [Archiving a channel](#archiving-a-channel)
- [Downloading a livestream as it is occurring](#downloading-a-livestream-as-it-is-occurring)
- [FAQ](#faq)

## Prerequisites
### Installing chocolatey on Windows
1. Open PowerShell in elevated mode
> Open the start menu by pressing the ⊞ windows key, type cmd, right click `Windows PowerShell` and clicking `Run as administrator`.
2. Run the following command in PowerShell by pasting it in(CTRL+V) and pressing enter.
```
Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
3. Verify chocolatey has instealled by running the command then `choco -?`.

### Installing youtube-dl and FFmpeg using chocolatey
1. Using the same PowerShell window from before, run the following command by pasting it in(CTRL+V) and pressing enter.
```
choco install -y youtube-dl ffmpeg
```
2. Verify both programs have been installed by typing then `youtube-dl --version` and `ffmpeg -version`

## Using youtube-dl
### Downloading videos
* To make your life easier, you can use [this script](scripts/dlsinglevid.ps1) instead of running the commands every time. Save the script to the directory where you want to save the video to and run it.
* Download the video to the current directory which is the path shown in cmd on the left of where you are typing
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s
```

* The `-i` flag simply ignores errors and continues instead of throwing an error (eg. if the video is privated or deleted).

* The `-o` flag is used to download the video to a different directory or to name the download file. To see a list of all the output placeholders, read [this documentation](https://github.com/ytdl-org/youtube-dl#output-template).
> Using the filename `[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s` is preferred when gathering large amounts of video as it makes the video files more searchable.

* The `-add-metadata` flag is used to add metadata to the video file which may be useful when using a [video organizer](https://www.filebot.net/) or [media centre](https://www.plex.tv/).

* The `--write-thumbnail` flag is used to save the thumbnail as an image file and the `--write-description` flag to save the description as a `.description` file.

* The `--embed-thumbnail` flag is used to embed the original thumbnail of the video into the downloaded video file. `--embed-subs` is used to embed subtitles from YouTube into the video file, this is useful for music videos.

* `--merge-output-format mp4` is used to output an `.mp4` file instead of an `.mkv` file.

* The flags can be combined to form a single command. Example:
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i --merge-output-format mp4 --add-metadata --embed-thumbnail -o "C:\Users\anon\Downloads\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Downloading playlists
> The flags shown in the previous commands can be used here too.
* You can use [this script](scripts/dlsingleplaylist.ps1) which incorporates all the flags shown below except `-r`. To update a downloaded playlist, simply run the script again with the same playlist URL.

* Download a playlist to the current directory
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd
```

* The `-r` flag is used to throttle the download rate so it does not use up all your bandwidth. 100K = 100KB/s, 1M = 1MB/s (eg. -r 10M to limit download rate to 10MB/s)
>Warning! Do not confuse MB/s with Mbps! Read about it [here](https://www.backblaze.com/blog/megabits-vs-megabytes).

* You can use the `%(playlist_index)s` placeholder in `-o` to have the video names ordered according to the playlist order.

* You can use the `%(playlist)s` placeholder to create a folder with the same name as the playlist.

* The `--download-archive` flag saves a list of downloaded videos so that if you decide to update the downloaded playlist in the future it will not redownload the videos listed.

* To download all playlists from a channel, simply copy the channel's URL and add `/playlists` at the end. Unfortunately if used with `--download-archive`, any video that shows up more than once in different playlists will only be downloaded to the playlist with the first download of that video.:


### Downloading a members only video
Make sure you have membership of the channel and are logged into YouTube or it will not work.
1. Install the extension `cookies.txt` [for Firefox](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) or [for Chrome](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid). This will let us extract cookies from your YouTube which will be used to authenticate `ytarchive`.
2. Click on the `cookies.txt` extension in the top right hand corner of the browser and click the `Export ↓` button to save the cookies. Move the file to a location of your choice.
> Do not share your cookie file with anyone unless you know what you're doing! They can have complete access to your YouTube channel.
3. Add `--cookies C:\Path\To\youtube.com_cookies.txt` at the end of any command and replace `C:\Path\To\youtube.com_cookies.txt` with the path to your cookie file. Example:
```
youtube-dl https://www.youtube.com/watch?v=TEoslCqshuQ -i --cookies C:\Users\anon\Desktop\youtube.com_cookies.txt
```
>You may find that sometimes authentication will fail. This is most likely due to old cookies. Simply repeat step 2 to replace your current cookie file.
* You can use [this script](scripts/dlsinglevid.ps1) instead of running the commands every time. Save the script to the directory where you want to save the video to and run it.

### Archiving a channel
There is a script to simplify the process of archiving an entire channel which you can find [here](scripts/dlentirechannel.ps1)

## Downloading a livestream as it is occurring
Livestreams can be captured and downloaded as they are airing.

Refer to [this guide](archiving_livestreams.md).

## FAQ
### How do I get the highest quality video and audio available?
New versions of youtube-dl will automatically pick the best quality available without any extra command options.

### How do I do stuff not mentioned here?
Read the docs.
* https://github.com/ytdl-org/youtube-dl/blob/master/README.md
* https://ffmpeg.org/documentation.html
