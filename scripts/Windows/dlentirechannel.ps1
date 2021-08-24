<#
Download an entire channel

Read https://github.com/Lytexx/hollow_memories#using-yt-dlp
to learn how to use the script
#>

$url = Read-Host -Prompt "Enter the shortened channel ID"
$threads = Read-Host -Prompt "Enter the number of threads to use (Default: 1)(Max: 5)"
$confirmation = Read-Host "Do you want to throttle the download speed? (y/n)"
if ($confirmation -eq 'y') {
$speed = Read-Host -Prompt 'Enter the download speed limit'
$rate = "-r$speed"
}
else {
$rate = ""
}
$confirmation = Read-Host "Are you saving a members-only videos and streams? (y/n)"
if ($confirmation -eq 'y') {
    Read-Host -Prompt "Save your cookies file as youtube.com_cookies.txt and in the same directory as this script before pressing [ENTER]"
    yt-dlp "https://www.youtube.com/channel/UC$url" --merge-output-format mp4 --match-filter "!is_live" --embed-metadata --embed-thumbnail --embed-subs $rate --cookies "youtube.com_cookies.txt" -N $threads --download-archive "%(uploader)s/archive.log" -o "%(uploader)s/[%(upload_date)s] %(title)s (%(id)s).%(ext)s"
    yt-dlp "https://www.youtube.com/playlist?list=UUMO$URL" --merge-output-format mp4 --match-filter "!is_live" --embed-metadata --embed-thumbnail --embed-subs $rate --cookies "youtube.com_cookies.txt" -N $threads --download-archive "%(uploader)s/archive.log" -o "%(uploader)s/Membership/[%(upload_date)s] %(title)s (%(id)s).%(ext)s"
}
else {
    yt-dlp "https://www.youtube.com/channel/UC$url" --merge-output-format mp4 --match-filter "!is_live" --embed-metadata --embed-thumbnail --embed-subs $rate -N $threads --download-archive "archive.log" -o "%(uploader)s/[%(upload_date)s] %(title)s (%(id)s).%(ext)s"
}

pause
