#==============================================================================
# ** Game Message Reposition
# Author: Soulpour777
#------------------------------------------------------------------------------
# Description: This is a script exclusively made in RMVXAN for Nestat. This
# script allows to change the update placement of the game message.
#------------------------------------------------------------------------------
# Instructions / Script Call:
# $game_system.message_position_x(value)
# where value is the x position value you want to give.
# $game_system.message_position_y(value)
# where value is the y position value you want to give.
#------------------------------------------------------------------------------
# Author's Notes:
# Remember that the update placement checks the values of the message_x and
# message_y. So in case you do not want to use this update_placement, use
# this script call:
# change_message(tf)
# tf should only be true or false. True means you'll use my script's config,
# while false will use the default position. By default, it is false.
#==============================================================================

module Soul
  module Ex
    USE_POSITION = false
  end
end


class Game_System
  
  alias window_message_placement_soul initialize
  
  attr_accessor :message_x
  attr_accessor :message_y
  attr_accessor :use_soul_position
  
  def message_position_x(value)
    @message_x = value
  end
  
  def message_position_y(value)
    @message_y = value
  end
  
  #--------------------------------------------------------------------------
  # * Object Initialization (Initial Value)
  #--------------------------------------------------------------------------
  def initialize
    window_message_placement_soul
    @use_soul_position = Soul::Ex::USE_POSITION
    @message_x = 0 # starts on the left side of the screen
    @message_y = 468 # value position for bottom position
  end  

end

class Game_Interpreter
  def change_message(tf)
    $game_system.use_soul_position = tf
  end
end


class Window_Message < Window_Base
  #--------------------------------------------------------------------------
  # * Update Window Position
  #--------------------------------------------------------------------------
  def update_placement
    if $game_system.use_soul_position
      self.x = $game_system.message_x
      self.y = $game_system.message_y
      @gold_window.y = y > 0 ? 0 : Graphics.height - @gold_window.height
    else
      @position = $game_message.position
      self.y = @position * (Graphics.height - height) / 2
      @gold_window.y = y > 0 ? 0 : Graphics.height - @gold_window.height
    end
  end
end