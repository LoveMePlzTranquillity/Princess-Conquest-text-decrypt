
#==============================================================================
# ** Victor Engine - Anti Lag
#------------------------------------------------------------------------------
# Author : Victor Sant
#
# Version History:
#  v 1.00 - 2012.08.03 > First release
#  v 1.01 - 2012.08.04 > Fixed issue when teleport to the same map
#------------------------------------------------------------------------------
#  This script was designed to reduce the lag cause by many events on map.
# Most anti lag script just skip the update of events that outside the screen
# while still loops though all of them. This one, instead, dinamically manage
# the list of events for update, and keeps events that aren't going to be 
# updated outside of the list.
#------------------------------------------------------------------------------
# Compatibility
#   Requires the script 'Victor Engine - Basic Module' v 1.00 or higher
#
# * Overwrite methods
#   class Game_Map
#     def update_events
#     def event_list
#
#   class Spriteset_Map
#     def update_characters
#
# * Alias methods
#   class Game_Map
#     def setup(map_id)
#     def refresh
#
#   class Game_Event < Game_Character
#     def setup_page_settings
#
#   class Spriteset_Map
#     def create_characters
#
#------------------------------------------------------------------------------
# Instructions:
#  To instal the script, open you script editor and paste this script on
#  a new section bellow the Materials section. This script must also
#  be bellow the script 'Victor Engine - Basic'
#
#------------------------------------------------------------------------------
# Comment boxes note tags:
#   Tags to be used on events Comment boxes. They're different from the
#   comment call, they're called always the even refresh.
# 
#  <always update>
#   Events with this comment on the active page will be always updated
# 
#  <never update>
#   Events with this comment on the active page will be never updated
#   Useful for decoration only events.
# 
#------------------------------------------------------------------------------
# Additional instructions:
#
#  Parallel process events and auto start events will be always updated no
#  matter their positions.
#
#  Remember that your hardware specification still have influence on the
#  performance
#==============================================================================

#==============================================================================
# ** Victor Engine
#------------------------------------------------------------------------------
#   Setting module for the Victor Engine
#==============================================================================

module Victor_Engine
  #--------------------------------------------------------------------------
  # * Setup the update buffer
  #   Setting values higher than 0, you increase the tile area of update
  #   By default, only events on the screen area or 1 tile near the visible
  #   area updates. Increasing the buff increase the update area, but also
  #   increase the potential lag.
  #--------------------------------------------------------------------------
  VE_UPDATE_BUFFER = 1
  #--------------------------------------------------------------------------
  # * required
  #   This method checks for the existance of the basic module and other
  #   VE scripts required for this script to work, don't edit this
  #--------------------------------------------------------------------------
  def self.required(name, req, version, type = nil)
    if !$imported[:ve_basic_module]
      msg = "The script '%s' requires the script\n"
      msg += "'VE - Basic Module' v%s or higher above it to work properly\n"
      msg += "Go to http://victorenginescripts.wordpress.com/ to download this script."
      msgbox(sprintf(msg, self.script_name(name), version))
      exit
    else
      self.required_script(name, req, version, type)
    end
  end
  #--------------------------------------------------------------------------
  # * script_name
  #   Get the script name base on the imported value
  #--------------------------------------------------------------------------
  def self.script_name(name, ext = "VE")
    name = name.to_s.gsub("_", " ").upcase.split
    name.collect! {|char| char == ext ? "#{char} -" : char.capitalize }
    name.join(" ")
  end
end

$imported ||= {}
$imported[:ve_anti_lag] = 1.01
Victor_Engine.required(:ve_anti_lag, :ve_basic_module, 1.00, :above)

#==============================================================================
# ** Game_Map
#------------------------------------------------------------------------------
#  This class handles maps. It includes scrolling and passage determination
# functions. The instance of this class is referenced by $game_map.
#==============================================================================

class Game_Map
  #--------------------------------------------------------------------------
  # * Overwrite method: update_events
  #--------------------------------------------------------------------------
  def update_events
    @update_list.each   {|event| event.update }
    @common_events.each {|event| event.update }
  end
  #--------------------------------------------------------------------------
  # * Overwrite method: event_list
  #--------------------------------------------------------------------------
  def event_list
    @event_list
  end
  #--------------------------------------------------------------------------
  # * Alias method: setup
  #--------------------------------------------------------------------------
  alias :setup_ve_anti_lag :setup
  def setup(map_id)
    @event_list  = []
    @update_list = []
    setup_ve_anti_lag(map_id)
  end
  #--------------------------------------------------------------------------
  # * Alias method: refresh
  #--------------------------------------------------------------------------
  alias :refresh_ve_anti_lag :refresh
  def refresh
    refresh_ve_anti_lag
    refresh_event_list
  end
  #--------------------------------------------------------------------------
  # * New method: screen_moved?
  #--------------------------------------------------------------------------
  def screen_moved?
    @last_screen_x != @display_x.to_i || @last_screen_y != @display_y.to_i
  end
  #--------------------------------------------------------------------------
  # * New method: refresh_screen_position
  #--------------------------------------------------------------------------
  def refresh_screen_position
    @last_screen_x = @display_x.to_i
    @last_screen_y = @display_y.to_i
  end
  #--------------------------------------------------------------------------
  # * New method: refresh_event_list
  #--------------------------------------------------------------------------
  def refresh_event_list
    @event_list  = events.values.select {|event| event.on_screen? }
    @update_list = events.values.select {|event| event.update? }
  end
end

#==============================================================================
# ** Game_CharacterBase
#------------------------------------------------------------------------------
#  This class deals with characters. Common to all characters, stores basic
# data, such as coordinates and graphics. It's used as a superclass of the
# Game_Character class.
#==============================================================================

class Game_CharacterBase
  #--------------------------------------------------------------------------
  # * New method: update?
  #--------------------------------------------------------------------------
  def update?(*args)
    return true
  end
  #--------------------------------------------------------------------------
  # * New method: near_the_screen?
  #--------------------------------------------------------------------------
  def near_the_screen?(*args)
    return true
  end
  #--------------------------------------------------------------------------
  # * New method: on_buffer_area?
  #--------------------------------------------------------------------------
  def on_screen?(*args)
    return true
  end
end

#==============================================================================
# ** Game_Event
#------------------------------------------------------------------------------
#  This class deals with events. It handles functions including event page 
# switching via condition determinants, and running parallel process events.
# It's used within the Game_Map class.
#==============================================================================

class Game_Event < Game_Character
  #--------------------------------------------------------------------------
  # * Alias method: setup_page_settings
  #--------------------------------------------------------------------------
  alias :setup_page_settings_ve_anti_lag :setup_page_settings
  def setup_page_settings
    setup_page_settings_ve_anti_lag
    @mode = nil
    @mode = :always if note =~ /<ALWAYS UPDATE>/i
    @mode = :never  if note =~ /<NEVER UPDATE>/i
  end
  #--------------------------------------------------------------------------
  # * New method: update?
  #--------------------------------------------------------------------------
  def update?
    return false if @mode == :never
    on_screen?(12, 8)
  end
  #--------------------------------------------------------------------------
  # * New method: auto_event?
  #--------------------------------------------------------------------------
  def auto_event?
    @mode == :always || @trigger == 3 || @trigger == 4
  end
  #--------------------------------------------------------------------------
  # * New method: on_screen?
  #--------------------------------------------------------------------------
  def on_screen?(x = 14, y = 10)
    z = [VE_UPDATE_BUFFER, 0].max
    near_the_screen?(x + z, y + z) || auto_event?
  end
end

#==============================================================================
# ** Spriteset_Map
#------------------------------------------------------------------------------
#  This class brings together map screen sprites, tilemaps, etc. It's used
# within the Scene_Map class.
#==============================================================================

class Spriteset_Map
  #--------------------------------------------------------------------------
  # * Overwrite method: update_characters
  #--------------------------------------------------------------------------
  def update_characters
    refresh_characters if @map_id != $game_map.map_id
    refresh_sprites    if $game_map.screen_moved?
    @screen_sprites.each {|sprite| sprite.update }
  end
  #--------------------------------------------------------------------------
  # * Alias method: create_characters
  #--------------------------------------------------------------------------
  alias :create_characters_ve_anti_lag :create_characters
  def create_characters
    create_characters_ve_anti_lag
    refresh_characters_sprites
  end
  #--------------------------------------------------------------------------
  # * New method: refresh_characters_sprites
  #--------------------------------------------------------------------------
  def refresh_characters_sprites
    @screen_sprites = []
    @character_sprites.each do |sprite|
      sprite.update
      @screen_sprites.push(sprite) if sprite.character.on_screen?
    end
  end
  #--------------------------------------------------------------------------
  # * New method: refresh_sprites
  #--------------------------------------------------------------------------
  def refresh_sprites
    refresh_characters_sprites
    $game_map.refresh_event_list
    $game_map.refresh_screen_position
  end
end