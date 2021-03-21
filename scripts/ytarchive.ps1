$confirmation = Read-Host "Are you saving a members-only stream? (y/n)"
if ($confirmation -eq 'y') {
    Read-Host -Prompt "Save your cookies file as youtube.com_cookies.txt and in the same directory as this script before pressing [ENTER]"
    ytarchive.exe --add-metadata -c youtube.com_cookies.txt
}
else {
    ytarchive.exe --add-metadata
}
