# Screen Flash Alert

A mac tool for streamers to trigger
a sound when screen brightness
crosses a threshold. (Can probalby
get it to work for Windows and \*nix
with a little work too)

---

You'll need ffmpeg, imagemagik,
and fswatch.

---

Run this to figure out which screen
id to use:

```
ffmpeg -f avfoundation -list_devices true -i ""
```

---

References:

- https://trac.ffmpeg.org/wiki/Capture/Desktop
