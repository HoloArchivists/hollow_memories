<#
Download playlists

Read https://github.com/Lytexx/hollow_memories#using-youtube-dl
to learn how to use the script
#>

$url = Read-Host -Prompt "Enter a YouTube playlist URL"
$threads = Read-Host -Prompt "Enter the number of threads to use (Default: 1)(Max: 5)"
$confirmation = Read-Host "Do you want to throttle the download speed? (y/n)"
if ($confirmation -eq 'y') {
$speed = Read-Host -Prompt 'Enter the download speed limit'
$rate = "-r$speed"
}
else {
$rate = ""
}
$confirmation = Read-Host "Do you want to save members only videos? (y/n)"
if ($confirmation -eq 'y') {
    Read-Host -Prompt "Save your cookies file as youtube.com_cookies.txt and in the same directory as this script before pressing [ENTER]"
    $cookies = "--cookies youtube.com_cookies.txt"
}
else {
    $cookies = ""
}

youtube-dl "$url" -i --merge-output-format mp4 --add-metadata --embed-thumbnail --embed-subs $rate $cookies --download-archive ".\%(playlist)s\playlist.txt" -o ".\%(playlist)s\%(playlist_index)s - [%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"

pause
