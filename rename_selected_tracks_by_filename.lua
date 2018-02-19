function Main()

  reaper.Undo_BeginBlock() -- Begining of the undo block.

  sel_tracks_count = reaper.CountSelectedTracks(0) --counts selected tracks
  
  -- INITIALIZE loop through selected items
  for i = 0, sel_tracks_count-1  do
    -- GET ITEMS
    track = reaper.GetSelectedTrack(0, i) -- Get selected track i

    -- gets name of current take of the first media item on the track
    track_item =  reaper.GetTrackMediaItem(track, 0)
    cur_take =  reaper.GetActiveTake( track_item )
    
    -- gets name of current  
    retval, item_file_name = reaper.GetSetMediaItemTakeInfo_String(cur_take, "P_NAME", "", false)  
    
    --strips file extension from name   
    item_name = string.sub(item_file_name, 1, -5)
    
    --removes unncessary text at beginning of file name
    a, b = string.match(item_name, "(%A*%s)(.*)")
    
    if b then
      item_name = b
    end
    
    --renames the track
    reaper.GetSetMediaTrackInfo_String(track, "P_NAME", item_name, true)
  
  end --end loop
  
end
  
Main() -- execute
