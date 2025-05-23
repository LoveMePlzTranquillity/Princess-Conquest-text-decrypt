#==============================================================================
# ** Scene_Gameover
#------------------------------------------------------------------------------
#  This class performs game over screen processing.
#==============================================================================

class Scene_Gameover < Scene_Base
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    play_gameover_music
    fadeout_frozen_graphics
    create_background
  end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    dispose_background
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    goto_title if Input.trigger?(:C) || WolfPad.trigger?(:X,0) || WolfPad.trigger?(:X,1)
  end
  #--------------------------------------------------------------------------
  # * Execute Transition
  #--------------------------------------------------------------------------
  def perform_transition
    Graphics.transition(fadein_speed)
  end
  #--------------------------------------------------------------------------
  # * Play Music on Game Over Screen
  #--------------------------------------------------------------------------
  def play_gameover_music
    RPG::BGM.stop
    RPG::BGS.stop
    $data_system.gameover_me.play
  end
  #--------------------------------------------------------------------------
  # * Fade Out Frozen Graphics
  #--------------------------------------------------------------------------
  def fadeout_frozen_graphics
    Graphics.transition(fadeout_speed)
    Graphics.freeze
  end
  #--------------------------------------------------------------------------
  # * Create Background
  #--------------------------------------------------------------------------
  def create_background
    @sprite = Sprite.new
  if $game_switches[5150] == true
    @sprite.bitmap = Cache.system("GameOver-Defeat")  
  elsif $game_switches[5151] == true
    @sprite.bitmap = Cache.system("GameOver-Succubus")
  elsif $game_switches[5152] == true || $game_map.map_id == 145
    @sprite.bitmap = Cache.system("GameOver-Dog")
  elsif $game_switches[5153] == true
    @sprite.bitmap = Cache.system("GameOver-Silenus")    
  elsif $game_switches[5154] == true
    @sprite.bitmap = Cache.system("GameOver-Wendigo")    
  elsif $game_switches[5155] == true
    @sprite.bitmap = Cache.system("GameOver-Drown")    
  elsif $game_switches[5156] == true
    @sprite.bitmap = Cache.system("GameOver-Oni")   
  elsif $game_switches[5157] == true
    @sprite.bitmap = Cache.system("GameOver-Flow")       
  elsif $game_map.map_id == 524
    @sprite.bitmap = Cache.system("GameOver-Moth")   
  else
    @sprite.bitmap = Cache.system("GameOver-Battle")
      end
  end
  #--------------------------------------------------------------------------
  # * Free Background
  #--------------------------------------------------------------------------
  def dispose_background
    @sprite.bitmap.dispose
    @sprite.dispose
  end
  #--------------------------------------------------------------------------
  # * Get Fade Out Speed
  #--------------------------------------------------------------------------
  def fadeout_speed
    return 60
  end
  #--------------------------------------------------------------------------
  # * Get Fade In Speed
  #--------------------------------------------------------------------------
  def fadein_speed
    return 120
  end
  #--------------------------------------------------------------------------
  # * Transition to Title Screen
  #--------------------------------------------------------------------------
  def goto_title
    fadeout_all
    SceneManager.goto(Scene_Title)
  end
end
