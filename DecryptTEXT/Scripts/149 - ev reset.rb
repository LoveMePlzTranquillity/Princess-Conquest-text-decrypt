class Game_Interpreter  
  def reset_gather_points(map_id)    
    map = load_data(sprintf("Data/Map%03d.rvdata2", map_id))    
    map.events.each do |i, event|      
    key = [map_id, i, 'A'] 
    $game_self_switches[key] = false  
    key = [map_id, i, 'B'] 
    $game_self_switches[key] = false
     key = [map_id, i, 'C'] 
    $game_self_switches[key] = false
     key = [map_id, i, 'D'] 
    $game_self_switches[key] = false  
  end 
end  
end

