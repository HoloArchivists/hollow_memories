# Archiving Livestreams
This guide covers on how to record ongoing livestreams. This is useful for streams that will not be archived later on.

## Table of Contents
- nope

## Prerequisites
### Installing ytarchive on Windows
1. Download ytarchive from https://github.com/Kethsar/ytarchive/releases/latest
2. Move `ytarchive.exe` to a permanent location (eg. C:\Program Files\ytarchive)
3. Open Command Prompt in elevated mode
> Open the start menu by pressing the ⊞ windows key, type cmd, right click `Command Prompt` and clicking `Run as administrator`.
4. Modify the following command by replacing `C:\Path\To\ytarchive` with the folder path where you are storing `ytarchive.exe` and run the command in Command Prompt by pasting the command in(CTRL+V) and pressing enter.
```
setx /M PATH "%PATH%;C:\Path\To\ytarchive"
```
>Example: If you were to store `ytarchive.exe` in `C:\Program Files\ytarchive` you would run the command `setx /M PATH "%PATH%;C:\Program Files\youtube-dl"`
5. Verify that it has installed correctly by opening a new Command Prompt without elevated mode, typing `ytarchive -h` and pressing enter.

### Installing FFMpeg on Windows
1. Download FFMpeg from https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z .
2. Extract the downloaded zip file (You might need to install https://www.7-zip.org/ to extract the file).
3. Rename the extracted folder to `ffmpeg` for simplicity then copy the `ffmpeg` folder to a permanent location. (eg. C:\Program Files\ffmpeg)
4. Open Command Prompt in elevated mode
> Open the start menu by pressing the ⊞ windows key, type cmd, right click `Command Prompt` and clicking `Run as administrator`.
5. Modify the following command by replacing `C:\Path\To\ffmpeg` with the folder path where you are storing `ffmpeg` and run the command in Command Prompt by pasting the command in(CTRL+V) and pressing enter. Do not remove `\bin` from the end of the command.
```
setx /M PATH "%PATH%;C:\Path\To\ffmpeg\bin"
```
>Example: If you were to store `ffmpeg` in `C:\Program Files\ffmpeg` you would run the command `setx /M PATH "%PATH%;C:\Program Files\ffmpeg\bin"`
6. Verify that it has installed correctly by opening a new Command Prompt without elevated mode, typing `ffmpeg -h` and pressing enter.

## Using ytarchive
### Saving a normal stream
1. Open Command Prompt.
2. Change the directory of Command Prompt by modifying the following command, replacing `C:\Path\To\stream` with the folder path you want to save the stream to.
```
cd "C:\Path\To\stream"
```
>Example: If you were to save the stream in `C:\Users\anon\Videos` you would run the command `cd "C:\Users\anon\Videos"`
3. Type `ytarchive --add-metadata` into Command Prompt and pressing enter.
>To prevent having to type these 2 commands in every time you want to save a stream, download this [file](scripts\ytarchive.ps1) and copy it to the directory you wish to save your stream to, then open the file.
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
cd "C:\Path\To\stream"
```
>Example: If you were to save the stream in `C:\Users\anon\Videos` you would run the command `cd "C:\Users\anon\Videos"`
5. Modify the following command by replacing `C:\Path\To\youtube-cookies.txt` with the folder path where you are storing the cookie file.
```
ytarchive --add-metadata -c C:\Path\To\cookies.txt
```
>Example: If you were to store `cookie` in `C:\Users\anon\Desktop\youtube-cookies.txt` you would run the command `ytarchive --add-metadata -c C:\Users\anon\Desktop\youtube-cookies.txt`

>To prevent having to type these 2 commands in every time you want to save a stream, download this [file](scripts\ytarchive.ps1) and copy it to the directory you wish to save your stream to, then open the file.

If you wish to learn the CLI commands yourself, use the `ytarchive -h` command or refer to this [README](https://github.com/Kethsar/ytarchive/blob/master/README.md).

