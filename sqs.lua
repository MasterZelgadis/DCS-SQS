--[[
    Sound-Queue-System

 ]]

sqs = {} -- DONT REMOVE!

sqs.SoundCoalitionTable = {}

function sqs.AddSoundToAll(_soundfile, _duration)

end

function sqs.AddSoundToGroup(_groupid, _soundfile, _duration)
  
end

function sqs.AddSoundToCoalition(_coalition, _soundfile, _duration)
  local soundCoalition = {side = _coalition, soundFile = _soundfile, endTime = sqs.SoundEndTime(), playing = false}
  table.insert(sqs.SoundCoalitionTable, soundCoalition)
end

function sqs.SoundEndTime(_duration)
  return timer.getTime() + _duration
end

function sqs.PlaySoundTable()
  if table.getn(sqs.SoundCoalitionTable) > 0 then
    -- Check if first sound in queue is played completely
    local sound = sqs.SoundCoalitionTable[0]
    if sound.playing == false then
      trigger.action.outSoundForCoalition(sound.side, sound.soundFile)
      sound.playing = true
      sqs.SoundCoalitionTable[0] = sound
    else
      if sound.endTime < timer.getTime() then
        table.remove(sqs.SoundCoalitionTable, 0)
      end
    end
  end

  timer.scheduleFunction(sqs.PlaySoundTable, nil, timer.getTime()+2)
end

timer.scheduleFunction(sqs.PlaySoundTable, nil, timer.getTime()+2)
