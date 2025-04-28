#==============================================================================
# ** Game_Variables
#------------------------------------------------------------------------------
#  This class handles variables. It's a wrapper for the built-in class "Array."
# The instance of this class is referenced by $game_variables.
#==============================================================================

class Game_Variables
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    @data = []
  end
  #--------------------------------------------------------------------------
  # * Get Variable
  #--------------------------------------------------------------------------
  def [](variable_id)
    @data[variable_id] || 0
  end
  #--------------------------------------------------------------------------
  # * Set Variable
  #--------------------------------------------------------------------------
  def []=(variable_id, value) 
    @data[variable_id] = value
    ###
    if variable_id == 376
################
    if $game_variables[76] == 0
     $game_variables[76] = Array.new(100,0)
    elsif $game_variables[76].length < 100
     $game_variables[76] = Array.new(100,0)
    end
################
    @tI = $game_variables[75]
    @tF = $game_variables[376]
    if @tF >= 24
    @tF -= 24
    end
    @tCh = 0
    while @tI != @tF
    @tI += 1
    if @tI >= 24
    @tI -= 24
    end
    @tCh += 1
    end
################
    $game_variables[75] = $game_variables[376]
    if $game_variables[75] >= 24
     $game_variables[75] -= 24
    end
################
    @noSleepCl = [6,8,12,28,49,72,82,83,84,85,86,87,88,89,90,91,92,93,94,95,120,121,122,129,130,131,132,133,134,135,136,163,183,191]
    @ac = 0
    while @ac < $game_variables[76].length
    if $game_party.members.include?($game_actors[@ac])
    $game_variables[76][@ac] += @tCh
    else
    $game_variables[76][@ac] = 0
    end  
    if $game_actors[@ac]
    if $game_actors[@ac].state?(241) == true          
     $game_variables[76][@ac] = 0 
    elsif @noSleepCl.include?$game_actors[@ac].class_id
     $game_variables[76][@ac] = 0
    elsif $game_actors[@ac].id == 1 && $game_switches[804] == true #undK
     $game_variables[76][@ac] = 0
    end
    if $game_variables[76][@ac] >= 72
     if $game_actors[@ac].id == 1 && $game_switches[2768] == true #dreamK
      $game_actors[@ac].add_state(242)
      $game_actors[@ac].remove_state(223)
      else #no dreamK
      $game_actors[@ac].add_state(223)     
      $game_actors[@ac].remove_state(242)
     end
     $game_actors[@ac].remove_state(222)
    elsif $game_variables[76][@ac] >= 24
     $game_actors[@ac].add_state(222)
     $game_actors[@ac].remove_state(223)
     $game_actors[@ac].remove_state(242)
    else
     $game_actors[@ac].remove_state(222)
     $game_actors[@ac].remove_state(223)
     $game_actors[@ac].remove_state(242)
    end
    end
    @ac += 1
    end         
    end  
    ###
    unless $game_switches[3910] == true #achi lock
    #Fiber.yield while $game_switches[475] || $game_switches[742] || $game_switches[375] || $game_switches[3826]
    @affV = [6,9,15,59,110,186,381,638,1365,1556,1886,3554,3761,3929,4169,4249,4329,4429,4498]
    @affPV = [49,127,126,128,129,232,474,639,1366,1557,1887,3555,3762,3930,4170,4250,4330,4430,4499]  
    if @affV.include?variable_id && $game_variables[3903][13] == 0
      $game_temp.reserve_common_event(980)
    elsif @affPV.include?variable_id && $game_variables[3903][14] == 0
      $game_temp.reserve_common_event(980)
    elsif variable_id == 112 || variable_id == 920 || variable_id == 987 || variable_id == 3752 || variable_id == 3912 || variable_id == 3913 || variable_id == 6530 || variable_id == 7785 || variable_id == 7252
      $game_temp.reserve_common_event(980)
    elsif variable_id == 3899 && $game_variables[3899] >= 500000 && $game_variables[3905][13] == 0
      $game_temp.reserve_common_event(980)
    elsif variable_id == 584 && $game_variables[584] >= 50000 && $game_variables[3904][7] == 0
      $game_temp.reserve_common_event(980)
    elsif variable_id == 584 && $game_variables[584] >= 20000 && $game_variables[3903][7] == 0
      $game_temp.reserve_common_event(980)
    elsif variable_id == 3440 && $game_variables[3440] >= 500 && $game_variables[3905][2] == 0
      $game_temp.reserve_common_event(980)
    elsif variable_id == 3440 && $game_variables[3440] >= 50 && $game_variables[3903][9] == 0
      $game_temp.reserve_common_event(980)
    elsif variable_id == 4188 && $game_variables[4188] >= 30 && $game_variables[3904][31] == 0
      $game_temp.reserve_common_event(980)   
    elsif variable_id == 7329
      $game_temp.reserve_common_event(981)
    end  
   end
    on_change      
  end
  #--------------------------------------------------------------------------
  # * Processing When Setting Variables
  #--------------------------------------------------------------------------
  def on_change
    $game_map.need_refresh = true
  end
end