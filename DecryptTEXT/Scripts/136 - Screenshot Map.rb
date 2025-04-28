=begin
#===============================================================================
 Title: Map Screenshot
 Author: Hime
 Date: Sep 25, 2015
--------------------------------------------------------------------------------
 ** Change log
 Sep 25, 2015
   - fixed placement issue with large sprites
 Dec 7, 2014
   - added option to draw certain events
 Apr 15, 2013
   - updated script to use GDI+ interface
   - added support for region map overlay and passage map overlay
 Apr 6, 2013
   - fixed bug where drawing events crashed the game
 Apr 2, 2013
   - map data is now setup by an instance of Game_Map, to account for custom
     map scripts adding to the map
 Jul 27
   - Export dirNames are now optional
 May 28
   - updated overlay mapping compatibility to draw the overlays 
     based on the player's current position
   - fixed issue where import hash was commented out
   - Added support for Yami's overlay mapping
 May 24, 2012
   - fixed large characters
   - some optimizations for calculating bounds and dimensions
 May 5, 2012
   - fixed waterfall autotile
   - added screenshot feature
 May 4, 2012
   - fixed tiles with alpha channel
   - fixed shadows
   - fixed wall autotiles
 May 1, 2012
   - fixed wall autotile, although there is still an issue with some tiles
 Apr 29, 2012
   - fixed shadow map drawing
   - added region highlighting
   - added damage tile highlighting
 Apr 28, 2012
   - Initial Release
------------------------------------------------------------------------------
 ** Description
 
 This script allows you to take a full image of any of your game's maps
 and export. An image of the map is referred to as a "mapshot" (as opposed to
 screenshot).
 
 The script provides various configuration options to control what kinds of
 things you want to see on your map, such as events, vehicles, region ID's, or
 specific tile properties.
 
------------------------------------------------------------------------------
 ** Usage
 
 The default key for taking a mapshot is F7. This can be changed in the
 configuration section.
 
 To take a mapshot, first start the game, and then hit F7.
 A message will appear informing you that a mapshot was successfully taken.
 
 Alternatively, you can use script calls to take mapshots.

    Map_Saver.new(map_id).export
    
 Aside from exporting images, you are able to use the image that the
 map saver captures.
 
   ms = Map_Saver.new(map_id)
   bmp = ms.map_image
   
 This gives you a reference to a Bitmap object that contains an image of
 your map.
--------------------------------------------------------------------------------
  ** Credits
 
  Cremno
    -GDI+ interface code
  Cidiomar
    -for drawing autotiles and shadows, 
    -providing efficient bmp and png exporters
  Moon
    -auto-tile related info
  Mephistox
    -testing and suggestions
================================================================================
=end
$imported = {} if $imported.nil?
$imported["TH_MapSaver"] = true
#===============================================================================
# ** Configuration
#===============================================================================
module TH
  module Map_Saver
    
    #Mapshot options. This takes an image of the entire map
    Mapshot_Button = Input::F7
    Mapshot_Scale = 1
    
    #Screenshot options. This takes an image of the visible map
    Screenshot_Button = Input::F8
    Screenshot_Scale = 1
    
    #Folder that the map will be exported to
    Mapshot_Directory = "Mapshots"
    Screenshot_Directory = "Screenshots"
    
    # format you want to export to. You should stick with png.
    # Options: [bmp, png] 
    Export_Format = "png"
    
    # Sprite draw options
    Draw_Events = false    
    Draw_Player = false
    Draw_Followers = false
    Draw_Vehicles = false
    
    #Should shadows be drawn? What color?
    Draw_Shadow = true
    Shadow_Color = Color.new(0, 0, 0, 128)
    
    # Should regions be drawn? Requires "Region Overlay Map" script
    Draw_Regions = false
    
    # Should passage settings be drawn? Requires "Passage Overlay Map" script
    Draw_Passages = false
    
    #Should damage tiles be highlighted? What color?
    Highlight_Damage = true
    Damage_Color = Color.new(128, 0, 0, 128)
  end
end

#==============================================================================
# ** Module: Map_Tiles
# Contains data and methods useful for working with maps and tiles
#==============================================================================

module Map_Tiles
  AUTOTILE_PARTS = [[18,17,14,13], [ 2,14,17,18], [13, 3,17,18], [ 2, 3,17,18],
                    [13,14,17, 7], [ 2,14,17, 7], [13, 3,17, 7], [ 2, 3,17, 7],
                    [13,14, 6,18], [ 2,14, 6,18], [13, 3, 6,18], [ 2, 3, 6,18],
                    [13,14, 6, 7], [ 2,14, 6, 7], [13, 3, 6, 7], [ 2, 3, 6, 7],
                    [16,17,12,13], [16, 3,12,13], [16,17,12, 7], [12, 3,16, 7], 
                    [10, 9,14,13], [10, 9,14, 7], [10, 9, 6,13], [10, 9, 6, 7],
                    [18,19,14,15], [18,19, 6,15], [ 2,19,14,15], [ 2,19, 6,15],
                    [18,17,22,21], [ 2,17,22,21], [18, 3,22,21], [ 2, 3,21,22],
                    [16,19,12,15], [10, 9,22,21], [ 8, 9,12,13], [ 8, 9,12, 7],
                    [10,11,14,15], [10,11, 6,15], [18,19,22,23], [ 2,19,22,23],
                    [16,17,20,21], [16, 3,20,21], [ 8,11,12,15], [ 8, 9,20,21],
                    [16,19,20,23], [10,11,22,23], [ 8,11,20,23], [ 0, 1, 4, 5]]
  WATERFALL_PIECES = [[ 2, 1, 6, 5], [ 0, 1, 4, 5], [ 2, 3, 6, 7], [0, 3, 4, 7]]
  WALL_PIECES =  [[10, 9, 6, 5], [ 8, 9, 4, 5], [ 2, 1, 6, 5], [ 0, 1, 4, 5],
                  [10,11, 6, 7], [ 8,11, 4, 7], [ 2, 3, 6, 7], [ 0, 3, 4, 7],
                  [10, 9,14,13], [ 8, 9,12,13], [ 2, 1,14,13], [ 0, 1,12,13],
                  [10,11,14,15], [8, 11,12,15], [ 2, 3,14,15], [ 0, 3,12,15]]

  A1_TILES = [[0, 0], [0, 96], [192, 0], [192, 96],
               [256, 0], [448, 0], [256, 96], [448, 96],
               [0, 192], [192, 192], [0, 288], [192, 288],
               [256, 192], [448, 192], [256, 288], [448, 288]]
    
  
  #--------------------------------------------------------------------------
  # * Checks if a tile is a wall
  #--------------------------------------------------------------------------
  def is_wall?(data)
    return true if data.between?(2288, 2335)
    return true if data.between?(2384, 2431)
    return true if data.between?(2480, 2527)
    return true if data.between?(2576, 2623)
    return true if data.between?(2672, 2719)
    return true if data.between?(2768, 2815)
    return true if data.between?(4736, 5119)
    return true if data.between?(5504, 5887)
    return true if data.between?(6272, 6655)
    return true if data.between?(7040, 7423)
    return true if data > 7807
    false
  end
  #--------------------------------------------------------------------------
  # * Checks if a tile is roof
  #--------------------------------------------------------------------------
  def is_roof?(data)
    return true if data.between?(4352, 4735)
    return true if data.between?(5120, 5503)
    return true if data.between?(5888, 6271)
    return true if data.between?(6656, 7039)
    return true if data.between?(7424, 7807)
    false
  end  
  #--------------------------------------------------------------------------
  # * Checks if a tile is soil
  #--------------------------------------------------------------------------
  def is_soil?(data)
    return true if data.between?(2816, 4351) && !is_table?(data)
    return true if data > 1663 && !is_stair?(data)
    false
  end    
  #--------------------------------------------------------------------------
  # * Checks if a tile is a stair
  #--------------------------------------------------------------------------
  def is_stair?(data)
     return true if data.between?(1541, 1542)
     return true if data.between?(1549, 1550)
     return true if data.between?(1600, 1615)
     false
  end
  #--------------------------------------------------------------------------
  # * Checks if a tile is a table
  #--------------------------------------------------------------------------
  def is_table?(data)
    return true if data.between?(3152, 3199)
    return true if data.between?(3536, 3583)
    return true if data.between?(3920, 3967)
    return true if data.between?(4304, 4351)
    false
  end
 
  #--------------------------------------------------------------------------
  # * The tileset to be used
  #--------------------------------------------------------------------------
  def tileset
    $data_tilesets[@tileset_id]
  end
  
  #--------------------------------------------------------------------------
  # * Region ID
  #--------------------------------------------------------------------------
  def region_id(x, y)
    valid?(x, y) ? @map.data[x, y, 3] >> 8 : 0
  end
  
  #--------------------------------------------------------------------------
  # * Gets all of the tiles for each layer at position x,y
  #--------------------------------------------------------------------------
  def layered_tiles(x, y)
    [2, 1, 0].collect {|z| @map.data[x, y, z] }
  end
  
  def layered_tiles_flag?(x, y, bit)
    layered_tiles(x, y).any? {|tile_id| tileset.flags[tile_id] & bit != 0 }
  end
   
  def valid?(x, y)
    x >= 0 && x < width && y >= 0 && y < height
  end
  
  def damage_floor?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x100)
  end
  
  #--------------------------------------------------------------------------
  # * Specifies which type of autotile is used
  #--------------------------------------------------------------------------
  def auto_tile(id)
    id / 48
  end
  
  #--------------------------------------------------------------------------
  # * Specifies the specific arrangement of autotiles used
  #--------------------------------------------------------------------------
  def auto_index(id)
    id % 48
  end
  
  #--------------------------------------------------------------------------
  # * Put the auto-tile pieces together
  #--------------------------------------------------------------------------
  def make_autotile(rects, sx, sy)
    @tile.clear
    for i in 0...4
      @auto_rect.x = (rects[i] % 4) * 16 + sx
      @auto_rect.y = (rects[i] / 4) * 16 + sy
      @tile.blt((i % 2) * 16,(i / 2) * 16, @tilemap, @auto_rect)
    end
  end
     
  #--------------------------------------------------------------------------
  # * Get auto-tile A1 tiles
  #--------------------------------------------------------------------------
  def autotile_A1(tile_id)
    @tilemap = @bitmaps[0]
    autotile = tile_id / 48
    auto_id = tile_id % 48
    sx, sy = A1_TILES[autotile]
    if is_wall?(tile_id + 2048)
      rects = WATERFALL_PIECES[auto_id]
    else  
      rects = AUTOTILE_PARTS[auto_id]
    end
    make_autotile(rects, sx, sy)
  end
  
  #--------------------------------------------------------------------------
  # * Get auto-tile A2 tiles.
  # 64x96 tiles, 8 per row, 4 rows
  #--------------------------------------------------------------------------
  def autotile_A2(tile_id)
    autotile = tile_id / 48
    auto_id = tile_id % 48
    @tilemap = @bitmaps[1]
    sx = (autotile % 8) * 64
    sy = (autotile / 8 % 4) * 96
    rects = AUTOTILE_PARTS[auto_id]
    make_autotile(rects, sx, sy)
  end
  
  #--------------------------------------------------------------------------
  # * Get auto-tile A3 tiles.
  # 64x64 tiles, 8 per row, 4 rows
  #--------------------------------------------------------------------------
  def autotile_A3(tid)
    @tilemap = @bitmaps[2]
    sx = (auto_tile(tid) % 8) * 64
    sy = (auto_tile(tid) / 8 % 4) * 64
    rects = WALL_PIECES[auto_index(tid)]
    make_autotile(rects, sx, sy)
  end
  
  #--------------------------------------------------------------------------
  # * Get auto-tile A4 tiles (walls)
  #--------------------------------------------------------------------------
  def autotile_A4(tile_id)
    @tilemap = @bitmaps[3]
    autotile = tile_id / 48
    auto_id = tile_id % 48
    sx = (autotile % 8) * 64
    sy = (autotile / 16 * 160) + (autotile / 8 % 2) * 96
    if is_wall?(tile_id + 5888)
      rects = WALL_PIECES[auto_id]
    else
      rects = AUTOTILE_PARTS[auto_id]
    end 
    make_autotile(rects, sx, sy)
  end
  
  #--------------------------------------------------------------------------
  # * Get auto-tile A5 tiles (normal)
  #--------------------------------------------------------------------------
  def autotile_A5(tile_id)
    @tilemap = @bitmaps[4]
    sx = (tile_id) % 8 * tilesize
    sy = (tile_id) / 8 * tilesize
    @src_rect.set(sx, sy, tilesize, tilesize)
    @tile.clear
    @tile.blt(0, 0, @tilemap, @src_rect)
  end
  
  #--------------------------------------------------------------------------
  # * Get normal tiles B, C, D, E
  #--------------------------------------------------------------------------
  def normal_tile(tile_id)
    @tilemap = @bitmaps[5 + tile_id / 256]
    sx = (tile_id / 128 % 2 * 8 + tile_id % 8) * tilesize;
    sy = (tile_id % 256 / 8 % 16) * tilesize;
    @src_rect.set(sx, sy, tilesize, tilesize)
    @tile.clear
    @tile.blt(0, 0, @tilemap, @src_rect)
  end
   
  #--------------------------------------------------------------------------
  # * Get bitmap for the specified tile id
  #--------------------------------------------------------------------------
  def get_bitmap(id)
    if id < 1024
      normal_tile(id)
    elsif id < 1664
      autotile_A5(id - 1536)
    elsif id < 2816
      autotile_A1(id - 2048)
    elsif id < 4352
      autotile_A2(id - 2816)
    elsif id < 5888
      autotile_A3(id - 4352)
    else
      autotile_A4(id - 5888)
    end
  end
end

#==============================================================================
# ** 
#==============================================================================

class Game_Player < Game_Character
  
  alias :th_mapsaver_update :update
  def update
    th_mapsaver_update
    if Input.trigger?(TH::Map_Saver::Mapshot_Button)
      s = Map_Saver.new($game_map.map_id)
      s.set_scale(TH::Map_Saver::Mapshot_Scale)
      s.mapshot
    end
    if Input.trigger?(TH::Map_Saver::Screenshot_Button)
      s = Map_Saver.new($game_map.map_id)
      s.set_scale(TH::Map_Saver::Screenshot_Scale)
      s.screenshot
    end
  end
end

class Game_Vehicle < Game_Character
  attr_reader :map_id
end

class Game_Map
  attr_reader :map
end

#==============================================================================
# ** 
#==============================================================================

class Map_Saver
  include TH::Map_Saver
  include Map_Tiles
  #--------------------------------------------------------------------------
  # * Constants
  #--------------------------------------------------------------------------

  SHADOW_COLOR = TH::Map_Saver::Shadow_Color
  DAMAGE_COLOR = TH::Map_Saver::Damage_Color

  #--------------------------------------------------------------------------
  # * Public instance variables
  #--------------------------------------------------------------------------
  attr_reader :map_image
  
  def initialize(map_id=$game_map.map_id, x=$game_player.x, y=$game_player.y)
    @scale = 1
    @local_x = x
    @local_y = y
    @screen_local = false
    @shadow_bitmap = Bitmap.new(128, 128)
    @draw_layer0 = true
    @draw_layer1 = true
    @draw_layer2 = true
    @draw_events = Draw_Events
    @draw_vehicles = Draw_Vehicles
    @draw_player = Draw_Player
    @draw_followers = Draw_Followers
    @draw_shadow = Draw_Shadow
    @draw_damage = Highlight_Damage
    @draw_regions = Draw_Regions
    @draw_passages = Draw_Passages
    @tile = Bitmap.new(32, 32) #stores the current tile to be drawn
    @tilemap = nil
    @src_rect = Rect.new
    @auto_rect = Rect.new(0, 0, tilesize / 2, tilesize/ 2) #constant
    @tile_rect = Rect.new(0, 0, tilesize, tilesize)        #constant
  end
  
  def load_tilesets
    bitmaps = []
    tileset.tileset_names.each_with_index do |name, i|
      bitmaps[i] = Cache.tileset(name)
    end
    return bitmaps
  end
  
  #--------------------------------------------------------------------------
  # * Refresh, possibly with a new map
  #--------------------------------------------------------------------------
  def redraw(map_id=$game_map.map_id, x=$game_player.x, y=$game_player.y)
    @map_image.dispose if @map_image
    @map_id = map_id
    @local_x = x
    @local_y = y
    @game_map = Game_Map.new
    @game_map.setup(map_id)
    @map = @game_map.map
    @map_info = $data_mapinfos[map_id]
    @screen = $game_map.screen
    @tileset_id = @game_map.tileset.id
    @bitmaps = load_tilesets
    
    get_bounds
    @map_image = Bitmap.new(@width * tilesize, @height * tilesize)
    draw_map
    scale_map if @scale != 1
  end
  
  #--------------------------------------------------------------------------
  # * Pre-process. These will never change when drawing the map. 
  #--------------------------------------------------------------------------
  def get_bounds
    @start_x = start_x
    @start_y = start_y
    @end_x = end_x
    @end_y = end_y
    @width = width
    @height = height
    @tilesize = tilesize
  end
  
  def screen_tile_x
    Graphics.width / 32
  end
  
  def screen_tile_y
    Graphics.height / 32
  end
  
  #--------------------------------------------------------------------------
  # * Sets the scale for the map
  #--------------------------------------------------------------------------
  def set_scale(scale)
    @scale = scale
  end
  
  #--------------------------------------------------------------------------
  # * Size of a tile
  #--------------------------------------------------------------------------
  def tilesize
    32
  end
  
  #--------------------------------------------------------------------------
  # * Width and height of the map, both locally and globally
  #--------------------------------------------------------------------------
  def width
    end_x - @start_x
  end
  
  def height
    end_y - @start_y
  end
  
  #--------------------------------------------------------------------------
  # * Starting and end positions, relative to the screen or map
  #--------------------------------------------------------------------------
  def start_x
    @screen_local ? [[$game_player.x - screen_tile_x / 2, @map.width - screen_tile_x].min, 0].max : 0
  end

  def start_y
    @screen_local ? [[$game_player.y - screen_tile_y / 2, @map.height - screen_tile_y].min, 0].max : 0
  end
  
  def end_x
    @screen_local ? [[screen_tile_x, @local_x + screen_tile_x / 2 + 1].max, @map.width].min : @map.width
  end
  
  def end_y
    @screen_local ? [[screen_tile_y, @local_y + screen_tile_y / 2 + 1].max, @map.height].min : @map.height
  end

  #--------------------------------------------------------------------------
  # * Draw tile onto image. x and y values are absolute coords. They should
  # be re-mapped based on the start_x and start_y values
  #--------------------------------------------------------------------------
  def draw_tile(x, y, tile, rect)
    ox = (x - @start_x) * tilesize
    oy = (y - @start_y) * tilesize
    @map_image.blt(ox, oy, tile, rect)
  end
  
  def draw_character(x, y, width, height, bmp, rect)
    ox = (x - @start_x) * tilesize
    oy = (y - @start_y) * tilesize
    
    ox = ox - width / 4 if width > 32
    oy = oy - height / 2 if height > 32
    @map_image.blt(ox, oy, bmp, rect)
  end
  
  #--------------------------------------------------------------------------
  # * Get bitmap for the specified character
  #--------------------------------------------------------------------------
  def get_character_bitmap(name)
    charmap = Cache.character(name)
    sign = name[/^[\!\$]./]
    if sign && sign.include?('$')
      cw = charmap.width / 3
      ch = charmap.height / 4
    else
      cw = charmap.width / 12
      ch = charmap.height / 8
    end
    return charmap, cw, ch
  end
  
  #--------------------------------------------------------------------------
  # * Draw the character onto the tile
  #--------------------------------------------------------------------------
  def set_character_bitmap(character, x, y)
    charmap, cw, ch = get_character_bitmap(character.character_name)
    index = character.character_index
    pattern = character.pattern < 3 ? character.pattern : 1
    sx = (index % 4 * 3 + pattern) * cw
    sy = (index / 4 * 4 + (character.direction - 2) / 2) * ch
    @src_rect.set(sx, sy, cw, ch)
    draw_character(x, y, cw, ch, charmap, @src_rect)
  end
  
  #--------------------------------------------------------------------------
  # * create the shadow map
  #--------------------------------------------------------------------------
  def make_shadow_map
    for s in 0 ... 16
      x = s % 4
      y = s / 4
      if s & 0b1000 == 0b1000
        @shadow_bitmap.fill_rect(x*tilesize+16, y*@tilesize+16, 16, 16, SHADOW_COLOR)
      end
      if s & 0b0100 == 0b0100
        @shadow_bitmap.fill_rect(x*tilesize, y*@tilesize+16, 16, 16, SHADOW_COLOR)
      end
      if s & 0b0010 == 0b0010
        @shadow_bitmap.fill_rect(x*tilesize+16, y*@tilesize, 16, 16, SHADOW_COLOR)
      end
      if s & 0b0001 == 0b0001
        @shadow_bitmap.fill_rect(x*tilesize, y*@tilesize, 16, 16, SHADOW_COLOR)
      end
    end
  end
  
  def draw_parallax
    image = Cache.parallax(@map.parallax_name)
    @src_rect.set(0, 0, image.width, image.height)
    @map_image.blt(0, 0, image, @src_rect)
  end
  
  #--------------------------------------------------------------------------
  # * Draw the shadow map
  #--------------------------------------------------------------------------
  def draw_shadow_map
    for x in @start_x ... @end_x
      for y in @start_y ... @end_y
      _x, _y = x*@tilesize, y*@tilesize
        s = @map.data[x, y, 3]  & 0b1111
        if s != 0
          x_ = (s % 4) * @tilesize
          y_ = (s / 4) * @tilesize
          @src_rect.set(x_, y_, @tilesize, @tilesize)
          draw_tile(x, y, @shadow_bitmap, @src_rect)
        end
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Draw the specified layer
  #--------------------------------------------------------------------------
  def draw_layer(layer)
    for x in @start_x ... @end_x
      for y in @start_y ... @end_y
        _x, _y = x*@tilesize, y*@tilesize
        tile_id = @map.data[x, y, layer]
        next if tile_id == 0
        get_bitmap(tile_id)
        draw_tile(x, y, @tile, @tile_rect)
      end
    end
  end
  
  #-----------------------------------------------------------------------------
  # Draw game regions
  #-----------------------------------------------------------------------------
  def draw_regions
    if $imported["TH_RegionOverlay"]
      image = SceneManager.scene.instance_variable_get(:@spriteset).instance_variable_get(:@region_map).bitmap
      @src_rect.set(@start_x * tilesize, @start_y * tilesize, image.width, image.height)
      @map_image.blt(0, 0, image, @src_rect, 255)
    end
  end
  
  def draw_passages
    if $imported["TH_OverlayPassageMap"]
      image = SceneManager.scene.instance_variable_get(:@spriteset).instance_variable_get(:@passage_map).bitmap
      @src_rect.set(@start_x * tilesize, @start_y * tilesize, image.width, image.height)
      @map_image.blt(0, 0, image, @src_rect, 255)
    end
  end

  #--------------------------------------------------------------------------
  # * Draw the game player
  #--------------------------------------------------------------------------
  def draw_player
    set_character_bitmap($game_player, $game_player.x, $game_player.y) if @map_id == $game_map.map_id
  end
  
  def draw_followers
  end
  
  #--------------------------------------------------------------------------
  # * Draw map events
  #--------------------------------------------------------------------------
  def draw_events
    @map.events.values.each do |event|
      canDraw = event.pages[0].list.any? do |cmd|
        cmd.code == 108 && cmd.parameters[0] =~ /<screenshot:\s*tile\s*>/i
      end
      next unless @draw_events || canDraw
      id = event.pages[0].graphic.tile_id
      char_name = event.pages[0].graphic.character_name
      if id > 0
        normal_tile(id)
        draw_tile(event.x, event.y, @tilemap, @src_rect)
      elsif char_name != ""
        set_character_bitmap(event.pages[0].graphic, event.x, event.y)
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # * Draw map vehicles
  #--------------------------------------------------------------------------
  def draw_vehicles
    $game_map.vehicles.each do |vehicle|
      set_character_bitmap(vehicle, vehicle.x, vehicle.y) if @map_id == vehicle.map_id
    end
  end
  
  #--------------------------------------------------------------------------
  # * Draw map sprites
  #--------------------------------------------------------------------------
  def draw_sprites
    draw_events
    draw_vehicles if @draw_vehicles
    draw_player if @draw_player
    draw_followers if @draw_followers
  end
  
  #--------------------------------------------------------------------------
  # * Highlight damage tiles
  #--------------------------------------------------------------------------
  def draw_damage
    @tile.clear
    @tile.fill_rect(0, 0, @tilesize, @tilesize, DAMAGE_COLOR)
    @src_rect.set(0, 0, @tilesize, @tilesize)
    for x in @start_x ... @end_x
      for y in @start_y ... @end_y
        _x, _y = x*@tilesize, y*@tilesize
        if damage_floor?(x, y)
          draw_tile(x, y, @tile, @src_rect)
        end
      end
    end
  end
  
  def draw_screen_effects
  end
  #--------------------------------------------------------------------------
  # * Draw the map
  #--------------------------------------------------------------------------
  def draw_map
    make_shadow_map if @draw_shadow
    draw_parallax
    draw_layer(0)
    draw_layer(1)
    draw_shadow_map
    draw_layer(2)
    draw_damage if @draw_damage
    draw_regions if @draw_regions
    draw_passages if @draw_passages
    draw_sprites
    draw_screen_effects
  end
  
  #--------------------------------------------------------------------------
  # * Scale the map
  #--------------------------------------------------------------------------
  def scale_map
    nw = @width * @scale
    nh = @height * @scale
    @src_rect.set(0, 0, @width, @height)
    scaled_map = Bitmap.new(nw, nh)
    scaled_rect = Rect.new(0, 0, nw, nh)
    scaled_map.stretch_blt(scaled_rect, @map_image, @src_rect)
    @map_image = scaled_map
  end
  
  #--------------------------------------------------------------------------
  # * Take a mapshot of the map
  #--------------------------------------------------------------------------
  def mapshot
    @screen_local = false
    redraw
    export(TH::Map_Saver::Mapshot_Directory)
    $game_message.add("Mapshot taken")
  end
    
  #--------------------------------------------------------------------------
  # * Take a screenshot of the map
  #--------------------------------------------------------------------------
  def screenshot
    @screen_local = true
    redraw
    export(TH::Map_Saver::Screenshot_Directory)
    $game_message.add("Screenshot taken")
  end
  
  #--------------------------------------------------------------------------
  # * Get the format to export to
  #--------------------------------------------------------------------------
  def get_format
    TH::Map_Saver::Export_Format
  end
  
  #--------------------------------------------------------------------------
  # * Export the map to a file
  #--------------------------------------------------------------------------
  def export(dirName="")
    format = get_format
    #name = @map.display_name != "" ? @map.display_name : @map_info.name
    name = sprintf("Map%03d" %[@map_id])
    Dir.mkdir(dirName) unless File.directory?(dirName)
    name = 
    filename = "%s\\%s.%s" %[dirName, name, format]
    t1 = Time.now
    @map_image.save(filename)
    t2 = Time.now
    $game_message.add("Exported in %f seconds" %[t2 - t1])
  end
end

class Bitmap
 
  def save(filename, options = {})
    options.merge!(format: File.extname(filename)[1..-1].to_sym)
    retval = false
    #bitmap = Gdiplus::Bitmap.new(:hbitmap, hbitmap)
    #bitmap = Gdiplus::Bitmap.new(:gdidib, *gdidib)
    # this seems to be the fastest one (RGSS 3.0.1, Windows 8 64-bit)
    bitmap = Gdiplus::Bitmap.new(:scan0, width, height, scan0)
    if bitmap
      retval = bitmap.save(:file, filename, options[:format])
      bitmap.dispose
    end
    retval
  end
 
private
 
  def _data_struct(offset = 0)
    @_data_struct ||= (DL::CPtr.new((object_id << 1) + 16).ptr + 8).ptr
    (@_data_struct + offset).ptr.to_i
  end
 
  def gdidib
     [_data_struct(8), _data_struct(16)]
  end
 
  def hbitmap
    _data_struct(44)
  end
 
  def scan0
    _data_struct(12)
  end
 
end

# ★ GDI+ interface
# ★★★★★★★★★★★★
#
# Author : Cremno
#
 
module Gdiplus
  DLL = 'gdiplus.dll'
 
  def self.get_function name, import, export = 'L'
    Win32API.new DLL, name, import, export
  end
 
  FUNCTIONS = {
    GdiplusStartup: get_function('GdiplusStartup', 'PPP'),
    GdiplusShutdown: get_function('GdiplusShutdown', 'P', 'V'),
    GdipDisposeImage: get_function('GdipDisposeImage', 'P'),
    GdipSaveImageToFile: get_function('GdipSaveImageToFile', 'PPPP'),
    GdipCreateBitmapFromGdiDib: get_function('GdipCreateBitmapFromGdiDib', 'LLP'),
    GdipCreateBitmapFromHBITMAP: get_function('GdipCreateBitmapFromHBITMAP', 'LLP'),
    GdipCreateBitmapFromScan0: get_function('GdipCreateBitmapFromScan0', 'LLLLPP')
  }
 
  @@token = [0].pack('I')
  def self.token
    @@token
  end
 
  @@clsids = {}
  def self.clsids
    @@clsids
  end
 
  def self.gen_clsids
    return unless @@clsids.empty?
    func = Win32API.new('rpcrt4.dll', 'UuidFromString', 'PP', 'L')
    {
      bmp:  '557cf400-1a04-11d3-9a73-0000f81ef32e',
      jpeg: '557cf401-1a04-11d3-9a73-0000f81ef32e',
      gif:  '557cf402-1a04-11d3-9a73-0000f81ef32e',
      tiff: '557cf405-1a04-11d3-9a73-0000f81ef32e',
      png:  '557cf406-1a04-11d3-9a73-0000f81ef32e'
    }.each_pair do |k, v|
      clsid = [0].pack('I')
      func.call(v, clsid)
      @@clsids[k] = clsid
    end
    @@clsids[:jpg] = @@clsids[:jpeg]
    @@clsids[:tif] = @@clsids[:tiff]
  end
 
  # TODO: prepend prefix (Gdip or Gdiplus) automatically
  def self.call(*args)
    name = args.shift
    func = FUNCTIONS[name]
    v = func.call(*args)
    if v && v != 0
      msgbox "GDI+ error: #{v}\n\nFunction: #{name}\nArguments: #{args.inspect}"
      false
    else
      true
    end
  end
 
  def self.startup
    call :GdiplusStartup, @@token, [1, 0, 0, 0].pack('L4'), 0
  end
 
  def self.shutdown
    call :GdiplusShutdown, @@token
  end
 
  class Image
 
    attr_reader :instance
    def initialize
      @instance = 0
      true
    end
 
    def save(destination, *args)
      case destination
      when :file
        filename = args.shift << "\0"
        filename.encode!('UTF-16LE')
        argv = [:GdipSaveImageToFile, filename, Gdiplus.clsids[args.shift], 0]
      else
        raise ArgumentError, "unknown GDI+ image destination: #{source}"
      end
      argv.insert(1, @instance)
      Gdiplus.call *argv
    end
 
    def dispose
      Gdiplus.call :GdipDisposeImage, @instance
    end
  end
 
  class Bitmap < Image
 
    def initialize source, *args
      case source
      when :gdidib
        argv = [:GdipCreateBitmapFromGdiDib, args.shift, args.shift]
      when :hbitmap
        argv = [:GdipCreateBitmapFromHBITMAP, args.shift, 0]
      when :scan0
        w = args.shift
        h = args.shift
        argv = [:GdipCreateBitmapFromScan0, w, h, w * -4, 0x26200a, args.shift]
      else
        raise ArgumentError, "unknown GDI+ bitmap source: #{source}"
      end
      argv.push([0].pack('I'))
      retval = Gdiplus.call *argv
      @instance = retval ? argv.last.unpack('I').first : 0
      retval
    end
  end
end
 
if Gdiplus.startup
  Gdiplus.gen_clsids
  class << SceneManager
    alias_method :run_wo_gdip_shutdown, :run
    def run
      run_wo_gdip_shutdown
      Gdiplus.shutdown
    end
  end
end

#==============================================================================
# * Compatibility add-ons
#==============================================================================
#Yami overlays
if $imported["YSE-OverlayMapping"]
  class Map_Saver
    def draw_overlay_map_ground
      filename = YSA::OVERLAY::GROUND
      filename += $game_map.map_id.to_s
      filename += "-" + $game_variables[YSA::OVERLAY::GROUND_VARIABLE].to_s
      p filename
      image = Cache.overlay(filename)
      @src_rect.set(@start_x*tilesize, @start_y*tilesize, image.width, image.height)
      @map_image.blt(0, 0, image, @src_rect)
    end
    
    def draw_overlay_map_parallax
      filename = YSA::OVERLAY::PARALLAX
      filename += $game_map.map_id.to_s
      filename += "-" + $game_variables[YSA::OVERLAY::PARALLAX_VARIABLE].to_s
      image = Cache.overlay(filename)
      @src_rect.set(@start_x*tilesize, @start_y*tilesize, image.width, image.height)
      @map_image.blt(0, 0, image, @src_rect)
    end
    
    def draw_overlay_map_light
      filename = YSA::OVERLAY::LIGHT
      filename += $game_map.map_id.to_s
      filename += "-" + $game_variables[YSA::OVERLAY::LIGHT_VARIABLE].to_s
      image = Cache.overlay(filename)
      @src_rect.set(@start_x*tilesize, @start_y*tilesize, image.width, image.height)
      @map_image.blt(0, 0, image, @src_rect, 10)
    end
    
    def draw_overlay_map_shadow
      filename = YSA::OVERLAY::SHADOW
      filename += $game_map.map_id.to_s
      filename += "-" + $game_variables[YSA::OVERLAY::SHADOW_VARIABLE].to_s
      image = Cache.overlay(filename)
      @src_rect.set(@start_x*tilesize, @start_y*tilesize, image.width, image.height)
      @map_image.blt(0, 0, image, @src_rect, 10)
    end
  
    alias :th_map_overlay_draw_map :draw_map
    def draw_map
      th_map_overlay_draw_map
      draw_overlay_map_ground if $game_switches[YSA::OVERLAY::GROUND_SWITCH] 
      draw_overlay_map_parallax if $game_switches[YSA::OVERLAY::PARALLAX_SWITCH] 
      draw_overlay_map_shadow if $game_switches[YSA::OVERLAY::SHADOW_SWITCH]
      draw_overlay_map_light if $game_switches[YSA::OVERLAY::LIGHT_SWITCH]
    end
  end
end

if $imported["TH_AreaOverlay"]
  class Map_Saver
    def draw_overlay_area_map
      image = SceneManager.scene.instance_variable_get(:@spriteset).instance_variable_get(:@area_map).bitmap
      @src_rect.set(@start_x * tilesize, @start_y * tilesize, image.width, image.height)
      @map_image.blt(0, 0, image, @src_rect, 255)
    end
    
    alias :th_area_overlay_draw_map :draw_map
    def draw_map
      th_area_overlay_draw_map
      draw_overlay_area_map
    end
  end
end