#==============================================================================
# ** Game_Switches
#------------------------------------------------------------------------------
#  This class handles switches. It's a wrapper for the built-in class "Array."
# The instance of this class is referenced by $game_switches.
#==============================================================================

class Game_Switches
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    @data = []
  end
  #--------------------------------------------------------------------------
  # * Get Switch
  #--------------------------------------------------------------------------
  def [](switch_id)
    @data[switch_id] || false
  end
  #--------------------------------------------------------------------------
  # * Set Switch
  #     value : ON (true) / OFF (false)
  #--------------------------------------------------------------------------
  def []=(switch_id, value)
    @data[switch_id] = value
    if $game_switches[781] == true && switch_id == 648
      return
    end    
    if switch_id == 3438
     #if $game_variables[114].include?"BioCamo"
       if $game_variables[116] == "BioCamo"
        if $game_switches[3438] == true #UW
          $game_switches[3600] = true
        else
          $game_switches[3600] = false
        end  
        end  
       @n = 0
       @oowStr = [34,143,144,145,146,147,148,189,210] #Out of Water status
       while @n < $game_party.members.size    
         if $game_party.members[@n].class_id == 212
           if $game_switches[3438] == true #UW
             $game_party.members[@n].add_state(249)
           else
             $game_party.members[@n].remove_state(249)             
           end  
         end           
         if @oowStr.include?$game_party.members[@n].class_id
           if $game_switches[3438] == true #UW
             $game_party.members[@n].remove_state(245)             
           else
             $game_party.members[@n].add_state(245)
           end  
         end  
       @n += 1
      end  
    #end  
    end
    unless $game_switches[3910] == true #achi lock
    #Fiber.yield while $game_switches[475] || $game_switches[742] || $game_switches[375] || $game_switches[3826]
    @swStr = [2581,3878,1119,1182,1183,3465,2093,4148,839,840,3438]
    if @swStr.include?switch_id
      $game_temp.reserve_common_event(980)
    end  
    if switch_id >= 10001 && switch_id <= 10500 #endings
      $game_temp.reserve_common_event(980)
    end      
    end
    on_change
  end
  #--------------------------------------------------------------------------
  # * Processing When Setting Switches
  #--------------------------------------------------------------------------
  def on_change
    $game_map.need_refresh = true
  end
end
