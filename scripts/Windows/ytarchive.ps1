<#
Download livestreams

Read https://github.com/Lytexx/hollow_memories/blob/master/archiving_livestreams.md
to learn how to use the script
#>

$url = Read-Host -Prompt "Enter a YouTube livestream URL"
$threads = Read-Host -Prompt "Enter the number of fragment threads to use (Default: 1)(Max: 5)"
$quality = Read-Host -Prompt "Enter desired video quality (Default: best)"
$confirmation = Read-Host "Are you saving a members-only stream? (y/n)"
if ($confirmation -eq 'y') {
    Read-Host -Prompt "Save your cookies file as youtube.com_cookies.txt and in the same directory as this script before pressing [ENTER]"
    $cookies = "-cookies youtube.com_cookies.txt"
}
else {
    $cookies = ""
}

ytarchive.exe "$url" $quality --embed-metadata --threads $threads -t -r 15 $cookies -o ".\[%(channel)s][%(upload_date)s] %(title)s (%(id)s)"

pause
