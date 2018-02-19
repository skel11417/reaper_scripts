function Main()
  reaper.Undo_BeginBlock()
  fxname = "Fabfilter Pro-Q 2"
  track =  reaper.GetSelectedTrack(0, 0)
  reaper.TrackFX_AddByName( track, fxname, 0, -1 ) --add volume plugin
  if reaper.GetMediaTrackInfo_Value(track, "I_FXEN") <= 0 then
      reaper.SetMediaTrackInfo_Value( track, "I_FXEN", 1 )
  end
  count = reaper.TrackFX_GetCount( track ) - 1
  
  reaper.TrackFX_SetOpen( track, count, 1 )
end
Main()
