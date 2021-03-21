<#
Download an entire channel + membership videos

Shortened channel ID is ID without the UC for example
https://www.youtube.com/channel/UCyKsg-57XC9pyHbP7v3kCPQ
becomes yKsg-57XC9pyHbP7v3kCPQ

Put your youtube.com_cookies.txt in the same folder as the script to download all the membership videos
#>
$URL = Read-Host -Prompt 'Paste the shortened channel ID'
$threads = Read-Host -Prompt 'Number of threads to use'

youtube-dl -o "%(uploader)s/[%(upload_date)s] %(title)s (%(id)s).%(ext)s" "https://www.youtube.com/channel/UC$URL" --download-archive "archive.log"  --merge-output-format mp4 --match-filter "!is_live" --add-metadata --embed-thumbnail --ignore-errors --cookies "youtube.com_cookies.txt"
youtube-dl -o "%(uploader)s/Membership/[%(upload_date)s] %(title)s (%(id)s).%(ext)s" "https://www.youtube.com/playlist?list=UUMO$URL" --download-archive "archive.log"  --merge-output-format mp4 --match-filter "!is_live" --add-metadata --embed-thumbnail --ignore-errors --cookies "youtube.com_cookies.txt"

pause