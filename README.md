# Youtube Archive Tutorial

This tutorial covers setting up and using `youtube-dl` to download videos, playlists and channels.

## Prerequisites
### Get youtube-dl
1. Go to https://yt-dl.org/downloads/latest/youtube-dl.exe to download youtube-dl.
2. From your `Downloads` folder, move `youtube-dl.exe` to a permanent location.
3. Open cmd with Administrator permissions
   * right-click ⊞ windows key and click `Command Prompt (Admin)`
4. Modify the following command by replacing `<REPLACE THIS WITH YOUR youtube-dl DIRECTORY>` with the folder path where you are storing `youtube-dl.exe` and then run the command in the cmd window by pasting the command into the cmd window and pressing enter
>Example:
If you were to store `youtube-dl.exe` in `C:\Program Files\youtube-dl` you would run the command `setx /M PATH "%PATH%;C:\Program Files\youtube-dl"`
   
```
setx /M PATH "%PATH%;<REPLACE THIS WITH YOUR youtube-dl DIRECTORY>"
```
5. Close the cmd window
6. Open a new cmd window (not administrator mode)
7. Run the command `youtube-dl --version`, you should get an output like `2021.03.14` if you set everything up correctly. 

### Get FFmpeg
1. Go to https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z to download FFmpeg.
2. Extract the downloaded zip file (You might need to install https://www.7-zip.org/ to extract the file).
3. Copy the folder inside the folder that was extracted to a permanent location. You may want to rename the long folder name to `ffmpeg`. `ffmpeg.exe` is inside the `bin` folder inside the folder you copied.
4. Repeat steps 4 and 5 from `Get youtube-dl` section but this time using the folder for where `ffmpeg.exe` is.
>Example:
If you were to store the folder at `C:\Program Files\ffmpeg` then you would run `setx /M PATH "%PATH%;C:\Program Files\ffmpeg\bin`. `ffmpeg.exe` should be located in `C:\Program Files\ffmpeg\bin`.
5. Run the command `ffmpeg -version`, you should get an output like `ffmpeg version 2.2.2` along with other text if you set everything up correctly.

### Get AtomicParsley
> This is optional, it will allow you to create `.mp4` files with thumbnails from the youtube video. Currently this guide does not make use of AtomicParsley.
1. Go to https://sourceforge.net/projects/atomicparsley/files/latest/download to download AtomicParsley.
3. Extract the the downloaded zip file
4. Inside the extracted files, copy the folder `AtomicParley-win32-x.x.x` to a permanent location. You may want to rename the folder to `AtomicParsley`.
4. Repeat steps 4 and 5 from `Get youtube-dl` section but this time using the folder for where `AtomicParsley.exe` is.
>Example: 
If you were to store the folder at `C:\Program Files\AtomicParsley` then you would run `setx /M PATH "%PATH%;C:\Program Files\AtomicParsley`. `AtomicParsley.exe` should be located in `C:\Program Files\AtomicParsley`.
6. You should now be able to run the command `AtomicParsley`.

## Using youtube-dl
>The following examples download as `.mkv` files otherwise stated. See the FAQ section below on the difference between `.mkv` and `.mp4`. It is recommended to use the `.mp4` version of the command for most streams and `.mkv` for content with video resolution higher than `1080p` or music videos.

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
In this example you will create a folder for the channel and all the playlists will be downloaded to their own folders inside the channel folder. An archive file is going to be used to prevent redownloading if `youtube-dl` stops working (such as your computer going to sleep). Due to technical constrains, any video that shows up more than once in different playlists will only be downloaded to the playlist with the first download of that video. If you do not want this behavior, then refer to instructions from `To download a playlist` section. Generally, videos are not repeated in playlists on Hololivers' channels.

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
> Make sure you have membership of the channel and are logged into YouTube or it will not work.
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

Unlisted videos can be downloaded using the instructions in `To download a single video` section. Use `[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s` as the file name to get the same file name format as the command above.

You can create scheduled tasks to periodically run your archival commands to stay up to date automatically. 

## Download a livestream as it is occurring
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
