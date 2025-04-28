#==============================================================================
# 
# �� Yami Engine Ace - Dlc2 System
# -- Last Updated: 2012.04.06
# -- Level: Hard
# -- Requires: Yami Engine Ace - Basic Module
# 
#==============================================================================

$imported = {} if $imported.nil?
$imported["YSE-Dlc2System"] = true

#==============================================================================
# �� Updates
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# 2012.04.06 - Changed fake-dlc2 detection.
# 2012.03.17 - Released Full version.
# 2012.03.04 - Released Open Beta version.
# 2012.03.01 - Started Script.
# 
#==============================================================================
# �� Introduction
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script will generate dlc2 files for your game and make your game read
# it to update things.
# 
#==============================================================================
# �� Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# To install this script, open up your script editor and copy/paste this script
# to an open slot below �� Materials/�f�� but above �� Main. Remember to save.
#
# To open Dlc2 Maker, use this custom script: (Use Script in Event)
#---------------------------
#    YSE.dlc2_start
#---------------------------
#
#==============================================================================
# �� Compatibility
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script is made strictly for RPG Maker VX Ace. It is highly unlikely that
# it will run with RPG Maker VX without adjusting.
# 
# Do not compress dlc2 files in any methods.
# 
#==============================================================================

#==============================================================================
# �� Configuration
#==============================================================================

module YSE
  module DLC2_SYSTEM
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # - Save Data Configuration -
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    SAVE_CONFIGURATION = { # Start here.
      :path          =>  "DLC#2",
      :prefix_name   =>  "DLC",
    } # Do not delete this.
    
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    # - Load Data Configuration -
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    LOAD_CONFIGURATION = { # Start here.
      :load_test      =>  true, # Load Dlc2s when Test.
      :quit_fake      =>  true, # Quit Game when detected Fake Dlc2s.
      :check_dlc2    =>  true,
    } # Do not delete this.

  end
end

#==============================================================================
# �� Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================

#==============================================================================
# �� YSE - Dlc2 Module
#==============================================================================

module YSE
  module DLC2_SYSTEM
    
    #--------------------------------------------------------------------------
    # load_map_data
    #--------------------------------------------------------------------------
    def self.load_map_data(map_id)
      result = load_data(sprintf("Data/Map%03d.rvdata2", map_id))
      result
    end
    
    #--------------------------------------------------------------------------
    # slice_data
    #--------------------------------------------------------------------------
    def self.slice_data(data)
      # Preparing Output
      result = {}
      actors = {}
      classes = {}
      skills = {}
      items = {}
      weapons = {}
      armors = {}
      enemies = {}
      troops = {}
      states = {}
      animations = {}
      map_data = {}
      tileset = {}
      common_event = {}
      # Analyzing Data
      data.each { |key, value|
        case key
        when /(?:common_event)(\d+)?/i
          common_event[$1] = value
        when /(?:tileset)(\d+)?/i
          tileset[$1] = value
        when /(?:map)(\d+)/i
          map_data[$1] = value
        when /(?:map_info)/i
          map_data[:map_info] = value
        when /(?:actors)(\d+)/i
          actors[$1] = value
        when /(?:classes)(\d+)/i
          classes[$1] = value
        when /(?:skills)(\d+)/i
          skills[$1] = value
        when /(?:items)(\d+)/i
          items[$1] = value
        when /(?:weapons)(\d+)/i
          weapons[$1] = value
        when /(?:armors)(\d+)/i
          armors[$1] = value
        when /(?:enemies)(\d+)/i
          enemies[$1] = value
        when /(?:troops)(\d+)/i
          troops[$1] = value
        when /(?:states)(\d+)/i
          states[$1] = value
        when /(?:animations)(\d+)/i
          animations[$1] = value
        end
      }
      # Combining Data
      result[:common_event] = common_event
      result[:tileset] = tileset
      result[:map_data] = map_data
      result[:actors] = actors
      result[:classes] = classes
      result[:skills] = skills
      result[:items] = items
      result[:weapons] = weapons
      result[:armors] = armors
      result[:enemies] = enemies
      result[:troops] = troops
      result[:states] = states
      result[:animations] = animations
      result
    end
    
  end # DLC2_SYSTEM
end # YSE

#==============================================================================
# �� DataManager
#==============================================================================

module DataManager
  
  #--------------------------------------------------------------------------
  # alias method: load_normal_database
  #--------------------------------------------------------------------------
  class<<self; alias datamanager_dlc2_yse_load_normal_database load_normal_database; end
  def self.load_normal_database
    datamanager_dlc2_yse_load_normal_database
    return unless YSE::DLC2_SYSTEM::LOAD_CONFIGURATION[:load_test]
    load_dlc2_database
  end
  
  #--------------------------------------------------------------------------
  # new method: load_dlc2_database
  #--------------------------------------------------------------------------
  def self.load_dlc2_database
    $data_maps_dlc2 = {}
    # Load Directory 2
    dir = YSE::DLC2_SYSTEM::SAVE_CONFIGURATION[:path]
    prefix = YSE::DLC2_SYSTEM::SAVE_CONFIGURATION[:prefix_name]
    begin
      directory = Dir.open("./#{dir}") 
    rescue 
      Dir.mkdir("./#{dir}", 0777)
      directory = Dir.open("./#{dir}") 
    end
    directory.each { |filename|
      if filename =~ /(?:#{prefix})(\d+)?(?:.*)/i
        YSE.load_data("./#{dir}/#{filename}", method(:extract_dlc2_data), 0, :mtime)
      end
    }    
  end
  
  #--------------------------------------------------------------------------
  # new method: check_hash
  #--------------------------------------------------------------------------
  def self.check_hash(data)
    return unless YSE::DLC2_SYSTEM::LOAD_CONFIGURATION[:check_dlc2]
    return unless data["time"]
    real_check = YSE.make_hash(data["time"])
    return if data["hash"] == real_check
    msg = "System detected a fake dlc2. Filename: #{data["filename"]}.\n"
    msg += "Please delete that file or you will take your own risk.\n"
    msg += "Thank you."
    YSE.message_box("Fake Dlc2 Detected!", msg)
    exit if YSE::DLC2_SYSTEM::LOAD_CONFIGURATION[:quit_fake]
  end
  
  #--------------------------------------------------------------------------
  # new method: extract_dlc2_data
  #--------------------------------------------------------------------------
  def self.extract_dlc2_data(data, mtime)
    # Checking hash
    check_hash(data)
    # Slice Data
    temp = YSE::DLC2_SYSTEM.slice_data(data)
    common_event = temp[:common_event]
    tileset = temp[:tileset]
    map_data = temp[:map_data]
    actors = temp[:actors]
    classes = temp[:classes]
    skills = temp[:skills]
    items = temp[:items]
    weapons = temp[:weapons]
    armors = temp[:armors]
    enemies = temp[:enemies]
    troops = temp[:troops]
    states = temp[:states]
    animations = temp[:animations]
    # Common Events
    common_event.each { |key, value|
      next if value.nil?
      $data_common_events[key.to_i] = value
    }
    # Database
    tileset.each { |key, value|
      next if value.nil?
      $data_tilesets[key.to_i] = value
    }
    actors.each { |key, value|
      next if value.nil?
      $data_actors[key.to_i] = value
    }
    classes.each { |key, value|
      next if value.nil?
      $data_classes[key.to_i] = value
    }
    skills.each { |key, value|
      next if value.nil?
      $data_skills[key.to_i] = value
    }
    items.each { |key, value|
      next if value.nil?
      $data_items[key.to_i] = value
    }
    weapons.each { |key, value|
      next if value.nil?
      $data_weapons[key.to_i] = value
    }
    armors.each { |key, value|
      next if value.nil?
      $data_armors[key.to_i] = value
    }
    enemies.each { |key, value|
      next if value.nil?
      $data_enemies[key.to_i] = value
    }
    troops.each { |key, value|
      next if value.nil?
      $data_troops[key.to_i] = value
    }
    states.each { |key, value|
      next if value.nil?
      $data_states[key.to_i] = value
    }
    animations.each { |key, value|
      next if value.nil?
      $data_animations[key.to_i] = value
    }
    # Maps
    $data_mapinfos = map_data[:map_info] if map_data[:map_info]
    map_data.delete(:map_info)
    $data_maps_dlc2 = map_data
  end
  
  #--------------------------------------------------------------------------
  # alias method: reload_map_if_updated
  #--------------------------------------------------------------------------
  class<<self; alias datamanager_dlc2_yse_reload_map_if_updated reload_map_if_updated; end
  def self.reload_map_if_updated
    datamanager_dlc2_yse_reload_map_if_updated
    reload_map_if_dlc2ed
  end
  
  #--------------------------------------------------------------------------
  # new method: reload_map_if_dlc2ed
  #--------------------------------------------------------------------------
  def self.reload_map_if_dlc2ed
    unless $data_maps_dlc2[$game_map.map_id].nil?
      $game_map.setup($game_map.map_id)
      $game_player.center($game_player.x, $game_player.y)
      $game_player.make_encounter_count
    end  
  end
  
end # DataManager

#==============================================================================
# �� Game_Map
#==============================================================================

class Game_Map
  
  #--------------------------------------------------------------------------
  # overwrite method: setup
  #--------------------------------------------------------------------------
  def setup(map_id)
    @map_id = map_id    
    if $data_maps_dlc1.nil? || $data_maps_dlc1[map_id.to_s].nil? 
      if $data_maps_dlc2.nil? || $data_maps_dlc2[map_id.to_s].nil?  
        if $data_maps_patch.nil? || $data_maps_patch[map_id.to_s].nil? 
            @map = load_data(sprintf("Data/Map%03d.rvdata2", @map_id))
        else
            @map = $data_maps_patch[map_id.to_s]
        end          
    else
      @map = $data_maps_dlc2[map_id.to_s]
    end
    else
      @map = $data_maps_dlc1[map_id.to_s]
    end
    @tileset_id = @map.tileset_id
    @display_x = 0
    @display_y = 0
    referesh_vehicles
    setup_events
    setup_scroll
    setup_parallax
    setup_battleback
    @need_refresh = false
  end
  
end # Game_Map

#==============================================================================
# �� Window_Dlc2_Base
#==============================================================================

class Window_Dlc2_Base < Window_Selectable
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super((Graphics.width - 408) / 2, (Graphics.height - 344) / 2, 408, 344)
    @data = []
    refresh
  end
  
  #--------------------------------------------------------------------------
  # item_max
  #--------------------------------------------------------------------------
  def item_max
    return @data.nil? ? 1 : @data.size
  end
  
  #--------------------------------------------------------------------------
  # item_max
  #--------------------------------------------------------------------------
  def make_data_list
    # Loading Data.
  end
  
  #--------------------------------------------------------------------------
  # highlight
  #--------------------------------------------------------------------------
  def highlight(index)
    # Highlight Data.
  end
  
  #--------------------------------------------------------------------------
  # draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    name = @data[index]
    rect = item_rect(index)
    rect.width -= 4
    change_color(normal_color)
    rect.x += 4
    draw_text(rect, "#{index + 1}, ", 0)
    change_color(normal_color)
    change_color(Color.new(100,100,100)) unless highlight(index)
    rect.x += 40
    draw_text(rect, "#{name}", 0)
    change_color(Color.new(255,175,175))
    rect.x -= 44
    draw_text(rect, sprintf("(ID: %03d)", index + 1), 2)
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    make_data_list
    create_contents
    draw_all_items
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def set_on_off
    # Set on/off
  end
  
end # Window_Dlc2_Base

#==============================================================================
# �� Window_Dlc2_Maps
#==============================================================================

class Window_Dlc2_Maps < Window_Dlc2_Base
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    $dlc2_map_temp = []
    super
  end
  
  #--------------------------------------------------------------------------
  # make_data_list
  #--------------------------------------------------------------------------
  def make_data_list
    $data_mapinfos.each { |key, value|
      @data.push(value.name)
    }
  end
  
  #--------------------------------------------------------------------------
  # highlight
  #--------------------------------------------------------------------------
  def highlight(index)
    $dlc2_map_temp.include?(index + 1)
  end
  
  #--------------------------------------------------------------------------
  # set_on_off
  #--------------------------------------------------------------------------
  def set_on_off
    if $dlc2_map_temp.include?(index + 1)
      $dlc2_map_temp.delete(index + 1)
      draw_item(index)
    else
      $dlc2_map_temp.push(index + 1)
      draw_item(index)
    end
  end
  
end # Window_Dlc2_Maps

#==============================================================================
# �� Window_Dlc2_Common_Event
#==============================================================================

class Window_Dlc2_Common_Event < Window_Dlc2_Base
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    $dlc2_ce_temp = []
    super
  end
  
  #--------------------------------------------------------------------------
  # make_data_list
  #--------------------------------------------------------------------------
  def make_data_list
    $data_common_events.each { |value|
      next if value.nil?
      @data.push(value.name)
    }
  end
  
  #--------------------------------------------------------------------------
  # highlight
  #--------------------------------------------------------------------------
  def highlight(index)
    $dlc2_ce_temp.include?(index + 1)
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def set_on_off
    if $dlc2_ce_temp.include?(index + 1)
      $dlc2_ce_temp.delete(index + 1)
      draw_item(index)
    else
      $dlc2_ce_temp.push(index + 1)
      draw_item(index)
    end
  end
  
end # Window_Dlc2_Common_Event

#==============================================================================
# �� Window_Dlc2_Tileset
#==============================================================================

class Window_Dlc2_Tileset < Window_Dlc2_Base
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    $dlc2_ts_temp = []
    super
  end
  
  #--------------------------------------------------------------------------
  # make_data_list
  #--------------------------------------------------------------------------
  def make_data_list
    $data_tilesets.each { |value|
      next if value.nil?
      @data.push(value.name)
    }
  end
  
  #--------------------------------------------------------------------------
  # highlight
  #--------------------------------------------------------------------------
  def highlight(index)
    $dlc2_ts_temp.include?(index + 1)
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def set_on_off
    if $dlc2_ts_temp.include?(index + 1)
      $dlc2_ts_temp.delete(index + 1)
      draw_item(index)
    else
      $dlc2_ts_temp.push(index + 1)
      draw_item(index)
    end
  end
  
end # Window_Dlc2_Tileset

DLC2_HASH_NAME = ["Actors", "Classes", "Skills", "Items", "Weapons", "Armors",
                   "Enemies", "Troops", "States", "Animations"]
DLC2_HASH_NAME.each { |dlc2_name|
  cStr = %Q(
  class Window_Dlc2_#{dlc2_name} < Window_Dlc2_Base
    
    #--------------------------------------------------------------------------
    # initialize
    #--------------------------------------------------------------------------
    def initialize
      $dlc2_#{dlc2_name.downcase}_temp = []
      super
    end
    
    #--------------------------------------------------------------------------
    # make_data_list
    #--------------------------------------------------------------------------
    def make_data_list
      $data_#{dlc2_name.downcase}.each { |value|
        next if value.nil?
        @data.push(value.name)
      }
    end
    
    #--------------------------------------------------------------------------
    # highlight
    #--------------------------------------------------------------------------
    def highlight(index)
      $dlc2_#{dlc2_name.downcase}_temp.include?(index + 1)
    end
    
    #--------------------------------------------------------------------------
    # refresh
    #--------------------------------------------------------------------------
    def set_on_off
      if $dlc2_#{dlc2_name.downcase}_temp.include?(index + 1)
        $dlc2_#{dlc2_name.downcase}_temp.delete(index + 1)
        draw_item(index)
      else
        $dlc2_#{dlc2_name.downcase}_temp.push(index + 1)
        draw_item(index)
      end
    end
    
  end
  )
  eval(cStr)
}

#==============================================================================
# �� Window_Dlc2_Command
#==============================================================================

class Window_Dlc2_Command < Window_Command
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, (Graphics.height - fitting_height(4)) / 2)
  end
  
  #--------------------------------------------------------------------------
  # window_width
  #--------------------------------------------------------------------------
  def window_width
    return Graphics.width
  end
  
  #--------------------------------------------------------------------------
  # visible_line_number
  #--------------------------------------------------------------------------
  def visible_line_number
    return 4
  end
  
  #--------------------------------------------------------------------------
  # col_max
  #--------------------------------------------------------------------------
  def col_max
    4
  end
  
  #--------------------------------------------------------------------------
  # make_command_list
  #--------------------------------------------------------------------------
  def make_command_list
    add_command("Maps", :maps, true)
    add_command("Common Events", :ce, true)
    add_command("Tilesets", :ts, true)
    DLC2_HASH_NAME.each { |dlc2_name|
      cStr = "add_command(\"#{dlc2_name}\", :#{dlc2_name.downcase}, true)"
      eval(cStr)
    }
    add_command("Dlc2!", :dlc2, true)
    add_command("Dlc2 All Things", :dlc2_all, true)
    add_command("Exit", :cancel, true)
  end

end # Window_Dlc2_Command

#==============================================================================
# �� Scene_DLC2_YSE
#==============================================================================

class Scene_DLC2_YSE < Scene_Base
  
  #--------------------------------------------------------------------------
  # start
  #--------------------------------------------------------------------------
  def start
    super
    create_all_windows
    @command_window.activate
    @command_window.select(0)
  end
  
  #--------------------------------------------------------------------------
  # create_all_windows
  #--------------------------------------------------------------------------
  def create_all_windows
    #---
    @command_window = Window_Dlc2_Command.new
    @command_window.viewport = @viewport
    @command_window.set_handler(:maps,    method(:dlc2_maps))
    @command_window.set_handler(:ts,    method(:dlc2_tileset))
    @command_window.set_handler(:ce,    method(:dlc2_common_event))
    @command_window.set_handler(:dlc2,    method(:apply_dlc2))
    @command_window.set_handler(:dlc2_all,    method(:apply_dlc2_all))
    DLC2_HASH_NAME.each { |dlc2_name|
      cStr = "@command_window.set_handler(:#{dlc2_name.downcase},    method(:dlc2_#{dlc2_name.downcase}))"
      eval(cStr)
    }
    @command_window.set_handler(:cancel,   method(:return_scene))
    #---
    @maps_window = Window_Dlc2_Maps.new
    @maps_window.viewport = @viewport
    @maps_window.set_handler(:ok,    method(:on_maps_ok))
    @maps_window.set_handler(:cancel,   method(:on_maps_cancel))
    @maps_window.close
    #---
    DLC2_HASH_NAME.each { |dlc2_name|
      cStr = %Q(
        @#{dlc2_name.downcase}_window = Window_Dlc2_#{dlc2_name}.new
        @#{dlc2_name.downcase}_window.viewport = @viewport
        @#{dlc2_name.downcase}_window.set_handler(:ok,    method(:on_#{dlc2_name.downcase}_ok))
        @#{dlc2_name.downcase}_window.set_handler(:cancel,   method(:on_#{dlc2_name.downcase}_cancel))
        @#{dlc2_name.downcase}_window.close
      )
      eval(cStr)
    }
    #---
    @ce_window = Window_Dlc2_Common_Event.new
    @ce_window.viewport = @viewport
    @ce_window.set_handler(:ok,    method(:on_ce_ok))
    @ce_window.set_handler(:cancel,   method(:on_ce_cancel))
    @ce_window.close
    #---
    @ts_window = Window_Dlc2_Tileset.new
    @ts_window.viewport = @viewport
    @ts_window.set_handler(:ok,    method(:on_ts_ok))
    @ts_window.set_handler(:cancel,   method(:on_ts_cancel))
    @ts_window.close
  end
  
  #--------------------------------------------------------------------------
  # dlc2_maps
  #--------------------------------------------------------------------------
  def dlc2_maps
    @command_window.deactivate
    @maps_window.open
    @maps_window.activate
    @maps_window.select(0)
  end
  
  #--------------------------------------------------------------------------
  # dlc2_tileset
  #--------------------------------------------------------------------------
  def dlc2_tileset
    @command_window.deactivate
    @ts_window.open
    @ts_window.activate
    @ts_window.select(0)
  end
  
  #--------------------------------------------------------------------------
  # dlc2_common_event
  #--------------------------------------------------------------------------
  def dlc2_common_event
    @command_window.deactivate
    @ce_window.open
    @ce_window.activate
    @ce_window.select(0)
  end
  
  DLC2_HASH_NAME.each { |dlc2_name|
    cStr = %Q(
    def dlc2_#{dlc2_name.downcase}
      @command_window.deactivate
      @#{dlc2_name.downcase}_window.open
      @#{dlc2_name.downcase}_window.activate
      @#{dlc2_name.downcase}_window.select(0)
    end
    )
    module_eval(cStr)
  }
  
  #--------------------------------------------------------------------------
  # on_maps_ok
  #--------------------------------------------------------------------------
  def on_maps_ok
    @maps_window.set_on_off
    @maps_window.activate
  end
  
  #--------------------------------------------------------------------------
  # on_maps_ok
  #--------------------------------------------------------------------------
  def on_maps_cancel
    @maps_window.deactivate
    @maps_window.close
    @command_window.activate
  end
  
  DLC2_HASH_NAME.each { |dlc2_name|
    cStr = %Q(
    def on_#{dlc2_name.downcase}_ok
      @#{dlc2_name.downcase}_window.set_on_off
      @#{dlc2_name.downcase}_window.activate
    end
    def on_#{dlc2_name.downcase}_cancel
      @#{dlc2_name.downcase}_window.deactivate
      @#{dlc2_name.downcase}_window.close
      @command_window.activate
    end
    )
    module_eval(cStr)
  }
  
  #--------------------------------------------------------------------------
  # on_ce_ok
  #--------------------------------------------------------------------------
  def on_ce_ok
    @ce_window.set_on_off
    @ce_window.activate
  end
  
  #--------------------------------------------------------------------------
  # on_ce_cancel
  #--------------------------------------------------------------------------
  def on_ce_cancel
    @ce_window.deactivate
    @ce_window.close
    @command_window.activate
  end
  
  #--------------------------------------------------------------------------
  # on_ts_ok
  #--------------------------------------------------------------------------
  def on_ts_ok
    @ts_window.set_on_off
    @ts_window.activate
  end
  
  #--------------------------------------------------------------------------
  # on_ts_cancel
  #--------------------------------------------------------------------------
  def on_ts_cancel
    @ts_window.deactivate
    @ts_window.close
    @command_window.activate
  end
  
  #--------------------------------------------------------------------------
  # apply_dlc2
  #--------------------------------------------------------------------------
  def apply_dlc2
    dir = YSE::DLC2_SYSTEM::SAVE_CONFIGURATION[:path]
    prefix = YSE::DLC2_SYSTEM::SAVE_CONFIGURATION[:prefix_name]
    time = Time.now.strftime("%s")
    filename = YSE.make_filename("#{prefix}#{time}", dir)
    @temporary = {}
    $dlc2_map_temp.each { |id|
      #next if id.nil?
      map_data = YSE::DLC2_SYSTEM.load_map_data(id)
      @temporary["map#{id}"] = map_data
      @temporary["map_info"] = $data_mapinfos
    }
    $dlc2_ce_temp.each { |id|
      #next if id.nil?
      @temporary["common_event#{id}"] = $data_common_events[id]
    }
    $dlc2_ts_temp.each { |id|
      #next if id.nil?
      @temporary["tileset#{id}"] = $data_tilesets[id]
    }
    DLC2_HASH_NAME.each { |dlc2_name|
      cStr = %Q(
        $dlc2_#{dlc2_name.downcase}_temp.each { |id|
          next if id.nil?
          @temporary["#{dlc2_name.downcase}"+id.to_s] = $data_#{dlc2_name.downcase}[id]
        }
      )
      eval(cStr)
    }
    @temporary["hash"] = YSE.make_hash(time)
    @temporary["time"] = time
    @temporary["filename"] = filename
    YSE.save_data(filename, @temporary)
    YSE.message_box("Dlc2 System","Create Dlc2 Complete! Location: #{filename}. Click OK to Exit.")
    exit
  end
  
  #--------------------------------------------------------------------------
  # apply_dlc2_all
  #--------------------------------------------------------------------------
  def apply_dlc2_all
    $data_mapinfos.each_key { |i|
      #next if i == 0
      $dlc2_map_temp.push(i)
    }
    $data_common_events.size.times { |i|
      #next if i == 0
      $dlc2_ce_temp.push(i)
    }
    $data_tilesets.size.times { |i|
      #next if i == 0
      $dlc2_ts_temp.push(i)
    }
    DLC2_HASH_NAME.each { |dlc2_name|
      cStr = %Q(
        $data_#{dlc2_name.downcase}.size.times { |i|
          next if i == 0
          $dlc2_#{dlc2_name.downcase}_temp.push(i)
        }
      )
      eval(cStr)
    }
    apply_dlc2
  end
  
end # Scene_DLC2_YSE

#==============================================================================
# 
# �� End of File
# 
#==============================================================================