--[[
    Sound-Queue-System
 ]]

sqs = {} -- DONT REMOVE!

sqs.debuglevel = 2

sqs.SoundCoalitionTable = {}

function sqs.AddSoundToAll(_soundfile, _duration)

end

function sqs.AddSoundToGroup(_groupid, _soundfile, _duration)
  
end

function sqs.AddSoundToCoalition(_coalition, _soundfile, _duration)
  local soundCoalition = {side = _coalition, soundFile = _soundfile, endTime = _duration, playing = false}
  table.insert(sqs.SoundCoalitionTable, soundCoalition)
  
  if sqs.debuglevel > 0 then
    trigger.action.outText("SQS Debug: Sound inserted", 10)
  end
end

function sqs.SoundEndTime(_duration)
  local endTime = timer.getTime() + _duration
  if sqs.debuglevel > 1 then
    trigger.action.outText("SQS Debug: Sound playing until " .. endTime, 10)
  end
  return endTime
end

function sqs.PlaySoundTable()
  if table.getn(sqs.SoundCoalitionTable) > 0 then
    if sqs.debuglevel > 0 then
      trigger.action.outText("SQS Debug: Sound in table", 10)
    end
    -- Check if first sound in queue is played completely
    local sound = sqs.SoundCoalitionTable[1]
    if sqs.debuglevel > 1 then
      trigger.action.outText("SQS Debug: Sound: " .. sound.soundFile, 10)
    end
    if sound.playing == false then
      if sqs.debuglevel > 1 then
        trigger.action.outText("SQS Debug: No sound playing", 10)
      end
      trigger.action.outSoundForCoalition(sound.side, sound.soundFile)
      sound.playing = true
      sound.endTime = sqs.SoundEndTime(sound.endTime)
      if sqs.debuglevel > 0 then
        trigger.action.outText("SQS Debug: Sound started playing", 10)
      end
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
  timer.scheduleFunction(sqs.PlaySoundTable, nil, timer.getTime()+2)
end

timer.scheduleFunction(sqs.PlaySoundTable, nil, timer.getTime()+2)
