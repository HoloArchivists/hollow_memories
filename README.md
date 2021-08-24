# Youtube Archive Tutorial

This tutorial covers setting up `yt-dlp` and `ytarchive` to download livestreams, videos, playlists and channels.

## Table of Contents

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
- [Content sharing](#content-sharing)
  - [Using torrents](#using-torrents)
- [HoloTools/HoloStats](#holotoolsholostats)
- [Troubleshooting/FAQ](#troubleshootingfaq)

## Prerequisites

### Installing chocolatey on Windows

1. Open PowerShell in elevated mode
    - Open the start menu by pressing the ⊞ windows key, type cmd, right click `Windows PowerShell` and clicking `Run as administrator`.
2. Run the following command in PowerShell by pasting it in(CTRL+V) and pressing enter.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
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

- You can use [this script to download single videos](scripts/Windows/dlsinglevid.ps1) which incorporates all the recommended flags. Save the script to the directory where you want to save the video to and run it.
- You can use [this script to download playlists](scripts/Windows/dlsingleplaylist.ps1) which incorporates all the recommended flags. To update a downloaded playlist, simply run the script again with the same playlist URL.

- This is the basic command to download a video to the current directory

```powershell
yt-dlp https://www.youtube.com/watch?v=P8OjkcLzYCM
```

- The `-o` flag is used to download the video to a different directory or to name the download file. To see a list of all the output placeholders, read [this documentation](https://github.com/yt-dlp/yt-dlp#output-template).

> You can add `~\` at the start of `-o` as a shortcut to your home directory (eg. C:\Users\anon). Using `.\` will save it to the current directory of the Command Prompt.

> Using the filename `[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s` is preferred when gathering large amounts of video as it makes the video files more searchable.

- The `--write-thumbnail` flag is used to save the thumbnail as an image file and the `--write-description` flag to save the description as a `.description` file.

- The `--embed-thumbnail` flag is used to embed the original thumbnail of the video into the downloaded video file. `--embed-subs` is used to embed subtitles from YouTube into the video file, this is useful for music videos.

> --embed-thumbnail will show the thumbnail as file preview if your file explorer supports it (mp4 has thumbnail embeded)

![Preview](https://raw.githubusercontent.com/Lytexx/hollow_memories/master/assets/post_process_difference.png)

- The `--embed-metadata` flag is used to add metadata to the video file which is a nice way to save the description without the need of an additional file
> The description will be saved as `Comment` to view or copy it open the files propeties and then go to the datails tab


- `--merge-output-format mp4` is used to output an `.mp4` file instead of an `.mkv` file.

- The `-r` flag is used to throttle the download rate so it does not use up all your bandwidth. 100K = 100KB/s, 1M = 1MB/s (eg. -r 10M to limit download rate to 10MB/s)

>Warning! Do not confuse MB/s with Mbps! Read about it [here](https://www.backblaze.com/blog/megabits-vs-megabytes).

- The `-N` flag is used to state the amount of threads to use when downloading fragments. Higher count will result in faster downloads but do not set it above 16 as it does nothing much past that point.

- The `-S` flag is used to sort video and audio formats to use from first to last order. It is has a lot of options that you can read about [here](https://github.com/yt-dlp/yt-dlp#sorting-formats).

> It is recommended to use `-S quality,res,fps,proto,codec:vp9.2` as it fixes issues with broken video downloading and playback, [see here](#i-get-a-conversion-failed-error-from-ffmpeg)

- The flags can be combined to form a single command. Example:

```
yt-dlp https://www.youtube.com/watch?v=P8OjkcLzYCM --merge-output-format mp4 --embed-metadata --embed-thumbnail --embed-subs -S "quality,res,fps,proto,codec:vp9.2" -r 10M -o "[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Downloading playlists

- Download a playlist to the current directory

```
yt-dlp https://www.youtube.com/playlist?list=PLZ34fLWik_iAP2AdGLOHthUhAJTrEXqGb
```

- You can use the `%(playlist_index)s` placeholder in `-o` to have the video names ordered according to the playlist order.

- You can use the `%(playlist)s` placeholder to create a folder with the same name as the playlist.

- The `--download-archive` flag saves a list of downloaded videos so that if you decide to update the downloaded playlist in the future it will not redownload the videos listed.

- To download all playlists from a channel, simply copy the channel's URL and add `/playlists` at the end. Unfortunately if used with `--download-archive`, any video that shows up more than once in different playlists will only be downloaded to the playlist with the first download of that video.:

- The flags can be combined to form a single command. Example:

```
yt-dlp https://www.youtube.com/playlist?list=PLZ34fLWik_iAP2AdGLOHthUhAJTrEXqGb --merge-output-format mp4 --embed-metadata --embed-thumbnail --embed-subs -r 10M --download-archive ".\%(playlist)s\playlist.txt" -o ".\%(playlist)s\%(playlist_index)s - [%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Downloading members only videos

Make sure you have membership of the channel and are logged into YouTube or it will not work.

1. Install the extension `cookies.txt` [for Firefox](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) or [for Chrome](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid). This will let us extract your cookies from YouTube which will be used to authenticate `ytarchive`.
2. Open Youtube then click on the `cookies.txt` extension in the top right hand corner of the browser and click the `Export ↓` button to save the cookies. Move the file to a location of your choice.

> Do not share your cookie file with anyone unless you know what you're doing! They can have complete access to your YouTube Account.

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

There is a script to simplify the process of downloading an entire channel which you can find [here](scripts/Windows/dlentirechannel.ps1).

## Downloading livestreams

Livestreams can be downloaded as they are airing.

This is useful for no archive livestreams or scheduled livestreams.

Refer to [this guide](archiving_livestreams.md).

## Content Sharing

### Using Torrents

In case you are new to torrents this article explains how bittorrent works
<https://www.howtogeek.com/141257/htg-explains-how-does-bittorrent-work>

Explaining how to use a bittorrent client would go beyond the scope of this tutorial

I personally use Qbittorrent <https://www.qbittorrent.org/> a very advanced bittorrent client that i would definitively recommend if you plan on torrenting a lot

if you just want something simple you can use picotorrent <https://picotorrent.org/>

both are free,open-source and very easy to use

#### Uploading Torrents to Nyaa.si

If you want to share streams as torrents i recommend using nyaa.si to upload them
nyaa.si is "A BitTorrent community focused on Eastern Asian media including anime, manga, music, and more."

before using it read the rules <https://nyaa.si/rules> and the help page <https://nyaa.si/help>
I recommend making an account so you can edit/manage your torrents later
to upload torrents to nyaa.si click the upload button at the top left which wil send you to <https://nyaa.si/upload>

the rest should be pretty self explaining, the search on nyaa is very specific so use a proper title
as example you could use `hololive` at the beginning and `(VideoID)` at the end like i do

as Category you can use whatever you want since there is none that fits vtuber content, i usually use `Live Action - Raw`

for the Torrent flags `Anonymous` will show `Anonymous` instead of your username as uploader
`Hidden` is like the unlisted option on youtube only you will be able to see it

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

### I get a "Conversion failed!" error from FFmpeg

- There is an issue with newer FFmpeg releases when there is a different protocol for audio and video.
- FFmpeg versions before 3.1.4 do not have this issue.
- you can fix this by using `-S quality,res,fps,proto,codec:vp9.2` which will prefer https+avc over dash+vp9
  or use `--extractor-args "youtube:skip=dash"` to completly ignore dash formats

### How do I do stuff not mentioned here?

Read the docs.

- <https://github.com/yt-dlp/yt-dlp/blob/master/README.md>
- <https://ffmpeg.org/documentation.html>
