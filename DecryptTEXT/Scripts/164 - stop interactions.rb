class Game_Event < Game_Character
  alias mdqp_block_start start
  def start
    return if $game_switches[3775] == true && !@event.name.include?('&&&') && $game_switches[1405] == false
    return if $game_switches[4182] == true && !@event.name.include?('$RIN$')
    mdqp_block_start
  end
end