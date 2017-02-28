# DCS-SQS
## What is this?

At the moment the only option to send voiceovers so that CA players can hear them is "Sound to [All/Coalition]". This is because the 
CA player has no access to radio equipment, even worse if he is not steering a vehicle, then even "Sound to Country" does not work.

This is not a big problem, unless you have a very dynamic mission, with voiceovers based on actions the players do rather than
voiceovers that play after a specific timetable.
But in a dynamic mission, situations can occur, when two voiceovers have to be played directly each after another. DCS doesn't buffer
those sounds, so the second sound will be played even if the first was not completed, which makes the first one stop. This is especially
annoying, when you want to give mission critical information via voiceover

## SQS - Sound Queue System
With this script you can send sounds into a queue instead of sending them directly. If a voiceover is added to the queue while another
voiceover is still playing, it gets queued up until the first voiceover has ended. Then the next voiceover in the queue is played.

## How to use
On mission start load the "sqs.lua" script via "Do Sript File" trigger. You can do this at mission start or after a few seconds.
To add a voiceover instead of using the "Sound to.." trigger, use the "sqs.AddSoundToCoalition" function.

```lua
sqs.AddSoundToCoalition(Coalition, SoundFile, Duration)
```

The coalition has to be a value of 0 (Neutral), 1 (Red), 2 (Blue). Soundfile has to be the filename of a soundfile added to the .miz
file.
You can do this via your preferred zip tool or by adding a trigger "Sound to ..." which is never actually triggered. Duration is the
length of the sound file in seconds. For example:

```lua
sqs.AddSoundToCoalition(2, "MissionBriefing.ogg", 36)
```
That's all!

Be advised: At the moment only "Sound to Coalition" is supported. I will try to add other ways to send sounds, but that will be more
complicated. And because I need the "Sound to Coalition" for my current work in progress mission, I implemented that first ;)

## Prerequesites
None. Not even MIST
SQS is a mission based script. You can implement it into your mission. Clients do not have to install any mods or scripts.

## Incompatibilities
None that I know about. Maybe if a script uses the namespace "sqs".

## Performance impact
None that I know about. If you encounter performance issues maybe you can increase the loop interval. Have too little lua experience to
give some reliable info about this.

## Example
Feel free to load the attached sqs_test.miz to see the triggers that need to be set.
