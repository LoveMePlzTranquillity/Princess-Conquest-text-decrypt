#==============================================================================
# ** Game_CharacterBase
#------------------------------------------------------------------------------
#  This base class handles characters. It retains basic information, such as 
# coordinates and graphics, shared by all characters.
#==============================================================================

class Game_CharacterBase
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader   :id                       # ID
  attr_reader   :x                        # map X coordinate (logical)
  attr_reader   :y                        # map Y coordinate (logical)
  attr_reader   :real_x                   # map X coordinate (real)
  attr_reader   :real_y                   # map Y coordinate (real)
  attr_reader   :tile_id                  # tile ID (invalid if 0)
  attr_reader   :character_name           # character graphic filename
  attr_reader   :character_index          # character graphic index
  attr_accessor   :move_speed               # movement speed
  attr_accessor   :move_frequency           # movement frequency
  attr_reader   :walk_anime               # walking animation
  attr_reader   :step_anime               # stepping animation
  attr_reader   :direction_fix            # direction fix
  attr_reader   :opacity                  # opacity level
  attr_reader   :blend_type               # blending method
  attr_reader   :direction                # direction
  attr_reader   :pattern                  # pattern
  attr_reader   :priority_type            # priority type
  attr_reader   :through                  # pass-through
  attr_reader   :bush_depth               # bush depth
  attr_accessor :animation_id             # animation ID
  attr_accessor :balloon_id               # balloon icon ID
  attr_accessor :transparent              # transparency flag
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize
    init_public_members
    init_private_members
  end
  #--------------------------------------------------------------------------
  # * Initialize Public Member Variables
  #--------------------------------------------------------------------------
  def init_public_members
    @id = 0
    @x = 0
    @y = 0
    @real_x = 0
    @real_y = 0
    @tile_id = 0
    @character_name = ""
    @character_index = 0
    @move_speed = 4
    @move_frequency = 6
    @walk_anime = true
    @step_anime = false
    @direction_fix = false
    #if $game_variables[116] == "BlindLuck"
    # @opacity = 55  
    #else
     @opacity = 255  
    #end  
    @blend_type = 0
    @direction = 2
    @pattern = 1
    @priority_type = 1
    @through = false
    @bush_depth = 0
    @animation_id = 0
    @balloon_id = 0
    @transparent = false
  end
  #--------------------------------------------------------------------------
  # * Initialize Private Member Variables
  #--------------------------------------------------------------------------
  def init_private_members
    @original_direction = 2               # Original direction
    @original_pattern = 1                 # Original pattern
    @anime_count = 0                      # Animation count
    @stop_count = 0                       # Stop count
    @jump_count = 0                       # Jump count
    @jump_peak = 0                        # Jump peak count
    @locked = false                       # Locked flag
    @prelock_direction = 0                # Direction before lock
    @move_succeed = true                  # Move success flag
  end
  #--------------------------------------------------------------------------
  # * Determine Coordinate Match
  #--------------------------------------------------------------------------
  def pos?(x, y)
    @x == x && @y == y
  end
  #--------------------------------------------------------------------------
  # * Determine if Coordinates Match and Pass-Through Is Off (nt = No Through)
  #--------------------------------------------------------------------------
  def pos_nt?(x, y)
    pos?(x, y) && !@through
  end
  #--------------------------------------------------------------------------
  # * Determine if [Same as Characters] Priority
  #--------------------------------------------------------------------------
  def normal_priority?
      if $game_player.real_move_speed >= 6
       @priority_type == 1  || @priority_type == 0 #2 FAST!
     else
       @priority_type == 1
      end  
  end
  #--------------------------------------------------------------------------
  # * Determine if Moving
  #--------------------------------------------------------------------------
  def moving?
    @real_x != @x || @real_y != @y
  end
  #--------------------------------------------------------------------------
  # * Determine if Jumping
  #--------------------------------------------------------------------------
  def jumping?
    @jump_count > 0
  end
  #--------------------------------------------------------------------------
  # * Calculate Jump Height
  #--------------------------------------------------------------------------
  def jump_height
    (@jump_peak * @jump_peak - (@jump_count - @jump_peak).abs ** 2) / 2
  end
  #--------------------------------------------------------------------------
  # * Determine if Stopping
  #--------------------------------------------------------------------------
  def stopping?
    !moving? && !jumping?
  end
  #--------------------------------------------------------------------------
  # * Get Move Speed (Account for Dash)
  #--------------------------------------------------------------------------
  def real_move_speed
     if self == $game_player
     if $game_variables[116] == "Rooted" #Rooted Skill
      @move_speed - (dash? ? 1 : 1) 
     elsif $game_switches[831] == true #lockspeed
       if $game_variables[774] == 0
         @move_speed - (dash? ? 1 : 1) 
       elsif $game_variables[774] == 1
         @move_speed + (dash? ? 0 : 0)          
       elsif $game_variables[774] == 2
         @move_speed + (dash? ? 1 : 1) 
       elsif $game_variables[774] == 3 
         @move_speed + (dash? ? 2 : 2) 
       elsif $game_variables[774] == 4 
         @move_speed + (dash? ? 3 : 3)          
       elsif $game_variables[774] >= 5 
         @move_speed + (dash? ? 4 : 4)          
       end
     else #custom Speeds
      @moveCh = 0 
     unless $game_map.interpreter.running? #reset during scenes
     if $game_switches[2991] == true #RabTF
      @moveCh -= 1
     end  
     if $game_party.members[0].state?(165) == true #barkskin
      @moveCh -= 1
     end 
     if $game_self_switches[[270,122,"A"]] == true #missBorne event
       @moveCh -= 1
     end  
     if $game_party.members[0].state?(218) == true #dog rush
      @moveCh += 1
     end        
     if $game_party.members[0].state?(164) == true #speedster 
      @moveCh += 1
     end 
     if $game_party.members[0].equips.include?$data_armors[666] #fast leaf 
      @moveCh += 1
     end 
     if $game_variables[116] == "Sleepwalker" && $game_switches[413] == true #Sleepwalker Skill + NIGHT
       @moveCh += 1
     end  
     end  
     if @moveCh <= -1
        @move_speed + (dash? ? 0 : 0)
      elsif @moveCh == 0
        @move_speed + (dash? ? 1 : 0)
      elsif @moveCh == 1
        @move_speed + (dash? ? 2 : 1)
      elsif @moveCh >= 2
        if $game_switches[839] == false
        $game_switches[839] = true
        end
        @move_speed + (dash? ? 2: 2)
      end   
     end  
  else
   @move_speed + (dash? ? 1 : 0)
  end 
  end  
  #--------------------------------------------------------------------------
  # * Calculate Move Distance per Frame
  #--------------------------------------------------------------------------
  def distance_per_frame
     2 ** real_move_speed / 256.0 
  end
  #--------------------------------------------------------------------------
  # * Determine if Dashing
  #--------------------------------------------------------------------------
  def dash?
    return false
  end
  #--------------------------------------------------------------------------
  # * Determine if Debug Pass-Through State
  #--------------------------------------------------------------------------
  def debug_through?
    return false
  end
  #--------------------------------------------------------------------------
  # * Straighten Position
  #--------------------------------------------------------------------------
  def straighten
    @pattern = 1 if @walk_anime || @step_anime
    @anime_count = 0
  end
  #--------------------------------------------------------------------------
  # * Get Opposite Direction
  #     d : Direction (2,4,6,8)
  #--------------------------------------------------------------------------
  def reverse_dir(d)
    return 10 - d
  end

#==============================================================================
# ** Game_CharacterBase
#------------------------------------------------------------------------------
#  This base class handles characters. It retains basic information, such as 
# coordinates and graphics, shared by all characters.
#==============================================================================
  #--------------------------------------------------------------------------
  # * Determine if Passable
  #     d : Direction (2,4,6,8)
  #--------------------------------------------------------------------------
  def passable?(x, y, d)
    x2 = $game_map.round_x_with_direction(x, d)
    y2 = $game_map.round_y_with_direction(y, d)
    return false unless $game_map.valid?(x2, y2)
    return true if @through || debug_through?
    return false unless map_passable?(x, y, d)
    return false unless map_passable?(x2, y2, reverse_dir(d))
    return false if collide_with_characters?(x2, y2)
    return true
  end
  #--------------------------------------------------------------------------
  # * Determine Diagonal Passability
  #     horz : Horizontal (4 or 6)
  #     vert : Vertical (2 or 8)
  #--------------------------------------------------------------------------
  def diagonal_passable?(x, y, horz, vert)
    x2 = $game_map.round_x_with_direction(x, horz)
    y2 = $game_map.round_y_with_direction(y, vert)
    (passable?(x, y, vert) && passable?(x, y2, horz)) ||
    (passable?(x, y, horz) && passable?(x2, y, vert))
  end
  #--------------------------------------------------------------------------
  # * Determine if Map is Passable
  #     d : Direction (2,4,6,8)
  #--------------------------------------------------------------------------
  def map_passable?(x, y, d)
    $game_map.passable?(x, y, d)
  end
  #--------------------------------------------------------------------------
  # * Detect Collision with Character 
  #--------------------------------------------------------------------------
  def collide_with_characters?(x, y)
    collide_with_events?(x, y) || collide_with_vehicles?(x, y)
  end
  #--------------------------------------------------------------------------
  # * Detect Collision with Event
  #--------------------------------------------------------------------------
  def collide_with_events?(x, y)
    $game_map.events_xy_nt(x, y).any? do |event|
      event.normal_priority? || self.is_a?(Game_Event)
    end
  end
  #--------------------------------------------------------------------------
  # * Detect Collision with Vehicle
  #--------------------------------------------------------------------------
  def collide_with_vehicles?(x, y)
    $game_map.boat.pos_nt?(x, y) || $game_map.ship.pos_nt?(x, y)
  end
  #--------------------------------------------------------------------------
  # * Move to Designated Position
  #--------------------------------------------------------------------------
  def moveto(x, y)
    @x = x % $game_map.width
    @y = y % $game_map.height
    @real_x = @x
    @real_y = @y
    @prelock_direction = 0
    straighten
    update_bush_depth
  end
  #--------------------------------------------------------------------------
  # * Change Direction to Designated Direction
  #     d : Direction (2,4,6,8)
  #--------------------------------------------------------------------------
  def set_direction(d)
    @direction = d if !@direction_fix && d != 0
    @stop_count = 0
  end
  #--------------------------------------------------------------------------
  # * Determine Tile
  #--------------------------------------------------------------------------
  def tile?
    @tile_id > 0 && @priority_type == 0
  end
  #--------------------------------------------------------------------------
  # * Determine Object Character
  #--------------------------------------------------------------------------
  def object_character?
    @tile_id > 0 || @character_name[0, 1] == '!'
  end
  #--------------------------------------------------------------------------
  # * Get Number of Pixels to Shift Up from Tile Position
  #--------------------------------------------------------------------------
  def shift_y
    object_character? ? 0 : 4
  end
  #--------------------------------------------------------------------------
  # * Get Screen X-Coordinates
  #--------------------------------------------------------------------------
  def screen_x
    $game_map.adjust_x(@real_x) * 32 + 16
  end
  #--------------------------------------------------------------------------
  # * Get Screen Y-Coordinates
  #--------------------------------------------------------------------------
  def screen_y
    $game_map.adjust_y(@real_y) * 32 + 32 - shift_y - jump_height
  end
  #--------------------------------------------------------------------------
  # * Get Screen Z-Coordinates
  #--------------------------------------------------------------------------
  def screen_z
    @priority_type * 100
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    update_animation
    return update_jump if jumping?
    return update_move if moving?
    return update_stop
  end
  #--------------------------------------------------------------------------
  # * Update While Jumping
  #--------------------------------------------------------------------------
  def update_jump
    @jump_count -= 1
    @real_x = (@real_x * @jump_count + @x) / (@jump_count + 1.0)
    @real_y = (@real_y * @jump_count + @y) / (@jump_count + 1.0)
    update_bush_depth
    if @jump_count == 0
      @real_x = @x = $game_map.round_x(@x)
      @real_y = @y = $game_map.round_y(@y)
    end
  end
  #--------------------------------------------------------------------------
  # * Update While Moving
  #--------------------------------------------------------------------------
  def update_move
    @real_x = [@real_x - distance_per_frame, @x].max if @x < @real_x
    @real_x = [@real_x + distance_per_frame, @x].min if @x > @real_x
    @real_y = [@real_y - distance_per_frame, @y].max if @y < @real_y
    @real_y = [@real_y + distance_per_frame, @y].min if @y > @real_y
    update_bush_depth unless moving?
  end
  #--------------------------------------------------------------------------
  # * Update While Stopped
  #--------------------------------------------------------------------------
  def update_stop
    @stop_count += 1 unless @locked
  end
  #--------------------------------------------------------------------------
  # * Update Walking/Stepping Animation
  #--------------------------------------------------------------------------
  def update_animation
    update_anime_count
    if @anime_count > 18 - real_move_speed * 2
      update_anime_pattern
      @anime_count = 0
    end
  end
  #--------------------------------------------------------------------------
  # * Update Animation Count
  #--------------------------------------------------------------------------
  def update_anime_count
    if moving? && @walk_anime
      @anime_count += 1.5
    elsif @step_anime || @pattern != @original_pattern
      @anime_count += 1
    end
  end
  #--------------------------------------------------------------------------
  # * Update Animation Pattern
  #--------------------------------------------------------------------------
  def update_anime_pattern
    if !@step_anime && @stop_count > 0
      @pattern = @original_pattern
    else
      @pattern = (@pattern + 1) % 4
    end
  end
  #--------------------------------------------------------------------------
  # * Determine if Ladder
  #--------------------------------------------------------------------------
  def ladder?
    $game_map.ladder?(@x, @y)
  end
  #--------------------------------------------------------------------------
  # * Update Bush Depth
  #--------------------------------------------------------------------------
  def update_bush_depth
    if normal_priority? && !object_character? && bush? && !jumping?
      @bush_depth = 8 unless moving?
    else
      @bush_depth = 0
    end
  end
  #--------------------------------------------------------------------------
  # * Determine if Bush
  #--------------------------------------------------------------------------
  def bush?
    $game_map.bush?(@x, @y)
  end
  #--------------------------------------------------------------------------
  # * Get Terrain Tag
  #--------------------------------------------------------------------------
  def terrain_tag
    $game_map.terrain_tag(@x, @y)
  end
  #--------------------------------------------------------------------------
  # * Get Region ID
  #--------------------------------------------------------------------------
  def region_id
    $game_map.region_id(@x, @y)
  end
  #--------------------------------------------------------------------------
  # * Increase Steps
  #--------------------------------------------------------------------------
  def increase_steps
    set_direction(8) if ladder?
    @stop_count = 0
    update_bush_depth
  end
  #--------------------------------------------------------------------------
  # * Change Graphics
  #     character_name  : new character graphic filename
  #     character_index : new character graphic index
  #--------------------------------------------------------------------------
  def set_graphic(character_name, character_index)
    @tile_id = 0
    @character_name = character_name
    @character_index = character_index
#CUSTSPRITES INIT
if $game_map.map_id != 436 && $game_switches[4182] == true && @character_name != "$protagVR"
  @character_name = "$Void"
  @character_index = 0    
end  
#Pruszka Sprites   
if @character_name == "$Pruszka" && $game_switches[497] == true
  @character_name = "$PruszkaDra"
end  
#knight Traits
   traitK = $game_variables[628]
   if $game_switches[783] == true #classic K
     traitK = 1
   end   
   knight = ""
   if traitK == 2 || traitK == 102 || traitK == 1002 #BattleReady
     knight = "Battle"        
   elsif traitK == 3 || traitK == 103 || traitK == 1003 #Stud
     knight = "Stud"
   elsif traitK == 4 || traitK == 104 || traitK == 1004 #Pacifista
     knight = "Pacifista"        
   elsif traitK == 5 || traitK == 105 || traitK == 1005 #Monster
     knight = "Monster"
   elsif traitK == 6 || traitK == 106 || traitK == 1006 #Beast
     knight = "Beast" 
   elsif traitK == 7 || traitK == 107 || traitK == 1007 #Undead
     knight = "Undead"
   elsif traitK == 8 || traitK == 108 || traitK == 1008 #Wealthy
     knight = "Wealthy"
   elsif traitK == 9 || traitK == 109 || traitK == 1009 #Prince
     knight = "Prince"
   elsif traitK == 10 || traitK == 110 || traitK == 1010 #Stranded
     knight = "Stranded"
   elsif traitK == 11 || traitK == 111 || traitK == 1011 #Testo
     knight = "Testo"     
   elsif traitK == 12 || traitK == 112 || traitK == 1012 #Counsellor
     knight = "Counsellor"          
   elsif traitK == 13 || traitK == 113 || traitK == 1013 #SoulMaster
     knight = "Soul"
   elsif traitK == 14 || traitK == 114 || traitK == 1014 #Necromancer
     knight = "Necro"     
   elsif traitK == 15 || traitK == 115 || traitK == 1015 #Slaver
     knight = "Slaver"     
   elsif traitK == 16 || traitK == 116 || traitK == 1016 #Goddess
     knight = "Goddess"          
   elsif traitK == 17 || traitK == 117 || traitK == 1017 #Chef
     knight = "Chef"   
   elsif traitK == 18 || traitK == 118 || traitK == 1018 #Peasant
     knight = "Peasant"      
   elsif traitK == 19 || traitK == 119 || traitK == 1019 #Houndmaster
     knight = "Hound"      
   elsif traitK == 20 || traitK == 120 || traitK == 1020 #Guild
     knight = "Guild"      
   elsif traitK == 21 || traitK == 121 || traitK == 1021 #Snitch
     knight = "Snitch"             
   elsif traitK == 22 || traitK == 122 || traitK == 1022 #Incubus
     knight = "Incubus"
   elsif traitK == 23 || traitK == 123 || traitK == 1023 #Banker
     knight = "Banker"
   elsif traitK == 24 || traitK == 124 || traitK == 1024 #Mason
     knight = "Mason"
   elsif traitK == 25 || traitK == 125 || traitK == 1025 #Insurgent
     knight = "Insurgent"     
   elsif traitK == 26 || traitK == 126 || traitK == 1026 #Brawler
     knight = "Brawler"
   elsif traitK == 27 || traitK == 127 || traitK == 1027 #Zealot
     knight = "Zealot"       
   elsif traitK == 28 || traitK == 128 || traitK == 1028 #MonsterEater
     knight = "MonsterEater"     
   elsif traitK == 29 || traitK == 129 || traitK == 1029 #Dice
     knight = "Dice"    
   elsif traitK == 30 || traitK == 130 || traitK == 1030 #Dream
     knight = "Dream"      
   elsif traitK == 31 || traitK == 131 || traitK == 1031 #Rabi
     knight = "Rabi"     
   elsif traitK == 32 || traitK == 132 || traitK == 1032 #Magi
     knight = "Magi"     
   elsif traitK == 33 || traitK == 133 || traitK == 1033 #Clockwork
     knight = "Clockwork"      
   end    
  knightAcc = ""
  if $game_actors[1].equips[5] == $data_armors[252]
  knightAcc = "Fish"
     elsif $game_actors[1].equips[5] == $data_armors[230]
  knightAcc = "Pumpkin"
     elsif $game_actors[1].equips[5] == $data_armors[229]
  knightAcc = "Nun"
     elsif $game_actors[1].equips[5] == $data_armors[260] || $game_actors[1].equips[5] == $data_armors[483]
  knightAcc = "Gob"
     elsif $game_actors[1].equips[5] == $data_armors[254]
  knightAcc = "Gas"
end   
    #Kni Sprites - Walking
if @character_name == "$protag"
  if $game_map.map_id == 55 #gho flashback
    @character_name = "$protagSpirit"
  elsif $game_switches[2991] == true
   @character_name = "$RabColony"    
  elsif $game_switches[3778] == true
   @character_name = "$protagSkele"
  elsif $game_map.map_id == 456 #slime end
   @character_name = "$protag"
 else  
  @character_name += knight + knightAcc
     ### SHAD ###
     @shadMaps = [125,531,532,533,535]
     if @shadMaps.include?$game_map.map_id
       character_name = "$protagShadow"
       knight = "Shadow"
     end   
     ### SHAD ###  
end
end
    #Kni Sprites - Kneel
if @character_name == "$protagKneel" && knight != ""
  @character_name = "$protag" + knight
end  
    #Kni Sprites - Fly
if @character_name == "$protagFly"
  @character_name = "$protag" + knight + "Fly"
end  
    #Kni Sprites - Shield
if @character_name == "$protagshield" || @character_name == "$protagShield"
  @character_name = "$protag" + knight + "Shield" + knightAcc
end
    #Kni Sprites - Field
if @character_name == "$protagField%(4)" 
  @character_name = "$protagField" + knightAcc + "%(4)"
end
    #Kni Sprites - Cart
if @character_name == "$protagCart"    
  @character_name = "$protagCart" + knightAcc
end
#WATER NPCS
if @character_name == "$Merchant_Princess"
 if $game_map.map_id == 166
   @character_name = "$Merchant_PrincessBUB"
 end  
end  
#RND Butterflies
if @character_name == "$RNDbutt"
  @character_name = "butterflies"
  @character_index = rand(8)
end 
#TRUE RND
if @character_name == "$trueRND"
  @character_index = 0  
  @character_name = ["$Knocker","$Knight","$Jell","$golem","$Hornet","$Bonehead","$IncubusM","$Ghost","$Gremlin","$MothMage","$CatSidhe","$Hourly","$SFShroudDEC","$Goblin_Musketeer","$Jackalopes","$FinSoldier","$BirdGuard","$OniGuard","$PlaRND"].sample
end       
  #MARM CHANGE
  if @character_name.include? "$Marmalad"
      @character_name = "$Jell"
      if @character_name == "$Marmalad"
      @character_name = "$Jell"
         elsif @character_name == "$MarmaladG"
      @character_name = "$JellG"
         elsif @character_name == "$MarmaladR"
      @character_name = "$JellR"
         elsif @character_name == "$MarmaladB"
      @character_name = "$JellB"
         elsif @character_name == "$MarmaladP"
      @character_name = "$JellP"
         elsif @character_name == "$MarmaladGDMG"
      @character_name = "$JellGDMG"
         elsif @character_name == "$MarmaladRDMG"
      @character_name = "$JellRDMG"
         elsif @character_name == "$MarmaladBDMG"
      @character_name = "$JellBDMG"
         elsif @character_name == "$MarmaladPDMG"
      @character_name = "$JellPDMG"
    end  
  end
 #Jell Sprites 
     if @character_name == "$Jell" || @character_name == "$Marmalad"
      @character_name = "$JellG"
      @character_index = 0
      if $game_switches[3009] == false
       if $game_variables[4063][0] != 0
       if $game_variables[4063][4] == 0
       @character_name = "$JellG"   
    elsif $game_variables[4063][4] == 1
       @character_name = "$JellB"     
    elsif $game_variables[4063][4] == 2
       @character_name = "$JellR"      
    elsif $game_variables[4063][4] == 3
       @character_name = "$JellP"      
       end      
     end        
     end 
   end    
    if @character_name == "$JellDMG" || @character_name == "$MarmaladDMG"
      @character_name = "$JellGDMG"
      @character_index = 0
      if $game_switches[3009] == false
       if $game_variables[4063][0] != 0
       if $game_variables[4063][4] == 0
       @character_name = "$JellGDMG"   
    elsif $game_variables[4063][4] == 1
       @character_name = "$JellBDMG"     
    elsif $game_variables[4063][4] == 2
       @character_name = "$JellRDMG"      
    elsif $game_variables[4063][4] == 3
       @character_name = "$JellPDMG"      
       end      
     end        
     end 
   end   
#RND Mermaid
if @character_name == "$MerRND"
  @a = "MerHeirS"
  @b = rand(4)
if  @b < 1
  @b = "G" 
elsif @b < 2
  @b = "T"
elsif @b < 3
  @b = "B"
elsif @b <= 4
  @b = "P"
end
@c = rand(2)
if  @c < 1
  @c = "GGy" 
else
  @c = "BP"
end  
 @d = rand(5)
if  @d < 1
  @d = "Blk" 
elsif @d < 2
  @d = "Red"
elsif @d < 3
  @d = "Gre"
elsif @d < 4
  @d = "Whi"
elsif @d <= 5
  @d = "Gry"
end  
@character_name = @a + @b + @c + @d
@character_index = rand(8)
end
#RND Bird
if @character_name == "$BirRND" || @character_name == "$BirRNDf" || @character_name == "$BirRNDfNoShad"
  @a = "BirPro"
  @b = ["B","P","Br","R","W","Y","Bk"].sample
  @c = ""
  if @character_name == "$BirRNDf"
    @c = "f"
  elsif @character_name == "$BirRNDfNoShad"
    @c = "fNoShad"
  end  
  @character_name = @a + @b + @c
  @character_index = [0,1,2,3].sample
end   
#RND Fairy
if @character_name == "$FAIRY3"
  @character_name = "$FairyP"
end  
if @character_name == "$FaiRND"
@character_index = rand(4)
@a = "Fairy"
@b = rand(3)
if @b < 1
  @b = "F"
elsif @b < 2
  @b = "C"
elsif @b <= 3
  @b = "M"
end  
@c = rand(3)
if @c < 1
  @c = "P"
elsif @c < 2
  @c = "T"
elsif @c <= 3
  @c = "G"
end  
@d = rand(6)
if @d < 1
  @d = "BBl"  
elsif @d < 2
  @d = "BBl"
  @character_index += 4
elsif @d <= 3
  @d = "GGy"
elsif @d <= 4
  @d = "GGy"
  @character_index += 4
elsif @d <= 5
  @d = "PY"
elsif @d <= 6
  @d = "PY"
  @character_index += 4
end     
@character_name = @a + @b + @c + @d
end  
#RND All
if @character_name == "$SkeGrvRND"
@character_index = 0  
  @r = rand(4)
  if @r < 1
    @character_name = "$SkeGrvB"
  elsif @r < 2
    @character_name = "$SkeGrvG"
  elsif @r < 3
    @character_name = "$SkeGrvGy"
  elsif @r < 4
    @character_name = "$SkeGrvW"
  end
end  
if @character_name == "$nunRND"
@character_index = 0  
  @r = rand(3)
  if @r < 1
    @character_name = "$nun"
  elsif @r < 2
    @character_name = "$nunDra"    
  elsif @r < 3
    @character_name = "$nunLam"
  end
end  
if @character_name == "$nunRNDGh"
@character_index = 0  
  @r = rand(3)
  if @r < 1
    @character_name = "$nunGh"
  elsif @r < 2
    @character_name = "$nunDraGh"   
  elsif @r < 3
    @character_name = "$nunLamGh"
  end
end  
#RND OniUnits
if @character_name == "$OniGuard"
  @r = rand(2) + 1
  if @r < 1
    @character_name = "$ForgeSprite"
  else
    @character_name = "$TriclopWicca"
  end
end   
#RND Dancers
if @character_name == "$DesPdance"
  if $game_variables[4007][0] != 0
    @character_name = "$DancerBla"    
  if $game_variables[4007][5] == 0
    @character_name = "$DancerBro"
     elsif $game_variables[4007][5] == 1
    @character_name = "$DancerBla"
     elsif $game_variables[4007][5] == 2
    @character_name = "$DancerWhi"
     elsif $game_variables[4007][5] == 3
    @character_name = "$DancerPur"
     elsif $game_variables[4007][5] == 4
    @character_name = "$DancerGre"
  end        
end  
end  
if @character_name == "$RNDdancer"
  if $game_variables[3241][5] == 0
    @character_name = "$DancerBro"
     elsif $game_variables[3241][5] == 1
    @character_name = "$DancerBla"
     elsif $game_variables[3241][5] == 2
    @character_name = "$DancerWhi"
     elsif $game_variables[3241][5] == 3
    @character_name = "$DancerPur"
     elsif $game_variables[3241][5] == 4
    @character_name = "$DancerGre"
  end    
end  
#RND Wart Rename
if @character_name == "$Wartomaton"
  @character_name = "$Chimp"
end  
#RND Dra Sold
if @character_name == "$DraSold%(4)" || @character_name == "$dragonQguard%(4)"
         @a = "$Dra"
         @r = rand(5) + 1
       if @r < 1
        @b = "S" 
        elsif @r < 3
        @b = "12"
       elsif @r < 4
        @b = "3" 
      else
        @b = "M" 
      end      
         @r = rand(6) + 1
       if @r < 1
        @c = "Y" 
        elsif @r < 2
        @c = "R"
       elsif @r < 3
        @c = "B" 
      elsif @r < 4
        @c = "G" 
      elsif @r < 5
        @c = "K" 
      else
        @c = "W"         
      end         
        @character_index = 0             
        @character_name = @a + @b + @c
      end  
#RND Kunoichi Cat
if @character_name == "$CatTroops" || @character_name == "$AssTroops"
  @bod = rand(5)
  @sex = rand(2)
  @col = rand(4)
    if @bod == 2 || @bod == 4
        @character_name = "CatHeirT"
      else
        @character_name = "CatHeir"
        end
        if @col == 0
        @character_index = 0  
     elsif @col == 1
        @character_index = 1    
     elsif @col == 2
        @character_index = 2   
     elsif @col >= 3
        @character_index = 3    
      end  
        if @sex == 0
          @character_index += 0
        else
          @character_index += 4
        end     
      end     
 #Oni RND Sprites   
     if @character_name == "$OniRND" 
       @a = "OniHeir"
     @r = rand(5)
     if @r < 2
       @b = "StdF"
     elsif @r < 3
       @b = "SliF"
     elsif @r < 4
       @b = "StdM"
     elsif @r <= 5
       @b = "SliM"
     end  
     @r = rand(5)
     if @r < 1
        @c = "R" 
     elsif @r < 2
        @c = "B"
     elsif @r < 3
        @c = "O" 
     elsif @r < 4
        @c = "Bl" 
     elsif @r <= 5
        @c = "P"               
      end
        @character_index = rand(5)    
        @character_name = @a + @b + @c  
      end     
 #Sha Sprites 
     if @character_name == "$ShadowP" || @character_name == "$ShaHeir"
        @shadMaps = [125,531,532,533,535]
       if @character_name == "$ShaHeir"
         @shadow = 2201
         elsif @character_name == "$ShadowP"
         @shadow = 4031   
      end  
     if @shadow == 4031 && $game_variables[6401][22] == 2 #sha succ
         @character_name = "$ShadowPsuc" 
         @character_index = 0
     elsif @shadow == 4031 && $game_switches[2840] == true #sha alt
        @character_name = "$ShadowPSha"
        @character_index = 0       
     elsif $game_variables[@shadow][0] != 0
        @a = "ShaPro"
        @b = ""
        @c = ""
        if @shadMaps.include?$game_map.map_id
          @a = "ShaPro"
          @b = ""
          @c = ""          
        end  
        @indexStr = [0,0,1,2,3]
        @i = $game_variables[@shadow][3] 
        if @i > 4
          @i = 4
        end  
        @character_index = @indexStr[@i]   
        @character_name = @a + @b + @c
       else #check shadmaps
        if @shadMaps.include?$game_map.map_id
         @character_name = "$ShadowPSha"
         @character_index = 0      
        end  
       end    
     end              
 if @character_name == "$ShadowPShade"
   @shadMaps = [125,531,532,533,535] 
   if @shadMaps.include?$game_map.map_id
     @character_name = "$ShadowPShaShade"
     @character_index = 0      
   end  
 end     
 #PLA RND Sprites   
     if @character_name == "$PlaRND" 
       @a = "PlaHeir"
       @b = ["Woo","W","Y","B","G"].sample
       @c = ["Woo","W","Y","R","G"].sample
        @character_index = [0,1,2,3,4].sample  
        @character_name = @a + @b + @c  
      end      
 #Pla Sprites   
     if @character_name == "$PlantPdug" && $game_switches[3207] == true #pla alt
        @character_name = "$PlantPthodug"
        @character_index = 0       
     end  
     if @character_name == "$PlantP" || @character_name == "$PlaHeir"
       if @character_name == "$PlaHeir"
         @plant = 2200
         elsif @character_name == "$PlantP"
         @plant = 4030   
      end  
     if @plant == 4030 && $game_variables[6401][21] == 2 #pla succ
         @character_name = "$PlantPsuc" 
         @character_index = 0
     elsif @plant == 4030 && $game_switches[3207] == true #pla alt
        @character_name = "$PlantPtho"
        @character_index = 0       
     elsif $game_variables[@plant][0] != 0
       @a = "PlaHeir"
     if $game_variables[@plant][4] == 0   
       @b = "G"
     elsif $game_variables[@plant][4] == 1
       @b = "B"
     elsif $game_variables[@plant][4] == 2
       @b = "Y"       
     elsif $game_variables[@plant][4] == 3
       @b = "W"
     elsif $game_variables[@plant][4] == 4
       @b = "Woo"
     end  
     if $game_variables[@plant][6] == 0   
       @c = "G"
     elsif $game_variables[@plant][6] == 1
       @c = "R"
     elsif $game_variables[@plant][6] == 2
       @c = "Y"       
     elsif $game_variables[@plant][6] == 3
       @c = "W"
     elsif $game_variables[@plant][6] == 4
       @c = "Woo"
     end
        @indexStr = [0,1,4,3,2,5]
        @i = $game_variables[@plant][3] 
        if @i > 5
          @i = 5
        end  
        @character_index = @indexStr[@i]   
        @character_name = @a + @b + @c
       end    
   end        
 #Oni Sprites   
     if @character_name == "$OniP" || @character_name == "$OniHeir"
       if @character_name == "$OniHeir"
         @oni = 2199
         elsif @character_name == "$OniP"
         @oni = 4020   
      end  
     if @oni == 4020 && $game_variables[6401][20] == 2 #oni succ
         @character_name = "$OniPsuc" 
         @character_index = 0
     elsif @oni == 4020 && $game_switches[4613] == true #oni alt
        @character_name = "$OniPten"
        @character_index = 0       
     elsif $game_variables[@oni][0] != 0
        @a = "OniHeir"
     if $game_variables[@oni][3] <= 1   
       @b = "StdF"
     elsif $game_variables[@oni][3] == 2
       @b = "SliF"
     elsif $game_variables[@oni][3] == 3
       @b = "StdM"
     elsif $game_variables[@oni][3] == 4
       @b = "SliM"
     end  
     if $game_variables[@oni][4] == 0
        @c = "R" 
     elsif $game_variables[@oni][4] == 1
        @c = "B"
     elsif $game_variables[@oni][4] == 2
        @c = "O" 
     elsif $game_variables[@oni][4] == 3
        @c = "Bl" 
     elsif $game_variables[@oni][4] == 4
        @c = "P"               
      end
        @character_index = $game_variables[@oni][6]      
        @character_name = @a + @b + @c
       end    
   end            
#Bir Sprites   
     if @character_name == "$BirdP" || @character_name == "$BirdPf" || @character_name == "$BirHeir" || @character_name == "$BirHeirf" || @character_name == "$BirMer" || @character_name == "$BirMerf" || @character_name == "$BirHoused"
      if @character_name == "$BirHoused"      
       @bir = 3332 #safe
     if $game_map.map_id == 480
       @bir = 3331
     elsif $game_map.map_id == 481
       @bir = 3332
     elsif $game_map.map_id == 482
       @bir = 3333
     elsif $game_map.map_id == 483
       @bir = 3334
     end          
     elsif @character_name == "$BirHeir" || @character_name == "$BirHeirf"
         @bir = 2198
       elsif @character_name == "$Bir" || @character_name == "$BirMerf"
         @bir = 7510
         if $game_variables[7512] != 0
         if @id == 10
           if $game_variables[7526] != 0
           @bir = 7512
           end
         elsif @id == 11
           if $game_variables[7527] != 0
           @bir = 7513
           end
         else
         @bir = 7510
         end
         end
     elsif @character_name == "$BirdP" || @character_name == "$BirdPf"
         @bir = 4019
     end  
     if @bir == 4019 && $game_variables[6401][19] == 2
         @character_name = "$BirdPsuc" 
         @character_index = 0 
     else
      if @bir == 4019 && $game_switches[4592] == true #bir alt
       @character_name = "$BirdPfin"
        @character_index = 0       
     elsif $game_variables[@bir][0] != 0
        @a = "BirPro"
     if $game_variables[@bir][4] == 0
        @b = "B" 
     elsif $game_variables[@bir][4] == 1
        @b = "Bk"
     elsif $game_variables[@bir][4] == 2
        @b = "Br" 
     elsif $game_variables[@bir][4] == 3
        @b = "P" 
     elsif $game_variables[@bir][4] == 4
        @b = "R" 
     elsif $game_variables[@bir][4] == 5
        @b = "W" 
     elsif $game_variables[@bir][4] == 6
        @b = "Y"         
      end
      if @character_name == "$BirdPf" || @character_name == "$BirHeirf" || @character_name == "$BirMerf"
        @c = "f"
      else
        @c = ""
      end  
		  if $game_variables[@bir][3] == 0 || $game_variables[@bir][3] == 1 || $game_variables[@bir][3] == 2
        @character_index = 0        
      elsif $game_variables[@bir][3] == 3 || $game_variables[@bir][3] == 4
		    @character_index = 1
      elsif $game_variables[@bir][3] == 5
		    @character_index = 2
      elsif $game_variables[@bir][3] == 6
		    @character_index = 3      
	  	 end            
        @character_name = @a + @b + @c
       end 
     end  
   end   
 #Kob Sprites     
     if @character_name == "$KobP"
       if $game_variables[6401][1] == 2
         @character_name = "$KobPsuc"
         else
       if $game_switches[4120] == true
         @character_name = "$KobPdog"
       else  
     if $game_variables[4001][0] != 0
       @a = "$KobHeir"
        if $game_variables[4001][1] == 0
         @b = "F"
        else
          @b = "M"
        end  
     if $game_variables[4001][4] == 0
        @c = "G"   
     elsif $game_variables[4001][4] == 1
        @c = "B"   
     elsif $game_variables[4001][4] == 2
        @c = "R"   
     elsif $game_variables[4001][4] == 3
        @c = "Y"   
     elsif $game_variables[4001][4] == 4
        @c = "P"   
        end  
        if $game_variables[4001][5] == 3
          @d = "B"
        else
          @d = "L"
        end
        if $game_variables[4001][11] == 1
          @e = "W"
        else
          @e = ""
        end
        @character_index = 0         
        @character_name = @a + @b + @c + @d + @e
       end
     end
   end
   end
 #Knockers Sprites   
     if @character_name == "$Knocker"
      if $game_variables[4061][0] != 0
       @a = "$KobHeir"
        if $game_variables[4061][1] == 0
         @b = "F"
        else
          @b = "M"
        end  
        if $game_variables[4061][4] == 0
        @c = "G"   
     elsif $game_variables[4061][4] == 1
        @c = "B"   
     elsif $game_variables[4061][4] == 2
        @c = "R"   
     elsif $game_variables[4061][4] == 3
        @c = "Y"   
     elsif $game_variables[4061][4] == 4
        @c = "P"   
        end    
        if $game_variables[4061][5] == 3
          @d = "B"
        else
          @d = "L"
        end
        if $game_variables[4061][11] == 1
          @e = "W"
        else
          @e = ""
        end
        @character_index = 0         
        @character_name = @a + @b + @c + @d + @e
      end
      end      
     if @character_name == "$KoboldMiner" || @character_name == "$KoboldMinerUP"
      if $game_variables[4061][0] != 0
        if @character_name == "$KoboldMiner"
       @a = "$KoboldMiner"
        else
       @a = "$KoboldMinerUP"
        end  
        if $game_variables[4061][4] == 0
        @c = "G"   
     elsif $game_variables[4061][4] == 1
        @c = "B"   
     elsif $game_variables[4061][4] == 2
        @c = "R"   
     elsif $game_variables[4061][4] == 3
        @c = "Y"   
     elsif $game_variables[4061][4] == 4
        @c = "P"   
        end  
        @character_index = 0         
        @character_name = @a + @c        
      end
      end            
   #Mer Sprites 
     if @character_name == "$MermaidP" || @character_name == "$MerHeir" || @character_name == "$MerRaider"
       if @character_name == "$MermaidP" 
        @mer = 4018
        @character_name = "$MermaidP"         
        @character_index = 0    
       elsif @character_name == "$MerHeir"
        @mer = 2182
       else
        @mer = 4078
       end 
       if @mer == 4018 && $game_variables[6401][18] == 2
         @character_name = "$MermaidPsuc" 
         @character_index = 0 
       elsif @mer == 4018 && $game_switches[4595] == true #mer alt
        @character_name = "$MermaidPscylla"
        @character_index = 0         
        else         
      if $game_variables[@mer][0] != 0
        @a = "MerHeir"
      ##############
      if $game_variables[@mer][4] == 0 #skin
        @c = "G"  
      elsif $game_variables[@mer][4] == 1
        @c = "T"
      elsif $game_variables[@mer][4] == 2
        @c = "B"
      elsif $game_variables[@mer][4] == 3
        @c = "P"
      end 
      if $game_variables[@mer][5] == 0 #fin
        @d = "Gy"  
      elsif $game_variables[@mer][5] == 1
        @d = "G"
      elsif $game_variables[@mer][5] == 2
        @d = "B"
      elsif $game_variables[@mer][5] == 3
        @d = "P"
      end      
      ##############
      if $game_variables[@mer][3] == 4
        @b = "L"        
        @m = $game_variables[@mer][6]
        @e = ""
      else
        @b = "S"
        @m = 0  
      if $game_variables[@mer][3] == 0 || $game_variables[@mer][3] == 1
        @m = 0  
      elsif $game_variables[@mer][3] == 2
        @m = 2
      elsif $game_variables[@mer][3] == 3
        @m = 1
      elsif $game_variables[@mer][3] == 5
        @m = 3
      end          
      if $game_variables[@mer][5] <= 1
        @d = "GGy"
       if $game_variables[@mer][5] == 1
         @m += 4
       end  
      else
        @d = "BP"
       if $game_variables[@mer][5] == 3
        @m += 4
       end              
      end         
      if $game_variables[@mer][6] == 0
        @e = "Blk"  
      elsif $game_variables[@mer][6] == 1
        @e = "Red"
      elsif $game_variables[@mer][6] == 2
        @e = "Gre"
      elsif $game_variables[@mer][6] == 3
        @e = "Whi"
      elsif $game_variables[@mer][6] == 4
        @e = "Gry"
      end          
      end  
    @character_index = @m    
    @character_name = @a + @b + @c + @d + @e
        end
      end 
    end
#  end      
   #Hum Sprites 
     if @character_name == "$HumanP" || @character_name == "$HumanPshield" || @character_name == "$HumHeir" 
       if @character_name == "$HumHeir" 
         @hum = 2181
       else
         @hum = 4002
        @character_name = "$HumanP"         
        @character_index = 0  
      end  
     if @hum == 4002 && $game_variables[6401][2] == 2
         @character_name = "$HumanPsuc" 
         @character_index = 0 
         else
     if @hum == 4002 && $game_switches[4116] == true #hum porgy
       @character_name = "$HumanPpor"
        @character_index = 0       
      else               
      if $game_variables[@hum][0] != 0
        @a = "$HumHeir"
       if $game_variables[@hum][3] == 0
        @b = "FCur" 
     elsif $game_variables[@hum][3] == 1 || $game_variables[@hum][3] == 2
        @b = "FTon"
     elsif $game_variables[@hum][3] == 3 || $game_variables[@hum][3] == 4
        @b = "M" 
      end
      if $game_variables[@hum][7] ==  2
        @c = "Him"
     elsif $game_variables[@hum][7] == 3 || $game_variables[@hum][7] == 4
        @c = "Sho"
     elsif $game_variables[@hum][7] == 0 || $game_variables[@hum][7] == 1
        @c = "Wav"
        end
      if $game_variables[@hum][4] == 0 || $game_variables[@hum][4] == 1
        @d = "Pal"
     elsif $game_variables[@hum][4] == 2 
        @d = "Tan"
      end     
      if $game_variables[@hum][5] == 4
        @e = "Blo"
     elsif $game_variables[@hum][5] == 2
        @e = "Bla"
     elsif $game_variables[@hum][5] == 3
        @e = "Bro"
     elsif $game_variables[@hum][5] == 1
        @e = "Red"
     elsif $game_variables[@hum][5] == 0
        @e = "Sil"
      end      
        @character_index = 0       
        @character_name = @a + @b + @c + @d + @e
       end 
     end      
   end 
   end
   #Sli Sprites 
   if $game_map.map_id != 456 #slime ending
     if @character_name == "$SliP" || @character_name == "$SliPfaint" || @character_name == "$SliHeir"
       if @character_name == "$SliHeir" 
         @sli = 2182
       else
         @sli = 4003
        @character_name = "$SliP"         
        @character_index = 0
     end  
     if @sli == 4003 && $game_variables[6401][3] == 2
         @character_name = "$SliPsuc" 
         @character_index = 0 
         else
     if @sli == 4003 && $game_switches[2445] == true #slime bubble
       @character_name = "$SliPooz"
       @character_index = 0         
      else         
      if $game_variables[@sli][0] != 0
        @a = "SliHeir"
       if $game_variables[@sli][3] == 3
        @b = "Dumb" 
        @c = ""
       else
        if $game_variables[@sli][1] == 0
          @b = ""
        else
          @b = "M"
        end  
        if $game_variables[@sli][6] == 0
        @c = "Sli"   
     elsif $game_variables[@sli][6] == 1
        @c = "Leg"   
     elsif $game_variables[@sli][6] == 2
        @c = "Ten"   
        end
      end
        @character_index = $game_variables[@sli][4]
        @character_name = @a + @b + @c      
        end
      end 
    end
  end
  end #slime end     
   #Gol Sprites 
     if @character_name == "$golemP" || @character_name == "$golemPOFF" || @character_name == "$GolemHeir"
     if @character_name == "$GolemHeir"
       @gol = 2183
     else
        @gol = 4004
        #@character_name = "$golemP"
        @character_index = 0         
     end  
     if @gol == 4004 && $game_variables[6401][4] == 2
         @character_name = "$golemPsuc" 
         @character_index = 0 
         else
     if @gol == 4004 && $game_switches[2452] == true #golem human
        @character_name = "$golemPlive"
        @character_index = 0              
     elsif @gol == 4004 && $game_switches[2450] == true #golem rock
        @character_name = "$golemProck"
        @character_index = 0           
      else       
       if $game_variables[@gol][0] != 0
        @a = "$Gol"
       if $game_variables[@gol][12] == 4
        @b = "S" 
               else
        if $game_variables[@gol][5] == 1
          @b = "J"
        else
          @b = "T"
        end  
        end
        if $game_variables[@gol][4] == 0
        @c = "O"   
     elsif $game_variables[@gol][4] == 1
        @c = "Br"   
     elsif $game_variables[@gol][4] == 2
        @c = "Bl"   
     elsif $game_variables[@gol][4] == 3
        @c = "B"   
      end  
        @character_index = 0       
        @character_name = @a + @b + @c     
           end
         end 
       end   
       end
   #Ins Sprites 
     if @character_name == "$InsectPrincess" || @character_name == "$InsHeir"
      if @character_name == "$InsHeir"
       @ins = 2184
     else
       @ins = 4005
     end              
     if @ins == 4005 && $game_variables[6401][5] == 2
         @character_name = "$InsectPrincesssuc" 
         @character_index = 0 
       elsif @ins == 4005 && $game_actors[8].state?(29) == true    
         @character_name = "$InsectPrincessHor" 
         @character_index = 0          
       else
      if $game_variables[@ins][0] != 0
        @a = "InsHeir"
        if $game_variables[@ins][3] == 0 || $game_variables[@ins][3] == 3
        @b = "Norm"   
     elsif $game_variables[@ins][3] == 1
        @b = "Bee"   
     elsif $game_variables[@ins][3] == 2
        @b = "Spi"   
     elsif $game_variables[@ins][3] == 4
        @b = "Big"   
      end      
        if $game_variables[@ins][4] == 0
        @character_index = 1  
     elsif $game_variables[@ins][4] == 1
        @character_index = 4    
     elsif $game_variables[@ins][4] == 2
        @character_index = 0   
     elsif $game_variables[@ins][4] == 3
        @character_index = 2    
     elsif $game_variables[@ins][4] == 4
        @character_index = 3   
      end             
         @character_name = @a + @b     
       end
     end
     end
   #Hornet Sprites 
     if @character_name == "$Hornet" || @character_name == "$GHornet" 
       if @character_name == "$Hornet"
         @hor = 4065
       else
         @hor = 4090
       end  
      if $game_variables[@hor][0] != 0
        @a = "InsHeir"
        if $game_variables[@hor][3] == 0 || $game_variables[@hor][3] == 3
        @b = "Norm"   
     elsif $game_variables[@hor][3] == 1
        @b = "Bee"   
     elsif $game_variables[@hor][3] == 2
        @b = "Spi"   
     elsif $game_variables[@hor][3] == 4
        @b = "Big"   
      end      
        if $game_variables[@hor][4] == 0
        @character_index = 1  
     elsif $game_variables[@hor][4] == 1
        @character_index = 4    
     elsif $game_variables[@hor][4] == 2
        @character_index = 0   
     elsif $game_variables[@hor][4] == 3
        @character_index = 2    
     elsif $game_variables[@hor][4] == 4
        @character_index = 3   
      end             
         @character_name = @a + @b     
       end
     end     
    #Ske Sprites 
     if @character_name == "$SkeP" || @character_name == "$SkePspirit" || @character_name == "$SkeBoss" || @character_name == "$SkeHeir" || @character_name == "$SkeCour"
       if @character_name == "$SkeCour"
         @ske = 3217
     elsif @character_name == "$SkeHeir"
         @ske = 2185
     elsif @character_name == "$SkeBoss"
         @ske = 4087
       else
         @ske = 4006
        @character_name = "$SkeP"
        @character_index = 0      
       end
     if @ske == 4006 && $game_variables[6401][6] == 2
         @character_name = "$SkePsuc" 
         @character_index = 0 
         else
      if @ske == 4006 && $game_switches[2395] == true #ske live form
        @character_name = "$SkePlive"
        @character_index = 0      
      else      
      if $game_variables[@ske][0] != 0
        @a = "$Ske"
        if $game_variables[@ske][4] == 0
        @c = "W"
     elsif $game_variables[@ske][4] == 1
        @c = "Gy"
     elsif $game_variables[@ske][4] == 2
        @c = "B"
     elsif $game_variables[@ske][4] == 3
        @c = "G"
      end  
        if $game_variables[@ske][3] == 2
         @b = "Grv"
         @d = ""
       else     
       if $game_variables[@ske][3] == 0
        @b = "F2"
     elsif $game_variables[@ske][3] == 1
        @b = "F4"
     elsif $game_variables[@ske][3] == 3
        @b = "M2"
     elsif $game_variables[@ske][3] == 4
        @b = "M4"
       end       
      if $game_variables[@ske][7] >= 4 && $game_variables[@ske][7] <= 6
        @d = "Hor"
      elsif $game_variables[@ske][7] == 2
        @d = "Hor"
      else  
       if $game_variables[@ske][11] == 0
        @d = "B"
     elsif $game_variables[@ske][11] == 1
        @d = "Bl"
     elsif $game_variables[@ske][11] == 2
        @d = "G"
     elsif $game_variables[@ske][11] == 3
        @d = "P"
      end   
      end
    end
        @character_index = 0     
        @character_name = @a + @b + @c +@d    
      end
     end 
   end
   end
    #Ske Soldiers
     if @character_name == "$Skull"
        @a = "$SkeM2Gy"
        @r = rand(5)
       if @r < 1
        @c = "G"
      else 
        if @r < 2
        @c = "B"
      else    
        if @r < 3
        @c = "Bl"
      else            
        @c = "P"
      end
    end
    end
        @character_index = 0     
        @character_name = @a + @c
    end    
     if @character_name == "$Bonehead"
      if $game_variables[4066][0] != 0
        @a = "$Bonehead"
        if $game_variables[4006][4] == 0
        @c = "W"
     elsif $game_variables[4006][4] == 1
        @c = "Gy"
     elsif $game_variables[4006][4] == 2
        @c = "B"
     elsif $game_variables[4006][4] == 3
        @c = "G"
      end      
        @character_index = 0     
        @character_name = @a + @c
      end
    end
     if @character_name == "$BoneheadElite"
      if $game_variables[4066][0] != 0
        @a = "$BoneheadElite"
        if $game_variables[4006][4] == 0
        @c = "W"
     elsif $game_variables[4006][4] == 1
        @c = "Gy"
     elsif $game_variables[4006][4] == 2
        @c = "B"
     elsif $game_variables[4006][4] == 3
        @c = "G"
      end      
        @character_index = 0     
        @character_name = @a + @c
      end
      end    
    #Des Sprites - guard
     if @character_name == "$DesGuard" || @character_name == "$DesGuardDMG"
        @character_index = 0       
        @a = @character_name
     if $game_variables[4093][5] == 0
        @b = "Br"
     elsif $game_variables[4093][5] == 1
        @b = "B"
     end   
        @character_name = @a + @b
        @character_index = 0 
     end   
     #Des Sprites   
     if @character_name == "$DesP" || @character_name == "$DesHeirF" || @character_name == "$DesHeirM"
     if @character_name == "$DesHeirF" || @character_name == "$DesHeirM"
       @des = 2186
     else  
       @des = 4007
     end       
     if @des == 4007 && $game_variables[6401][7] == 2
         @character_name = "$DesPsuc" 
         @character_index = 0 
         else
      if @des == 4007 && $game_switches[4121] == true
       @character_name = "$DesPdji"
       @character_index = 0
       else
      if $game_variables[@des][0] != 0
        @a = "$DesHeir"
        @b = "N"
       if $game_variables[@des][3] == 0
        @b = "N"
     elsif $game_variables[@des][3] == 1
        @b = "L"
     elsif $game_variables[@des][3] == 2
        @b = "Su"
     elsif $game_variables[@des][3] == 3
        @b = "Sf"
     elsif $game_variables[@des][3] == 4
        @b = "Sm"
       end  
       if $game_variables[@des][4] == 0 || $game_variables[@des][4] == 1
        @c = "T"
     elsif $game_variables[@des][4] == 2
        @c = "W"
     elsif $game_variables[@des][4] == 3
        @c = "P"
      end  
       if $game_variables[@des][5] == 0
        @d = "Br"
     elsif $game_variables[@des][5] == 1
        @d = "B"
     elsif $game_variables[@des][5] == 2
        @d = "W"
     elsif $game_variables[@des][5] == 3
        @d = "P"
     elsif $game_variables[@des][5] == 4
        @d = "G"
      end    
        @character_index = 0       
        @character_name = @a + @b + @c + @d     
        end
      end 
    end    
    end
    #Incubus Sprites 
     if @character_name == "$IncubusM" || @character_name == "$IncubusF" || @character_name == "$DesCourt"  
       if @character_name == "$DesCourt"
         @des = 3219
       else
         @des = 4067
       end  
      if $game_variables[@des][0] != 0
        @a = "$DesHeir"
       if $game_variables[@des][3] == 0
        @b = "N"
     elsif $game_variables[@des][3] == 1
        @b = "L"
     elsif $game_variables[@des][3] == 2
        @b = "Su"
     elsif $game_variables[@des][3] == 3
        @b = "Sf"
     elsif $game_variables[@des][3] == 4
        @b = "Sm"
       end  
       if $game_variables[@des][4] == 0 || $game_variables[@des][4] == 1
        @c = "T"
     elsif $game_variables[@des][4] == 2
        @c = "W"
     elsif $game_variables[@des][4] == 3
        @c = "P"
      end  
       if $game_variables[@des][5] == 0
        @d = "Br"
     elsif $game_variables[@des][5] == 1
        @d = "B"
     elsif $game_variables[@des][5] == 2
        @d = "W"
     elsif $game_variables[@des][5] == 3
        @d = "P"
     elsif $game_variables[@des][5] == 4
        @d = "G"
      end    
        @character_index = 0       
        @character_name = @a + @b + @c + @d     
      end 
    end        
    #Gho Sprites 
     if @character_name == "$GhoP" || @character_name == "$GhostHeir" || @character_name == "$GhoPfollow"
     if @character_name == "$GhostHeir"
       @gho = 2187
     else
       @gho = 4008
        @character_name = "$GhoP"
        @character_index = 0     
     end           
     if @gho == 4008 && $game_variables[6401][8] == 2
         @character_name = "$GhoPsuc" 
         @character_index = 0 
         else
      if @gho == 4008 && $game_switches[2454] == true
        @character_name = "$GhoPlive"
        @character_index = 0    
      else
      if $game_variables[@gho][0] != 0
        @a = "$Gho"
        if $game_variables[@gho][3] == 0 || $game_variables[@gho][3] == 2
        @b = "FN"   
     elsif $game_variables[@gho][3] == 1 || $game_variables[@gho][3] == 5
        @b = "FB"   
     elsif $game_variables[@gho][3] == 3
        @b = "Mega"   
     elsif $game_variables[@gho][3] == 4
        @b = "MN"   
      end  
        if $game_variables[@gho][4] == 0
        @c = "B"   
     elsif $game_variables[@gho][4] == 1
        @c = "G"   
     elsif $game_variables[@gho][4] == 2
        @c = "P"   
     elsif $game_variables[@gho][4] == 3
        @c = "Pi"   
     elsif $game_variables[@gho][4] == 4
        @c = "T"   
      end       
        @character_index = 0       
         @character_name = @a + @b + @c  
       end
   end      
 end
 end
     # GHOST
     if @character_name == "$Ghost"
       if @character_name == "$Ghost"
         @gho = 4068
       end
      if $game_variables[@gho][0] != 0
        @a = "$Gho"
        if $game_variables[@gho][3] == 0 || $game_variables[@gho][3] == 2
        @b = "FN"   
     elsif $game_variables[@gho][3] == 1 || $game_variables[@gho][3] == 5
        @b = "FB"   
     elsif $game_variables[@gho][3] == 3
        @b = "Mega"   
     elsif $game_variables[@gho][3] == 4
        @b = "MN"   
      end  
        if $game_variables[@gho][4] == 0
        @c = "B"   
     elsif $game_variables[@gho][4] == 1
        @c = "G"   
     elsif $game_variables[@gho][4] == 2
        @c = "P"   
     elsif $game_variables[@gho][4] == 3
        @c = "Pi"   
     elsif $game_variables[@gho][4] == 4
        @c = "T"   
      end      
        @character_index = 0       
         @character_name = @a + @b + @c  
       end 
     end     
   #Gob Sprites 
     if @character_name == "$GoblinP" || @character_name == "$GobHeir"
     if @character_name == "$GobHeir"
       @gob = 2188
     else
       @gob = 4009
     end     
     if @gob == 4009 && $game_variables[6401][9] == 2
         @character_name = "$GoblinPsuc" 
         @character_index = 0 
     elsif @gob == 4009 && $game_actors[14].state?(28) == true    
         @character_name = "$GoblinPgre" 
         @character_index = 0 
     else
      if $game_variables[@gob][0] != 0
        @a = "GobHeir"
        if $game_variables[@gob][4] == 0
        @c = "G"   
     elsif $game_variables[@gob][4] == 1
        @c = "B"   
     elsif $game_variables[@gob][4] == 2
        @c = "P"   
     elsif $game_variables[@gob][4] == 3
        @c = "Bl"   
      end
        if $game_variables[@gob][5] == 0
        @character_index = 0   
     elsif $game_variables[@gob][5] == 1
        @character_index = 1 
     elsif $game_variables[@gob][5] == 2
        @character_index = 2   
     elsif $game_variables[@gob][5] == 3
        @character_index = 3
      end     
        if $game_variables[@gob][3] == 2
        @b = "B"
        else
        @b = ""
         if $game_variables[@gob][1] == 0
          @character_index += 0
        else
          @character_index += 4
        end    
        end
         @character_name = @a + @b + @c  
       end   
     end
     end
   #Gremlin Sprites 
     if @character_name == "$Gremlin" || @character_name == "$Goblin_Musketeer" || @character_name == "$GobCour" || @character_name == "$Goblin_Auctioneer" || @character_name == "$GoblinEliteSold"
       if @character_name == "$Gremlin"
         @v = 4069
     elsif @character_name == "$GobCour"
       @v = 3216
     elsif @character_name == "$Goblin_Musketeer"
         @v = 4084
     elsif @character_name == "$Goblin_Auctioneer"
         @v = 3188
     elsif @character_name == "$GoblinEliteSold"
         @v = 4089
       end           
      if $game_variables[@v][0] != 0
        @a = "GobHeir"
        if $game_variables[@v][4] == 0
        @c = "G"   
     elsif $game_variables[@v][4] == 1
        @c = "B"   
     elsif $game_variables[@v][4] == 2
        @c = "P"   
     elsif $game_variables[@v][4] == 3
        @c = "Bl"   
      end
        if $game_variables[@v][5] == 0
        @character_index = 0   
     elsif $game_variables[@v][5] == 1
        @character_index = 1 
     elsif $game_variables[@v][5] == 2
        @character_index = 2   
     elsif $game_variables[@v][5] == 3
        @character_index = 3
      end     
        if $game_variables[@v][3] == 2
        @b = "B"
        else
        @b = ""
         if $game_variables[@v][1] == 0
          @character_index += 0
        else
          @character_index += 4
        end    
        end
         @character_name = @a + @b + @c  
       end  
     end     
     #Moth Sprites 
     if @character_name == "$MothP" || @character_name == "$MothHeir" || @character_name == "$MothCou"
      if @character_name == "$MothHeir"
       @mot = 2189
     elsif @character_name == "$MothCou"
       @mot = 3311
     else  
       @mot = 4010
        @character_name = "$MothP"
        @character_index = 0        
     end         
     if @mot == 4010 && $game_variables[6401][10] == 2
         @character_name = "$MothPsuc" 
         @character_index = 0 
         else
      if @mot == 4010 && $game_switches[4118] == true
        @character_name = "$MothPfai"
        @character_index = 0 
      elsif @mot == 4010 && $game_switches[2460] == true  
        @character_name = "$MothPbut"
        @character_index = 0         
     else     
      if $game_variables[@mot][0] != 0
        @a = "MothHeir"
        if $game_variables[@mot][5] == 0
        @character_index = 0   
     elsif $game_variables[@mot][5] == 1
        @character_index = 1 
     elsif $game_variables[@mot][5] == 2
        @character_index = 2   
     elsif $game_variables[@mot][5] == 3
        @character_index = 3
      end     
       if $game_variables[@mot][3] == 3
        @character_name = "CPillar" 
        @b = ""
       else
        if $game_variables[@mot][4] == 3
          @character_index += 4
        else
          @character_index += 0
        end    
       if $game_variables[@mot][3] == 0 || $game_variables[@mot][3] == 4
        @b = "Std" 
     elsif $game_variables[@mot][3] == 1
        @b = "Plu" 
     elsif $game_variables[@mot][3] == 2
        @b = "Sl" 
      end      
        end
         @character_name = @a + @b
       end
       end
     end   
     end
     #Moth Units Sprites 
     if @character_name == "$MothMage"
      if $game_variables[4070][0] != 0
        @a = "MothHeir"
        if $game_variables[4070][5] == 0
        @character_index = 0   
     elsif $game_variables[4070][5] == 1
        @character_index = 1 
     elsif $game_variables[4070][5] == 2
        @character_index = 2   
     elsif $game_variables[4070][5] == 3
        @character_index = 3
      end     
       if $game_variables[4070][3] == 3
        @character_name = "CPillar" 
        @b = ""
       else
        if $game_variables[4070][4] == 3
          @character_index += 0
        else
          @character_index += 4
        end    
       if $game_variables[4070][3] == 0 || $game_variables[4070][3] == 4
        @b = "Std" 
     elsif $game_variables[4070][3] == 1
        @b = "Plu" 
     elsif $game_variables[4070][3] == 2
        @b = "Sl" 
      end      
        end
         @character_name = @a + @b
       end
      end     
  #CatFighter Sprites     
     if @character_name == "$CatFighter"
       @cat = 2190
       @a = "$CatFighter"
       @b = "P"
        if $game_variables[@cat][4] == 0
        @b = "P"  
     elsif $game_variables[@cat][4] == 1
        @b = "B"   
     elsif $game_variables[@cat][4] == 2
        @b = "Y"   
     elsif $game_variables[@cat][4] == 3
        @b = "W"
      end  
       @character_name = @a + @b
     end
    #Cat Sprites 
     if @character_name == "$CatP" || @character_name == "$CatHeir" || @character_name == "$CatCourt" 
      if @character_name == "$CatHeir"
       @cat = 2190
     elsif @character_name == "$CatCourt" 
       @cat = 3309
       else
       @cat = 4011
     end        
     if @cat == 4011 && $game_variables[6401][11] == 2
         @character_name = "$CatPsuc" 
         @character_index = 0 
         else
      if @cat == 4011 && $game_switches[2340] == true
        @character_name = "$CatPmata"
        @character_index = 0 
     else        
     if @cat == 4011 && $game_switches[4115] == true
        @character_name = "$CatPfish"
        @character_index = 0 
     else   
      if $game_variables[@cat][0] != 0
        if $game_variables[@cat][3] == 2 || $game_variables[@cat][3] == 4
        @character_name = "CatHeirT"
      else
        @character_name = "CatHeir"
        end
        if $game_variables[@cat][4] == 0
        @character_index = 0  
     elsif $game_variables[@cat][4] == 1
        @character_index = 1    
     elsif $game_variables[@cat][4] == 2
        @character_index = 2   
     elsif $game_variables[@cat][4] == 3
        @character_index = 3    
      end  
        if $game_variables[@cat][1] == 0
          @character_index += 0
        else
          @character_index += 4
        end  
      end
    end
  end
end
end
  #Sidhe Sprites      
     if @character_name == "$CatSidhe"
      if $game_variables[4071][0] != 0
        if $game_variables[4071][3] == 2 || $game_variables[4071][3] == 4
        @character_name = "CatHeirT"
      else
        @character_name = "CatHeir"
        end
        if $game_variables[4071][4] == 0
        @character_index = 0  
     elsif $game_variables[4071][4] == 1
        @character_index = 1    
     elsif $game_variables[4071][4] == 2
        @character_index = 2   
     elsif $game_variables[4071][4] == 3
        @character_index = 3    
      end  
        if $game_variables[4071][1] == 0
          @character_index += 0
        else
          @character_index += 4
        end  
      end
    end    
 #Dog Sprites 
     if @character_name == "$DogP" || @character_name == "$DogPrunningcalm%(4)" || @character_name == "$DogPrunning%(4)" || @character_name == "$Dog_Princess_Sleeping"
     if $game_variables[6401][12] == 2
         @character_name = "$DogPsuc" 
         @character_index = 0 
         else
      if $game_switches[2338] == true
         @character_name = "$DogPshi"
         @character_index = 0
       else  
       if $game_variables[4012][0] != 0
        @a = "DogHeir"
        if $game_variables[4012][4] == 0
        @character_index = 1  
     elsif $game_variables[4012][4] == 1
        @character_index = 2    
     elsif $game_variables[4012][4] == 2
        @character_index = 3   
     elsif $game_variables[4012][4] == 3
        @character_index = 4    
     elsif $game_variables[4012][4] == 4
        @character_index = 0   
      end          
       if $game_variables[4012][1] == 1
        @b = "M" 
      else
        if $game_variables[4012][3] == 0
          @b = "FW"
        else
          @b = "F"
        end           
      end
        @character_name = @a + @b     
      end 
      end
    end  
    end
#Mou Sprites 
     if @character_name == "$MouseP" || @character_name == "$Hourly" || @character_name == "$
       eir"
       if @character_name == "$MouHeir"
       @mou = 2192  
     end 
       if @character_name == "$MouseP"
       @mou = 4013  
        @character_index = 0         
        @character_name = "$MouseP" 
     end 
       if @character_name == "$Hourly"
       @mou = 4085 
     end         
     if @mou == 4013 && $game_variables[6401][13] == 2
         @character_name = "$MousePsuc" 
         @character_index = 0 
         else
      if @mou == 4013 && $game_switches[4117] == true
        @character_index = 0         
        @character_name = "$MouseProb" 
     else     
      if $game_variables[@mou][0] != 0
        @a = "$MouHeir"
        # MOU SAVE        
        if $game_variables[@mou][3] >= 5
          if $game_variables[@mou][1] == 0
          $game_variables[@mou][3] = 0
        else
          $game_variables[@mou][3] = 3
          end
        end  
        # MOU SAVE
        if $game_variables[@mou][3] == 1
          @b = "FJ"
     elsif $game_variables[@mou][3] == 3 || $game_variables[@mou][3] == 4
          @b = "M"
     elsif $game_variables[@mou][3] == 0
          @b = "F"
     elsif $game_variables[@mou][3] == 2
          @b = "FW"
        end             
        if $game_variables[@mou][4] == 0
          @c = "W"
     elsif $game_variables[@mou][4] == 1
          @c = "G"
     elsif $game_variables[@mou][4] == 2
          @c = "O"
     elsif $game_variables[@mou][4] == 3
          @c = "B"
     elsif $game_variables[@mou][4] == 4
          @c = "P"
        end  
        if $game_variables[@mou][11] == 0
          @d = "Y"
     elsif $game_variables[@mou][11] == 1
          @d = "G"
     elsif $game_variables[@mou][11] == 2
          @d = "Br"
     elsif $game_variables[@mou][11] == 3
          @d = "B"
        end 
        @character_index = 0         
        @character_name = @a + @b + @c + @d             
        end 
      end 
    end    
    end
 #RabP Sprites   
     if @character_name == "$RabbitP" || @character_name == "$RabHeir" || @character_name == "$RabCourt"
     if @character_name == "$RabHeir"
       @rab = 2193 
     else 
     if @character_name == "$RabCourt"
       @rab = 3215 
     else        
       @rab = 4014 
     end
   end
     if @rab == 4014 && $game_variables[6401][14] == 2
         @character_name = "$RabbitPsuc" 
         @character_index = 0 
     elsif @rab == 4014 && $game_switches[3014] == true
         @character_name = "$RabbitPmoon" 
         @character_index = 0 
     else
      if $game_variables[@rab][0] != 0
        @a = "$RabHeir"
        if $game_variables[@rab][3] == 1
          @b = "FCur"
     elsif $game_variables[@rab][3] == 3
          @b = "MCur"
     elsif $game_variables[@rab][3] == 0 || $game_variables[@rab][3] == 2
          @b = "FStd"
     elsif $game_variables[@rab][3] == 4
          @b = "MStd"
        end             
        if $game_variables[@rab][4] == 0
          @c = "P"
     elsif $game_variables[@rab][4] == 1
          @c = "G"
     elsif $game_variables[@rab][4] == 2
          @c = "R"
     elsif $game_variables[@rab][4] == 3
          @c = "B"
     elsif $game_variables[@rab][4] == 4
          @c = "W"
        end         
        @character_index = 0        
        @character_name = @a + @b + @c
      end 
    end 
    end
 #Jackal Sprites 
     if @character_name == "$Jackalopes"
      if $game_variables[4074][0] != 0
        @a = "$RabHeir"
        if $game_variables[4074][3] == 1
          @b = "FCur"
     elsif $game_variables[4074][3] == 3
          @b = "MCur"
     elsif $game_variables[4074][3] == 0 || $game_variables[4074][3] == 2
          @b = "FStd"
     elsif $game_variables[4074][3] == 4
          @b = "MStd"
        end             
        if $game_variables[4074][4] == 0
          @c = "P"
     elsif $game_variables[4074][4] == 1
          @c = "G"
     elsif $game_variables[4074][4] == 2
          @c = "R"
     elsif $game_variables[4074][4] == 3
          @c = "B"
     elsif $game_variables[4074][4] == 4
          @c = "W"
        end         
        @character_index = 0        
        @character_name = @a + @b + @c
      end 
    end     
 #Har Sprites 
     if @character_name == "$HarvestP" || @character_name == "$HarHeir"
     if @character_name == "$HarHeir"
       @har = 2194 
     else 
       @har = 4015
     end         
     if @har == 4015 && $game_variables[6401][15] == 2
         @character_name = "$HarvestPsuc" 
         @character_index = 0 
         else
      if @har == 4015 && $game_switches[4119] == true
       @character_name = "$HarvestPwol"
       @character_index = 0
     else
      if $game_variables[@har][0] != 0
        @a = "$HumHeir"
       if $game_variables[@har][3] == 0
        @b = "FCur" 
     elsif $game_variables[@har][3] == 1 || $game_variables[@har][3] == 2
        @b = "FTon"
     elsif $game_variables[@har][3] == 3 || $game_variables[@har][3] == 4
        @b = "M" 
      end
      if $game_variables[@har][7] ==  2
        @c = "Him"
     elsif $game_variables[@har][7] == 3 || $game_variables[@har][7] == 4
        @c = "Sho"
     elsif $game_variables[@har][7] == 0 || $game_variables[@har][7] == 1
        @c = "Wav"
      end 
      if $game_variables[@har][4] == 0 || $game_variables[@har][4] == 1
        @d = "Pal"
     elsif $game_variables[@har][4] == 2 
        @d = "Tan"
      end
      if $game_variables[@har][5] == 4
        @e = "Blo"
     elsif $game_variables[@har][5] == 2
        @e = "Bla"
     elsif $game_variables[@har][5] == 3
        @e = "Bro"
     elsif $game_variables[@har][5] == 1
        @e = "Red"
     elsif $game_variables[@har][5] == 0
        @e = "Sil"
      end      
  @character_index = 0      
        @character_name = @a + @b + @c + @d + @e
        end
      end 
    end 
    end
  # Finhead Sprites
     if @character_name == "$FinheadP" || @character_name == "$FinHeir" || @character_name == "$FinHoused" || @character_name == "$FinCourt"
       if @character_name == "$FinHoused"
       @fin = 3279 #safe
       if $game_map.map_id == 413
       @fin = 3279
     elsif $game_map.map_id == 416
       @fin = 3280
     elsif $game_map.map_id == 418
       @fin = 3281
     elsif $game_map.map_id == 417
       @fin = 3282
     elsif $game_map.map_id == 420
       @fin = 3283
     elsif $game_map.map_id == 419
       @fin = 3284
     elsif $game_map.map_id == 422
       @fin = 3285
     elsif $game_map.map_id == 421
       @fin = 3286
     elsif $game_map.map_id == 415
       @fin = 3287
     end     
    end
     if @character_name == "$FinHeir"
       @fin = 2196
     end 
       if @character_name == "$FinCourt"
       @fin = 3220
     end
     if @character_name == "$FinheadP"
       @fin = 4017
     end
      if @fin == 4017 && $game_switches[4593] == true #fin alt
       @character_name = "$FinheadPbir"
        @character_index = 0            
     elsif @fin == 4017 && $game_variables[6401][17] == 2
         @character_name = "$FinheadPsuc%(4)" 
         @character_index = 0 
         else
      if $game_variables[@fin][0] != 0
        @a = "FinHeir"
       @character_index = 0        
      if $game_variables[@fin][4] == 0
        @b = "B"
     elsif $game_variables[@fin][4] == 1
        @b = "R"
     elsif $game_variables[@fin][4] == 2
        @b = "G"
     elsif $game_variables[@fin][4] == 3
        @b = "W"
     elsif $game_variables[@fin][4] == 4
        @b = "T"
      end        
   if $game_variables[@fin][5] == 0 #FIN BLUE
     @c = "B"
     elsif $game_variables[@fin][5] == 1 #FIN RED
     @c = "R"  
     elsif $game_variables[@fin][5] == 2 #FIN GREEN
     @c = "G"  
     elsif $game_variables[@fin][5] == 3 #FIN PINK
     @c = "W"  
     elsif $game_variables[@fin][5] == 4 #FIN YELLOW
     @c = "Y"  
     elsif $game_variables[@fin][5] == 5 #FIN PURPLE
     @c = "P"  
   end    
        @character_index = $game_variables[@fin][3]
        @character_name = @a + @b + @c
      end 
    end
    end
  #Drider Sprites
     if @character_name == "$DRIDER" || @character_name == "$DRIDERgoss"
      if $game_variables[4021][0] != 0
        @a = "$Dri"
       if $game_variables[4021][3] == 0 || $game_variables[4021][3] == 1
        @b = "Std" 
     elsif $game_variables[4021][3] == 2
        @b = "Ush"
     elsif $game_variables[4021][3] == 3
        @b = "Hum" 
     elsif $game_variables[4021][3] == 4
        @b = "Jum"
      end      
      if $game_variables[4021][4] == 0
        @c = "P"
      elsif $game_variables[4021][4] == 1
        @c = "V"
     elsif $game_variables[4021][4] == 2 
        @c = "W"     
     elsif $game_variables[4021][4] == 3
        @c = "G"
     elsif $game_variables[4021][4] == 4 
        @c = "K"     
      end       
      if $game_variables[4021][5] == 0
        @d = "P"
     elsif $game_variables[4021][5] == 1
        @d = "Gr"
     elsif $game_variables[4021][5] == 2
        @d = "W"
     elsif $game_variables[4021][5] == 3
        @d = "G"
     elsif $game_variables[4021][5] == 4
        @d = "K"
      end 
    @character_index = 0      
        @character_name = @a + @b + @c + @d
      end 
    end        
  #Lamia Sprites 
     if @character_name == "$LamiaP"
      if $game_variables[4022][0] != 0
        @a = "$Lamia"
       if $game_variables[4022][3] == 0
        @b = "P" 
     elsif $game_variables[4022][3] == 1
        @b = "S"
     elsif $game_variables[4022][3] == 2
        @b = "C"
     elsif $game_variables[4022][3] == 3
        @b = "G" 
     elsif $game_variables[4022][3] == 4
        @b = "M"
      end      
      if $game_variables[4022][4] == 0
        @c = "H"
     elsif $game_variables[4022][4] == 1
        @c = "T"
     elsif $game_variables[4022][4] == 2 
        @c = "P"     
      end 
      if $game_variables[4022][5] == 0
        @d = "R"
     elsif $game_variables[4022][5] == 1
        @d = "Gy"
     elsif $game_variables[4022][5] == 2
        @d = "G"
     elsif $game_variables[4022][5] == 3
        @d = "P"
     elsif $game_variables[4022][5] == 4
        @d = "W"
      end 
       if $game_variables[4022][3] == 3
        @e = "" 
      else
      if $game_variables[4022][11] == 0
        @e = "P"
     elsif $game_variables[4022][11] == 1
        @e = "B"
     elsif $game_variables[4022][11] == 2
        @e = "K"
     elsif $game_variables[4022][11] == 3
        @e = "G"
     elsif $game_variables[4022][11] == 4
        @e = "S"
      end         
      end      
  @character_index = 0      
        @character_name = @a + @b + @c + @d + @e
      end 
 end     
  #Shroud Sprites 
     if @character_name == "$SFShroudDEC" || @character_name == "$SFShroudSOFT"
       if @character_name == "$SFShroudDEC"
         @prog = 4082
       end
       if @character_name == "$SFShroudSOFT"
         @prog = 4083
       end  
           if $game_variables[@prog][0] != 0
        @a = "$Lamia"
       if $game_variables[@prog][3] == 3
        @b = "G" 
     elsif $game_variables[@prog][3] == 4
        @b = "M"
      else
       if $game_variables[@prog][7] == 0
        @b = "C" 
     elsif $game_variables[@prog][7] == 1
        @b = "P"
     elsif $game_variables[@prog][7] >= 2
        @b = "S"
        end          
      end
      end
      if $game_variables[@prog][4] == 0
        @c = "H"
     elsif $game_variables[@prog][4] == 1
        @c = "T"
     elsif $game_variables[@prog][4] == 2 
        @c = "P"     
      end 
      if $game_variables[@prog][5] == 0
        @d = "R"
     elsif $game_variables[@prog][5] == 1
        @d = "Gy"
     elsif $game_variables[@prog][5] == 2
        @d = "G"
     elsif $game_variables[@prog][5] == 3
        @d = "P"
     elsif $game_variables[@prog][5] == 4
        @d = "W"
      end 
       if $game_variables[@prog][3] == 3
        @e = "" 
      else
      if $game_variables[@prog][11] == 0
        @e = "P"
     elsif $game_variables[@prog][11] == 1
        @e = "B"
     elsif $game_variables[@prog][11] == 2
        @e = "K"
     elsif $game_variables[@prog][11] == 3
        @e = "G"
     elsif $game_variables[@prog][11] == 4
        @e = "S"
      end              
        @character_index = 0      
        @character_name = @a + @b + @c + @d + @e
      end 
    end     
 #Dra Sprites 
    @v = 0
    if @character_name == "$DraCarriage"
       @v = 7511
       @d = "" 
    elsif @character_name == "$DraCarriagef" 
       @v = 7511
      if $game_variables[@v][1] == 0
        @d = "f" 
      else
        @d = ""
      end      
    elsif @character_name == "$CourtInBir" 
       @v = 7520
       @d = "" 
     elsif @character_name == "$WyvPf" || @character_name == "$WyvPfNoShad"
       @v = 4016
       @d = "f" 
     elsif @character_name == "$DraPFly" || @character_name == "$DraPFlyNoShad"
       @v = 4026
       @d = "f"
     elsif @character_name == "$DraPIIFly" || @character_name == "$DraPIIFlyNoShad"
       @v = 4027  
       @d = "f"       
     elsif @character_name == "$DQamb"
       @v = 3278
       @d = ""       
     elsif @character_name == "$WyvP"
       @v = 4016
       @d = ""       
     elsif @character_name == "$DraP" || @character_name == "$DraP_Kneeling"
       @v = 4026
       @d = ""       
     elsif @character_name == "$DraPII"
       @v = 4027
       @d = ""              
     elsif @character_name == "$DraPIII"
       @v = 4028      
       @d = ""              
     end
     if @v > 0
     if @v == 4016 && $game_variables[6401][16] == 2
         @character_name = "$WyvPsuc" 
         @character_index = 0 
         else
      if $game_variables[@v][0] != 0 && @v >= 3278
       @a = "$Dra"
       if $game_variables[@v][3] == 0
        @b = "S" 
        @d = ""
     elsif $game_variables[@v][3] == 1 || $game_variables[@v][3] == 2
        @b = "12"
     elsif $game_variables[@v][3] == 3
        @b = "3" 
     elsif $game_variables[@v][3] == 4
        @b = "M" 
     elsif $game_variables[@v][3] == 5
        @b = "4" 
      end       
      if $game_variables[@v][4] == 0
        @c = "Y"
     elsif $game_variables[@v][4] == 1
        @c = "R"
     elsif $game_variables[@v][4] == 2 
        @c = "B"
     elsif $game_variables[@v][4] == 3
        @c = "G"
     elsif $game_variables[@v][4] == 4
        @c = "K"
     elsif $game_variables[@v][4] == 5
        @c = "W"
      end   
        @character_index = 0             
        @character_name = @a + @b + @c + @d
      end 
     end   
   end    
   #CUSTSPRITES END  
   @original_pattern = 1
  end
  #--------------------------------------------------------------------------
  # * Determine Triggering of Frontal Touch Event
  #--------------------------------------------------------------------------
  def check_event_trigger_touch_front
    x2 = $game_map.round_x_with_direction(@x, @direction)
    y2 = $game_map.round_y_with_direction(@y, @direction)
    check_event_trigger_touch(x2, y2)
  end
  #--------------------------------------------------------------------------
  # * Determine if Touch Event is Triggered
  #--------------------------------------------------------------------------
  def check_event_trigger_touch(x, y)
    return false
  end
  #--------------------------------------------------------------------------
  # * Move Straight
  #     d:        Direction (2,4,6,8)
  #     turn_ok : Allows change of direction on the spot
  #--------------------------------------------------------------------------
  def move_straight(d, turn_ok = true)
    @move_succeed = passable?(@x, @y, d)
    if @move_succeed
      set_direction(d)
      @x = $game_map.round_x_with_direction(@x, d)
      @y = $game_map.round_y_with_direction(@y, d)
      @real_x = $game_map.x_with_direction(@x, reverse_dir(d))
      @real_y = $game_map.y_with_direction(@y, reverse_dir(d))
      increase_steps
    elsif turn_ok
      set_direction(d)
      check_event_trigger_touch_front
    end
  end
  #--------------------------------------------------------------------------
  # * Move Diagonally
  #     horz:  Horizontal (4 or 6)
  #     vert:  Vertical (2 or 8)
  #--------------------------------------------------------------------------
  def move_diagonal(horz, vert)
    @move_succeed = diagonal_passable?(x, y, horz, vert)
    if @move_succeed
      @x = $game_map.round_x_with_direction(@x, horz)
      @y = $game_map.round_y_with_direction(@y, vert)
      @real_x = $game_map.x_with_direction(@x, reverse_dir(horz))
      @real_y = $game_map.y_with_direction(@y, reverse_dir(vert))
      increase_steps
    end
    set_direction(horz) if @direction == reverse_dir(horz)
    set_direction(vert) if @direction == reverse_dir(vert)
  end
end
