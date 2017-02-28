--[[
    Sound-Queue-System
 ]]

sqs = {} -- DONT REMOVE!

-- Debug Log Level (0 = off, 1 = basic, 2 = extended)
sqs.debuglevel = 0
-- Interval in seconds for the check of the queue table
sqs.loopInterval = 2

----------------------------------------------------------------------
----------------------------------------------------------------------
--        CHANGES BELOW THIS LINE AT OWN RISK
----------------------------------------------------------------------
----------------------------------------------------------------------
sqs.SoundCoalitionTable = {}

-- Functions to call in the mission editor
function sqs.AddSoundToAll(_soundfile, _duration)
  trigger.action.outText("SQS: Sound to All not implementet...yet.", 10)
end

function sqs.AddSoundToCoalition(_coalition, _soundfile, _duration)
  local soundCoalition = {side = _coalition, soundFile = _soundfile, endTime = _duration, playing = false}
  table.insert(sqs.SoundCoalitionTable, soundCoalition)
  
  if sqs.debuglevel > 0 then
    trigger.action.outText("SQS Debug: Sound inserted", 10)
  end
end

function sqs.AddSoundToCountry(_country, _soundfile, _duration)
  trigger.action.outText("SQS: Sound to Country not implementet...yet.", 10)
end

function sqs.AddSoundToGroup(_groupid, _soundfile, _duration)
  trigger.action.outText("SQS: Sound to Group not implementet...yet.", 10)
end


-- Helper Functions
function sqs.SoundEndTime(_duration)
  local endTime = timer.getTime() + _duration
  if sqs.debuglevel > 1 then
    trigger.action.outText("SQS Debug: Sound playing until " .. endTime, 10)
  end
  return endTime
end

-- Main Loop
function sqs.PlaySoundTable()
  if table.getn(sqs.SoundCoalitionTable) > 0 then
    if sqs.debuglevel > 0 then
      trigger.action.outText("SQS Debug: Sound in table", 10)
    end
    local sound = sqs.SoundCoalitionTable[1]
    if sqs.debuglevel > 1 then
      trigger.action.outText("SQS Debug: Sound: " .. sound.soundFile, 10)
    end
    -- Check if first sound in queue is played completely
    if sound.playing == false then
      
      if sqs.debuglevel > 1 then
        trigger.action.outText("SQS Debug: No sound playing", 10)
      end
      trigger.action.outSoundForCoalition(sound.side, sound.soundFile)
      -- Set sound to "playing" and calculate Timestamp when sound is completely played
      sound.playing = true
      sound.endTime = sqs.SoundEndTime(sound.endTime)
      if sqs.debuglevel > 0 then
        trigger.action.outText("SQS Debug: Sound started playing", 10)
      end
      -- Changes back to the table entry
      sqs.SoundCoalitionTable[1] = sound
    else
      if sound.endTime < timer.getTime() then
        table.remove(sqs.SoundCoalitionTable, 1)
        if sqs.debuglevel > 0 then
          trigger.action.outText("SQS Debug: Sound removed", 10)
        end
      end
    end
  else
    if sqs.debuglevel > 1 then
      trigger.action.outText("SQS Debug: No sound in table", 10)
    end
  end
  timer.scheduleFunction(sqs.PlaySoundTable, nil, timer.getTime() + sqs.loopInterval)
end

timer.scheduleFunction(sqs.PlaySoundTable, nil, timer.getTime() + sqs.loopInterval)