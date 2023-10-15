#  mike
In macOS, whenever you connect to a bluetooth audio device with a microphone input, Tim Cook decides to switch your default microphone input to that device.
There's currently no way of setting a "real" default input audio device; you have to manually change your audio input. Every. Single. Time.

Why is this annoying? Because having your microphone input device be your bluetooth headphones/speakers usually screws up the output audio, especially
in web conference applications (Zoom, Teams, Meet, etc.). Or sometimes a website/app enables the microphone and sound quality gets crappy all of a sudden.

mike fixes that by making sure your default microphone is that of the MacBook at all times, thought you can also change which microphone you'd like 
to default to. But at the meantime, **plz fix Apple.**

Big thanks to the [SimplyCoreAudio](https://github.com/rnine/SimplyCoreAudio) library, this small tool would've been impossible to make
(given my very limited knowledge of Swift and the macOS SDK) without it.

## Known Bugs & Missing Features
- Default microphone selector does not actually change the observer unless you toggle mike at least once
- Microphone preference does not save on quit
- Better UI than just a MenuBar menu
- An original icon
- (Maybe) Expand support for overriding default _output_ device

