#Download an entire channel
#Read https://github.com/Lytexx/hollow_memories#using-yt-dlp
#to learn how to use the script

unset url
while [ -z $url ]; do
    read -p "Enter the shortened channel ID: " url
done
unset threads
while [ -z $threads ]; do
    read -p "Enter the number of threads to use (Default: 1)(Max: 5): " threads
done
unset confirmation
while [ -z $confirmation ]; do
    read -p "Do you want to throttle the download speed? (y/n): " confirmation
done
if [[ $confirmation =~ ^[Yy]$ ]]; then
    unset speed
    while [ -z $speed ]; do
        read -p "Enter the download speed limit: " speed
    done
    set rate = "-r $speed"
else
    set rate = ""
fi 

unset memberprompt
while [ -z $memberprompt ]; do
    read -p "Are you saving a members-only videos and streams? (y/n): " memberprompt
done
printf "$url \n $threads \n $confirmation \n $speed"
if [[ $memberprompt =~ ^[Yy]$ ]]; then
    read -p "Save your cookies file as youtube.com_cookies.txt and in the same directory as this script before pressing [ENTER]"
    yt-dlp "https://www.youtube.com/channel/UC$url" -i --merge-output-format mp4 --match-filter "!is_live" --embed-metadata --embed-thumbnail --embed-subs $rate --cookies "youtube.com_cookies.txt" -N $threads --download-archive "%(uploader)s/archive.log" -o "%(uploader)s/[%(upload_date)s] %(title)s (%(id)s).%(ext)s"
    yt-dlp "https://www.youtube.com/playlist?list=UUMO$URL" --merge-output-format mp4 --match-filter "!is_live" --embed-metadata --embed-thumbnail --embed-subs $rate --cookies "youtube.com_cookies.txt" -N $threads --download-archive "%(uploader)s/archive.log" -o "%(uploader)s/Membership/[%(upload_date)s] %(title)s (%(id)s).%(ext)s"
else
    yt-dlp "https://www.youtube.com/channel/UC$url" -i --merge-output-format mp4 --match-filter "!is_live" --embed-metadata --embed-thumbnail --embed-subs $rate -N $threads --download-archive "%(uploader)s/archive.log" -o "%(uploader)s/[%(upload_date)s] %(title)s (%(id)s).%(ext)s"
fi
read -p "Press any key to close ..."