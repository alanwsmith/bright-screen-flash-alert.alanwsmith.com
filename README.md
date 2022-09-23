# Screen Flash Alert

A mac tool for streamers to trigger
a sound when screen brightness
crosses a threshold. (Can probalby
get it to work for Windows and \*nix
with a little work too)

---

You'll need ffmpeg, imagemagik,
and fswatch. (I think you can get all
of them from homebrew)

---

### Instructions

- Run this to get a list of devices ffmpeg
  can watch:

  ffmpeg -f avfoundation -list_devices true -i ""

- Edit `src/watch-screen.bash` to set the first
  number in the `avfoundation -i "#:#"` to the
  sceen you want

- cd two separate terminal windows into `src`

- run: `./yell-when-it-gets-bright.bash`

- then run: `./watch-screen.bash`

- you can adjust the level at which the yell
  happens by adjusting the number in
  `if [ $LIGHT_LEVEL_INT -gt 40 ]`

- you can use a different sound by changing
  `afplay ahhhh.mp3` to point to another file

- the `watch-screen.bash` creates .png file in the
  `images` directory. The `yell-when-it-gets-bright.bash`
  file processes them then deletes them.

- If you leave the `watch-screen.bash` file running
  after closing `yell-when-it-gets-bright.bash`
  it'll make files that don't get deleted. You can
  kill them with `rm images/*.png`

- I wrote this pretty quick. Let me know if you
  hit bugs
