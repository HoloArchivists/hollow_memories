# Archiving Livestreams
This guide covers on how to record ongoing or scheduled livestreams. This is useful for streams that will not be archived later on.

## Table of Contents
- [Prerequisites](#prerequisites)
   - [Installing Python and FFmpeg on Windows](#installing-python-and-ffmpeg-on-windows)
   - [Installing ytarchive on Windows](#installing-ytarchive-on-windows)
- [Using ytarchive](#using-ytarchive)
   - [Saving a normal stream](#saving-a-normal-stream)
   - [Saving a members only stream](#saving-a-members-only-stream)
   - [Advanced usage](#advanced-usage)
- [Troubleshooting/FAQ](#troubleshootingfaq)

## Prerequisites
### Installing Python and FFMpeg on Windows
Follow the guide shown in the [README](README.md#prerequisites)

### Installing ytarchive on Windows
1. Download ytarchive from https://github.com/Kethsar/ytarchive/releases/latest
   - If you get a virus warning on your anti-virus, it's a false-positive. [Read here](https://github.com/Kethsar/ytarchive/issues/9).
   - Click [here](#how-do-i-use-the-py-file-version-of-ytarchive-instead) if you want to use the .py version instead
2. Move `ytarchive.exe` to a permanent location (eg. C:\Program Files\ytarchive)
3. Open Command Prompt in elevated mode
> Open the start menu by pressing the ⊞ windows key, type cmd, right click `Command Prompt` and clicking `Run as administrator`.
4. Modify the following command by replacing `C:\Path\To\ytarchive` with the folder path where you are storing `ytarchive.exe` and run the command in Command Prompt by pasting the command in(CTRL+V) and pressing enter.
```
setx /M PATH "%PATH%;C:\Path\To\ytarchive"
```
>Example: If you were to store `ytarchive.exe` in `C:\Program Files\ytarchive` you would run the command `setx /M PATH "%PATH%;C:\Program Files\ytarchive"`
5. Verify that it has installed correctly by opening a new Command Prompt without elevated mode, typing `ytarchive -h` and pressing enter.

## Using ytarchive
### Saving a normal stream
* To make your life easier, you can use this [script](scripts/Windows/ytarchive.ps1) and copy it to the directory you wish to save the stream to, then open the file.
1. Open Command Prompt.
2. Change the directory of Command Prompt by modifying the following command, replacing `C:\Path\To\stream` with the folder path you want to save the stream to.
```
pushd "C:\Path\To\stream"
```
>Example: If you were to save the stream in `C:\Users\anon\Videos` you would run the command `pushd "C:\Users\anon\Videos"`
3. Type `ytarchive` into Command Prompt and pressing enter.
4. Paste the URL of the stream you wish to save. (eg. `https://www.youtube.com/watch?v=tYnk9EnrnOE`)
5. If you are saving a stream that has been scheduled but not yet started, it will ask you if you will wait until the start of the livestream. Type `poll` then `15` to check if the stream has started every 15 seconds.
6. Enter the quality option you desire from the list shown.
> Generally when archiving streams for public sharing it is advised to use the `best` quality. You may choose to use 720p or lower if you have bad internet or low diskspace.
7. Once the stream ends, `ytarchive` will automatically mux the stream into an `.mp4` video.

### Saving a members only stream
Make sure you have membership of the channel and are logged into YouTube or it will not work.
1. Install the extension `cookies.txt` [for Firefox](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) or [for Chrome](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid). This will let us extract cookies from your YouTube which will be used to authenticate `ytarchive`.
2. Click on the `cookies.txt` extension in the top right hand corner of the browser and click the `Export ↓` button to save the cookies. Move the file to a location of your choice.
> Do not share your cookie file with anyone unless you know what you're doing! They can have complete access to your YouTube channel.
2. Change the directory of Command Prompt by modifying the following command, replacing `C:\Path\To\stream` with the folder path you want to save the stream to.
```
pushd "C:\Path\To\stream"
```
>Example: If you were to save the stream in `C:\Users\anon\Videos` you would run the command `pushd "C:\Users\anon\Videos"`
5. Modify the following command by replacing `C:\Path\To\youtube.com_cookies.txt` with the folder path where you are storing the cookie file.
```
ytarchive -c youtube.com_cookies.txt
```
>Example: If you were to store `cookie` in `C:\Users\anon\Desktop\youtube.com_cookies.txt` you would run the command `ytarchive -c youtube.com_cookies.txt`

>You may find that sometimes authentication will fail. This is most likely due to old cookies which can be caused by logging out. Simply repeat step 2 to replace your current cookie file.

### Advanced usage
If you wish to learn the CLI commands yourself, use the `ytarchive -h` command or refer to this [README](https://github.com/Kethsar/ytarchive/blob/master/README.md).
* Download the stream to the current directory with the best quality
```
ytarchive https://www.youtube.com/watch?v=WGjAGh1zVQg best
```

* You can replace `best` with different quality options:

   `audio_only, 144p, 240p, 360p, 480p, 720p, 720p60, 1080p, 1080p60, best`

* The `-add-metadata` flag is used to add metadata to the video file which is a nice way to save the description without the need of an additional file

* The `-o` flag is used to download the video to a different directory or to name the download file. The available placeholders are
```
	id (string): Video identifier
	title (string): Video title
	channel_id (string): ID of the channel
	channel (string): Full name of the channel the livestream is on
	upload_date (string): Technically stream date (YYYYMMDD)
```
> You can add `~\` at the start of `-o` as a shortcut to your home directory (eg. C:\Users\anon).

> Using the filename `[%(channel)s][%(upload_date)s] %(title)s (%(id)s)` is preferred when gathering large amounts of video as it makes the video files more searchable.

* The `-r X` flag is used to re-check if the stream is up every `X` seconds. This is useful for waiting for scheduled livestreams.

* The `--threads X` flag is used to set the number of threads to use for downloading audio and video fragments. A sane number for this would be something between 2 and 8.
The total number of threads running will be `X` * 2 + 3. Main thread, a thread for each audio and video download, and `X` number of fragment downloaders for both audio and video. Due to Python limitations the ytarchive will never use more than a single CPU core. Setting this above 8 is not recommended. Default is 1.

* The `-t` flag is used to embed the original stream thumbnail in the downloaded video file.

* The `--write-thumbnail` flag is used to save the thumbnail as an image file and the `--write-description` flag to save the description as a `.description` file.

## Troubleshooting/FAQ
### When I run a command in Command Prompt, I get `'xxxx' is not recognized as an internal or external command, operable program or batch file`!
- Try reopening a new Command Prompt in administrator mode and verify if they work.
- Make sure you followed the instructions and installed everything correctly.
- Try adding `.exe` behind the command (eg. `ytarchive.exe` instead of `ytarchive`).
### When I run `ytarchive` in Command Prompt, I get an infinite loop!
- Try ytarchive.exe instead of ytarchive.
### How do I use the `.py` file version of ytarchive instead?
- The `.py` file must be in the directory you want to save the stream to
- Follow the normal instructions but instead of using the `ytarchive` command use `python ytarchive.py` instead.
- The `ytarchive.ps1` script will not work with the `.py` file version.