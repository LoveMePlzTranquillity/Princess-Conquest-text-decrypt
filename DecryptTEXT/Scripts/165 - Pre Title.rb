#==============================================================================
# ** dbchest's Disclaimer v1.0
#==============================================================================
# ** Credits (Freeware)
#------------------------------------------------------------------------------
#  a list of credits for those involved in the production of said script.
#  you are not required to credit special mentions; you are however, fully
#  responsible for proper accreditations of those directly involved in this
#  work's production as follows:
#------------------------------------------------------------------------------
#  programmer: dbchest (none required, always appreciated)
#  special thanks: wariolandgoldpiramid (requested this script)
#==============================================================================
# ** Details
#------------------------------------------------------------------------------
#  The purpose of this script is to provide users the opportunity to warrant
#  the players with a text based disclaimer prior to any splash / title screen.
#==============================================================================
# ** Features
#------------------------------------------------------------------------------
#  up to sixteen lines of text can be used.
#  press enter to proceed to the proceeding screen.
#  set proceeding scene: title screen is used by default.
#==============================================================================
# ** Installation Instructions (Plug and Play)
#------------------------------------------------------------------------------
#  paste script in "Materials" section of the script editor.
#  no known compatibility issues.
#  no foreign script requirements.
#==============================================================================
# ** Author's Notes
#------------------------------------------------------------------------------
#  up to 54 characters of text can be used per line.
#  i recommend only 48 characters are used per line.
#------------------------------------------------------------------------------
#  for error reporting and / or suggestions, please post in the script's
#  official thread or contact me directly via personal message at
#  rpgmakervxace.net
#==============================================================================

#==============================================================================
# ** Disclaimer
#------------------------------------------------------------------------------
#  This module defines terms and messages used in your disclaimer.  
#==============================================================================
module Disclaimer
  #--------------------------------------------------------------------------
  # * Constants (Text Lines)
  #--------------------------------------------------------------------------
  L1  = ""
  L2  = ""
  L3  = "DISCLAIMER:"
  L4  = ""
  L5  = "Do not reset the game or try to take"
  L6  = "screenshots using the F12 button"
  L7  = "" 
  L8  = "All the characters depicted"
  L9  = "in this game are age 18+" 
  L10 = "" 
  L11 = "" 
  L12 = "ENJOY THE GAME!"
  L13 = ""
  L14 = ""
  L15 = ""
  L16 = "Press any button to continue"  

  #--------------------------------------------------------------------------
  # * Constants (Settings)
  #--------------------------------------------------------------------------
  GOTO = Scene_Title                      # Next Scene
end

#==============================================================================
# ** SceneManager
#------------------------------------------------------------------------------
#  This module manages scene transitions. For example, it can handle
# hierarchical structures such as calling the item screen from the main menu
# or returning from the item screen to the main menu.
#==============================================================================
module SceneManager
  #--------------------------------------------------------------------------
  # * Get First Scene Class
  #--------------------------------------------------------------------------
  def self.first_scene_class
    $BTEST ? Scene_Battle : Scene_Disclaimer
  end
end

#==============================================================================
# ** Scene_Disclaimer
#------------------------------------------------------------------------------
#  This class performs the disclaimer screen processing.
#==============================================================================

class Scene_Disclaimer < Scene_Base
  #--------------------------------------------------------------------------
  # * Include Disclaimer Module
  #--------------------------------------------------------------------------
  include Disclaimer
  #--------------------------------------------------------------------------
  # * Start Processing
  #--------------------------------------------------------------------------
  def start
    super
    create_spriteset_a
    create_spriteset_b
    create_spriteset_c
    create_spriteset_d
  end
  #--------------------------------------------------------------------------
  # * Create Spriteset A
  #--------------------------------------------------------------------------
  def create_spriteset_a
    Font.default_name = ["RuneScape-ENA"]
    Font.default_size = 38
    @l1 = Sprite.new
    @l1.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l2 = Sprite.new
    @l2.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l3 = Sprite.new
    @l3.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l4 = Sprite.new
    @l4.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    draw_text_for_spriteset_a
  end
  #--------------------------------------------------------------------------
  # * Draw Text (Spriteset A)
  #--------------------------------------------------------------------------
  def draw_text_for_spriteset_a
    os = 24 # offset
    lh = 32 # line height
    rect = Rect.new(0, os, Graphics.width, 32)
    @l1.bitmap.draw_text(rect, L1, 1)
    rect = Rect.new(0, os + lh, Graphics.width, 32)
    @l2.bitmap.draw_text(rect, L2, 1)
    rect = Rect.new(0, os + lh * 2, Graphics.width, 32)
    @l3.bitmap.draw_text(rect, L3, 1)
    rect = Rect.new(0, os + lh * 3, Graphics.width, 32)
    @l4.bitmap.draw_text(rect, L4, 1)    
  end
  #--------------------------------------------------------------------------
  # * Create Spriteset B
  #--------------------------------------------------------------------------
  def create_spriteset_b
    @l5 = Sprite.new
    @l5.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l6 = Sprite.new
    @l6.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l7 = Sprite.new
    @l7.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l8 = Sprite.new
    @l8.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    draw_text_for_spriteset_b
  end
  #--------------------------------------------------------------------------
  # * Draw Text (Spriteset 
  #--------------------------------------------------------------------------
  def draw_text_for_spriteset_b
    os = 24
    lh = 32
    rect = Rect.new(0, os + lh * 4, Graphics.width, 32)
    @l5.bitmap.draw_text(rect, L5, 1)
    rect = Rect.new(0, os + lh * 5, Graphics.width, 32)
    @l6.bitmap.draw_text(rect, L6, 1)
    rect = Rect.new(0, os + lh * 6, Graphics.width, 32)
    @l7.bitmap.draw_text(rect, L7, 1)
    rect = Rect.new(0, os + lh * 7, Graphics.width, 32)
    @l8.bitmap.draw_text(rect, L8, 1)
  end
  #--------------------------------------------------------------------------
  # * Create Spriteset C
  #--------------------------------------------------------------------------
  def create_spriteset_c
    @l9 = Sprite.new
    @l9.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l10 = Sprite.new
    @l10.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l11 = Sprite.new
    @l11.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l12 = Sprite.new
    @l12.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    draw_text_for_spriteset_c
  end
  #--------------------------------------------------------------------------
  # * Draw Text (Spriteset C)
  #--------------------------------------------------------------------------
  def draw_text_for_spriteset_c
    os = 24
    lh = 32
    rect = Rect.new(0, os + lh * 8, Graphics.width, 32)
    @l9.bitmap.draw_text(rect, L9, 1)
    rect = Rect.new(0, os + lh * 9, Graphics.width, 32)
    @l10.bitmap.draw_text(rect, L10, 1)
    rect = Rect.new(0, os + lh * 10, Graphics.width, 32)
    @l11.bitmap.draw_text(rect, L11, 1)
    rect = Rect.new(0, os + lh * 11, Graphics.width, 32)
    @l12.bitmap.draw_text(rect, L12, 1)
  end
  #--------------------------------------------------------------------------
  # * Create Spriteset D
  #--------------------------------------------------------------------------
  def create_spriteset_d
    @l13 = Sprite.new
    @l13.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l14 = Sprite.new
    @l14.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l15 = Sprite.new
    @l15.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    @l16 = Sprite.new
    @l16.bitmap = Bitmap.new(Graphics.width, Graphics.height)
    draw_text_for_spriteset_d
  end
  #--------------------------------------------------------------------------
  # * Draw Text (Spriteset D)
  #--------------------------------------------------------------------------
  def draw_text_for_spriteset_d
    os = 26
    lh = 32
    rect = Rect.new(0, os + lh * 12, Graphics.width, 32)
    @l13.bitmap.draw_text(rect, L13, 1)
    rect = Rect.new(0, os + lh * 13, Graphics.width, 32)
    @l14.bitmap.draw_text(rect, L14, 1)
    rect = Rect.new(0, os + lh * 14, Graphics.width, 32)
    @l15.bitmap.draw_text(rect, L15, 1)
    rect = Rect.new(0, os + lh * 15, Graphics.width, 32)
    @l16.bitmap.draw_text(rect, L16, 1)
  end
  #--------------------------------------------------------------------------
  # * Update Frame (Basic)
  #--------------------------------------------------------------------------
  def update_basic
    super    
    if Input.trigger?(Input::A) || Input.trigger?(Input::B) || Input.trigger?(Input::C) || Input.trigger?(Input::Y) || Input.trigger?(Input::Z) || Input.trigger?(Input::L) || Input.trigger?(Input::R) || Input.trigger?(:C) || WolfPad.trigger?(:X,0) || WolfPad.trigger?(:X,1) || WolfPad.trigger?(:A,0) || WolfPad.trigger?(:A,1) || WolfPad.trigger?(:B,0) || WolfPad.trigger?(:B,1) || WolfPad.trigger?(:Y,0) || WolfPad.trigger?(:Y,1) || WolfPad.trigger?(:SELECT,0) || WolfPad.trigger?(:SELECT,1) || WolfPad.trigger?(:R1,0) || WolfPad.trigger?(:R1,1) || WolfPad.trigger?(:L1,0) || WolfPad.trigger?(:L1,1)
      Font.default_name = ["RuneScape-ENA"]
      Font.default_size = 22      
      # Sound.play_ok
      SceneManager.call(GOTO)
    end
  end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    dispose_spriteset_a
    dispose_spriteset_b
    dispose_spriteset_c
    dispose_spriteset_d
  end
  #--------------------------------------------------------------------------
  # * Free Spriteset A
  #--------------------------------------------------------------------------
  def dispose_spriteset_a
    @l1.bitmap.dispose
    @l1.dispose
    @l2.bitmap.dispose
    @l2.dispose
    @l3.bitmap.dispose
    @l3.dispose
    @l4.bitmap.dispose
    @l4.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Spriteset B
  #--------------------------------------------------------------------------
  def dispose_spriteset_b
    @l5.bitmap.dispose
    @l5.dispose
    @l6.bitmap.dispose
    @l6.dispose
    @l7.bitmap.dispose
    @l7.dispose
    @l8.bitmap.dispose
    @l8.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Spriteset C
  #--------------------------------------------------------------------------
  def dispose_spriteset_c
    @l9.bitmap.dispose
    @l9.dispose
    @l10.bitmap.dispose
    @l10.dispose
    @l11.bitmap.dispose
    @l11.dispose
    @l12.bitmap.dispose
    @l12.dispose
  end
  #--------------------------------------------------------------------------
  # * Free Spriteset D
  #--------------------------------------------------------------------------
  def dispose_spriteset_d
    @l13.bitmap.dispose
    @l13.dispose
    @l14.bitmap.dispose
    @l14.dispose
    @l15.bitmap.dispose
    @l15.dispose
    @l16.bitmap.dispose
    @l16.dispose
  end
end