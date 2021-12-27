# Bookmarklets

Bookmarklets are Browser bookmarks containing code instead of a link. With those you can execute javascript on the website you have opened.
</br>Just Create a new Bookmark in your browser, choose a title and add the following code in the Link field.

We use the following Bookmarklets to make our life a little easier:

### Get a Playlist with all uploads of a channel

(Use on channel pages, example: <https://www.youtube.com/channel/UCK9V2B22uJYu3N7eR_BT9QA> )</br>

```javascript
javascript:(async()=>{window.location=window.location.toString().replace(/^https:\/\/www\.youtube\.com\/channel\/UC/,'https://www.youtube.com/playlist?list=UU')})();
```

### Get a Playlist with all member-only videos of a channel

(Use on channel pages, example: <https://www.youtube.com/channel/UCK9V2B22uJYu3N7eR_BT9QA> )</br>

```javascript
javascript:(async()=>{window.location=window.location.toString().replace(/^https:\/\/www\.youtube\.com\/channel\/UC/,'https://www.youtube.com/playlist?list=UUMO')})();
```

### Get the link tot the Master M3U8 from a livestream

(Use on livestream pages, example: <https://www.youtube.com/watch?v=[VIDEO_ID>] )</br>

```javascript
javascript:(async()=>{try{const t=await fetch(location.href),a=await t.text(),r=/"hlsManifestUrl":"([^"]+)/,e=a.match(r)[1];navigator.clipboard.writeText(e),alert("Copied!")}catch(t){console.error(t),alert("Error!")}})();
```
