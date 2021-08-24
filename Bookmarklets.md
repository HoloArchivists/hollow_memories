# Bookmarklets

Bookmarklets are Browser bookmarks containing code instead of a link. With those you can execute javascript on the website you have opened.
</br>Just Create a new Bookmark in your browser, choose a title and add the following code in the Link field.

We use the following Bookmarklets to make our life a little easier:

### Get a Playlist with all uploads of a channel
(Use on channel pages, example: https://www.youtube.com/channel/UCK9V2B22uJYu3N7eR_BT9QA )</br>
`javascript:(async()=>{window.location=window.location.toString().replace(/^https:\/\/www\.youtube\.com\/channel\/UC/,'https://www.youtube.com/playlist?list=UU')})();`

### Get a Playlist with all member-only videos of a channel
(Use on channel pages, example: https://www.youtube.com/channel/UCK9V2B22uJYu3N7eR_BT9QA )</br>
`javascript:(async()=>{window.location=window.location.toString().replace(/^https:\/\/www\.youtube\.com\/channel\/UC/,'https://www.youtube.com/playlist?list=UUMO')})();`

### Get the M3U8 link from a livestream
(Use on livestream pages, example: https://www.youtube.com/watch?v=[VIDEO_ID] )</br>
`javascript:(async()=>{try{const t=await fetch(location.href),a=await t.text(),r=/"hlsManifestUrl":"([^"]+)/,e=a.match(r)[1];navigator.clipboard.writeText(e),alert("Copied!")}catch(t){console.error(t),alert("Error!")}})();`

### Get the .json of a livestream
(For ytarchive-raw, use on livestream pages, example: https://www.youtube.com/watch?v=[VIDEO_ID] )</br>
```javascript:(async()=>{function a(a){if(!a.includes("."))return a;return a.match(/^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*/)[1]}async%20function%20b(a,b){const%20d=new%20DOMParser().parseFromString(b,"text/html"),e=b.includes("<link%20rel=\"image_src\"%20href=\"")?d.querySelector("link[rel=image_src]").getAttribute("href"):`https://img.youtube.com/vi/${a}/maxresdefault.jpg`;return{title:d.querySelector("meta[name=title]").getAttribute("content"),id:a,channelName:d.querySelector(`link[itemprop="name"]`).getAttribute("content"),channelURL:"https://www.youtube.com/channel/"+d.querySelector(`meta[itemprop="channelId"]`).getAttribute("content"),description:b.includes("\"description\":{\"simpleText\":\"")?b.match(/"description":{"simpleText":"(.+?)"},/)[1].replaceAll("\\n","\n"):"",thumbnail:await%20c(e),thumbnailUrl:e,startTimestamp:b.includes("\"startTimestamp\":\"")?b.match(/"startTimestamp":"(.+?)"/)[1].replaceAll("\\n","\n"):""}}function%20c(a){var%20b=new%20XMLHttpRequest;return%20b.responseType="blob",new%20Promise(c=>{b.onload=function(){var%20a=new%20FileReader;a.onloadend=function(){c(a.result)},a.readAsDataURL(b.response)},b.open("GET",a),b.send()})}function%20d(b,c,d){var%20e=new%20Blob([b],{type:d});if(window.navigator.msSaveOrOpenBlob)window.navigator.msSaveOrOpenBlob(e,c);else{var%20f=document.createElement("a"),a=URL.createObjectURL(e);f.href=a,f.download=c,document.body.appendChild(f),f.click(),setTimeout(function(){document.body.removeChild(f),window.URL.revokeObjectURL(a)},0)}}const%20e={VIDEO:[337,315,266,138,313,336,308,271,264,335,303,299,248,169,137,334,302,298,247,136],AUDIO:[251,141,171,140,250,249,139]};(async%20function(){const%20c=a(location.href),f=await%20fetch(`https://www.youtube.com/watch?v=${c}`),g=await%20f.text(),h=g.match(/"itag":(?<itag>\d+),"url":"(?<url>[^"]+)"/g),i={};for(const%20a%20of%20h){const%20b=a.match(/"itag":(?<itag>\d+),"url":"(?<url>[^"]+)"/).groups;i[b.itag]=b.url.replaceAll("\\u0026","&")}let%20j={video:null,audio:null,metadata:await%20b(c,g),version:"1.5",createTime:new%20Date().toISOString()};for(const%20a%20of%20e.VIDEO)if(Object.keys(i).includes(a.toString())&&i[a.toString()].includes("noclen")){j.video={[a.toString()]:i[a.toString()]};break}for(const%20a%20of%20e.AUDIO)if(Object.keys(i).includes(a.toString())&&i[a.toString()].includes("noclen")){j.audio={[a.toString()]:i[a.toString()]};break}window.result=i,d(JSON.stringify(j,null,4),`${c}.urls.json`,"application/json")})()})();```
