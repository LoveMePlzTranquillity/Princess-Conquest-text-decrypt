#==============================================================================
# 
# ▼ Yanfly Engine Ace - Ace Save Engine v1.02 and Todd's Autosave v1.1.0
# -- Last Updated: 12/21/13
# -- Level: Normal
# -- Requires: n/a
# 
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEA-SaveEngine"] = true

#==============================================================================
# ▼ Updates
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# 12/21/13 - Minor edits by BigJoshieC to fix Autosave name functionality
# 6/25/12 - Made compatible.
# 
#==============================================================================
# ▼ Introduction
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script provides a new save interface for the player. Along with a new
# interface, the player can also load and delete saves straight from the menu
# itself. This will in turn make the save command from the Main Menu always
# available, but the save option within the new save menu will be enabled
# depending on whether or not it is allowed or disallowed. From the interface,
# the player is given more information regarding the save file including the
# the location the player saved at, the amount of gold available, and any
# variables that you want to show the player as well. This will also autosave 
# the game based upon a variable.
# 
#==============================================================================
# ▼ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# To install this script, open up your script editor and copy/paste this script
# to an open slot below ▼ Materials/素材 but above ▼ Main. Remember to save.
# 
# For first time installers, be warned that loading this script the first time
# may not display all information in the status window for save files made
# before the installation of this script. To remedy this, just load up the save
# and save the file again.
# 
#==============================================================================
# ▼ Compatibility
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script is made strictly for RPG Maker VX Ace. It is highly unlikely that
# it will run with RPG Maker VX without adjusting.
# 
#==============================================================================

module YEA
  module SAVE
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # - Slot Window Settings -
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # This section adjusts how the slot window appears on the left side of the
    # screen. This also adjusts the maximum number of saves a player can make,
    # the way the slot names appear, and the icons used.
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    MAX_FILES = 17         # Maximum saves a player can make. Without Autosave.
    SLOT_NAME = "File %s"  # How the file slots will be named.
    
    # These are the icons
    SAVE_ICON  = 368       # Icon used to indicate a save is present.
    EMPTY_ICON = 375       # Icon used to indicate an empty file.
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # - Action Window Settings -
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # This section adjusts how the action window appears, the sound effect
    # played when deleting files, and what appears in the help window above.
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    ACTION_LOAD   = "Load"           # Text used for loading games.
    ACTION_SAVE   = "Save"           # Text used for saving games.
    ACTION_DELETE = "Delete"         # Text used for deleting games.
    DELETE_SOUND  = RPG::SE.new("Collapse3", 100, 100) # Sound for deleting.
    
    # These text settings adjust what displays in the help window.
    SELECT_HELP = "Please select a file slot."
    LOAD_HELP   = "Loads the data from the saved game."
    SAVE_HELP   = "Saves the current progress in your game."
    DELETE_HELP = "Deletes all data from this save file."
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # - Status Window Settings -
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # This section adjusts how the status window appears in the middle of the
    # screen (that displays the game's data) such as the total playtime, total
    # times saved, total gold, the party's current location, and the variables
    # to be displayed.
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    EMPTY_TEXT = "No Save Data"      # Text used when no save data is present.
    PLAYTIME   = "Playtime"          # Text used for total playtime.
    NG = "NG: "     # Text used to indicate NG status.
    TOTAL_GOLD = "Candy Bag: "      # Text used to indicate total gold.
    LOCATION   = "Location: "        # Text used to indicate current location.
    
    # These variables will be shown in each of the two columns for those who
    # would want to display more information than just what's shown. Input the
    # variables into the arrays below to designate what data will be shown.
    COLUMN1_VARIABLES = [920, 3717, 3899]
    COLUMN2_VARIABLES = [3912, 3913, 761]
    
  end # SAVE
end # YEA

module ToddAutoSaveAce
  
      #Autosave file name.
      AUTOSAVEFILENAME = "AutoSave"
      
      #Specify which switches to turn on and off autosave
      
      #Autosave before battle?
      AUTOSAVEBB = 6301
      
      #Autosave when menu opened?
      AUTOSAVEM =  6302 
      
      #Autosave when changing map?
      AUTOSAVETM =  6303 
      
      #Variable ID that contains the number where the sutosave file will be saved.
      VARIABLE = 7102
      
    end
#==============================================================================
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================

#==============================================================================
# ■ Icon
#==============================================================================

module Icon
  
  #--------------------------------------------------------------------------
  # self.save_icon
  #--------------------------------------------------------------------------
  def self.save_icon; return YEA::SAVE::SAVE_ICON; end
  
  #--------------------------------------------------------------------------
  # self.empty_icon
  #--------------------------------------------------------------------------
  def self.empty_icon; return YEA::SAVE::EMPTY_ICON; end
    
end # Icon

#==============================================================================
# ■ Numeric
#==============================================================================

class Numeric
  
  #--------------------------------------------------------------------------
  # new method: group_digits
  #--------------------------------------------------------------------------
  unless $imported["YEA-CoreEngine"]
  def group; return self.to_s; end
  end # $imported["YEA-CoreEngine"]
    
end # Numeric

#==============================================================================
# ■ DataManager
#==============================================================================

module DataManager
  
  #--------------------------------------------------------------------------
  # overwrite method: savefile_max
  #--------------------------------------------------------------------------
  def self.savefile_max
    return YEA::SAVE::MAX_FILES + 1
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: self.make_save_header
  #--------------------------------------------------------------------------
  def self.make_save_header
    header = {}
    header[:characters]    = $game_party.characters_for_savefile
    header[:playtime_s]    = $game_system.playtime_s
    header[:system]        = Marshal.load(Marshal.dump($game_system))
    #header[:timer]         = Marshal.load(Marshal.dump($game_timer))
    #header[:message]       = Marshal.load(Marshal.dump($game_message))
    #header[:switches]      = Marshal.load(Marshal.dump($game_switches))
    #header[:variables]     = Marshal.load(Marshal.dump($game_variables))#[3000,920, 3717, 3899,3912, 3913, 761]
    header[:variableNG]    = Marshal.load(Marshal.dump($game_variables))[3000]
    header[:var1]          = Marshal.load(Marshal.dump($game_variables))[920]
    header[:var2]          = Marshal.load(Marshal.dump($game_variables))[3717]
    header[:var3]          = Marshal.load(Marshal.dump($game_variables))[3899]
    header[:var4]          = Marshal.load(Marshal.dump($game_variables))[3912]
    header[:var5]          = Marshal.load(Marshal.dump($game_variables))[3913]
    header[:var6]          = Marshal.load(Marshal.dump($game_variables))[761]
    #header[:self_switches] = Marshal.load(Marshal.dump($game_self_switches))
    header[:actors]        = Marshal.load(Marshal.dump($game_actors))
    header[:party]         = Marshal.load(Marshal.dump($game_party))
    #header[:troop]         = Marshal.load(Marshal.dump($game_troop))
    #header[:map]           = Marshal.load(Marshal.dump($game_map))
    header[:player]        = Marshal.load(Marshal.dump($game_player))
    header
  end
  
end # DataManager

#==============================================================================
# ■ Window_MenuCommand
#==============================================================================

class Window_MenuCommand < Window_Command
  
  #--------------------------------------------------------------------------
  # overwrite method: save_enabled
  #--------------------------------------------------------------------------
  def save_enabled; return true; end
  
end # Window_MenuCommand

#==============================================================================
# ■ Window_FileList
#==============================================================================

class Window_FileList < Window_Selectable
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(dx, dy)
    super(dx, dy, 128, Graphics.height - dy)
    refresh
    activate
    select(SceneManager.scene.first_savefile_index)
  end
  
  #--------------------------------------------------------------------------
  # item_max
  #--------------------------------------------------------------------------
  def item_max; return DataManager.savefile_max; end
  
  #--------------------------------------------------------------------------
  # current_item_enabled?
  #--------------------------------------------------------------------------
  def current_item_enabled?
    header = DataManager.load_header(index)
    return false if header.nil? && SceneManager.scene_is?(Scene_Load)
    return true
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    create_contents
    draw_all_items
  end
  
  #--------------------------------------------------------------------------
  # draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    header = DataManager.load_header(index)
    enabled = !header.nil?
    rect = item_rect(index)
    rect.width -= 4
    draw_icon(save_icon?(header), rect.x, rect.y, enabled)
    change_color(normal_color, enabled)
     if index == 17 #$game_variables[ToddAutoSaveAce::VARIABLE]
        text = ToddAutoSaveAce::AUTOSAVEFILENAME
      else
        text = sprintf(YEA::SAVE::SLOT_NAME, (index + 1).group)
      end
    draw_text(rect.x+24, rect.y, rect.width-4, line_height, text)
  end
  
  #--------------------------------------------------------------------------
  # save_icon?
  #--------------------------------------------------------------------------
  def save_icon?(header)
    return Icon.empty_icon if header.nil?
    return Icon.save_icon
  end
  
end # Window_FileList

#==============================================================================
# ■ Window_FileStatus
#==============================================================================

class Window_FileStatus < Window_Base
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(dx, dy, file_window)
    super(dx, dy, Graphics.width - dx, Graphics.height - dy)
    @file_window = file_window
    @current_index = @file_window.index
    refresh
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    super
    return if @file_window.index < 0
    return if @current_index == @file_window.index
    @current_index = @file_window.index
    refresh
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    reset_font_settings
    @header = DataManager.load_header(@file_window.index)
    if @header.nil?
      draw_empty
    else
      draw_save_contents
    end
  end
  
  #--------------------------------------------------------------------------
  # draw_empty
  #--------------------------------------------------------------------------
  def draw_empty
    colour = Color.new(0, 0, 0, translucent_alpha/2)
    rect = Rect.new(0, 0, contents.width, contents.height)
    contents.fill_rect(rect, colour)
    text = YEA::SAVE::EMPTY_TEXT
    change_color(system_color)
    draw_text(rect, text, 1)
  end
  
  #--------------------------------------------------------------------------
  # draw_save_slot
  #--------------------------------------------------------------------------
  def draw_save_slot(dx, dy, dw)
    reset_font_settings
    change_color(system_color)
    text = sprintf(YEA::SAVE::SLOT_NAME, "")
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    draw_text(dx+cx, dy, dw-cx, line_height, (@file_window.index+1).group)
  end
  
  #--------------------------------------------------------------------------
  # draw_save_playtime
  #--------------------------------------------------------------------------
  def draw_save_playtime(dx, dy, dw)
    return if @header[:playtime_s].nil?
    reset_font_settings
    change_color(system_color)
    draw_text(dx, dy, dw, line_height, YEA::SAVE::PLAYTIME, 0)
    change_color(normal_color)
    draw_text(dx, dy, dw, line_height, @header[:playtime_s], 2)
  end
  
  #--------------------------------------------------------------------------
  # draw_save_NG
  #--------------------------------------------------------------------------
  def draw_save_NG(dx, dy, dw)    
    return if @header[:variableNG].nil?
    return if @header[:variableNG] == 0
    reset_font_settings
    change_color(system_color)
    text = YEA::SAVE::NG
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    text2 = @header[:variableNG]
    draw_text(dx+cx, dy, dw-cx, line_height, text2)
  end
  
  #--------------------------------------------------------------------------
  # draw_save_gold
  #--------------------------------------------------------------------------
  def draw_save_gold(dx, dy, dw)
    return if @header[:party].nil?
    reset_font_settings
    change_color(system_color)
    draw_text(dx, dy, dw, line_height, YEA::SAVE::TOTAL_GOLD)
    text = Vocab::currency_unit
    draw_text(dx, dy, dw, line_height, text, 2)
    cx = text_size(text).width
    change_color(normal_color)
    text = @header[:party].gold.group
    draw_text(dx, dy, dw-cx, line_height, text, 2)
  end
  
  #--------------------------------------------------------------------------
  # draw_save_location
  #--------------------------------------------------------------------------
  def draw_save_location(dx, dy, dw)
    #return if $data_mapinfos[@header[:map]].nil?
    reset_font_settings
    change_color(system_color)
    draw_text(dx, dy, dw, line_height, YEA::SAVE::LOCATION)
    change_color(normal_color)
    cx = text_size(YEA::SAVE::LOCATION).width
    return if $data_mapinfos[@header[:map]].nil? #here
    text = @header[:map].display_name
    text = $data_mapinfos[@header[:map].map_id].name if text == ""
    draw_text(dx+cx, dy, dw-cx, line_height, text)
  end
  
  #--------------------------------------------------------------------------
  # draw_save_characters
  #--------------------------------------------------------------------------
  def draw_save_characters(dx, dy)
    return if @header[:party].nil?
    reset_font_settings
    #make_font_smaller
    dw = (contents.width - dx) / @header[:party].max_battle_members
    dx += dw/2
    for member in @header[:party].battle_members
      next if member.nil?
      member = @header[:actors][member.id]
      change_color(normal_color)
      draw_actor_graphic(member, dx, dy)
      text = member.name
      draw_text(dx-dw/2, dy, dw, line_height, text, 1)
      text = member.level.group
      draw_text(dx-dw/2, dy-line_height, dw-2, line_height, text, 2)
      cx = text_size(text).width
      change_color(system_color)
      text = Vocab::level_a
      draw_text(dx-dw/2, dy-line_height, dw-cx-6, line_height, text, 2)
      dx += dw
    end
  end
  
  #--------------------------------------------------------------------------
  # draw_save_column1
  #--------------------------------------------------------------------------
  def draw_save_column1(dx, dy, dw)
    data = YEA::SAVE::COLUMN1_VARIABLES
    draw_column_data(data, dx, dy, dw)
  end
  
  #--------------------------------------------------------------------------
  # draw_save_column2
  #--------------------------------------------------------------------------
  def draw_save_column2(dx, dy, dw)
    data = YEA::SAVE::COLUMN2_VARIABLES
    draw_column_data(data, dx, dy, dw)
  end
  
  #--------------------------------------------------------------------------
  # draw_column_data
  #--------------------------------------------------------------------------
  def draw_column_data(data, dx, dy, dw)
    return if @header[:variables].nil?
    reset_font_settings
    for variable_id in data
      next if $data_system.variables[variable_id].nil?
      change_color(system_color)
      name = $data_system.variables[variable_id]
      draw_text(dx, dy, dw, line_height, name, 0)
      value = @header[:variables][variable_id].group
      change_color(normal_color)
      draw_text(dx, dy, dw, line_height, value, 2)
      dy += line_height
    end
  end
  
  #--------------------------------------------------------------------------
  # draw_vars
  #--------------------------------------------------------------------------
  
   def draw_save_var1(dx, dy, dw)    
    return if @header[:var1].nil?
    reset_font_settings
    change_color(system_color)
    text = "Knights INC. Level "
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    text2 = @header[:var1]
    cx2 = text_size(text2).width
    draw_text(contents.width/2-cx2-6, dy, dw, line_height, text2)
  end 
  
   def draw_save_var2(dx, dy, dw)    
    return if @header[:var2].nil?
    reset_font_settings
    change_color(system_color)
    text = "Wars # "
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    text2 = @header[:var2]
    cx2 = text_size(text2).width
    draw_text(contents.width/2-cx2-6, dy, dw, line_height, text2)
  end 
  
   def draw_save_var3(dx, dy, dw)    
    return if @header[:var3].nil?
    reset_font_settings
    change_color(system_color)
    text = "Rattesein Funds "
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    text2 = @header[:var3]
    cx2 = text_size(text2).width
    draw_text(contents.width/2-cx2-6, dy, dw, line_height, text2)
  end 
  
   def draw_save_var4(dx, dy, dw)    
    return if @header[:var4].nil?
    reset_font_settings
    change_color(system_color)
    text = "Progeny # "
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    text2 = @header[:var4]
    cx2 = text_size(text2).width
    draw_text(contents.width-cx2-6, dy, dw, line_height, text2)
  end 
  
   def draw_save_var5(dx, dy, dw)    
    return if @header[:var5].nil?
    reset_font_settings
    change_color(system_color)
    text = "NPCs Sex # "
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    text2 = @header[:var5]
    cx2 = text_size(text2).width
    draw_text(contents.width-cx2-6, dy, dw, line_height, text2)
  end 
  
   def draw_save_var6(dx, dy, dw)    
    return if @header[:var6].nil?
    reset_font_settings
    change_color(system_color)
    text = "Day "
    draw_text(dx, dy, dw, line_height, text)
    cx = text_size(text).width
    change_color(normal_color)
    text2 = @header[:var6]
    cx2 = text_size(text2).width
    draw_text(contents.width-cx2-6, dy, dw, line_height, text2)
  end   
  
  #--------------------------------------------------------------------------
  # draw_save_contents
  #--------------------------------------------------------------------------
  def draw_save_contents
    draw_save_slot(4, 0, contents.width/2+4)
    draw_save_playtime(contents.width/2+4, 0, contents.width/2-8)
    draw_save_NG(4, line_height, contents.width/2-8) #here
    draw_save_gold(contents.width/2+4, line_height, contents.width/2-8)
    #draw_save_location(4, line_height*2, contents.width-8) #here
    draw_save_characters(2, line_height*5 + line_height/3)
    #draw_save_column1(16, line_height*7, contents.width/2-48)
    #draw_save_column2(contents.width/2+16, line_height*7, contents.width/2-48)
    draw_save_var1(16, line_height*7, contents.width/2-48)
    draw_save_var2(16, line_height*8, contents.width/2-48)
    draw_save_var3(16, line_height*9, contents.width/2-48)
    draw_save_var4(contents.width/2+16, line_height*7, contents.width/2-48)
    draw_save_var5(contents.width/2+16, line_height*8, contents.width/2-48)
    draw_save_var6(contents.width/2+16, line_height*9, contents.width/2-48)
  end
  
end # Window_FileStatus

#==============================================================================
# ■ Window_FileAction
#==============================================================================

class Window_FileAction < Window_HorzCommand
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(dx, dy, file_window)
    @file_window = file_window
    super(dx, dy)
    deactivate
    unselect
  end
  
  #--------------------------------------------------------------------------
  # window_width
  #--------------------------------------------------------------------------
  def window_width; Graphics.width - 128; end
  
  #--------------------------------------------------------------------------
  # col_max
  #--------------------------------------------------------------------------
  def col_max; return 3; end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    super
    return if @file_window.index < 0
    return if @current_index == @file_window.index
    @current_index = @file_window.index
    refresh
  end
  
  #--------------------------------------------------------------------------
  # make_command_list
  #--------------------------------------------------------------------------
  def make_command_list
    @header = DataManager.load_header(@file_window.index)
    add_load_command
    add_save_command
    add_delete_command
  end
  
  #--------------------------------------------------------------------------
  # add_load_command
  #--------------------------------------------------------------------------
  def add_load_command
    add_command(YEA::SAVE::ACTION_LOAD, :load, load_enabled?)
  end
  
  #--------------------------------------------------------------------------
  # load_enabled?
  #--------------------------------------------------------------------------
  def load_enabled?
    return false if @header.nil?
    return true
  end
  
  #--------------------------------------------------------------------------
  # add_save_command
  #--------------------------------------------------------------------------
  def add_save_command
    add_command(YEA::SAVE::ACTION_SAVE, :save, save_enabled?)
  end
  
  #--------------------------------------------------------------------------
  # save_enabled?
  #--------------------------------------------------------------------------
  def save_enabled?
    return false if @header.nil? && SceneManager.scene_is?(Scene_Load)
    return false if SceneManager.scene_is?(Scene_Load)
    return false if $game_system.save_disabled
    return false if $game_switches[1200] == true || $game_switches[3825] == true || $game_switches[3826] == true || $game_switches[3038] == true || $game_switches[2481] == true || $game_switches[3907] == true #Achi/War Dec/Daily events/WM Init
    return true
  end
  
  #--------------------------------------------------------------------------
  # add_delete_command
  #--------------------------------------------------------------------------
  def add_delete_command
    add_command(YEA::SAVE::ACTION_DELETE, :delete, delete_enabled?)
  end
  
  #--------------------------------------------------------------------------
  # delete_enabled?
  #--------------------------------------------------------------------------
  def delete_enabled?
    return false if @header.nil?
    return true
  end
  
  #--------------------------------------------------------------------------
  # update_help
  #--------------------------------------------------------------------------
  def update_help
    case current_symbol
    when :load; @help_window.set_text(YEA::SAVE::LOAD_HELP)
    when :save; @help_window.set_text(YEA::SAVE::SAVE_HELP)
    when :delete; @help_window.set_text(YEA::SAVE::DELETE_HELP)
    end
  end
  
end # Window_FileAction

#==============================================================================
# ■ Scene_File
#==============================================================================

class Scene_File < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # overwrite method: start
  #--------------------------------------------------------------------------
  def start
    super
    create_all_windows
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: terminate
  #--------------------------------------------------------------------------
  def terminate
    super
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
  end
  
  #--------------------------------------------------------------------------
  # new method: create_all_windows
  #--------------------------------------------------------------------------
  def create_all_windows
    create_help_window
    create_file_window
    create_action_window
    create_status_window
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: create_help_window
  #--------------------------------------------------------------------------
  def create_help_window
    @help_window = Window_Help.new
    @help_window.set_text(YEA::SAVE::SELECT_HELP)
  end
  
  #--------------------------------------------------------------------------
  # new method: create_file_window
  #--------------------------------------------------------------------------
  def create_file_window
    wy = @help_window.height
    @file_window = Window_FileList.new(0, wy)
    @file_window.set_handler(:ok, method(:on_file_ok))
    @file_window.set_handler(:cancel, method(:return_scene))
  end
  
  #--------------------------------------------------------------------------
  # new method: create_action_window
  #--------------------------------------------------------------------------
  def create_action_window
    wx = @file_window.width
    wy = @help_window.height
    @action_window = Window_FileAction.new(wx, wy, @file_window)
    @action_window.help_window = @help_window
    @action_window.set_handler(:cancel, method(:on_action_cancel))
    @action_window.set_handler(:load, method(:on_action_load))
    @action_window.set_handler(:save, method(:on_action_save))
    @action_window.set_handler(:delete, method(:on_action_delete))
  end
  
  #--------------------------------------------------------------------------
  # new method: create_status_window
  #--------------------------------------------------------------------------
  def create_status_window
    wx = @action_window.x
    wy = @action_window.y + @action_window.height
    @status_window = Window_FileStatus.new(wx, wy, @file_window)
  end
  
  #--------------------------------------------------------------------------
  # new method: on_file_ok
  #--------------------------------------------------------------------------
  def on_file_ok
    @action_window.activate
    index = SceneManager.scene_is?(Scene_Load) ? 0 : 1
    @action_window.select(index)
  end
  
  #--------------------------------------------------------------------------
  # new method: on_action_cancel
  #--------------------------------------------------------------------------
  def on_action_cancel
    @action_window.unselect
    @file_window.activate
    @help_window.set_text(YEA::SAVE::SELECT_HELP)
  end
  
  #--------------------------------------------------------------------------
  # new method: on_action_load
  #--------------------------------------------------------------------------
  def on_action_load
    if DataManager.load_game(@file_window.index)
      on_load_success
    else
      Sound.play_buzzer
    end
    $game_map.screen.start_fadein(30)   
    $game_switches[788] = true
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: on_load_success
  #--------------------------------------------------------------------------
  def on_load_success
    Sound.play_load
    fadeout_all
    $game_system.on_after_load
    SceneManager.goto(Scene_Map)
  end
  
  #--------------------------------------------------------------------------
  # new method: on_action_save
  #--------------------------------------------------------------------------
  def on_action_save
    @action_window.activate
    if DataManager.save_game(@file_window.index)
      on_save_success
      refresh_windows
    else
      Sound.play_buzzer
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: on_save_success
  #--------------------------------------------------------------------------
  def on_save_success; Sound.play_save; end
  
  #--------------------------------------------------------------------------
  # new method: on_action_delete
  #--------------------------------------------------------------------------
  def on_action_delete
    @action_window.activate
    DataManager.delete_save_file(@file_window.index)
    on_delete_success
    refresh_windows
  end
  
  #--------------------------------------------------------------------------
  # new method: on_delete_success
  #--------------------------------------------------------------------------
  def on_delete_success
    YEA::SAVE::DELETE_SOUND.play
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_windows
  #--------------------------------------------------------------------------
  def refresh_windows
    @file_window.refresh
    @action_window.refresh
    @status_window.refresh
  end
  
end # Scene_File

#==============================================================================
# ■ Scene_Save
#==============================================================================

class Scene_Save < Scene_File
  
  #--------------------------------------------------------------------------
  # overwrite method: on_savefile_ok
  #--------------------------------------------------------------------------
  def on_savefile_ok; super; end
  
  #--------------------------------------------------------------------------
  # overwrite method: on_save_success
  #--------------------------------------------------------------------------
  def on_save_success; super; end
  
end # help_window_text

#==============================================================================
# ■ Scene_Load
#==============================================================================

class Scene_Load < Scene_File
  
  #--------------------------------------------------------------------------
  # overwrite method: on_savefile_ok
  #--------------------------------------------------------------------------
  def on_savefile_ok; super; end
  
  #--------------------------------------------------------------------------
  # overwrite method: on_load_success
  #--------------------------------------------------------------------------
  def on_load_success; super; end
  
end # Scene_Load
#==============================================================================
# ** Autosave
#------------------------------------------------------------------------------
# This module contains the autosave method. This is allows you to use the
# "Autosave.call" command. 
#==============================================================================

module Autosave
  #--------------------------------------------------------------------------
  # * Call method
  #--------------------------------------------------------------------------
  def self.call
  DataManager.save_game_without_rescue(17) #$game_variables[ToddAutoSaveAce::VARIABLE]
end
end
#==============================================================================
# ** Scene_Map
#------------------------------------------------------------------------------
#  This class performs the map screen processing.
#==============================================================================

class Scene_Map < Scene_Base
  #--------------------------------------------------------------------------
  # * Preprocessing for Battle Screen Transition
  #--------------------------------------------------------------------------
  def pre_battle_scene
    Graphics.update
    Graphics.freeze
    @spriteset.dispose_characters
    BattleManager.save_bgm_and_bgs
    BattleManager.play_battle_bgm
    Sound.play_battle_start
  #Autosave.call if $game_switches[ToddAutoSaveAce::AUTOSAVEBB] == true
end
  #--------------------------------------------------------------------------
  # * Call Menu Screen
  #--------------------------------------------------------------------------
  def call_menu
    Sound.play_ok
    SceneManager.call(Scene_Menu)
    Window_MenuCommand::init_command_position
  #Autosave.call if $game_switches[ToddAutoSaveAce::AUTOSAVEM] == true
end
  #--------------------------------------------------------------------------
  # * Preprocessing for Transferring Player
  #--------------------------------------------------------------------------
  def pre_transfer
    @map_name_window.close
    case $game_temp.fade_type
    when 0
      fadeout(fadeout_speed)
    when 1
      white_fadeout(fadeout_speed)
    end
  #--------------------------------------------------------------------------
  # * Post Processing for Transferring Player
  #--------------------------------------------------------------------------
  #def post_transfer
  #  case $game_temp.fade_type
  #  when 0
  #    Graphics.wait(fadein_speed / 2)
  #    fadein(fadein_speed)
  #  when 1
  #    Graphics.wait(fadein_speed / 2)
  #    white_fadein(fadein_speed)
  #  end
  #  @map_name_window.open
  #Autosave.call if $game_switches[ToddAutoSaveAce::AUTOSAVETM] == true
  #end
 end
end
#==============================================================================
# 
# ▼ End of File
# 
#==============================================================================