<#
Download videos

Read https://github.com/Lytexx/hollow_memories#using-youtube-dl
to learn how to use the script
#>

$url = Read-Host -Prompt "Enter a YouTube video URL"
$confirmation = Read-Host "Do you want to throttle the download speed? (y/n)"
if ($confirmation -eq 'y') {
$speed = Read-Host -Prompt 'Enter the download speed limit'
$rate = "-r$speed"
}
else {
$rate = ""
}
$confirmation = Read-Host "Do you want to save the description of the video as a file? (y/n)"
if ($confirmation -eq 'y') {
$desc = "--write-description"
}
else {
$desc = ""
}
$confirmation = Read-Host "Do you want to save the thumbnail of the video as a file? (y/n)"
if ($confirmation -eq 'y') {
$thumbnail = "--write-thumbnail"
}
else {
$thumbnail = ""
}
$confirmation = Read-Host "Are you saving a members-only video? (y/n)"
if ($confirmation -eq 'y') {
    Read-Host -Prompt "Save your cookies file as youtube.com_cookies.txt and in the same directory as this script before pressing [ENTER]"
    $cookies = "--cookies youtube.com_cookies.txt"
}
else {
    $cookies = ""
}
$threads = Read-Host -Prompt 'Number of threads to use'

youtube-dl $url -i --merge-output-format mp4 --add-metadata $rate $thumbnail $desc $cookies --embed-thumbnail --embed-subs -o "[%(uploader)s][%(upload_date)s] %(title)s (%(id)s).%(ext)s"
