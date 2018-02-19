function Msg(param)
  reaper.ShowConsoleMsg(tostring(param).."\n")
end

function Main()
  reaper.Undo_BeginBlock()
  fxname = "Volume"
  sel_tracks_count = reaper.CountSelectedTracks(0) --counts selected tracks
  --Loop through tracks
  for i = 0, sel_tracks_count-1  do
    -- get track
    track =  reaper.GetSelectedTrack(0, i)
    -- get track volume
    ok, track_vol, pan =  reaper.GetTrackUIVolPan( track, 0, 0 )
    
    --if the track volume value is anything other than one
    if track_vol ~= 1 then
      reaper.TrackFX_AddByName( track, fxname, 0, 1 ) --add volume plugin
      fx_count = reaper.TrackFX_GetCount( track )
      fxId = reaper.TrackFX_GetByName( track, fxname, 1 ) --get fx index
      while fxId > 0 do
        reaper.SNM_MoveOrRemoveTrackFX(track, fxId, -1 ) -- place volume first in the fx chain
        fxId = fxId-1
      end
      -- adjusts trim volume based on current track volume
      vol_dB = 20 * ( math.log( track_vol, 10 ) )
      trim_vol_dB, min_val, max_val = reaper.TrackFX_GetParam(track, 0, 0 )
      reaper.TrackFX_SetParam( track, fxId, 0, trim_vol_dB + vol_dB )
      --enable fx if bypassed
      if reaper.GetMediaTrackInfo_Value(track, "I_FXEN") <= 0 then
          reaper.SetMediaTrackInfo_Value( track, "I_FXEN", 1 )
      end
      --resets track volume
      reaper.SetMediaTrackInfo_Value(track, "D_VOL", 1 ) 
    end
      --next track
  end
end
Main()
