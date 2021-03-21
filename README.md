# Youtube Archive Tutorial
This tutorial covers setting up and using `youtube-dl` to download videos, playlists and channels.

## Table of Contents
- [Prerequisites](#prerequisites)
  - [Installing chocolatey on Windows](#installing-chocolatey-on-windows)
  - [Installing youtube-dl and FFmpeg using chocolatey](#installing-youtube-dl-and-ffmpeg-using-chocolatey)
- [Using youtube-dl](#using-youtube-dl)
  - [Downloading a single video](#downloading-a-single-video)
  - [Downloading a playlist](#downloading-a-playlist)
  - [Downloading all playlists from a channel](#downloading-all-playlists-from-a-channel)
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
3. Verify chocolatey has instealled by running the command `refreshenv` then `choco -?`.

### Installing youtube-dl and FFmpeg using chocolatey
1. Using the same PowerShell window from before, run the following command by pasting it in(CTRL+V) and pressing enter.
```
choco install -y youtube-dl ffmpeg
```
2. Verify both programs have been installed by typing `refreshenv` then `youtube-dl --version` and `ffmpeg -version`

## Using youtube-dl
>The following examples download as `.mkv` files otherwise stated. See the [FAQ section](#faq) below on the difference between `.mkv` and `.mp4`. It is recommended to use the `.mp4` version of the command for most streams and `.mkv` for content with video resolution higher than `1080p` or music videos.
### Downloading a single video
1. Open cmd.
2. Run one of the following `youtube-dl` commands after replacing the youtube link with a link to the video you want to download.

* Download it to the current directory (The path shown in cmd on the left of where you are typing)
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i
```

* Download to a specific directory and use the video title as the file name. Replace the directory path `C:\Users\anon\Downloads\` with the path to the directory you want to download it to.
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i -o "C:\Users\anon\Downloads\%(title)s.%(ext)s"
```

* Download a video to a specific directory along with metadata, video description embedded in the comment property as well as in a file, and the youtube thumbnail.
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i --add-metadata --write-thumbnail --write-description -o "C:\Users\anon\Downloads\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

* Same as the above but as an `.mp4` file.
```
youtube-dl https://www.youtube.com/watch?v=pFgUluV_00s -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 --add-metadata --write-thumbnail --write-description -o "C:\Users\anon\Downloads\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

### Downloading a playlist
1. Open cmd.
2. Run one of the following `youtube-dl` commands after replacing the youtube playlist link with a link to the youtube playlist you want to download.

* Download a playlist to a specific directory with the files in order of how they appear in the playlist. Replace `C:\Users\anon\Desktop\comet originals` with the path to the directory of your choice.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd -i -o "C:\Users\anon\Desktop\comet originals\%(playlist_index)s - %(title)s.%(ext)s"
```
* Download a playlist to a folder named after the playlist with the files in order of how they appear in the playlist. Replace `C:\Users\anon\Desktop` with the path to the directory of your choice. A subfolder with the same name as the playlist will be created with the downloaded videos in it.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd -i -o "C:\Users\anon\Desktop\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```

* Same as the scenario above but saves information about the videos that have already been downloaded so you can later run the same command again to update your downloaded playlist without redownloading everything. 
> There are now two paths you must edit, one for the path to where the archive file is and one for where the videos will be downloaded. The folder of where the archive file will be located must exist prior to running this command, so create the folder if it doesn't already exist.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd --download-archive "C:\Users\anon\Desktop\archives\comet_originals_playlist.txt" -i -o "C:\Users\anon\Desktop\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```

* Same as the above but as an `.mp4` file.
```
youtube-dl https://www.youtube.com/playlist?list=PLAo9RlHR2tDZwddeEyp9nTfpaFB58DrXd --download-archive "C:\Users\anon\Desktop\archives\comet_originals_playlist.txt" -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 -o "C:\Users\anon\Desktop\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```

### Downloading all playlists from a channel
In this example you will create a folder for the channel and all the playlists will be downloaded to their own folders inside the channel folder. An archive file is going to be used to prevent redownloading if `youtube-dl` stops working (such as your computer going to sleep). Due to technical constrains, any video that shows up more than once in different playlists will only be downloaded to the playlist with the first download of that video. If you do not want this behavior, then refer to instructions from [Downloading a playlist
](##downloading-a-playlist). Generally, videos are not repeated in playlists on Hololivers' channels.

1. Create a folder where all the playlists will be downloaded.
2. Open cmd.
3. Run the following `youtube-dl` command, replacing the channel's playlists URL with the playlists URL of your choice. Replace `C:\Users\anon\Desktop\comet\` with the path to the folder you created. The speed is throttled to 1MB per second to prevent the download from hogging all your bandwidth, you can change `-r 1M` accordingly (eg. `-r 50K`, `-r 4.2M`) or remove it entirely to disable the throttling.
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A/playlists -r 1M --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -o "C:\Users\anon\Desktop\comet\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```

* Same as the above but as an `.mp4` file.
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A/playlists -r 1M --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 -o "C:\Users\anon\Desktop\comet\%(playlist)s\%(playlist_index)s - %(title)s.%(ext)s"
```

### Downloading a members only video
Make sure you have membership of the channel and are logged into YouTube or it will not work.
1. Install the extension `cookies.txt` [for Firefox](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) or [for Chrome](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid). This will let us extract cookies from youtube which will be used to authenticate `youtube-dl`.
2. Click on the `cookies.txt` extension in the top right hand corner of the browser and click get cookies for `Current Site`. Save the cookies to a location of your choice. In this example we will use `C:\Users\anon\Desktop\youtube-cookies.txt`
> Do not share your cookie file with anyone unless you know what you're doing! They can have complete access to your YouTube channel.
3. Follow the steps from [Downloading a single video](#Downloading a single video) but add `--cookies C:\Users\anon\Desktop\youtube-cookies.txt` at the end of any command. Example command for downloading the video to the current directory
```
youtube-dl https://www.youtube.com/watch?v=TEoslCqshuQ -i --cookies C:\Users\anon\Desktop\youtube-cookies.txt
```
>You may find that sometimes authentication will fail. This is most likely due to old cookies. Simply repeat step 2 to replace your current cookie file.

### Archiving a channel
In this example you will download every video uploaded by the channel into a single folder. This will not include videos uploaded by other channels that may have been included in playlists of the channel instead. This means you may miss out on collabs such as duet songs. Unlisted videos and members only videos will not be downloaded. The videos downloaded will have file names in the following format `[ChannelName][Upload Date] Video Title (Youtube video id).mkv`. Example: `[anon ch][20201231] anon sings (oqbyL3JRaHo).mkv`
1. Create a folder where all the videos of the channel will be downloaded.
2. Open cmd.
3. Run the following `youtube-dl` command, replacing the channel URL with the channel URL of your choice. Replace `C:\Users\anon\Desktop\comet\` with the path to the folder you created. The speed is throttled to 1MB per second to prevent the download from hogging all your bandwidth, you can change `-r 1M` accordingly (eg. `-r 50K`, `-r 4.2M`) or remove it entirely to disable the throttling. `--add-metadata` will add the video description to the downloaded video's comment property and set the date modified of the video file to the date it was uploaded. `--write-info-json` will create a file with some information that might be useful later on. `--write-thumbnail` will download the image that is used as the thumbnail for the video. `--write-description` will create a file with the video description in it.
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A -r 1M --add-metadata --write-info-json --write-thumbnail --write-description --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -o "C:\Users\anon\Desktop\comet\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

* Same as the scenario above but outputs an `.mp4` file.
```
youtube-dl https://www.youtube.com/channel/UC5CwaMl1eIgY8h02uZw7u8A -r 1M --add-metadata --write-info-json --write-thumbnail --write-description --download-archive "C:\Users\anon\Desktop\comet\archive.txt" -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 -o "C:\Users\anon\Desktop\comet\[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
```

To get a more complete collection of the channel will require some ingenuity on your part. You can download all the playlists on the channel and then run the command for archiving the channel to download all the videos that are not in a playlist on the channel. As long as `youtube-dl` targets the same archive file in `--download-archive <FILE>`, it will not download videos previously listed in the archive file. 

Unlisted videos can be downloaded using the instructions in [Downloading a single video](#downloading-a-single-video). Use `[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s` as the file name to get the same file name format as the command above.

You can create scheduled tasks to periodically run your archival commands to stay up to date automatically. 

## Downloading a livestream as it is occurring
Livestreams can be captured and downloaded as they are airing.

Refer to [this guide](archiving_livestreams.md).

## FAQ
### How do I get the highest quality video and audio available?
New versions of youtube-dl will automatically pick the best quality available without any extra command options.

### What options do I need to pass to get the highest quality `.mp4`?
```
-f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4
```
You can add this after the `-i` on any of the shown commands.

### What difference is there between the highest quality `.mp4` and `.mkv`?
Using `.mkv` will download `48kHz Opus audio` if it is available while `.mp4` will download `44.1kHZ AAC audio`. Using `.mkv` will allow higher qualities and resolutions above `1080p` while `.mp4` will be limited to `1080p`*. There are only a handful of videos that are above `1080p` and most are short music videos as opposed to long live streams.

*These limitations are due to the streams available from youtube and container type that can contain the streams.

### How do I do stuff not mentioned here?
Read the docs.
* https://github.com/ytdl-org/youtube-dl/blob/master/README.md
* https://ffmpeg.org/documentation.html
