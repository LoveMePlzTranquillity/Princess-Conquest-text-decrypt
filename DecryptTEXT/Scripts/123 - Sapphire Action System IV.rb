#-------------------------------------------------------------------------------
# * [ACE] Sapphire Action System IV
#-------------------------------------------------------------------------------
# * By Khas Arcthunder - arcthunder.site40.net
# * Version: 4.4 EN
# * Released on: 11/07/2012
#
#-------------------------------------------------------------------------------
# * Terms of Use
#-------------------------------------------------------------------------------
# Terms of Use – June 22, 2012
# 1. You must give credit to Khas;
# 2. All Khas scripts are licensed under a Creative Commons license
# 3. All Khas scripts are free for non-commercial projects. If you need some 
#    script for your commercial project, check bellow these terms which 
#    scripts are free and which scripts are paid for commercial use;
# 4. All Khas scripts are for personal use, you can use or edit for your own 
#    project, but you are not allowed to post any modified version;
# 5. You can’t give credit to yourself for posting any Khas script;
# 6. If you want to share a Khas script, don’t post the script or the direct 
#    download link, please redirect the user to http://arcthunder.site40.net/
# 7. You are not allowed to convert any of Khas scripts to another engine, 
#    such converting a RGSS3 script to RGSS2 or something of that nature.
# 8. Its your obligation (user) to check these terms on the date you release 
#    your game. Your project must follow them correctly.
#
# Free commercial use scripts:
# - Sapphire Action System IV (RPG Maker VX Ace)
# - Awesome Light Effects (RPG Maker VX Ace)
# - Pixel movement (RPG Maker VX e RPG Maker VX Ace)
# - Sprite & Window Smooth Sliding (RPG Maker VX e RPG Maker VX Ace)
# - Pathfinder (RPG Maker VX Ace)
#
# Check all the terms at http://arcthunder.site40.net/terms/
#
#-------------------------------------------------------------------------------
# * Features
#-------------------------------------------------------------------------------
# The Sapphire Action System IV includes the following features:
# - Pixel Movement
# - Khas Particle Engine powered
# - Realistic collisions
# - Awesome jogability
# - High customization level
# - Weapon Icon
# - Easy to use
# - Skill support
# - Lag free
# - Damage Sprite system
# - Optimized HUD
# - Voice support
# - And more...
#
#-------------------------------------------------------------------------------
# * Instructions
#-------------------------------------------------------------------------------
# All the instructions are on SAS IV guide. Please read them carefully.
#
#-------------------------------------------------------------------------------
# * How to use
#-------------------------------------------------------------------------------
# 1. Physics System
# In order to run this script with the best performance, there's a system 
# called "Physics". This system will load each map between the transitions,
# so you may experience little loadings. The Khas Pixel Movement is not 
# recommended for huge maps.
#
# 2. Event Commands (place a comment)
# There are two special commands for events, you may add a comment with
# the following sintax:
#
# a. [collision_x A]
# This command sets the x collision to A (A must be an integer)
#
# b. [collision_y B]
# This command sets the y collision to B (B must be an integer)
#
# Please check the demo to understand how the collision system works!
#
# 3. Event Commands (call script)
# You can call the following commands for the player or the events
#
# character.px
# This command returns the pixel coordinate X (4 px = 1 tile)
#
# character.py
# This command returns the pixel coordinate Y (4 py = 1 tile)
#
# character.pixel_passable?(px,py,d)
# This command checks the pixel passability from (px, py) to the direction d.
# 
# 4. Map Commands
# You can call a special command to update the passability of the current
# map. You MUST run this command if the option "Auto_Refresh_Tile_Events"
# is set to false.
#
# "But when do I need to use this command?"
# Well, if you change a event graphic to a tileset graphic, or if you remove
# this event graphic, then your map need to be updated!
#
# $game_map.refresh_table(start_x,start_y,end_x,end_y)
#
# Where:
# start_x => Initial X
# start_y => Initial Y
# end_x => End X
# end_y => End Y
#
#-------------------------------------------------------------------------------
# * Warning!
#-------------------------------------------------------------------------------
# Check your tileset directions. If any direction is set as unpassable, the
# system will set the whole tile as unpassable. Setup your tilesets before
# using them!
#
#-------------------------------------------------------------------------------
# * Setup Part (Sapphire Engine)
#-------------------------------------------------------------------------------
module Sapphire_Core
  
  # Enable voice?
  Enable_Voice = true
  
  # Voice files (separated by commas)
  Voice_Files = []
  
  # Voice volume
  Voice_Volume = 70
  
  # Disarmed animation
  Default_Animation = 1
  
  # Default recover time
  Default_Recover = 60
  
  # Switch that will be activated when player dies
  Kill_Switch = 666
  
  # Random factor
  Damage_Random = 0.1
  
  # Enable weapon icon drawing?
  Enable_Weapon_Graphics = true
  
  # Default skill speed
  Default_Skill_Speed = 5
  
  # Default skill recover time
  Default_Skill_Recover = 30
  
  # Skill volume
  Skill_Volume = 80
  
  # Default skill blend type
  Default_Particle_Blend = 1
  
  # Default enemy view range, in virtual pixels (1 tile = 4 virtual pixels)
  Enemy_View = 20
  
  # Enemies' default nature
  # 0 -> Only attack
  # 1 -> Attack and cast skills
  # 2 -> Only cast skills
  Enemy_Nature = 1
  
  # Default enemies' recover time
  Enemy_Recover = 60
  
  # Enable animation when player is seen
  Enemy_Exclamation = true
  
  # Minimal distance to use skills, in virtual pixels (1 tile = 4 virtual pixels)
  Enemy_Skill_Distance = 5
  
  
  # System constant - DO NOT CHANGE!
  Local_Switch = ["A","B","C","D"]
  
  # System constant - DO NOT CHANGE!
  Weapon_Range = {2=>[0,2],4=>[-2,0],6=>[2,0],8=>[0,-2]}
end
#-------------------------------------------------------------------------------
# * Setup Part (Pixel Movement)
#-------------------------------------------------------------------------------
module Pixel_Core
  
  # Auto Update events with tileset graphics?
  Auto_Refresh_Tile_Events = false
  
  # Auto Update range
  TileEvent_Range = 2
  
  # Auto Multiply event commands?
  # (this option will multiply the event commands by 4 if set to true)
  Multiply_Commands = true
  
  # Commands to multiply (ID)
  Commands = [1,2,3,4,5,6,7,8,9,10,11,12,13]
  
#-------------------------------------------------------------------------------
# * Constants - Do not modify!
#-------------------------------------------------------------------------------
  Pixel = 4
  Tile = 0.25
  Default_Collision_X = 3
  Default_Collision_Y = 3
  Body_Axis = [0.25,0.25,0.5,0.75]
  Bush_Axis = [0.5,0.75]
  Counter_Axis = [0.25,0.25,0.25,0.25]
  Ladder_Axis = [0.25,0.25]
  Pixel_Range = {2=>[0,0.25],4=>[-0.25,0],6=>[0.25,0],8=>[0,-0.25]}
  Tile_Range = {2=>[0,1],4=>[-1,0],6=>[1,0],8=>[0,-1]}
  Water_Range = {2=>[0,3],4=>[-3,0],6=>[3,0],8=>[0,-3]}
  Trigger_Range = {2=>[0,2],4=>[-2,0],6=>[2,0],8=>[0,-2]}
  Counter_Range = {2=>[0,3],4=>[-3,0],6=>[3,0],8=>[0,-3]}
  Chase_Axis = {2=>[0,1],4=>[1,0],6=>[1,0],8=>[0,1]}
end
#-------------------------------------------------------------------------------
# * Register
#-------------------------------------------------------------------------------
if $khas_awesome.nil?
  $khas_awesome = []
else
  scripts = []
  $khas_awesome.each { |script| scripts << script[0] }
  if scripts.include?("Pixel Movement")
    error = Sprite.new
    error.bitmap = Bitmap.new(544,416)
    error.bitmap.draw_text(0,208,544,32,"Please remove the script Khas Pixel Movement",1)
    continue = Sprite.new
    continue.bitmap = Bitmap.new(544,416)
    continue.bitmap.font.color = Color.new(0,255,0)
    continue.bitmap.font.size = error.bitmap.font.size - 3
    continue.bitmap.draw_text(0,384,544,32,"Press Enter to exit",1)
    add = Math::PI/80; max = 2*Math::PI; angle = 0 #add = Math::PI/80; max = 2*Math::PI; angle = 0
    loop do
      Graphics.update; Input.update
      angle += add; angle %= max
      continue.opacity = 185 + 70* Math.cos(angle)
      break if Input.trigger?(Input::C)
    end
    error.bitmap.dispose; continue.bitmap.dispose
    error.bitmap = nil; continue.bitmap = nil
    error.dispose; continue.dispose
    error = nil; continue = nil
    exit
  end
end

$khas_awesome << ["Sapphire Action System",4.4]

#-------------------------------------------------------------------------------
# * Sapphire Enemy
#-------------------------------------------------------------------------------
  
class Sapphire_Enemy
  attr_accessor :event
  attr_accessor :id
  attr_accessor :char_file
  attr_accessor :char_index
  attr_accessor :animation
  attr_accessor :skills
  attr_accessor :object
  attr_accessor :inanimate
  attr_accessor :immovable
  attr_accessor :weakphys
  attr_accessor :resphys  
  attr_accessor :weakfire  
  attr_accessor :resfire  
  attr_accessor :weakice  
  attr_accessor :resice  
  attr_accessor :weakrock  
  attr_accessor :resrock  
  attr_accessor :weakwater  
  attr_accessor :reswater  
  attr_accessor :weakwind  
  attr_accessor :reswind  
  attr_accessor :weakthun  
  attr_accessor :resthun  
  attr_accessor :weakmech  
  attr_accessor :resmech  
  attr_accessor :weakholy
  attr_accessor :resholy 
  attr_accessor :weakdark  
  attr_accessor :resdark   
  attr_accessor :weaksound  
  attr_accessor :ressound   
  attr_accessor :weakall  
  attr_accessor :resall                   
  attr_accessor :armorskin
  attr_accessor :armorfur
  attr_accessor :armorchitin 
  attr_accessor :armorscale
  attr_accessor :armorstone
  attr_accessor :armorbone
  attr_accessor :armorjello
  attr_accessor :armorplant
  attr_accessor :armorRES 
  attr_accessor :typebeast
  attr_accessor :typeundead
  attr_accessor :whipres
  attr_accessor :notbf
  attr_accessor :typeseafolk
  attr_accessor :typehumanoid
  attr_accessor :typeDMGwind
  attr_accessor :typeDMGdark
  attr_accessor :typeDMGfae
  attr_accessor :typeDMGfire
  attr_accessor :typeDMGice
  attr_accessor :typeDMGrock
  attr_accessor :typeDMGthunder
  attr_accessor :typeDMGwater
  attr_accessor :typeDMGmech
  attr_accessor :typeDMGbug
  attr_accessor :typeDMGgrass 
  attr_accessor :typeDMGfight
  attr_accessor :typeDMGghost
  attr_accessor :typeDMGdragon 
  attr_accessor :typeDMGnormal
  attr_accessor :typeDMGbeast
  attr_accessor :view
  attr_accessor :recover
  attr_accessor :step_anime
  attr_accessor :nature
  attr_accessor :auto_attack
  attr_accessor :attack
  attr_accessor :defence
  attr_accessor :luck
  attr_accessor :agility
  attr_accessor :exp
  attr_accessor :hp
  attr_accessor :mp
  attr_accessor :atk_invincible
  attr_accessor :skl_invincible
  attr_accessor :die_switch
  attr_accessor :die_variable
  attr_accessor :die_localsw
  attr_accessor :die_erase
  attr_accessor :magic
  attr_accessor :mdefence
  attr_accessor :static
  def initialize(event,id)
    @event = event
    @id = id            
    @game_enemy = Game_Enemy.new(0,@id)
    setup_enemy
    setup_skills
    setup_nature
    @attack = @game_enemy.atk
    @defence = @game_enemy.def
    @magic = @game_enemy.mat
    @mdefence = @game_enemy.mdf
    @luck = @game_enemy.luk
    @agility = @game_enemy.agi
    @exp = @game_enemy.exp
    @hp = @game_enemy.mhp    
    @mp = @game_enemy.mmp  
  ##########################    
   if $game_variables[116] == "Cottonweight" #CottonSkill
    @defence /= 2
    @mdefence /= 2
   end    
  ##########################
  allski = $game_variables[114] rescue ""
  ##########################
  if $game_variables[3000] != 0 #NG+ stat boost
    @ngp = $game_variables[3000]
    @fact = 1+(0.1 * (@ngp.length-1))
    @hp *= (200*@fact/100).round()
    @attack *= (160*@fact/100).round()
    @magic *= (160*@fact/100).round()
    @defence *= (110*@fact/100).round()
    @mdefence *= (110*@fact/100).round()
    @luck *= (120*@fact/100).round()
    @agility *= (140*@fact/100).round()
  end  
  if $game_switches[3656] == true #Oni Wish
    @hp *= (125/100)
    @attack *= (125/100)
    @magic *= (125/100)
    @defence *= (125/100)
    @mdefence *= (125/100)
    @luck *= (125/100)
    @agility *= (125/100)
  end    
  if $game_switches[3657] == true #Plant Wish
    if @game_enemy.enemy.typebeast
    @hp -= (@hp/4)
    @attack -= (@attack/4)
    @magic -= (@magic/4)
    @defence -= (@defence/4)
    @mdefence -= (@mdefence/4)
    @luck -= (@luck/4)
    @agility -= (@agility/4)
  end   
  end
    unless allski == "" || allski == 0   
      #Soprano
    if allski.include? "Soprano"
      @mdefence -= (@mdefence*30/100)
    end  
      #Magnitude
    if allski.include? "MagnitudeMagnitudeMagnitude" #Magnitude Skill x3
      @attack -= (@attack*30/100)
      @magic -= (@magic*30/100)
      @defence -= (@defence*30/100)
      @mdefence -= (@mdefence*30/100)
      @luck -= (@luck*30/100)
      @agility -= (@agility*30/100)
    elsif allski.include? "MagnitudeMagnitude" #Magnitude Skill x2
      @attack -= (@attack*20/100)
      @magic -= (@magic*20/100)
      @defence -= (@defence*20/100)
      @mdefence -= (@mdefence*20/100)
      @luck -= (@luck*20/100)
      @agility -= (@agility*20/100)
    elsif allski.include? "Magnitude" #Magnitude Skill x1 
      @attack -= (@attack*10/100)
      @magic -= (@magic*10/100)
      @defence -= (@defence*10/100)
      @mdefence -= (@mdefence*10/100)
      @luck -= (@luck*10/100)
      @agility -= (@agility*10/100)
    end         
    #Intimidate
    if allski.include? "IntimidateIntimidateIntimidate" #Intimidate Skill x3
      @attack -= (@attack*30/100)
      @magic -= (@magic*30/100)
    elsif allski.include? "IntimidateIntimidate" #Intimidate Skill x2
      @attack -= (@attack*20/100)
      @magic -= (@magic*20/100)
    elsif allski.include? "Intimidate" #Intimidate Skill x1 
      @attack -= (@attack*10/100)
      @magic -= (@magic*10/100)
    end   
    end  
    if $game_switches[5156] == true
    if $game_variables[4339] != 0 #FrogBonus
    @frog = $game_variables[4339] 
    @hp *= (100*@frog/100).round()
    @attack *= (100*@frog/100).round()
    @magic *= (100*@frog/100).round()
    @defence *= (100*@frog/100).round()
    @mdefence *= (100*@frog/100).round()
    @luck *= (100*@frog/100).round()
    @agility *= (100*@frog/100).round()
  end    
  end
  ##########################
    @atk_invincible = false
    @skl_invincible = false
    @die_switch = nil
    @die_variable = nil
    @die_localsw = nil
    @die_erase = false
  end
  def setup_nature
    @nature = 0 if @skills.empty?
  end
  def setup_enemy
    @animation = @game_enemy.enemy.animation
    @char_file = @game_enemy.enemy.char_file
    @char_index = @game_enemy.enemy.char_index
    @object = @game_enemy.enemy.object?
  ##########################
    @armorskin = @game_enemy.enemy.armorskin
    @armorfur = @game_enemy.enemy.armorfur
    @armorchitin = @game_enemy.enemy.armorchitin
    @armorscale = @game_enemy.enemy.armorscale
    @armorbone = @game_enemy.enemy.armorbone
    @armorstone = @game_enemy.enemy.armorstone
    @armorjello = @game_enemy.enemy.armorjello
    @armorplant = @game_enemy.enemy.armorplant
    @armorRES = @game_enemy.enemy.armorRES   
  ##########################
   @weakphys = @game_enemy.enemy.weakphys
   @resphys = @game_enemy.enemy.resphys
   @weakfire = @game_enemy.enemy.weakfire
   @resfire = @game_enemy.enemy.resfire
   @weakice = @game_enemy.enemy.weakice
   @resice = @game_enemy.enemy.resice
   @weakrock = @game_enemy.enemy.weakrock
   @resrock = @game_enemy.enemy.resrock
   @weakwater = @game_enemy.enemy.weakwater
   @reswater = @game_enemy.enemy.reswater
   @weakwind = @game_enemy.enemy.weakwind
   @reswind = @game_enemy.enemy.reswind
   @weakthun = @game_enemy.enemy.weakthun
   @resthun = @game_enemy.enemy.resthun
   @weakmech = @game_enemy.enemy.weakmech
   @resmech = @game_enemy.enemy.resmech
   @weakholy = @game_enemy.enemy.weakholy
   @resholy = @game_enemy.enemy.resholy
   @weakdark = @game_enemy.enemy.weakdark
   @resdark = @game_enemy.enemy.resdark
   @weaksound = @game_enemy.enemy.weaksound
   @ressound = @game_enemy.enemy.ressound
   @weakall = @game_enemy.enemy.weakall
   @resall = @game_enemy.enemy.resall
  ##########################  
    @typeDMGnormal = @game_enemy.enemy.typeDMGnormal  
    @typeDMGdark = @game_enemy.enemy.typeDMGdark
    @typeDMGwind = @game_enemy.enemy.typeDMGwind
    @typeDMGfae = @game_enemy.enemy.typeDMGfae    
    @typeDMGfire = @game_enemy.enemy.typeDMGfire
    @typeDMGwater = @game_enemy.enemy.typeDMGwater
    @typeDMGice = @game_enemy.enemy.typeDMGice
    @typeDMGthunder = @game_enemy.enemy.typeDMGthunder
    @typeDMGrock = @game_enemy.enemy.typeDMGrock
    @typeDMGmech = @game_enemy.enemy.typeDMGmech
    @typeDMGbug = @game_enemy.enemy.typeDMGbug
    @typeDMGgrass = @game_enemy.enemy.typeDMGgrass
    @typeDMGfight = @game_enemy.enemy.typeDMGfight  
    @typeDMGghost = @game_enemy.enemy.typeDMGghost
    @typeDMGdragon = @game_enemy.enemy.typeDMGdragon    
    @typeDMGbeast = @game_enemy.enemy.typeDMGbeast
  ##########################      
    @typebeast = @game_enemy.enemy.typebeast
    @typeseafolk = @game_enemy.enemy.typeseafolk
    @typehumanoid = @game_enemy.enemy.typehumanoid
    @typeundead = @game_enemy.enemy.typeundead
    @whipres = @game_enemy.enemy.whipres
    @notbf = @game_enemy.enemy.notbf
    @inanimate = @game_enemy.enemy.inanimate?
    @immovable = @game_enemy.enemy.immovable?
    @view = @game_enemy.enemy.view
    @recover = @game_enemy.enemy.recover
    @step_anime = @game_enemy.enemy.step_anime?
    @nature = @game_enemy.enemy.nature
    @auto_attack = @game_enemy.enemy.auto_attack
    @static = @game_enemy.enemy.static
  end
  def setup_skills
    ids = @game_enemy.enemy.skills
    @skills = []
    ids.each { |i|;
    skill = $data_skills[i];
    skills << [skill,skill.particle] unless skill.particle.nil?}
  end
end

#-------------------------------------------------------------------------------
# * Sapphire Particle
#-------------------------------------------------------------------------------

class Sapphire_Particle < Sprite
  attr_accessor :done
  def initialize(key,char)
    super(nil)
    @key = key
    self.bitmap = Sapphire_Bitcore[@key]
    self.ox = self.bitmap.width/2
    self.oy = self.bitmap.height/2
    self.z = 200
    @dur = 0
    #if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[368]
    #  @dur = 1
    #end  
    if $game_party.leader.class_id == 122 || $game_party.leader.class_id == 165
    self.angle = 1
    @add = rand(20)
      else
    self.angle = rand(360)
    @add = rand(10)
      end    
    @done = false
    @rx = char.real_x
    @ry = char.real_y
    self.blend_type = char.blend
  end
  def update
    self.x = $game_map.adjust_unlx(@rx) * 32 + 16
    self.y = $game_map.adjust_unly(@ry) * 32 + 16
#    if $game_party.leader.class_id == 1#22
#    self.angle = 1 #self.angle += @add
#  else
    self.angle += @add
#    end
    self.opacity <= 0 ? dispose : self.opacity -= 30
  end
  def release
    return Virtual_Particle.new(self.x,self.y,@rx,@ry,@key,self.z,self.angle,@add,self.blend_type,self.opacity)
  end
  def dispose
    self.bitmap = nil
    super
    @done = true
  end
end

#-------------------------------------------------------------------------------
# * Sapphire Restored Particle
#-------------------------------------------------------------------------------

class Sapphire_Restored_Particle < Sprite
  attr_accessor :done
  def initialize(vp)
    super(nil)
    @key = vp.key
    self.bitmap = Sapphire_Bitcore[@key]
    self.ox = self.bitmap.width/2
    self.oy = self.bitmap.height/2
    self.z = vp.z
    self.angle = vp.angle
    @add = vp.add
    @done = false
    @rx = vp.rx
    @ry = vp.ry
    self.blend_type = vp.blend
    self.opacity = vp.opacity
  end
  def update
    self.x = $game_map.adjust_unlx(@rx) * 32 + 16
    self.y = $game_map.adjust_unly(@ry) * 32 + 16
    self.angle += @add #return @add
    self.opacity <= 0 ? dispose : self.opacity -= 30
  end
  def release
    return Virtual_Particle.new(self.x,self.y,@rx,@ry,@key,self.z,self.angle,@add,self.blend_type,self.opacity) #self.angle
  end
  def dispose
    self.bitmap = nil
    super
    @done = true
  end
end

#-------------------------------------------------------------------------------
# * Virtual Particle
#-------------------------------------------------------------------------------

class Virtual_Particle
  attr_reader :x
  attr_reader :y
  attr_reader :rx
  attr_reader :ry
  attr_reader :key
  attr_reader :z
  attr_reader :angle
  attr_reader :add
  attr_reader :blend
  attr_reader :opacity
  def initialize(x,y,rx,ry,key,z,angle,add,blend,opacity)
    @x = x
    @y = y
    @rx = rx
    @ry = ry
    @key = key
    @z = z
    @angle = angle #angle
    @add = add
    @blend = blend
    @opacity = opacity
  end
end
#-------------------------------------------------------------------------------
# * Sapphire Skill
#-------------------------------------------------------------------------------

class Sapphire_Skill
  include Pixel_Core
  attr_accessor :px
  attr_accessor :py
  attr_accessor :cx
  attr_accessor :cy
  attr_reader :x
  attr_reader :y
  attr_reader :real_x
  attr_reader :real_y
  attr_reader :move_speed
  attr_reader :move_frequency
  attr_reader :direction
  attr_reader :priority_type
  attr_reader :skill
  attr_reader :done
  attr_reader :blend
  def initialize(char)
    @char = char
    if @char.is_a?(Game_Event)
      skills = char.enemy.skills
      select = skills[rand(skills.size)]
      @skill = select[0]
      @bitmap = select[1]
      @power = @char.enemy.magic
      @luck = @char.enemy.luck
      @cast_by_enemy = true
    else
      @skill = $game_player.current_skill[0]
      @bitmap = $game_player.current_skill[1]      
      if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[368]
        @duraff = $game_variables[7325]
        if @duraff <= 0
          @duraff = 0
        elsif @duraff >= 14
          @duraff = 14
        end        
        @power = 20 *(1 + @duraff)
        elsif $game_party.leader.class_id == 166 #bloo
        @power = $game_party.members[0].mat + (15 * $game_variables[8781])
        else 
        @power = $game_party.members[0].mat
      end
    if $game_variables[116] == "Cottonweight" #CottonSkill
     @power -= $game_party.members[0].equips[0].params[4]
    end      
    if $game_variables[116] == "BlindLuck" #BlindLuck Skill
     @power = ($game_party.members[0].mat + $game_party.members[0].luk)/2
    end 
     #Magiknight
    if $game_party.leader.id == 1 
    if $game_variables[628] == 132 || $game_variables[628] == 1032 #magiknight
      @power *= ($game_party.members[0].atk / 4)
    end   
    end
    if $game_switches[1948] == true #TicToc
      @power *= 2
      message = ["OK!","NICE!","PERFECT!"].sample
      $game_map.show_text($game_player,message)
    end       
      #####      
     if $game_party.members[0].equips[5] == $data_armors[676] && char.enemy.typeseafolk #Duel Winner
        @power += (@power/2)
     elsif $game_variables[628] == 1008 && $game_party.members[0].id == 1 #WealthyK ++ lid
        @power += ((@power/100)*($game_variables[584]/100)) # + 1%/Swirlies
     elsif $game_variables[116] == "Masochist" #Masochist Skill
        @mod = ($game_party.leader.hp/$game_party.leader.mhp)*100
        if @mod < 25
          @power += @power
        elsif @mod < 50
          @power += (@power/4)
        elsif @mod < 75
          @power += 0
        else
          @power -= (@power/5)
        end
     elsif $game_variables[116] == "Maniac" #Maniac Skill
        @power += ((@power/100)*$game_variables[2879]) # + 1%/KL          
     elsif $game_variables[116] == "Crepuscular" #Crepuscular Skill
        if $game_variables[376] >= 15 && $game_variables[376] <= 19
         @power += (@power/5)
        end
     elsif $game_variables[116] == "NoGuard" #No Guard Skill
         @power += (@power/4)  
     elsif $game_variables[116] == "Daredevil" #Daredevil Skill
         if $game_party.members[0].hp / $game_party.members[0].mhp < 0.25
         @power += (@power/2)  
         end
      elsif $game_variables[116] == "Kunoichi" #Kunoichi Skill
         @power += (@power/2)
      elsif $game_variables[116] == "Arrogant" #Arrogant Skill
         @power += (@power*30/100)   
      elsif $game_variables[116] == "FelineArr" #FelineArr Skill
         @power += (@power*40/100)          
       elsif $game_variables[116] == "HeatEngine" #HeatEngine Skill     
         if $game_player.real_move_speed == 5
           @power += (@power/2)
         elsif $game_player.real_move_speed == 6
           @power += (@power/2)
         end  
         if $game_switches[3708] == true || $game_switches[488] == true #hot terrain or scorch
           @power += (@power/4) 
         end  
      elsif $game_variables[116] == "Sunny" && $game_switches[412] == true && $game_switches[524] == true #Sunny Disposition Skill
         @power += (@power/4)            
      elsif $game_variables[116] == "Necrophiliac" #Necrophiliac Skill
        @power += (@power * $game_variables[396] / 4)
      elsif $game_variables[116] == "UnboundMagic" #Unbound Magic Skill 
        i = 0
      while i <= 5
         if $game_party.members[0].equips[i] == nil
           @power += (@power/5)
         end  
        i += 1
      end  
      end
      @power.to_i
      #####      
      @lucky = $game_party.members[0].luk
      @cast_by_enemy = false
    end
    @real_x = @char.x
    @real_y = @char.y
    @x = @char.x.to_f
    @y = @char.y.to_f
    @px = @char.px
    @py = @char.py
    @move_speed = @skill.speed
    if $game_party.members[0].equips.include?$data_armors[669] #Zeal Bullet
      @move_speed += 1
    end 
    if $game_party.members[0].state?(164) == true #speedster
      @move_speed += 1
    end      
    @wep = $game_party.leader.equips[0].id rescue 0
    if @wep != 0 #GobSkill
    @wepId = $game_party.leader.equips[0].wtype_id  
    if $game_switches[1875] == true && @wepId == 10 #GobSkill
      @move_speed += 2
    end   
    end    
    @move_frequency = 6
    @direction = @char.direction
    @cx = 3
    @cy = 3
    @done = false
    @last_move = false
    @remaining = 0
    @blend = @skill.blend
    @water_remaining = 0
    RPG::SE.new(@skill.cast_se,Sapphire_Core::Skill_Volume).play unless @skill.cast_se.nil?
  end
  def perform_damage(char)
    if @cast_by_enemy
      char.animation_id = @skill.animation_id
      if $game_switches[2723] == false && $game_switches[7331] == false
      char.set_direction(10-@direction)  
      5.times do; char.move_backward; end
      char.do_step
    end
      damage = @power * @skill.power
      damage += rand(damage*Sapphire_Core::Damage_Random).to_i
      ####################
      #@lukDiff = $game_party.members[0].luk + ($game_party.members[0].luk - @luck)
      #if @lukDiff <= 0
      #  @lukDiff = 1
      #end  
      #if $game_party.members[0].id == 1 #Knight
      #  @lukScore = (@lukDiff / (20 + $game_party.members[0].level)).round()
      #else #Not Knight
      #  @lukScore = (@lukDiff / (30 + $game_party.members[0].level)).round() + $game_party.members[0].parent_stat(3)
      #end    
      ####################      
      crit = ($game_party.members[0].luk * 100) / @luck
      if crit < 100
        chance = rand(100)
        if chance >= crit
         damage += damage
         RPG::SE.new("Reflection", 110, 100).play
       end
     else
      crit = (@luck * @luck) / 500
      if crit < 2
        crit = 2
      end
      if crit > 75
        crit = 75
      end  
        chance = rand(100)
        if chance <= crit
         damage += damage
         RPG::SE.new("Reflection", 110, 100).play
       end   
     end
      touch = 0 
      if touch == 1
          then
          damage /= 2
          ##################
          if $game_party.leader.class_id == 173 #salizzie dash
          value = $game_party.members[0].atk * $game_party.members[0].agi * 90/100
          i = 0
          while i <= 5
            if $game_party.members[0].equips[i] == nil
              value += (value/10)
            end  
            i += 1
          end    
        else
    if $game_variables[116] == "YinYang" #YinYang Skill
      @atkscore = $game_party.members[0].agi
    else
      @atkscore = $game_party.members[0].atk
    end     
    if $game_variables[116] == "BlindLuck" #BlindLuck Skill
    @atkscore += $game_party.members[0].equips[2].params[2]
    end 
          value = @atkscore * $game_party.members[0].def * 90/100
          end
          ##################          
          #damage_enemy(value)
          ################## 
          @recover = 20
        end              
     if damage > 0 && $game_switches[3908] == false
      $game_switches[3908] = true
    end         
      $game_player.damage_hero(damage)
    else
      char.animation_id = @skill.animation_id
      @wep = $game_party.leader.equips[0].id rescue 0
    unless char.enemy.inanimate || char.enemy.immovable
      if $game_switches[2723] == false && $game_switches[7331] == false
      char.set_direction(10-@direction)  
      step = 5
          if @wep != 0     
            if $game_party.leader.equips[0].wtype_id == 2 || $game_party.leader.equips[0].wtype_id == 7 #fist/dagg
             step -= 2
            end     
          end      
      if $game_party.members[0].state?(231) == true #heavyblows
        step *= 2
      end
      if $game_party.members[0].equips.include?$data_armors[372] #hippo set
      if $game_party.members[0].equips.include?$data_weapons[89]
        step *= 2
      end
      end
      step.times do; char.move_backward; end
      char.do_step
      end
    end
    if @skill.id == 341 #sticky web
      
    end  
      if @skill.id == 329 #poison jar
        @alcRing = $game_party.item_number($data_items[429])
        if @alcRing > 5
        @alcRing = 5
        end
        damage = @power * (@skill.power+(10 * @alcRing))
      else
        damage = @power * @skill.power
      end      
      damage += rand(damage*Sapphire_Core::Damage_Random).to_i         
  if $game_party.leader.class.id == 2 && $game_switches[4120] == true
    then
      crit = ($game_party.members[0].luk * $game_party.members[0].luk) / 400
    else 
      crit = ($game_party.members[0].luk * $game_party.members[0].luk) / 500      
    end          
     if $game_variables[116] == "NoGuard" #No Guard Skill
         crit += (crit/4)
       end          
     if $game_party.members[0].state?(53) == true #frenzy anemone
         crit += (crit/4)
       end  
     @love = $game_party.members[0].parent_stat(0)
      if $game_variables[116] == "TaintedLove" #Tainted Love Skill
        @love += $game_party.members[0].parent_stat(1)
      end      
     if $game_party.members[0].equips[4] == $data_armors[547] #BLOODY BANDAGES
      if @love >= 5
        crit += (crit/2)
      elsif @love >= 3
        crit += (crit/4)
      else
        crit += (crit/10)
      end
     end       
     if $game_party.members[0].equips[4] == $data_armors[453] #KING
        if @love >= 6
      if $game_variables[116] == "Manchild" #Manchild Skill
         crit += (crit/5)
      else
        crit += (crit/10)
      end          
        end
      end   
     #MONSTER EATER
     if $game_party.leader.id == 1 #MonsterEater++
       if $game_variables[628] == 1028 || $game_variables[628] == 128
         if char.enemy.typehumanoid || char.enemy.typeundead
           crit += (crit/5)
         end  
       end  
     end
     #MONSTER EATER weapon
     @wep = $game_party.leader.equips[0].id rescue 0
     if @wep == 166    
         crit += (crit/5)
     end           
     #MONSTER EATER - end
     if crit < 2
        crit = 2
      end
      if crit > 75
        crit = 75
      end        
     if $game_party.members[0].equips[5] == $data_armors[610] #Brazen Ox
        crit = 75
     end      
        chance = rand(100)
     if chance <= crit
         damage += damage
     unless char.enemy.inanimate    
     if $game_party.members[0].equips[4] == $data_armors[667] #Zeal Arm
       @animation_id = 134
       actor = $game_party.members[0]
       value = (actor.mhp * 5 / 100).to_i
       actor.hp += value
       message = "+ #{value}"
       $game_map.show_text($game_player,message)
       $game_map.sas_hud.refresh_bars
     end 
     if $game_party.members[0].equips[4] == $data_armors[668] #Zeal Amulet
       @animation_id = 134
       actor = $game_party.members[0]
       value = (actor.mmp * 5 / 100).to_i
       actor.mp += value
       message = "+ #{value}"
       $game_map.show_text($game_player,message)
       $game_map.sas_hud.refresh_bars
     end 
     end
     if $game_party.members[0].equips[4] == $data_armors[453] #KING
        if @love >= 10
      if $game_variables[116] =="Manchild" #Manchild Skill
        damage += (damage/5)
      else
        damage += (damage/10)
      end                
        damage = (damage).to_i
        end
     end 
         RPG::SE.new("Reflection", 110, 100).play
       end       
#####################
     @skiNam = $game_player.current_skill[1] rescue nil
      unless @skiNam.nil?
#####################
       calc_atkType(2)   
       calc_armorMod(char)
#####################       
       damage += (damage*@dmgMod).round()
      end  
#####################     
      char.skill_damage_enemy(damage,true) unless char.enemy.skl_invincible
    end
  end
  def moving?
    @real_x != @x || @real_y != @y
  end
  def distance_per_frame
    2 ** @move_speed / 256.0
  end
  def screen_x
    $game_map.adjust_unlx(@real_x) * 32 + 16
  end
  def screen_y
    $game_map.adjust_unly(@real_y) * 32 + 16
  end
  def update
    cast_particle
    move unless moving?
    return update_move if moving?
  end
  def move
    @last_move ? move_last : move_pixel
  end
  def move_last
    if @remaining > 0
      @px += Tile_Range[@direction][0]
      @py += Tile_Range[@direction][1]
      @real_x = @x
      @real_y = @y
      @x += Pixel_Range[@direction][0]
      @y += Pixel_Range[@direction][1]
      @remaining -= 1
    else
      destroy
    end
  end
  def destroy
    @done = true
  end
  def cast_particle
    $game_map.particles << Sapphire_Particle.new(@bitmap,self)
  end
  def update_move
    @real_x = [@real_x - distance_per_frame, @x].max if @x < @real_x
    @real_x = [@real_x + distance_per_frame, @x].min if @x > @real_x
    @real_y = [@real_y - distance_per_frame, @y].max if @y < @real_y
    @real_y = [@real_y + distance_per_frame, @y].min if @y > @real_y 
  end
  def pixel_range?(px,py)
    return (@px - px).abs <= @cx && (@py - py).abs <= @cy
  end
  def pixel_passable?(px,py,d)
    @skillPass = ["Chopplant Pea","Chopplant Pea"]
    nx = px+Tile_Range[d][0]
    ny = py+Tile_Range[d][1]
    return false unless $game_map.pixel_valid?(nx,ny)
    unless @skillPass.include?@skill.name #avoid collisions
    return false if $game_map.pixel_table[px+Tile_Range[d][0],py+Tile_Range[d][1],1] == 0
    end
    return false if collision?(nx,ny)
    return true
  end
  def collision?(px,py)
    if @cast_by_enemy
      for event in $game_map.events.values
        if (event.px - px).abs < event.cx && (event.py - py).abs < event.cy
          next if event.through || event == @char
          return true if event.priority_type == 1 && $game_map.map_id != 434 && $game_map.map_id != 261 && $game_map.map_id != 452 && $game_map.map_id != 457 && $game_map.map_id != 407
        end
      end
      return ($game_player.px - px).abs <= @cx && ($game_player.py - py).abs <= @cy
    else
      for event in $game_map.events.values
        if (event.px - px).abs < event.cx && (event.py - py).abs < event.cy
          next if event.through
          return true if event.priority_type == 1 || $game_map.map_id == 434 || $game_map.map_id == 261 || $game_map.map_id == 452 || $game_map.map_id == 457 || $game_map.map_id == 407
        end
      end
      return false
    end
  end
  def move_pixel
    if pixel_passable?(@px,@py,@direction)
      @px += Tile_Range[@direction][0]
      @py += Tile_Range[@direction][1]
      @real_x = @x
      @real_y = @y
      @x += Pixel_Range[@direction][0]
      @y += Pixel_Range[@direction][1]
    else
      front_pixel_touch?(@px + Tile_Range[@direction][0],@py + Tile_Range[@direction][1])
      @last_move = true
      @remaining = 3
    end
  end
def front_pixel_touch?(px,py)
    if @cast_by_enemy
      perform_damage($game_player) if ($game_player.px - px).abs <= @cx && ($game_player.py - py).abs <= @cy
    else
      for event in $game_map.enemies
      if (event.px - px).abs < event.cx && (event.py - py).abs < event.cy
          next if event.enemy.static
          perform_damage(event)
        end
      end
    end
  end
  end

#-------------------------------------------------------------------------------
# * Sapphire HUD
#-------------------------------------------------------------------------------

#class Sapphire_Hud
#  def refresh_bars(arg=nil)
#  end
#  def refresh_base
#  end
#  def hide(arg=nil)
#  end
#  def show(arg=nil)
#  end
#end

class Sapphire_Hud
 def refresh_bars(hp=$game_party.members[0].hp)
 end
 def refresh_base
 end
 def hide(lock=false)
 end
 def show(unlock=false)
 end
end


#-------------------------------------------------------------------------------
# * RGSS3 Object
#-------------------------------------------------------------------------------

class Object
  def check(string)
    self.each_line { |i| return true if i =~ /#{string}/i }
    return false
  end
  def get(string,default=nil)    
    self.each_line { |i| return i.gsub("#{string} = ", "").chomp if i =~ /#{string} = /i }
    return default
  end
end

#-------------------------------------------------------------------------------
# * Cache
#-------------------------------------------------------------------------------

module Cache
  def self.particle(filename)
    load_bitmap("Graphics/Particles/", filename)
  end
end

#-------------------------------------------------------------------------------
# * RPG::Enemy
#-------------------------------------------------------------------------------

class RPG::Enemy < RPG::BaseItem
  def skills
    value = self.note.get("Skills","")
    return eval("[#{value}]")
  end
  def object?
    self.note.check("Object")
  end
  def inanimate?
    self.note.check("Inanimate")
  end
  def immovable?
    self.note.check("Immovable")
  end  
  ##########################
   def weakphys
    self.note.check("WeakPhys")       
   end
   def resphys
    self.note.check("ResPhys")       
   end
   def weakfire  
    self.note.check("WeakFire")       
   end
   def resfire  
    self.note.check("ResFire")      
   end
   def weakice 
    self.note.check("WeakIce")       
   end
   def resice
    self.note.check("ResIce")       
   end
   def weakrock  
    self.note.check("WeakRock")       
   end
   def resrock  
    self.note.check("ResRock")       
   end
   def weakwater  
    self.note.check("WeakWater")       
   end 
   def reswater  
    self.note.check("ResWater")       
   end
   def weakwind  
    self.note.check("WeakWind")       
   end
   def reswind  
    self.note.check("ResWind")       
   end
   def weakthun  
    self.note.check("WeakThun")       
   end
   def resthun  
    self.note.check("ResThun")       
   end
   def weakmech  
    self.note.check("WeakMech")       
   end
   def resmech  
    self.note.check("ResMech")       
   end
   def weakholy  
    self.note.check("WeakHoly")       
   end
   def resholy  
    self.note.check("ResHoly")       
   end
   def weakdark  
    self.note.check("WeakDark")       
   end
   def resdark  
    self.note.check("ResDark")       
  end
   def weaksound 
    self.note.check("WeakSound")       
   end
   def ressound  
    self.note.check("ResSound")       
   end  
   def weakall  
    self.note.check("WeakAll")       
   end
   def resall  
    self.note.check("ResAll")     
   end  
  ##########################  
  def armorskin
    self.note.check("ArmorSkin")
  end 
  def armorfur
    self.note.check("ArmorFur")
  end 
  def armorchitin
    self.note.check("ArmorChitin")
  end   
  def armorscale
    self.note.check("ArmorScale")
  end 
  def armorstone
    self.note.check("ArmorStone")
  end 
  def armorjello
    self.note.check("ArmorJello")
  end 
  def armorplant
    self.note.check("ArmorPlant")
  end  
  def armorRES
    self.note.check("ArmorRES")
  end  
  def armorbone
    self.note.check("ArmorBone")
  end     
  def typebeast
    self.note.check("TypeBeast")
  end  
  ##########################   
  def typeDMGwind
    self.note.check("TypeDMGWind")
  end   
  def typeDMGdark
    self.note.check("TypeDMGDark")
  end     
  def typeDMGfae
    self.note.check("TypeDMGFae")
  end   
  def typeDMGfire
    self.note.check("TypeDMGFire")
  end    
  def typeDMGwater
    self.note.check("TypeDMGWater")
  end    
  def typeDMGice
    self.note.check("TypeDMGIce")
  end    
  def typeDMGrock
    self.note.check("TypeDMGRock")
  end    
  def typeDMGmech
    self.note.check("TypeDMGMech")
  end    
  def typeDMGthunder
    self.note.check("TypeDMGThunder")
  end 
  def typeDMGbug
    self.note.check("TypeDMGBug")
  end
  def typeDMGbeast
    self.note.check("TypeDMGBeast")
  end   
  def typeDMGgrass
    self.note.check("TypeDMGGrass")
  end    
  def typeDMGfight
    self.note.check("TypeDMGFight")
  end     
  def typeDMGghost
    self.note.check("TypeDMGGhost")
  end  
  def typeDMGdragon
    self.note.check("TypeDMGDragon")
  end   
  def typeDMGnormal
    self.note.check("TypeDMGNormal")
  end  
  ##########################   
  def typeseafolk
    self.note.check("TypeSeafolk")
  end    
  def typehumanoid
    self.note.check("TypeHumanoid")
  end    
  def typeundead
    self.note.check("TypeUndead")
  end       
  def whipres
    self.note.check("WhipRes")
  end 
  def notbf
    self.note.check("NotBF")
  end  
  def view
    self.note.get("View", Sapphire_Core::Enemy_View).to_i
  end
  def recover
    self.note.get("Recover", Sapphire_Core::Enemy_Recover).to_i
  end
  def step_anime?
    self.note.check("StepAnime")
  end
  def nature
    self.note.get("Nature", Sapphire_Core::Enemy_Nature).to_i
  end
  def char_file
    self.note.get("Char",nil)
  end
  def char_index
    self.note.get("Char_index",0).to_i
  end
  def animation
    self.note.get("Animation",0).to_i
  end
  def auto_attack
    self.note.check("Auto_Attack")
  end
  def static
    self.note.check("Static")
  end
end

#-------------------------------------------------------------------------------
# * RPG::Skill
#-------------------------------------------------------------------------------

class RPG::Skill < RPG::UsableItem
  attr_reader :recover
  def particle
    self.note.get("Particle", nil)
  end
  def speed
    self.note.get("Speed", Sapphire_Core::Default_Skill_Speed).to_i
  end
  def blend
    self.note.get("Blend", Sapphire_Core::Default_Particle_Blend).to_i
  end
  def set_recover
    @recover = self.note.get("Recover", Sapphire_Core::Default_Skill_Recover).to_i
  end
  def power
    self.note.get("Power", 0).to_i
  end
  def cast_se
    self.note.get("Sound", nil)
  end
end

#-------------------------------------------------------------------------------
# * Scene Map
#-------------------------------------------------------------------------------

class Scene_Map < Scene_Base
  attr_accessor :spriteset
end

#-------------------------------------------------------------------------------
# * Sprite Base
#-------------------------------------------------------------------------------

class Sprite_Base
  Reduce = 3
  def animation_set_sprites(frame)
    cell_data = frame.cell_data
    @ani_sprites.each_with_index do |sprite, i|
      next unless sprite
      pattern = cell_data[i, 0]
      if !pattern || pattern < 0
        sprite.visible = false
        next
      end
      sprite.bitmap = pattern < 100 ? @ani_bitmap1 : @ani_bitmap2
      sprite.visible = true
      sprite.src_rect.set(pattern % 5 * 192,
        pattern % 100 / 5 * 192, 192, 192)
      if @ani_mirror
        sprite.x = @ani_ox - cell_data[i, 1] / Reduce
        sprite.y = @ani_oy + cell_data[i, 2] / Reduce
        sprite.angle = (360 - cell_data[i, 4])
        sprite.mirror = (cell_data[i, 5] == 0)
      else
        sprite.x = @ani_ox + cell_data[i, 1] / Reduce
        sprite.y = @ani_oy + cell_data[i, 2] / Reduce
        sprite.angle = cell_data[i, 4]
        sprite.mirror = (cell_data[i, 5] == 1)
      end
      sprite.z = self.z + 300 + i
      sprite.ox = 96
      sprite.oy = 96
      sprite.zoom_x = cell_data[i, 3] / (100.0 * Reduce)
      sprite.zoom_y = cell_data[i, 3] / (100.0 * Reduce)
      sprite.opacity = cell_data[i, 6] * self.opacity / 255.0
      sprite.blend_type = cell_data[i, 7]
    end
  end
end

#-------------------------------------------------------------------------------
# * Spriteset Map
#-------------------------------------------------------------------------------
class Spriteset_Map
  alias sas_update update
  alias sas_initialize initialize
  alias sas_dispose dispose
  def initialize    
    @trash = []
    $game_map.show_particles
    $game_map.show_damage_sprites
    $game_map.sas_hud.show
    sas_initialize
    custom_wep
    refresh_weapon    
  end
  def custom_wep
    @weapon_graphic = Sprite.new(@viewport1)
    inc = 1
    if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[369]        
      inc *= 1.5
    end    
    if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[395]
     inc *= 1.5
    end        
    @wep = $game_party.leader.equips[0].id rescue 0
    @bigW = [76,77,78,80,88,89,90,91,92,96,106,109,111,124,130,162,163,171]
    @hugeW = [134,158]
    #slingaxe COUNTING as big weapon for size (96)
    return if @wep == 0
    if $game_party.leader.class_id == 174
    if $game_party.leader.equips[0].wtype_id == 3 || $game_party.leader.equips[0].wtype_id == 9 #lances/staves
      inc *= 1.5
    end
   end
    @sneks = [110,111,112,113,215]
    if $game_party.leader.equips[0].wtype_id == 11 #whips
      if @sneks.include?$game_party.leader.class_id
       inc *= 2.5
      else
       inc *= 1.5
      end
    end    
    if @bigW.include?@wep #Big Weapons
     inc *= 1.5
    elsif @hugeW.include?@wep #Huge Weapons
     inc *= 2.5     
   end    
    #MouSkill   
    if $game_switches[1877] == true && $game_party.leader.equips[0].wtype_id != 9 && $game_party.leader.equips[0].wtype_id != 10 && $game_party.leader.equips[0].wtype_id != 11
     inc *= 1.5
    end    
    if $game_variables[116] == "PitFighter" && $game_party.leader.equips[0].wtype_id == 2 #Pit Fighter Skill
       inc *= 1.5
    elsif $game_variables[116] == "Pikeman" && $game_party.leader.equips[0].wtype_id == 3 #Pikeman Skill
       inc *= 1.5
    end  
    if $game_party.members[0].id == 1 && $game_party.leader.equips[0].wtype_id == 2 #fist K
      if $game_variables[628] == 26 || $game_variables[628] == 126 || $game_variables[628] == 1026 #brawler
       inc *= 1.5
      end
    end            
    bigfighter = 0
    if $game_party.members[0].id == 54
      bigfighter = 1
    end
    #if bigfighter == 1
    #@weapon_graphic.ox = 22 * inc
    #@weapon_graphic.oy = 22 * inc  
    #inc *= (150/100)
    #else
    @weapon_graphic.ox = 22 * inc
    @weapon_graphic.oy = 22 * inc     
    #end  
    @attacking = false
    @attack_timer = 0
    ##### cust weap #####
    @mode = "slash"
    @wep = $game_party.leader.equips[0].id rescue 0
    return if @wep == 0
    if $game_party.leader.equips[0].wtype_id == 7 || $game_party.leader.equips[0].wtype_id == 3 #s/lances
    @mode = "pierce"  
    end
    if $game_party.leader.equips[0].wtype_id == 2 #fist
    @mode = "fist"  
    end    
    if @wep == 75 || @wep == 79 || @wep == 94 || @wep == 144 || @wep == 153 #rapier/pestle
    @mode = "pierce"
    end
    if @wep == 88 || @wep == 127 || @wep == 171 #sickle
    @mode = "slash"
    end
    if @mode == "pierce" #daggers/lances
    @angles = {2=>[130,130,130,130,130],4=>[40,40,40,40,40],6=>[220,220,220,220,220],8=>[310,310,310,310,310]}  
    elsif @mode == "fist" #fist weapons   
    @angles = {2=>[110,120,130,140,100],4=>[10,20,30,40,0],6=>[230,240,250,260,220],8=>[320,330,340,350,310]}
    else
    @angles = {2=>[80,110,140,170,50],4=>[340,10,40,70,310],6=>[200,230,260,290,170],8=>[290,320,350,20,260]}
    end    
    ##### cust weap #####
    @correction = {2=>[-8,-10],4=>[0,-10],6=>[0,-4],8=>[4,-10]}
    @z_values = {2=>120,4=>50,6=>120,8=>50}    
  end  
  def refresh_weapon        
    @weapon_bitmap.dispose unless @weapon_bitmap.nil?
    @weapon_bitmap = nil
    return if $game_party.members.empty?
    index = ($game_party.members[0].weapons[0].icon_index rescue nil)
    unless index == nil
      temp = Cache.system("Iconset")    
      bnx = 24
      bny = 24
      recx = 24
      recy = 24
      fac = 1
    if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[369]        
      fac *= 1.5
    end    
    if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[395]
      fac *= 1.5
    end        
    @wep = $game_party.leader.equips[0].id rescue 0
    @bigW = [76,77,78,80,88,89,90,91,92,96,106,109,111,124,130,162,163,171]
    @hugeW = [134,158]   
    #slingaxe COUNTING as big weapon for size (96)
    return if @wep == 0     
    if $game_party.leader.class_id == 174
    if $game_party.leader.equips[0].wtype_id == 3 || $game_party.leader.equips[0].wtype_id == 9 #lances/staves
      fac *= 1.5
    end
  end
    @sneks = [110,111,112,113,215]
    if $game_party.leader.equips[0].wtype_id == 11 #whips
      if @sneks.include?$game_party.leader.class_id
       fac *= 2.5
      else
       fac *= 1.5
      end
    end           
    if @bigW.include?@wep #Big Weapons
     fac *= 1.5
    elsif @hugeW.include?@wep #Huge Weapons
     fac *= 2.5     
   end   
    #MouSkill   
    if $game_switches[1877] == true && $game_party.leader.equips[0].wtype_id != 9 && $game_party.leader.equips[0].wtype_id != 10 && $game_party.leader.equips[0].wtype_id != 11
     fac *= 1.5
    end   
    if $game_variables[116] == "PitFighter" && $game_party.leader.equips[0].wtype_id == 2 #Pit Fighter Skill
       fac *= 1.5
    elsif $game_variables[116] == "Pikeman" && $game_party.leader.equips[0].wtype_id == 3 #Pikeman Skill
       fac *= 1.5
    end  
    if $game_party.members[0].id == 1 && $game_party.leader.equips[0].wtype_id == 2 #fist K
      if $game_variables[628] == 26 || $game_variables[628] == 126 || $game_variables[628] == 1026 #brawler
       fac *= 1.5
      end
    end        
      bnx *= fac
      bny *= fac
      recx *= fac
      recy *= fac
    ###  OCTOPUS TENTACLE
    #  temp2 = Cache.system("Iconset") 
    #  @weapon_bitmap = Bitmap.new(48,48)
    #  rect = Rect.new(index%16*24,index/16*24,24,24) 
    #  index2 = 787
    #  rect2 = Rect.new(index2%16*24,index2/16*24,24,24)      
    #  target = Rect.new(24, 24, 24,24)
    #  target2 = Rect.new(0, 0, 24,24)
    #  @weapon_bitmap.stretch_blt(target2, temp, rect) 
    #  @weapon_bitmap.stretch_blt(target, temp2, rect2) 
     ### 
        @weapon_bitmap = Bitmap.new(bnx,bny)        
        rect = Rect.new(index%16*24,index/16*24,24,24)        
        target = Rect.new(0, 0, recx, recy)
        @weapon_bitmap.stretch_blt(target, temp, rect)  
      temp.dispose
      temp = nil
    end
  end
  def dispose
    sas_dispose
    $game_map.sas_hud.hide
    $game_map.hide_particles
    $game_map.hide_damage_sprites
    @weapon_graphic.bitmap = nil
    unless @weapon_bitmap.nil?
      @weapon_bitmap.dispose
      @weapon_bitmap = nil
    end
    @weapon_graphic.dispose
    @weapon_graphic = nil
  end
  def update        
    sas_update
    update_particles
    update_damage_sprites
    update_weapon_graphic if @attacking
    if $game_switches[7335] == true
     $game_switches[7335] = false    
    ########
    custom_wep
    ########
    end
  end
  def update_damage_sprites
  end
  def update_particles
    $game_map.particles.each { |particle| particle.update; @trash << particle if particle.done }
    @trash.each { |item| $game_map.particles.delete(item) }
    @trash.clear
  end
 def update_weapon_graphic    
    @correction = {2=>[-8,-10],4=>[0,-10],6=>[0,-4],8=>[4,-10]}
    @weapon_graphic.x = $game_player.screen_x + @correction[$game_player.direction][0]
    @weapon_graphic.y = $game_player.screen_y + @correction[$game_player.direction][1]
    ##### cust weap #####
    @mode = "slash"
    @wep = $game_party.leader.equips[0].id rescue 0
    return if @wep == 0
    if $game_party.leader.equips[0].wtype_id == 7 || $game_party.leader.equips[0].wtype_id == 3 #daggers/lances
    @mode = "pierce"  
    end
    if $game_party.leader.equips[0].wtype_id == 2 || $game_party.leader.equips[0].wtype_id == 15 #fist / power gloves 
    @mode = "fist"  
    end  
    if $game_party.leader.equips[0].wtype_id == 1 || $game_party.leader.equips[0].wtype_id == 8 #axe/maces
    @mode = "heavy"  
    end     
    if @wep == 75 || @wep == 79 || @wep == 94 || @wep == 144 || @wep == 153 #rapier/pestle
    @mode = "pierce"
    end
    if @wep == 88 || @wep == 127 || @wep == 171 #sickle
    @mode = "slash"
    end
    if @mode == "pierce" #daggers/lances
    @angles = {2=>[130,130,130,130,130],4=>[40,40,40,40,40],6=>[220,220,220,220,220],8=>[310,310,310,310,310]}  
    elsif @mode == "fist" #fist weapons
    @angles = {2=>[110,120,130,140,100],4=>[10,20,30,40,0],6=>[230,240,250,260,220],8=>[320,330,340,350,310]}
    else
    @angles = {2=>[80,110,140,170,50],4=>[350,20,50,80,320],6=>[170,200,230,260,140],8=>[260,290,320,350,230]}
    end    
    ##### cust weap #####
    case @attack_timer
    when 15
      @weapon_graphic.angle = @angles[$game_player.direction][4]
      @weapon_graphic.z = @z_values[$game_player.direction]    
    when 12               
      @weapon_graphic.angle = @angles[$game_player.direction][0]
      @weapon_graphic.z = @z_values[$game_player.direction]
    when 9
      @weapon_graphic.angle = @angles[$game_player.direction][1]
      @weapon_graphic.z = @z_values[$game_player.direction]
    when 6        
      @weapon_graphic.angle = @angles[$game_player.direction][2]
      @weapon_graphic.z = @z_values[$game_player.direction]     
    when 3          
      @weapon_graphic.angle = @angles[$game_player.direction][3]
      @weapon_graphic.z = @z_values[$game_player.direction]  
    when 1..15
       spam = 0 
      if @mode == "heavy" && $game_switches[7330] == false
        if Input.press?(Input::X)
          spam = 1
        elsif WolfPad.trigger?(:X,0) || WolfPad.trigger?(:X,1)     
          spam = 1
        end
         if spam == 1   
         if Input.press?(Input::DOWN) || Input.press?(Input::LEFT) || Input.press?(Input::RIGHT) || Input.press?(Input::UP) || WolfPad.press?(:L_UP,0) || WolfPad.press?(:L_LEFT,0) || WolfPad.press?(:L_RIGHT,0) || WolfPad.press?(:L_DOWN,0) || WolfPad.press?(:L_UP,1) || WolfPad.press?(:L_LEFT,1) || WolfPad.press?(:L_RIGHT,1) || WolfPad.press?(:L_DOWN,1)
         $game_switches[7331] = false # no cd
         $game_switches[7330] = true
         else
         $game_switches[7331] = true # no cd
         end        
       end
       end
     when 0                   
       if @mode == "heavy" #rotation
         @cd = $game_player.direction
         case $game_player.direction
         when 2
         @nd = 6
         when 4  
         @nd = 2
         when 6
         @nd = 8  
         when 8
         @nd = 4
         end
         $game_player.set_direction(@nd)
        end 
      @attacking = false
      @weapon_graphic.bitmap = nil   
      $game_switches[7331] = false #no rotation  
      $game_switches[7330] = false #no moved malus
      if $game_variables[6530] >= 1
        $game_variables[6530] = 0
      end
    end
    @weapon_graphic.update
    @attack_timer -= 1
  end
  def weapon_animation
    return if @weapon_bitmap.nil?
    @weapon_graphic.bitmap = @weapon_bitmap
    @attacking = true
    @wep = $game_party.leader.equips[0].id rescue 0
    return if @wep == 0
    if $game_party.leader.equips[0].wtype_id == 8 || $game_party.leader.equips[0].wtype_id == 15 || $game_party.leader.equips[0].wtype_id == 1 || $game_party.leader.equips[0].wtype_id == 9 #axe/mace/staff
        @attack_timer = 15 
      else
        @attack_timer = 12
    end
  end
end

#-------------------------------------------------------------------------------
# * Game Map
#-------------------------------------------------------------------------------

class Game_Map
  include Pixel_Core
  attr_accessor :enemies
  attr_reader :sas_active
  attr_accessor :particles
  attr_accessor :skills
  attr_accessor :sas_hud
  attr_accessor :damage_sprites
  attr_reader :pixel_table
  alias kp_referesh_vehicles referesh_vehicles
  alias sas_update update
  alias sas_setup_events setup_events
  alias sas_initialize initialize
  def initialize
    sas_initialize
    @sas_hud = Sapphire_Hud.new
    @trash = []
  end
  def damage(target,value)
  end
  def level_up
  end
  def hide_damage_sprites
  end
  def show_damage_sprites
  end
  def setup_events
    @enemies = []
    sas_setup_events
  end
  def update(arg=false)
    sas_update(arg)
    update_skills
    update_action_system if @sas_active && arg
  end
  def update_action_system
    atk = 0
    skill = 0
    if Keys.trigger?(:A) 
      atk = 1
      elsif WolfPad.trigger?(:X,0) || WolfPad.trigger?(:X,1)
      atk = 1
     end  
   if Keys.trigger?(:S)
      skill = 1
     elsif WolfPad.trigger?(:R1,0) || WolfPad.trigger?(:R1,1) 
      skill = 1
   end  
    if atk == 1 || skill == 1    
    if $game_party.members[0].state?(157) == true #transmuted
     $game_temp.reserve_common_event(32) #Cancel Transmute
    end
    end  
    if atk == 1  
      $game_player.attack
    elsif skill == 1
      $game_player.cast_skill
      #if $game_party.members[0].equips.include?$data_weapons[15] #DoubleSkill
      # $game_player.set_direction(10-$game_player.direction)
      # puts("Cast2")
      # $game_player.recast_skill  
      # $game_player.set_direction(10-$game_player.direction)
      #end  
    end  
      if Keys.trigger?(:D)
      $game_player.next_skill
      elsif WolfPad.trigger?(:R2,0) || WolfPad.trigger?(:R2,1)
      $game_player.next_skill
      end
  end
  def start_sas
    return if $game_switches[4182] == true
    @sas_active = true
    $game_switches[739] = true
    $game_temp.reserve_common_event(53)
    end
  def pause_sas
    #$game_temp.reserve_common_event(32) #Cancel Transmute
    @sas_active = false
    $game_switches[739] = false
    #puts("pre call 56 in script")
    $game_temp.reserve_common_event(56)
    #puts("post call 56 in script")
  end
  def hide_particles
    virtual_particles = []
    @particles.each { |particle| virtual_particles << particle.release; particle.dispose }
    @particles = virtual_particles
  end
  def show_particles
    virtual_particles = @particles
    @particles = []
    virtual_particles.each { |vp| @particles << Sapphire_Restored_Particle.new(vp)}
    virtual_particles.clear
  end
  def delete_particles
    if @particles.nil?
      @particles = []
    else
      @particles.each { |particle| particle.dispose }
      @particles.clear
    end
  end
  def delete_skills
    if @skills.nil?
      @skills = []
    else
      @skills.each { |skill| skill.destroy }
      @skills.clear
    end
  end
  def delete_damage_sprites
  end
  def adjust_unlx(x)
    if @display_x.nil?
     return x
      else
     return x - @display_x
    end 
  end
  def adjust_unly(y)
    if @display_y.nil?
     return y
      else
     return y - @display_y
    end
  end
  def update_skills
    @skills.each { |skill| skill.update; @trash << skill if skill.done }
    @trash.each { |item| @skills.delete(item) }
    @trash.clear
  end
  def pixel_valid?(x, y)
    x >= 0 && x <= @pixel_wm && y >= 0 && y <= @pixel_hm
  end
  def referesh_vehicles
    setup_table
    delete_particles
    delete_skills
    delete_damage_sprites
    kp_referesh_vehicles
  end
  def setup_table
    @pixel_table = Table.new(width*Pixel, height*Pixel,6)
    for x in 0...(width*Pixel)
      for y in 0...(height*Pixel)
        @pixel_table[x,y,0] = table_player_collision(x*Tile,y*Tile)
        @pixel_table[x,y,1] = table_skill_collision(x*Tile,y*Tile)
        @pixel_table[x,y,3] = table_ladder(x*Tile,y*Tile)
        @pixel_table[x,y,4] = table_bush(x*Tile+Bush_Axis[0],y*Tile+Bush_Axis[1])
        @pixel_table[x,y,5] = table_counter(x*Tile+Counter_Axis[0],y*Tile+Counter_Axis[1])
      end
    end
    @pixel_wm = (width-1)*Pixel
    @pixel_hm = (height-1)*Pixel
  end
  def table_player_collision(x,y)
    return 0 unless table_pp((x+Body_Axis[0]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_pp((x+Body_Axis[2]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_pp((x+Body_Axis[0]).to_i,(y+Body_Axis[3]).to_i)
    return 0 unless table_pp((x+Body_Axis[2]).to_i,(y+Body_Axis[3]).to_i)
    return 1
  end
  def table_skill_collision(x,y)
    return 0 unless table_ps((x+Body_Axis[0]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_ps((x+Body_Axis[2]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_ps((x+Body_Axis[0]).to_i,(y+Body_Axis[3]).to_i)
    return 0 unless table_ps((x+Body_Axis[2]).to_i,(y+Body_Axis[3]).to_i)
    return 1
  end
  def refresh_table(start_x,start_y,end_x,end_y)
    for x in (start_x*Pixel)..(end_x*Pixel)
      for y in (start_y*Pixel)..(end_y*Pixel)
        @pixel_table[x,y,0] = table_pcrf(x*Tile,y*Tile)
        @pixel_table[x,y,1] = table_scrf(x*Tile,y*Tile)
      end
    end
  end
  def refresh_table_px(start_px,start_py,end_px,end_py)
    for x in start_px..end_px
      for y in start_py..end_py
        @pixel_table[x,y,0] = table_pcrf(x*Tile,y*Tile)
        @pixel_table[x,y,1] = table_scrf(x*Tile,y*Tile)
      end
    end
  end
  def table_pcrf(x,y)
    return 0 unless table_pprf((x+Body_Axis[0]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_pprf((x+Body_Axis[2]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_pprf((x+Body_Axis[0]).to_i,(y+Body_Axis[3]).to_i)
    return 0 unless table_pprf((x+Body_Axis[2]).to_i,(y+Body_Axis[3]).to_i)
    return 1
  end
  def table_scrf(x,y)
    return 0 unless table_psrf((x+Body_Axis[0]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_psrf((x+Body_Axis[2]).to_i,(y+Body_Axis[1]).to_i)
    return 0 unless table_psrf((x+Body_Axis[0]).to_i,(y+Body_Axis[3]).to_i)
    return 0 unless table_psrf((x+Body_Axis[2]).to_i,(y+Body_Axis[3]).to_i)
    return 1
  end
  def table_p(x,y,bit)
    layered_tiles(x,y).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0
      return true  if flag & bit == 0
      return false if flag & bit == bit
    end
    return false
  end
  def table_pp(x,y)
    layered_tiles(x,y).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0
      return true if flag & 0x0f == 0
      return false if flag & 0x0f == 0x0f
    end
    return false
  end
  def table_ps(x,y)
    layered_tiles(x,y).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0
      return true if flag & 0x0400 == 0
      return true if flag & 0x0f == 0
      return false if flag & 0x0f == 0x0f
    end
    return false
  end
  def table_pprf(x,y)
    all_tiles(x, y).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0
      return true if flag & 0x0f == 0
      return false if flag & 0x0f == 0x0f
    end
    return false
  end
  def table_psrf(x,y)
    all_tiles(x,y).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0
      return true if flag & 0x0400 == 0
      return true if flag & 0x0f == 0
      return false if flag & 0x0f == 0x0f
    end
    return false
  end
  def table_bush(x,y)
    return layered_tiles_flag?(x.to_i, y.to_i, 0x40) ? 1 : 0
  end
  def table_ladder(x,y)
    return 1 if layered_tiles_flag?(x.to_i,(y+Ladder_Axis[1]).to_i, 0x20)
    return 1 if layered_tiles_flag?((x+Ladder_Axis[0]).to_i, (y+Ladder_Axis[1]).to_i, 0x20)
    return 0
  end
  def table_counter(x,y)
    return 1 if layered_tiles_flag?(x.to_i,y.to_i, 0x80)
    return 1 if layered_tiles_flag?((x+Counter_Axis[2]).to_i,y.to_i, 0x80)
    return 1 if layered_tiles_flag?(x.to_i,(y+Counter_Axis[3]).to_i, 0x80)
    return 1 if layered_tiles_flag?((x+Counter_Axis[2]).to_i,(y+Counter_Axis[3]).to_i, 0x80)
    return 0
  end
end

if Pixel_Core::Auto_Refresh_Tile_Events
  class Game_Map
    def refresh_tile_events
      @tile_events = @events.values.select {|event| event.tile? }
      @tile_events.each { |event| refresh_table_px(event.px-TileEvent_Range,event.py-TileEvent_Range,event.px+TileEvent_Range,event.py+TileEvent_Range)}
    end
  end
end

#-------------------------------------------------------------------------------
# * Game CharacterBase
#-------------------------------------------------------------------------------

class Game_CharacterBase
  include Pixel_Core
  attr_accessor :px
  attr_accessor :py
  attr_accessor :cx
  attr_accessor :cy
  alias kp_moveto moveto
  alias kp_move_straight move_straight
  alias kp_move_diagonal move_diagonal
  alias kp_bush? bush?
  alias kp_ladder? ladder?
  alias kp_terrain_tag terrain_tag
  alias kp_region_id region_id
  alias sas_update update
  alias sas_public_members init_public_members
  alias sas_straighten straighten
  def pixel_range?(px,py)
    return (@px - px).abs <= @cx && (@py - py).abs <= @cy
  end
  def update
    sas_update
    update_step_action if @step_action
  end
  def straighten
    sas_straighten
    @step_action = false
    @step_timer = 0
  end
  def update_step_action
    case @step_timer
    when 12; @pattern = 0
    when 8; @pattern = 1
    when 4; @pattern = 2
    when 0
      @step_action = false
      @pattern = 1
      return
    end
    @step_timer -= 1
  end
  def do_step
    @step_action = true
    @step_timer = 12
  end
  def init_public_members
    sas_public_members
    @x = @x.to_f
    @y = @y.to_f
    @px = (@x*Pixel).to_i
    @py = (@y*Pixel).to_i
    @cx = Default_Collision_X
    @cy = Default_Collision_Y
    @step_action = false
    @step_timer = 0
  end
  def moveto(x,y)
    kp_moveto(x,y)
    @x = @x.to_f
    @y = @y.to_f
    @px = (@x*Pixel).to_i
    @py = (@y*Pixel).to_i
  end
  def pixel_passable?(px,py,d)
    nx = px+Tile_Range[d][0]
    ny = py+Tile_Range[d][1]
    return false unless $game_map.pixel_valid?(nx,ny)
    return true if @through || debug_through?
    return false if $game_map.pixel_table[nx,ny,0] == 0
    return false if collision?(nx,ny)
    return true
  end
  def collision?(px,py)
    for event in $game_map.events.values
      if (event.px - px).abs <= event.cx && (event.py - py).abs <= event.cy
        next if event.through || event == self
        return true if event.priority_type == 1
      end
    end
    if @priority_type == 1
      return true if ($game_player.px - px).abs <= @cx && ($game_player.py - py).abs <= @cy
    end
    return false
  end
  def move_straight(d,turn_ok = true)
    move_pixel(d,turn_ok)
  end
  def move_diagonal(horz, vert)
    move_dpixel(horz,vert)
  end
  def move_pixel(d,t)
    @move_succeed = pixel_passable?(@px,@py,d)
    if @move_succeed
      set_direction(d)
      @px += Tile_Range[d][0]
      @py += Tile_Range[d][1]
      @real_x = @x
      @real_y = @y
      @x += Pixel_Range[d][0]
      @y += Pixel_Range[d][1]
      increase_steps
    elsif t
      set_direction(d)
      front_pixel_touch?(@px + Tile_Range[d][0],@py + Tile_Range[d][1])
    end
  end
  def move_dpixel(h,v)
    @move_succeed = false
    if pixel_passable?(@px,@py,v)
      @move_succeed = true
      @real_x = @x
      @real_y = @y
      set_direction(v)
      @px += Tile_Range[v][0]
      @py += Tile_Range[v][1]
      @x += Pixel_Range[v][0]
      @y += Pixel_Range[v][1]
      increase_steps
    else
      set_direction(v)
      front_pixel_touch?(@px + Tile_Range[v][0],@py + Tile_Range[v][1])
    end
    if pixel_passable?(@px,@py,h)
      unless @move_succeed 
        @real_x = @x
        @real_y = @y
        @move_succeed = true
      end
      set_direction(h)
      @px += Tile_Range[h][0]
      @py += Tile_Range[h][1]
      @x += Pixel_Range[h][0]
      @y += Pixel_Range[h][1]
      increase_steps
    else
      set_direction(h)
      front_pixel_touch?(@px + Tile_Range[h][0],@py + Tile_Range[h][1])
    end
  end
  def bush?
    return $game_map.pixel_table[@px, @py, 4] == 1
  end
  def ladder?
    return $game_map.pixel_table[@px, @py, 3] == 1
  end
  def terrain_tag
    rx = ((@px % Pixel) > 1 ? @x.to_i + 1 : @x.to_i)
    ry = ((@py % Pixel) > 1 ? @y.to_i + 1 : @y.to_i)
    return $game_map.terrain_tag(rx,ry)
  end
  def region_id
    rx = ((@px % Pixel) > 1 ? @x.to_i + 1 : @x.to_i)
    ry = ((@py % Pixel) > 1 ? @y.to_i + 1 : @y.to_i)
    return $game_map.region_id(rx, ry)
  end
  def front_pixel_touch?(x,y)
  end
end

#-------------------------------------------------------------------------------
# * Game FakeFollowers
#-------------------------------------------------------------------------------

class Game_FakeFollowers
  attr_accessor :visible
  def initialize
    @visible = true
  end
  def refresh
  end
  def update
  end
  def gathering?
    return false
  end
  def synchronize(x,y,d)
  end
  def collide?(x,y)
    return false
  end
  def gather
  end
  def gather?
    return true
  end
  def reverse_each
    return []
  end
  def each
    return []
  end
end

#-------------------------------------------------------------------------------
# * Game Character
#-------------------------------------------------------------------------------

class Game_Character < Game_CharacterBase
  attr_accessor :pattern 
  alias kp_force_move_route force_move_route
  alias kp_move_toward_character move_toward_character
  alias kp_move_away_from_character move_away_from_character
  alias kp_jump jump
  def force_move_route(route)
    kp_force_move_route(route.clone)
    multiply_commands
  end
  def multiply_commands
    return unless Multiply_Commands
    return if @move_route.list.empty?
    new_route = []
    for cmd in @move_route.list
      if Commands.include?(cmd.code)
        Pixel.times do
          new_route << cmd
        end
      else
        new_route << cmd
      end
    end
    @move_route.list = new_route
  end
  def move_toward_character(character)
    if $game_switches[1412] == false #HUD off in menus
     if $game_switches[3701] == true #Crys DMG
       $game_switches[3701] = false
      value = ($game_party.members[0].hp * 5 ) * $game_party.members[0].mdf 
      value += rand(value*Sapphire_Core::Damage_Random).to_i
      if value < 0
        then
        value = 0
      end
      if @character_name != ""
      damage_enemy(value)
      end
      $game_variables[2040] += 1
    end   
     if $game_switches[3936] == true #Fear DMG
       $game_switches[3936] = false
      value = $game_party.members[0].mat * $game_party.members[0].mat 
      value += rand(value*Sapphire_Core::Damage_Random).to_i
      if value < 0
        then
        value = 0
      end
      if @character_name != ""
      damage_enemy(value)
      end
      $game_variables[3442] += 1
    end       
 if $game_switches[1785] == true #ZzZ
 @balloon_id = 10 if Sapphire_Core::Enemy_Exclamation
 else
    if !$game_switches[986] && !$game_switches[3485] && !$game_switches[2298]
    if $game_switches[1451] #Enticing 
        $game_variables[901] += 1 #bf trigger         
        @balloon_id = 4 if Sapphire_Core::Enemy_Exclamation  
    end   
    if $game_switches[1147] #Allure
      @balloon_id = 4 if Sapphire_Core::Enemy_Exclamation  
    end
    if $game_switches[1148] #Allure DMG 
      allure = 0
      if $game_party.leader.id == 21 && $game_switches[4118] == true
        allure = 1
      end       
     if $game_party.leader.state?(169) == true #Sweet Scent
        allure = 1
      end           
     if allure == 0 #NOT fairy moth / sweet scent
      $game_switches[1148] = false
      @balloon_id = 4 if Sapphire_Core::Enemy_Exclamation
      if $game_party.leader.id == 1 #protag
      value = 5 * $game_party.members[0].mat
      else
      @lust = $game_party.members[0].parent_stat(1)
      if $game_variables[116] == "TaintedLove" #Tainted Love Skill
        @lust += $game_party.members[0].parent_stat(0)
      end  
      value = (@lust * 5 ) * $game_party.members[0].mat
      value += rand(value*Sapphire_Core::Damage_Random).to_i
      end
      if value < 0
        then
        value = 0
      end
      if @character_name != ""
      damage_enemy(value)
      end
      $game_variables[883] += 1
    end
  end
    if !$game_switches[3485]
    dx = @px - character.px
    dy = @py - character.py
    if dx.abs < character.cx
      unless dy.abs < character.cy
        move_pixel(dy < 0 ? 2 : 8,true) 
        unless @move_succeed
          return if dx.abs - Chase_Axis[@direction][0] <= @cx && dy.abs - Chase_Axis[@direction][1] <= @cy
          move_dpixel(dx < 0 ? 6 : 4, dy < 0 ? 2 : 8)
        end
      end
     else
      if dy.abs < character.cy
        move_pixel(dx < 0 ? 6 : 4,true)
        unless @move_succeed
          return if dx.abs - Chase_Axis[@direction][0] <= @cx && dy.abs - Chase_Axis[@direction][1] <= @cy
          move_dpixel(dx < 0 ? 6 : 4, dy < 0 ? 2 : 8)
        end
      else
        move_dpixel(dx < 0 ? 6 : 4, dy < 0 ? 2 : 8)
      end
    end
    end
  else
  if $game_switches[2298]
  @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation  
  end
  if $game_switches[986]
  @balloon_id = 6 if Sapphire_Core::Enemy_Exclamation  
    if $game_switches[3793] #Intense Fear
      if $game_variables[883] < 3
      value = $game_party.members[0].mat * $game_party.members[0].mat
      value += rand(value*Sapphire_Core::Damage_Random).to_i
      if value < 0
        then
        value = 0
      end      
      if @character_name != ""
      damage_enemy(value)
      end
      $game_variables[883] += 1
      end
    end      
  end  
  if $game_switches[883] == true
  @balloon_id = 6 if Sapphire_Core::Enemy_Exclamation  
  end
  if $game_switches[3485]
  @balloon_id = 3 if Sapphire_Core::Enemy_Exclamation  
end
  if !$game_switches[3485]
  dx = @px - character.px
    dy = @py - character.py
    if dx == 0
      move_pixel(dy > 0 ? 2 : 8,true)
    else
      if dy == 0 
        move_pixel(dx > 0 ? 6 : 4,true)
      else
        move_dpixel(dx > 0 ? 6 : 4, dy > 0 ? 2 : 8)
      end
    end
  end
  end
end
end
end
  def move_away_from_character(character)
    dx = @px - character.px
    dy = @py - character.py
    if dx == 0
      move_pixel(dy > 0 ? 2 : 8,true)
    else
      if dy == 0 
        move_pixel(dx > 0 ? 6 : 4,true)
      else
        move_dpixel(dx > 0 ? 6 : 4, dy > 0 ? 2 : 8)
      end
    end
  end
  def jump(xp,yp)
    kp_jump(xp,yp)
    @px = @x*Pixel
    @py = @y*Pixel
  end
end

#-------------------------------------------------------------------------------
# * Game Player
#-------------------------------------------------------------------------------

class Game_Player < Game_Character
  attr_accessor :recover
  attr_accessor :current_skill
  alias sas_initialize initialize
  alias sas_player_update update
  def update
    sas_player_update
    @recover -= 1 if @recover > 0
  end
  def straighten
    super
    refresh_weapon_stats
    @recover = 0
  end
  def initialize
    sas_initialize
    @followers = Game_FakeFollowers.new
    @current_skill = [nil,nil]
  end
  def update_vehicle
  end
  def cast_skill
    @wep = $game_party.leader.equips[0].id rescue 0
    return if $game_switches[2932] == true || $game_switches[1195] == true #BF/whip BF
    if $game_party.leader.class_id >= 132 && $game_party.leader.class_id <= 135 #crystal Skill Harden
      $game_player.animation_id = 228
      $game_party.members[0].add_state(51)
      else
    return if @current_skill[0].nil? || @recover > 0
    paid = 0
    ### HP SKILLS ###
    if @current_skill[0].id == 339 #overclock
      @skillDMG = $game_party.leader.mhp / 20
     if $game_party.members[0].hp <= @skillDMG || $game_party.members[0].state?(248) == true
        $game_player.balloon_id = 6
        RPG::SE.new("Paralyze1", 100, 100).play
        message = "OVERHEAT"
        $game_map.show_text($game_player,message)
       else
      $game_party.members[0].hp -= @skillDMG 
      $game_player.animation_id = 394
      $game_party.members[0].add_state(248)
      $game_map.sas_hud.refresh_bars
      end
      return
    end  
    @hpSkills = [206,279,280,281,282,283,284,285,286] #bone throw/shrapnel
     if @hpSkills.include?@current_skill[0].id
        @skillDMG = $game_party.leader.mhp / 50
     if $game_party.members[0].hp <= @skillDMG
        $game_party.members[0].hp = 1
        kill_player
     else
      $game_party.members[0].hp -= @skillDMG 
    end        
      message = "- #{@skillDMG}"
      $game_map.show_text($game_player,message)
      $game_map.sas_hud.refresh_bars      
      paid = 1
    end   
    @mpCost = @current_skill[0].mp_cost
    if @wep != 0 #GobSkill
    if $game_switches[1875] == true && $game_party.leader.equips[0].wtype_id == 10
      @mpCost *= 3
    end  
    end
    ### SWIRLIES SKILLS ###      
    if $game_variables[116] == "SwirlyAmmo" && $game_variables[584] >= @mpCost #SwirlyAmmo Skill
      paid = 1
      RPG::SE.new("coin", 100, 100).play
      $game_variables[585] = 0
      $game_variables[585] -= @mpCost
      $game_switches[648] = true 
    else
    return if $game_party.members[0].mp < @mpCost
    end
    $game_variables[7777] = @current_skill[0].id
    if $game_variables[7777] == 299 #Yako Skill
      $game_switches[3468] = true
    end  
    $game_variables[7777] = 0
    $game_map.skills << Sapphire_Skill.new(self)
    if paid == 0 #no paid in Swirlies/HP
    $game_party.members[0].mp -= @mpCost
    $game_map.sas_hud.refresh_bars
    end
    @recover = @current_skill[0].recover
    if $game_variables[116] == "YinYang" #YinYang Skill
      @agiscore = $game_party.members[0].atk
    else
      @agiscore = $game_party.members[0].agi
    end 
    
    if $game_party.leader.state?(64) == true
     @recover -= @agiscore/10 #agi MS influence 
      else
     @recover -= @agiscore/15 #agi MS influence
   end
    if $game_party.members[0].state?(218) == true #dog rush
      @recover *= 0.8
    end     
    if $game_party.members[0].state?(248) == true #overclocked
      @recover *= 0.75
    end
    if $game_variables[116] == "Flurry"
      @recover *= 0.8
    end  
   return if @wep == 0   
   @wepId = $game_party.leader.equips[0].wtype_id  
    if $game_switches[1875] == true && @wepId == 10 #GobSkill
      @recover *= 0.4
    end       
   if $game_party.members[0].id == 1 && @wepId == 4 && $game_variables[628] == 1002 #battleready++
      @recover *= 0.75
   end         
   if $game_party.members[0].id == 1 && @wepId == 2 && $game_variables[628] == 1026 #brawler++
      @mod = ($game_party.leader.hp/$game_party.leader.mhp)*100
        if @mod < 25
          @mod = 0.5
        else
          @mod = 1
        end
     @recover *= @mod      
   end   
 end
#DOUBLE CAST
doublecast = ($game_party.members[0].luk * $game_party.members[0].luk) / 1000
doublecast = [([doublecast,1].max),25].min
if $game_variables[116] == "ForkedTongue"
  doublecast *= 2
end 
if $game_party.members[0].equips.include?$data_weapons[173] #hydra baton
  doublecast *= 2  
end  
if $game_party.members[0].equips.include?$data_armors[999] #test item
  doublecast *= 1.2  
end  
chance = rand(100)
if doublecast > chance
  RPG::SE.new("Reflection", 110, 100).play
  message = "And Another!!"
  $game_map.show_text($game_player,message)
  $game_player.recast_skill #Double Cast!
end
#############
  if $game_party.members[0].equips.include?$data_armors[806] #epocS rennI
    $game_player.set_direction(10-$game_player.direction)
    $game_player.recast_skill  
    $game_player.set_direction(10-$game_player.direction)
  end   
 end
#######
  def recast_skill
    @wep = $game_party.leader.equips[0].id rescue 0
    return if $game_switches[2932] == true || $game_switches[1195] == true #BF/whip BF
    return if @current_skill[0].nil?
    $game_map.skills << Sapphire_Skill.new(self)
  end
#######  
  def next_skill
    unless @current_skill[1].nil?
      @current_skill[1] = nil
    end
    skills = $game_party.members[0].skills
    if skills.empty?
      @current_skill = [nil,nil] 
    else
      ns = 0
      unless @current_skill[0].nil?
        max = skills.size-1
        for id in 0..max
          ns = (id == max ? 0 : id + 1) if skills[id] == @current_skill[0]
        end
      end
      skills[ns].set_recover
      @current_skill = [skills[ns],skills[ns].particle]
      $game_map.sas_hud.refresh_base
    end
  end
  def damage_hero(value)
    $game_switches[7477] = false #borea Dance stop
    if $game_party.members[0].state?(157) == true #transmuted
    $game_temp.reserve_common_event(32) #Cancel Transmute
    end
    if $game_party.members[0].id == 1 && $game_variables[628] == 1026 #brawler++
      @chHP = ($game_party.leader.hp/$game_party.leader.mhp)*100      
       if @chHP < 25 && $game_variables[772] == 0
        message = "Fired Up!"
        $game_map.show_text($game_player,message)
        $game_variables[772] = 1
       else
        $game_variables[772] = 0
       end
    end      
  ###
      @lust = $game_party.members[0].parent_stat(1)
      if $game_variables[116] == "TaintedLove" #Tainted Love Skill
        @lust += $game_party.members[0].parent_stat(0)
      end  
  ###    
    actor = $game_party.members[0]     
    if $game_switches[1186]
      value += 15
    end
    if $game_party.members[0].equips[4] == $data_armors[97] && $game_party.members[0].parent_stat(2) >= 5#paladin relic
      @r = rand(10)
      if @r > 8
      $game_player.animation_id = 259
      actor = $game_party.members[0]
      heal = actor.mhp / 10 # 5% heal
      actor.hp += heal
      message = "+ #{heal}"
      $game_map.show_text($game_player,message)
      $game_map.sas_hud.refresh_bars
      end
    end  
    if $game_party.leader.class_id == 156 && $game_variables[4134] <= 2 #wendigo stress
      $game_variables[4134] += 1
      $game_temp.reserve_common_event(137)
    end    
    ### CHECK PLAYER DEF ###
    @freeze = $game_party.members[0].def
    ### CHECK PLAYER DEF ###
    if $game_variables[116] == "ChainArmor" #ChainArmor Skill
    @freeze = ($game_party.members[0].def + $game_party.members[0].agi)/2
    end     
    if $game_variables[116] == "BlindLuck" #BlindLuck Skill
    @freeze = ($game_party.members[0].def + $game_party.members[0].luk)/2
    end   
    if $game_party.members[0].state?(165) == true #barkskin
    @shiSlot = $game_party.members[0].armors[0].etype_id rescue -1
     if @shiSlot == 1 #in Shield Eq Slot
      @freeze += $game_party.members[0].equips[1].params[3]
    end    
      @freeze += $game_party.members[0].equips[2].params[3]
      @freeze += $game_party.members[0].equips[3].params[3]
    end 
    if $game_party.members[0].state?(64) == true #charge
      if $game_party.members[0].equips[3]
      @freeze -= $game_party.members[0].equips[3].params[3] #chest DEF
      end
      if $game_party.members[0].equips[4]
      @freeze -= $game_party.members[0].equips[4].params[3] #acc DEF
      end           
    end      
    if $game_party.leader.equips[1] == $data_armors[323] && $game_switches[3691] == true #oozing shield
      @freeze += 20
    end      
    value = (value/@freeze)*(rand(15)+85)/100
    if $game_variables[116] == "Arrogant" #Arrogant Skill
      value += (value*30/100)
    elsif $game_variables[116] == "FelineArr" #FelineArr Skill
      value += (value*40/100)      
    end   
    #--------------------------# 
    if $game_variables[116] == "Discharge" #Discharge Skill
       @r = rand(10)
       if @r < 1
         $game_temp.reserve_common_event(359)
       end  
    end      
    #--------------------------#    
    allski = $game_variables[114] rescue ""
    unless allski == "" || allski == 0
    if allski.include? "GiveAndTake" #GiveAndTake Skill  
      $game_variables[35] = actor.id
      $game_variables[306] = value
      $game_temp.reserve_common_event(356)
      value = $game_variables[306]
    end   
    end
    #--------------------------#     
   if $game_variables[116] == "BroodLeader" && $game_variables[3010] < 3 #BroodLead
     $game_variables[3010] += 1   
     value = 0
     $game_player.animation_id = 372
     $game_temp.reserve_common_event(969)
   end      
    #--------------------------#    
    if $game_party.members[0].equips[3] == $data_armors[158] && $game_variables[584] >= value
      RPG::SE.new("coin", 100, 100).play
      $game_variables[585] = 0
      $game_variables[585] -= value
    @love = $game_party.members[0].parent_stat(0)
      if $game_variables[116] == "TaintedLove" #Tainted Love Skill
        @love += $game_party.members[0].parent_stat(1)
      end    
    if @love >= 5 #love effect
      $game_variables[585] *= 0.8
    elsif @love >= 3
      $game_variables[585] *= 0.9
    end
      value = 0
      $game_switches[648] = true   
    ### END?  
  if $game_party.leader.id >= 35 && $game_party.leader.id <= 39 && $game_party.leader.class_id < 50 && $game_party.leader.class_id != 18 #try shades
        $game_variables[900] = rand(5)
          if $game_variables[900] <= 1 
              $game_player.balloon_id = 4
              $game_variables[901] += 1+ rand(2)              
              if $game_variables[901] >= 3
                $game_variables[901] = 0
                 if $game_switches[2584] == false
                 $game_switches[1195] = true
               end
             end
           end
         end #try shades END  
      @rap = 1 #BattleFuck Check  
      if $game_party.leader.id == 1 #Protag
      @rap = 0
      end 
      if $game_party.leader.id == 16 && $game_switches[1075] == true #Dash Dog
      @rap = 0
      end    
      if $game_party.leader.id == 23 && $game_switches[4181] == true #Moon Cat
      @rap = 0
      end
      if $game_party.leader.id >= 35 && $game_party.leader.id <= 39 #Progeny
      @rap = 0
      ### check recruits ###
      @prBF = 2250
      while @prBF <= 2750
        if $game_party.leader.name == $game_variables[@prBF][2]
          if $game_party.leader.class_id == 163 #404B
            $game_variables[@prBF][57] += value
            @rap = 0
            break
          end  
          if $game_variables[@prBF][51] == 3 || $game_variables[@prBF][51] == 1
            @rap = 1
          end
          break
        end  
      @prBF += 1
    end  
    end    
      ### check recruits ###    
if $game_party.leader.class_id == 130 #mecha mouse
      @rap = 0
elsif $game_party.leader.class_id >= 132 && $game_party.leader.class_id <= 136 #Crystal Prog
      @rap = 0              
elsif $game_party.leader.class_id == 119 #Moss
      @rap = 1        
elsif $game_party.leader.class_id == 121 #Crusader
      @rap = 1  
elsif $game_party.leader.class_id == 122 #Scarecrow
      @rap = 1        
elsif $game_party.leader.class_id == 164 #Fina
      @rap = 0       
elsif $game_party.leader.class_id == 165 #Yako
      @rap = 1 
elsif $game_party.leader.class_id == 166 #Bloo
      @rap = 1    
elsif $game_party.leader.class_id == 173 #Salizzie
      @rap = 1     
elsif $game_party.leader.class_id == 174 #Wuchan
      @rap = 1      
elsif $game_party.leader.class_id == 175 #Marie
      @rap = 1   
elsif $game_party.leader.class_id == 176 #Vashti
      @rap = 0  
elsif $game_party.leader.class_id == 178 #Lolly
      @rap = 1        
elsif $game_party.leader.class_id == 179 #Victoria
      @rap = 1    
elsif $game_party.leader.class_id == 180 #Carolina
      @rap = 0    
elsif $game_party.leader.class_id == 181 #Chain
      @rap = 1  
elsif $game_party.leader.class_id == 182 #Pruszka
      @rap = 1  
elsif $game_party.leader.class_id == 183 #Borea
      @rap = 0       
elsif $game_party.leader.class_id == 184 #Harriet
      @rap = 1
elsif $game_party.leader.class_id == 189 #Kariddi
      @rap = 0      
elsif $game_party.leader.class_id == 190 #Princess
      @rap = 1  
elsif $game_party.leader.class_id == 191 #TasBOT
      @rap = 0      
elsif $game_party.leader.class_id == 192 #Broodmother
      @rap = 1
elsif $game_party.leader.class_id == 202 #Feather
      @rap = 0      
elsif $game_party.leader.class_id == 203 #Zalfos
      @rap = 0
elsif $game_party.leader.class_id == 207 #Shroom
      @rap = 0      
elsif $game_party.leader.class_id == 209 #FemK
      @rap = 0      
elsif $game_party.leader.class_id == 210 #SpikaP
      @rap = 1   
elsif $game_party.leader.class_id == 211 #Imps31
      @rap = 0
elsif $game_party.leader.class_id == 212 #Orca
      @rap = 1         
elsif $game_party.leader.class_id == 215 #Vendra
      @rap = 0               
elsif $game_party.leader.class_id == 167 #Gaita     
      if $game_switches[7461] == false
       @rap = 1 
      else
       @rap = 0
      end  
elsif $game_party.leader.class_id == 123 #Mimic
      @rap = 1  
elsif $game_party.leader.class_id == 156 #Wendigo
      @rap = 1  
elsif $game_party.leader.class_id == 157 #Eldritch
      @rap = 1  
elsif $game_party.leader.class_id == 120 #Crystal
      @rap = 1  
elsif $game_party.leader.class_id == 18 && $game_switches[3787] == false #Amelie 
      @rap = 1  
    end
   @noBFmaps = [87,477,495,507,509,510,511,513,536,537]
   if @noBFmaps.include?$game_map.map_id
     @rap = 0
   end
      if $game_party.leader.equips[4] == $data_armors[318] #suction urchin
      @rap = 0
    end   
    if $game_variables[393] == 0 || $game_variables[393].nil?
      $game_variables[393] = ""
    end    
    if $game_variables[393].include?"Cucco"
      @rap = 0
    elsif $game_variables[393].include?"Cocca"
      @rap = 0      
    elsif $game_variables[393].include?"Bake"
      @rap = 0
    elsif $game_variables[393].include?"Hippo"
      @rap = 0
    elsif $game_variables[393].include?"Chisel"
      @rap = 0
    elsif $game_variables[393].include?"Daimyo"
      @rap = 0
    elsif $game_variables[393].include?"Narag"
      @rap = 0
    elsif $game_variables[393].include?"Agathe"
      @rap = 0      
    end     
    if @character_name == "$LewdCrawler" || @character_name == "$LewdCrawlerATK"
      @lim = 1
    else      
    if @lust >= 10
       @lim = 1
    elsif @lust >= 5
       @lim = 2           
    elsif @lust >= 3
       @lim = 3     
    else
       @lim = 5
    end 
  end      
    #if @character_name.include?"MothImage"
    #if $game_party.leader.id == 1
    #  $game_switches[792] = true
    #  @lim = 1
    #  @lust = 1
    #  @rap = 1
    #end  
    #end
    if $game_party.leader.state?(169) == true #Sweet Scent
      @lim = 1
      @lust = 1
    end      
     if @rap == 1 && @lust >= 1 && $game_switches[2584] == false
          $game_variables[900] = rand(6 - @lust)
            if $game_variables[900] <= 1 
            #######  
              $game_variables[901] += 1
            #######            
            if ($game_variables[901]*100/@lim) < 34
              $game_player.balloon_id = 20
            elsif ($game_variables[901]*100/@lim) < 67
              $game_player.balloon_id = 21
            else
              $game_player.balloon_id = 22
            end
            #######               
              if $game_variables[901] >= @lim
                 $game_variables[901] = 0
                 $game_switches[1195] = true
              end
              end
             end
         #end
      else         
    if $game_switches[1195] == true
      value = 0
    end 
    if $game_switches[1197] == true #after death immunity
      value = 0
    end      
    value = 0 if value < 0
    if value > 0 && $game_switches[3694] == true   
      $game_variables[2946] -= 24
      if $game_variables[2946] <= 0
        $game_variables[2946] = 0
      end
    end  
    $game_map.show_text(self,value)
    if actor.hp <= value
      actor.hp = 1
      $game_map.sas_hud.refresh_bars(0)
      #  if $game_party.leader.id == 9
      #    atk = $game_variables[866]
      #    $game_actors[9].add_param(2, -atk)
      #    $game_variables[866] = 0
      #    $game_temp.reserve_common_event(131)
      #  end 
      kill_player
      $game_variables[901] = 0
     else
      actor.hp -= value   
    if $game_variables[116] == "Coward" #Coward Skill
      $game_player.balloon_id = 6
      $game_temp.reserve_common_event(45)
    end           
  end
    #end               
      $game_map.sas_hud.refresh_bars
      if $game_switches[1195] == false && $game_switches[1197] == false #no immunities
  if $game_party.leader.id >= 35 && $game_party.leader.id <= 39 && $game_party.leader.class_id < 50 && $game_party.leader.class_id != 18 #try shades
        $game_variables[900] = rand(5)
          if $game_variables[900] <= 1 
              $game_player.balloon_id = 4
              $game_variables[901] += 1 + rand(2)
              if $game_variables[901] >= 3
                $game_variables[901] = 0
                 if $game_switches[2584] == false
                 $game_switches[1195] = true
               end
             end
           end
        end #try shades END            
      @rap = 1   
      if $game_party.leader.id == 1 #Protag
      @rap = 0
    end
      if $game_party.leader.id == 16 && $game_switches[1075] == true #Dash Dog
      @rap = 0
      end        
      if $game_party.leader.id == 23 && $game_switches[4181] == true #Moon Cat
      @rap = 0
      end
      if $game_party.leader.id >= 35 && $game_party.leader.id <= 39 #Progeny
      @rap = 0
      ### check recruits ###
      @prBF = 2250
      while @prBF <= 2750
        if $game_party.leader.name == $game_variables[@prBF][2]
          if $game_party.leader.class_id == 163 #404B
            $game_variables[@prBF][57] += value
            @rap = 0
            break
          end  
          if $game_variables[@prBF][51] == 3 || $game_variables[@prBF][51] == 1
            @rap = 1
          end
          break
        end  
      @prBF += 1
      end  
      ### check recruits ###      
    end
      if $game_party.leader.class_id == 130 #mecha mouse
      @rap = 0
elsif $game_party.leader.class_id >= 132 && $game_party.leader.class_id <= 136 #Crystal Prog
      @rap = 0      
elsif $game_party.leader.class_id == 119 #Moss
      @rap = 1   
elsif $game_party.leader.class_id == 121 #Crusader
      @rap = 1  
elsif $game_party.leader.class_id == 122 #Scarecrow
      @rap = 1 
elsif $game_party.leader.class_id == 164 #Fina
      @rap = 0 
elsif $game_party.leader.class_id == 165 #Yako
      @rap = 1          
elsif $game_party.leader.class_id == 166 #Bloo
      @rap = 1    
elsif $game_party.leader.class_id == 173 #Salizzie
      @rap = 1    
elsif $game_party.leader.class_id == 174 #Wuchan
      @rap = 1            
elsif $game_party.leader.class_id == 175 #Marie
      @rap = 1      
elsif $game_party.leader.class_id == 176 #Vashti
      @rap = 0    
elsif $game_party.leader.class_id == 178 #Lolly
      @rap = 1       
elsif $game_party.leader.class_id == 179 #Victoria
      @rap = 1    
elsif $game_party.leader.class_id == 180 #Carolina
      @rap = 0    
elsif $game_party.leader.class_id == 181 #Chain
      @rap = 1  
elsif $game_party.leader.class_id == 182 #Pruszka
      @rap = 1  
elsif $game_party.leader.class_id == 183 #Borea
      @rap = 0        
elsif $game_party.leader.class_id == 184 #Harriet
      @rap = 1  
elsif $game_party.leader.class_id == 189 #Kariddi
      @rap = 0          
elsif $game_party.leader.class_id == 190 #Princess
      @rap = 1          
elsif $game_party.leader.class_id == 191 #TasBOT
      @rap = 0            
elsif $game_party.leader.class_id == 192 #Broodmother
      @rap = 1      
elsif $game_party.leader.class_id == 202 #Feather
      @rap = 0         
elsif $game_party.leader.class_id == 203 #Zalfos
      @rap = 0      
elsif $game_party.leader.class_id == 207 #Shroom
      @rap = 0   
elsif $game_party.leader.class_id == 209 #FemK
      @rap = 0        
elsif $game_party.leader.class_id == 210 #SpikaP
      @rap = 1         
elsif $game_party.leader.class_id == 211 #Imps31
      @rap = 0 
elsif $game_party.leader.class_id == 212 #Orca
      @rap = 1         
elsif $game_party.leader.class_id == 215 #Vendra
      @rap = 0       
elsif $game_party.leader.class_id == 167 #Gaita      
      if $game_switches[7461] == false
       @rap = 1 
      else
       @rap = 0
      end          
elsif $game_party.leader.class_id == 123 #Mimic
      @rap = 1  
elsif $game_party.leader.class_id == 156 #Wendigo
      @rap = 1  
elsif $game_party.leader.class_id == 157 #Eldritch
      @rap = 1         
elsif $game_party.leader.class_id == 120 #Crystal
      @rap = 1  
elsif $game_party.leader.class_id == 18 && $game_switches[3787] == false #Amelie 
      @rap = 1  
    end
   @noBFmaps = [87,477,495,507,509,510,511,513,536,537]
   if @noBFmaps.include?$game_map.map_id
     @rap = 0
   end    
     if $game_party.leader.equips[4] == $data_armors[318] #suction urchin
      @rap = 0
    end     
    if $game_variables[393] == 0 || $game_variables[393].nil?
      $game_variables[393] = ""
    end  
    if $game_variables[393].include?"Cucco"
      @rap = 0
    elsif $game_variables[393].include?"Cocca"
      @rap = 0      
    elsif $game_variables[393].include?"Bake"
      @rap = 0
    elsif $game_variables[393].include?"Hippo"
      @rap = 0
    elsif $game_variables[393].include?"Chisel"
      @rap = 0
    elsif $game_variables[393].include?"Daimyo"
      @rap = 0
    elsif $game_variables[393].include?"Narag"
      @rap = 0
    elsif $game_variables[393].include?"Agathe"
      @rap = 0      
    end   
    if $game_variables[393].include?"LewdCrawler"
      @lim = 1
    else
    if @lust >= 10
       @lim = 1
    elsif @lust >= 5
       @lim = 2           
    elsif @lust >= 3
       @lim = 3     
    else
       @lim = 5
    end 
  end      
    if $game_party.leader.state?(169) == true #Sweet Scent
      @lim = 1
      @lust = 1
    end 
    $game_switches[792] = false
    if $game_variables[393].include?"MothImage"
    if $game_party.leader.id == 1   
      $game_switches[792] = true
      @lim = 1
      @lust = 1
      @rap = 1      
    else
      @rap = 0
    end  
    end      
    if @rap == 1 && @lust >= 1 && $game_switches[2584] == false
          $game_variables[900] = rand(6 - @lust)
            if $game_variables[900] <= 1 || $game_switches[792] == true 
            #######  
              $game_variables[901] += 1
            #######
            if ($game_variables[901]*100/@lim) < 34
              $game_player.balloon_id = 20
            elsif ($game_variables[901]*100/@lim) < 67
              $game_player.balloon_id = 21
            else
              $game_player.balloon_id = 22
            end
            #######  
               if $game_switches[792] == true
                 @lim = -1
               end  
               if $game_variables[901] >= @lim
                 $game_variables[901] = 0                 
                 $game_switches[1195] = true
              end
              end
            end
         end       
      end
    end
  def skill_damage_hero(value)
    if $game_party.members[0].state?(157) == true #transmuted
    $game_temp.reserve_common_event(32) #Cancel Transmute
    end    
    #if $game_switches[1151] == true
    #@revId = $game_variables[8787][0]
    #$game_actors[@revId].set_graphic($game_variables[8787][1],$game_variables[8787][2],$game_variables[8787][3],$game_variables[8787][4])
    #$game_switches[1151] = false
    #$game_player.refresh
    #end
    actor = $game_party.members[0]
    ### CHECK PLAYER MDF ###
    @freeze = actor.mdf
    ### CHECK PLAYER MDF ###
    if $game_variables[116] == "ChainArmor" #ChainArmor Skill
    @freeze = ($game_party.members[0].mdf + $game_party.members[0].agi)/2
    end       
    if $game_variables[116] == "BlindLuck" #BlindLuck Skill
    @freeze = ($game_party.members[0].mdf + $game_party.members[0].luk)/2
    end       
    if $game_party.members[0].state?(165) == true #barkskin
    @shiSlot = $game_party.members[0].armors[0].etype_id rescue -1
     if @shiSlot == 1 #in Shield Eq Slot
      @freeze += $game_party.members[0].equips[1].params[5]
    end    
      @freeze += $game_party.members[0].equips[2].params[5]
      @freeze += $game_party.members[0].equips[3].params[5]
    end     
    if $game_party.leader.equips[1] == $data_armors[323] && $game_switches[3691] == true #oozing shield
      @freeze += 20
    end         
    if $game_party.members[0].state?(64) == true #charge
      if $game_party.members[0].equips[3]
      @freeze -= $game_party.members[0].equips[3].params[5] #chest MDF
      end
      if $game_party.members[0].equips[4]
      @freeze -= $game_party.members[0].equips[4].params[5] #acc MDF   
      end
    end          
    value = value / @freeze
    if $game_variables[116] == "Arrogant" #Arrogant Skill
      value += (value*30/100)   
    elsif $game_variables[116] == "FelineArr" #FelineArr Skill
      value += (value*40/100)        
    end     
    #--------------------------# 
    if $game_variables[116] == "Discharge" #Discharge Skill
       @r = rand(10)
       if @r < 1
         $game_temp.reserve_common_event(359)
       end  
    end      
    #--------------------------#
    allski = $game_variables[114] rescue ""
    if allski.include? "GiveAndTake" #GiveAndTake Skill  
      $game_variables[35] = actor.id
      $game_variables[306] = value
      $game_temp.reserve_common_event(356)
      value = $game_variables[306]
    end   
    #--------------------------#     
   if $game_variables[116] == "BroodLeader" && $game_variables[3010] < 3 #BroodLead
     $game_variables[3010] += 1   
     value = 0
     $game_player.animation_id = 372
     $game_temp.reserve_common_event(969)
   end           
    #--------------------------#           
    if $game_party.members[0].equips[3] == $data_armors[158] && $game_variables[584] >= value
      RPG::SE.new("coin", 100, 100).play
      $game_variables[585] = 0
      $game_variables[585] -= value
    @love = $game_party.members[0].parent_stat(0)
      if $game_variables[116] == "TaintedLove" #Tainted Love Skill
        @love += $game_party.members[0].parent_stat(1)
      end
    if @love >= 5 #love effect
      $game_variables[585] *= 0.8
    elsif @love >= 3
      $game_variables[585] *= 0.9
    end      
      value = 0
      $game_switches[648] = true    
    else      
    value = 0 if value < 0
    $game_map.show_text(self,value)
    if value > 0 && $game_switches[3694] == true
      $game_variables[2946] -= 24
      if $game_variables[2946] <= 0
        $game_variables[2946] = 0
      end
    end        
    if actor.hp <= value
      actor.hp = 1
      $game_map.sas_hud.refresh_bars(0)
      #  if $game_party.leader.id == 9
      #    atk = $game_variables[866]
      #    $game_actors[9].add_param(2, -atk)
      #    $game_variables[866] = 0
      #    $game_temp.reserve_common_event(131)
      #  end 
      kill_player
    else
      actor.hp -= value
    if $game_variables[116] == "Coward" #Coward Skill
      $game_player.balloon_id = 6
      $game_temp.reserve_common_event(45)
    end              
      $game_map.sas_hud.refresh_bars
    end
  end
end
  def kill_player
    actor.hp = 1
    $game_switches[Sapphire_Core::Kill_Switch] = true
    $game_map.need_refresh = true
  end
  def attack     
    #PLAYER ATK
    #return if $game_switches[2932] == true || $game_switches[1195] == true #BF/whip BF
    if $game_switches[7331] == false  
    return if $game_party.leader.state?(209) == true #disarmed
    return if @recover > 0 || $game_map.interpreter.running? 
    else
       @cd = $game_player.direction
         case $game_player.direction
         when 2
         @nd = 6
         when 4  
         @nd = 2
         when 6
         @nd = 8  
         when 8
         @nd = 4
         end
       $game_player.set_direction(@nd)
     end             
    can_move = true     
    @recover = @max_recover
    @recast = 0
    #Magiknight
    if $game_party.leader.id == 1 
    if $game_variables[628] == 32 || $game_variables[628] == 132 || $game_variables[628] == 1032 #magiknight
     @recast = 1
    end 
    end
    #Magi Baton
    if $game_party.leader.equips.include?$data_armors[759]
     @recast = 1
    end   
    if @recast == 1
    if $game_variables[628] == 32 
      @mpCost = 5
    elsif $game_variables[628] == 132   
      @mpCost = 10
    elsif $game_variables[628] == 1032   
      @mpCost = 15
    end  
    if $game_party.leader.equips.include?$data_armors[759]
     @mpCost = 10
    end
    return if $game_party.members[0].mp < @mpCost
      $game_party.members[0].mp -= @mpCost
      $game_map.sas_hud.refresh_bars
      $game_player.recast_skill 
    end
    if $game_variables[116] == "YinYang" #YinYang Skill
      @agiscore = $game_party.members[0].atk
    else
      @agiscore = $game_party.members[0].agi
    end 
    @recover -= @agiscore/10 #agi AS influence
    if $game_variables[116] == "Flurry"
      @recover *= 0.8
    end
    if $game_party.members[0].equips.include?$data_armors[666] #Fast Leaf
      @recover *= 0.8
    end        
    if $game_party.members[0].equips.include?$data_armors[743] #Zegre Cap
      @recover *= 0.8
    end        
    #MouSkill   
    if $game_switches[1877] == true && $game_party.leader.equips[0].wtype_id != 9 && $game_party.leader.equips[0].wtype_id != 10 && $game_party.leader.equips[0].wtype_id != 11
      @recover *= 1.2
    end    
    if @weapon_animation != nil
    SceneManager.scene.spriteset.weapon_animation if Sapphire_Core::Enable_Weapon_Graphics
    else
    @weapon_animation = 3
    end
    play_voice if Sapphire_Core::Enable_Voice   
    ###
    fac = 0
    if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[369] #Old Nick
     fac += 1.5
    end    
    if $game_party.leader.class_id == 1 && $game_party.leader.equips[4] == $data_armors[395]
     fac += 1.5
    end     
    @wep = $game_party.leader.equips[0].id rescue 0
    @bigW = [76,77,78,80,88,89,90,91,92,106,109,111,124,130,162,163]
    @hugeW = [134,158]
    #slingaxe COUNTING as big weapon for size (96)
    return if @wep == 0
    if $game_party.leader.class_id == 174
    if $game_party.leader.equips[0].wtype_id == 3 || $game_party.leader.equips[0].wtype_id == 9 #lances/staves
      fac += 1.5
    end
  end
    @sneks = [110,111,112,113,215]
    if $game_party.leader.equips[0].wtype_id == 11 #whips
      if @sneks.include?$game_party.leader.class_id
       fac += 2.5
      else
       fac += 1.5
      end
    end         
    if @bigW.include?@wep #Big Weapons
     fac += 1.5
    elsif @hugeW.include?@wep #Huge Weapons
     fac += 2.5     
   end   
    #MouSkill   
    if $game_switches[1877] == true && $game_party.leader.equips[0].wtype_id != 9 && $game_party.leader.equips[0].wtype_id != 10 && $game_party.leader.equips[0].wtype_id != 11
     fac += 1.5
    end   
    if $game_variables[116] == "PitFighter" && $game_party.leader.equips[0].wtype_id == 2 #Pit Fighter Skill
       fac += 1.5
    elsif $game_variables[116] == "Pikeman" && $game_party.leader.equips[0].wtype_id == 3 #Pikeman Skill
       fac += 1.5
    end  
    if $game_party.members[0].id == 1 && $game_party.leader.equips[0].wtype_id == 2 #fist K
      if $game_variables[628] == 26 || $game_variables[628] == 126 || $game_variables[628] == 1026 #brawler
       fac += 1.5
      end
    end    
    if fac >= 3
      if $game_switches[840] == false
      $game_switches[840] = true
      end
    end  
#range calc
  @diff0 = fac
  @diff1 = fac
  if @direction == 2
      @diff1 = fac/6*11
    end  
    if @direction == 4
       @diff0 = 0-fac/6*11 
    end 
    if @direction == 6
        @diff0 = fac/6*11  
    end 
    if @direction == 8
        @diff1 = 0-fac/6*11     
      end      
#range calc - END
@wr0 = Sapphire_Core::Weapon_Range[@direction][0]
@wr1 = Sapphire_Core::Weapon_Range[@direction][1]
#reduce/increase range
   @wep = $game_party.leader.equips[0].id rescue 0
   return if @wep == 0
  if $game_party.leader.equips[0].wtype_id == 7 || $game_party.leader.equips[0].wtype_id == 2 #fist/daggers
   @wr0 /= 2
   @wr1 /= 2
  elsif $game_party.leader.equips[0].wtype_id == 3 || @wep == 75 || @wep == 94 #rapier/lance
   @wr0 += (@wr0/2)
   @wr1 += (@wr1/2)
 end
 if @wep == 88 || @wep == 127 || @wep == 171 #sickle
   @wr0 = Sapphire_Core::Weapon_Range[@direction][0]
   @wr1 = Sapphire_Core::Weapon_Range[@direction][1]
 end
#reduce range END
  tx = @px + @wr0 + @diff0
  ty = @py + @wr1 + @diff1
  tx2 = 0
  ty2 = 0
  if @direction == 2 || @direction == 8
  tx2 = @px + @wr0 - @diff0
elsif @direction == 4 || @direction == 6  
  ty2 = @py + @wr1 - @diff1  
end   
    for char in $game_map.enemies      
      if char.pixel_range?(tx,ty) || char.pixel_range?(tx,ty2) || char.pixel_range?(tx2,ty)
        #char.animation_id = 188 
        #char.flash([255,255,255], 15)
        next if char.enemy.static
        char.animation_id = @weapon_animation
        if $game_map.map_id == 469 || $game_map.map_id == 470
         char.animation_id = 261 
       end  
        if $game_map.map_id == 477
         char.animation_id = 272 
       end         
      @wep = $game_party.leader.equips[0].id rescue 0 
      unless char.enemy.inanimate || char.enemy.immovable || @wep == 172 || @wep == 174 || @wep == 176 #sticky frog / soft staff
      unless $game_switches[2723] == true || $game_switches[2932] == true || $game_map.map_id == 477 #dont move / whipped
          char.turn_toward_character(self)
          step = 5
          @wep = $game_party.leader.equips[0].id rescue 0
          if @wep != 0     
            if $game_party.leader.equips[0].wtype_id == 2 || $game_party.leader.equips[0].wtype_id == 7 #fist/dagg
             step -= 2
            end     
          end    
          if $game_party.members[0].state?(231) == true #heavyblows
           step *= 2
          end
          step.times do; char.move_backward; end
          char.do_step
      end          
        else
          can_move = true #to false
        end
       # -------
    if $game_variables[116] == "YinYang" #YinYang Skill
      @wat = $game_party.members[0].agi
    else
      @wat = $game_party.members[0].atk
    end    
    if $game_variables[116] == "BlindLuck" #BlindLuck Skill
    @wat = ($game_party.members[0].atk + $game_party.members[0].luk)/2
    end     
       #MAIN HAND
      if !$game_party.members[0].weapons[0].nil?
        if $game_variables[116] == "Cottonweight" #CottonSkill
          @wat -= $game_party.members[0].equips[0].params[2]
        end           
         if $game_party.leader.equips[0] == $data_weapons[93] && $game_switches[3691] == true #frozen core
         @wat += 40 #frozen core
       elsif $game_party.leader.equips[0] == $data_weapons[81] && $game_switches[3438] == true #coral axe
         @wat += 40 #coral axe
       elsif $game_party.leader.equips[0] == $data_weapons[83] && $game_switches[3438] == true #crunchy red
         @wat += 20 #crunchy red
       elsif $game_party.leader.equips[0] == $data_weapons[90] && $game_switches[3438] == true #crunchy RAD
         @wat += 20 #crunchy RAD
       elsif $game_party.leader.equips[0] == $data_weapons[86] && $game_switches[3438] == true #nereus toothpick
         @wat += 30 #nereus toothpick
       elsif $game_party.leader.equips[0] == $data_weapons[109] && $game_switches[3438] == true #long grappler
         @wat += 15 #long grappler
       end  
       if $game_switches[3438] == true && $game_party.leader.equips[5] == $data_armors[533]
         @wat += 30 #UW Bloo Battlesuit
       end   
       if $game_party.leader.equips[0].wtype_id == 3 && $game_party.leader.equips[5] == $data_armors[506]
         @wat += 30 #lances + Coatl Armor
       elsif $game_party.leader.equips[0].wtype_id == 8 && $game_party.leader.equips[5] == $data_armors[592]
         @wat += 30 #hammers + Zegre Armor      
       elsif $game_party.leader.equips[0].wtype_id == 10 && $game_party.leader.equips[5] == $data_armors[597]
         @wat += 20 #hammers + Puntia Armor
       elsif $game_party.leader.equips[0].wtype_id == 3 && $game_party.leader.equips[5] == $data_armors[527]
         @wat += 30 #lances + Trav.Monkey
       elsif $game_party.leader.equips[0].wtype_id == 11 && $game_party.leader.equips[5] == $data_armors[184]
         @wat += 30 #whips + Lust Tamer
       end  
       if $game_party.members[0].id == 1 && $game_party.leader.equips[0].wtype_id == 2 #fist knight
        if $game_variables[628] == 26 || $game_variables[628] == 126 || $game_variables[628] == 1026 #brawler
           @wat += 15 #brawler++ Knight
       end    
       end
      end     
      @bigW = [76,77,78,80,88,89,90,91,92,106,109,111,124,130,134,158,162,163]
      #slingaxe not counting as big weapon for off hand damage (96)
      ############################
      unless $game_variables[116] == "Dexterous" || $game_party.members[0].equips[5] == $data_armors[579] || $game_party.members[0].equips[5] == $data_armors[614] #Dexterous Skill/Ronin Costume
       if $game_party.members[0].dual_wield? && !$game_party.members[0].weapons[1].nil?
        #dual 
        @offType = $game_party.members[0].weapons[1].wtype_id
       @dmgCh = 0 
       if @bigW.include?$game_party.members[0].weapons[1].id
        @dmgCh = $game_party.members[0].equips[1].params[2] / 4
       end  
       if @offType == 1 || @offType == 8 || @offType == 9 || @offType == 13 || @offType == 14 || @offType == 15 || @offType == 17 #axe/hammer/staff/power gloves/holy sw/cursed axe/runes
        @wat -= ($game_party.members[0].equips[1].params[2] / 4 * 3).abs
       elsif @offType == 3 || @offType == 4 || @offType == 5 || @offType == 11 #sword/spear/katana/whip
        @wat -= ($game_party.members[0].equips[1].params[2] / 4).abs 
       else #claw/dagger/gun
        @wat -= 0
      end  
      @wat -= @dmgCh
      end   
      end
      if $game_switches[7331] == true #spin
      #spinning
        @wat -= ($game_party.members[0].equips[0].params[2] / 4).abs 
        if $game_party.members[0].dual_wield? && !$game_party.members[0].weapons[1].nil?
        @wat -= ($game_party.members[0].equips[1].params[2] / 2).abs 
        end
      end
      damage = (@wat * @wat)        
      ############################
      @love = $game_party.members[0].parent_stat(0)
       if $game_variables[116] == "TaintedLove" #Tainted Love Skill
        @love += $game_party.members[0].parent_stat(1)
       end
       if !$game_party.members[0].weapons[0].nil?
        if $game_party.members[0].equips[0] == $data_weapons[73] #love whip
          damage += ((damage/100)*(@love/20)) # + 5%/Love 
        elsif $game_party.leader.equips[0] == $data_weapons[112] #ecclesiastic claw
          damage += ((damage/100)*$game_variables[2879]) # + 1%/KL 
        end  
       end
       #OFF HAND
       if $game_party.members[0].dual_wield? && !$game_party.members[0].weapons[1].nil?
         if $game_party.leader.equips[1] == $data_weapons[112] #ecclesiastic claw
          damage += ((damage/100)*($game_variables[2879]/100)) # + 1%/KL
         end 
       end
     if $game_switches[1948] == true #TicToc
       damage += damage
       message = ["OK!","NICE!","PERFECT!"].sample
       $game_map.show_text($game_player,message)
     end   
       #SKILL
    if $game_variables[116] == "Masochist" #Masochist Skill
        @mod = ($game_party.leader.hp/$game_party.leader.mhp)*100
        if @mod < 25
          damage += damage
        elsif @mod < 50
          damage += (damage/4)
        elsif @mod < 75
          damage += 0
        else
          damage -= (damage/5)
        end  
    elsif $game_variables[116] == "Maniac" #Maniac Skill
         damage += ((damage/100)*$game_variables[2879]) # + 1%/KL  
    elsif $game_variables[116] == "Crepuscular" #Crepuscular Skill
        if $game_variables[376] >= 15 && $game_variables[376] <= 19
         damage += (damage/5).round() 
         end
    elsif $game_variables[116] == "NoGuard" #No Guard Skill
         damage += (damage/4).round()
    elsif $game_variables[116] == "Arrogant" #Arrogant Skill
         damage += (damage*30/100)
    elsif $game_variables[116] == "FelineArr" #FelineArr Skill
         damage += (damage*40/100)         
    elsif $game_variables[116] == "HeatEngine" #HeatEngine Skill     
         if $game_player.real_move_speed == 5
           damage += (damage/2).round()
         elsif $game_player.real_move_speed == 6
           damage += (damage/2).round()
         end  
         if $game_switches[3708] == true || $game_switches[488] == true #hot terrain or scorch
           damage += (damage/4).round()
         end           
    elsif $game_variables[116] == "Daredevil" #Daredevil Skill
         if $game_party.members[0].hp / $game_party.members[0].mhp < 0.25
         damage += (damage/2).round()
         end
    elsif $game_variables[116] == "Kunoichi" #Kunoichi Skill
         damage /= 2
    elsif $game_variables[116] == "PitFighter" #Pit Fighter Skill
      if $game_party.leader.equips[0].wtype_id == 2 #fist
       damage += (damage/4).round()
      end    
    elsif $game_variables[116] == "Pikeman" #Pikeman Skill
      if $game_party.leader.equips[0].wtype_id == 3 #lance
       damage += (damage/2).round()
      end    
    elsif $game_variables[116] == "Necrophiliac" #Necrophiliac Skill
      damage += (damage * $game_variables[396] / 4)
    elsif $game_variables[116] == "Sunny" && $game_switches[412] == true && $game_switches[524] == true #Sunny Disposition Skill
      damage += (damage/4).round()
    end 
   if $game_party.members[0].id == 1
   if $game_variables[628] == 1008 #WealthyK ++
      damage += ((damage/100)*($game_variables[584]/100)) # + 1%/Swirlies
   elsif $game_variables[628] == 1019 && char.enemy.typebeast #Hound++
      damage += (damage/2)
    elsif $game_variables[628] == 32 || $game_variables[628] == 132 || $game_variables[628] == 1032 #
      damage -= (damage/4).round()
   end 
 end  
#####################
     @mainType = $game_party.members[0].weapons[0].wtype_id rescue nil
      unless @mainType.nil?
#####################
       calc_atkType(1)   
       calc_armorMod(char)
#####################       
       damage += (damage*@dmgMod).round()
      end  
#####################
   if $game_party.members[0].equips[5] == $data_armors[676] && char.enemy.typeseafolk #Duel Winner
     damage += (damage/2)
   end   
   if $game_party.members[0].equips.include?$data_weapons[148] #Chef Spatula
     if char.enemy.typeseafolk || char.enemy.typebeast 
     damage += (damage/2)
     end
   end     
   if $game_party.members[0].equips.include?$data_weapons[150] #Master Chain
     if char.enemy.typebeast 
     damage += (damage/2)
     end
   end      
   if $game_party.members[0].equips.include?$data_weapons[152] #Slaver Whip
     if char.enemy.typehumanoid 
     damage += (damage/2)
     end
   end         
   damage.round()
   ###########
    #---------------------------------------------#
        if !$game_party.members[0].weapons[0].nil?
        if $game_party.leader.class_id == 119 && $game_switches[3559] == false #moss status
          damage /= 3
        end         
        if $game_switches[749] || $game_switches[3485]
          damage = damage*2
          RPG::SE.new("Reflection", 110, 100).play
          $game_switches[3485] = false          
        else      
  if $game_party.leader.class.id == 2 && $game_switches[4120] == true
    then
      crit = ($game_party.members[0].luk * $game_party.members[0].luk) / 400
    else 
      crit = ($game_party.members[0].luk * $game_party.members[0].luk) / 500      
    end    
     @love = $game_party.members[0].parent_stat(0) 
       if $game_variables[116] == "TaintedLove" #Tainted Love Skill
        @love += $game_party.members[0].parent_stat(1)
       end
     if $game_party.members[0].equips[4] == $data_armors[453] #KING
        if @love >= 6
       if $game_variables[116] == "Manchild" #Manchild Skill
        crit += (crit/5)
      else
        crit += (crit/10)
      end          
        end
      end     
     if $game_party.members[0].state?(53) == true #frenzy anemone
         crit += (crit/4)
     end  
      if crit < 2
        crit = 2
      end
      if crit > 75
        crit = 75
      end   
     if $game_party.members[0].equips[5] == $data_armors[610] #Brazen Ox
        crit = 75
     end          
        chance = rand(100)
        if chance <= crit
         damage += damage
     unless char.enemy.inanimate  
     if $game_party.members[0].equips[4] == $data_armors[667] #Zeal Arm
       @animation_id = 134
       actor = $game_party.members[0]
       value = (actor.mhp * 5 / 100).to_i
       actor.hp += value
       message = "+ #{value}"
       $game_map.show_text($game_player,message)
       $game_map.sas_hud.refresh_bars
     end 
     if $game_party.members[0].equips[4] == $data_armors[668] #Zeal Amulet
       @animation_id = 134
       actor = $game_party.members[0]
       value = (actor.mmp * 5 / 100).to_i
       actor.mp += value
       message = "+ #{value}"
       $game_map.show_text($game_player,message)
       $game_map.sas_hud.refresh_bars
     end 
   end            
     if $game_party.members[0].equips[4] == $data_armors[453] #KING
        if @love >= 10
       if $game_variables[116] == "Manchild" #Manchild Skill
        damage += (damage/5).round()        
      else
        damage += (damage/10).round()
      end     
        damage = (damage).to_i
        end
     end          
         RPG::SE.new("Reflection", 110, 100).play
       end  
     end
   end
   damage.to_i
   if $game_variables[116] == "Incorporeal"
     @rInc = rand(100)
     if @rInc < 75
       damage = 0
       return
     end
    end         
       char.damage_enemy(damage,true) unless char.enemy.atk_invincible || damage == 0
      end
    end 
    return unless can_move
      if $game_switches[2723] == false && $game_switches[7331] == false   
    do_step      
    move_forward
  end   
    if $game_party.leader.equips[0] == $data_weapons[147] #sharp bamboo
      @rBam = rand(10)
      if @rBam <= 1
        @recover = 0
        $game_player.animation_id = 119
        $game_player.attack
      end
    end   
  end
  def get_weapon_recover(actor)
    for feature in actor.weapons[0].features
      return feature.value if feature.code == 33
    end
    return Sapphire_Core::Default_Recover
  end
  def refresh_weapon_stats 
    hero = $game_party.members[0]
    if hero.weapons[0].nil?
      @max_recover = Sapphire_Core::Default_Recover      
      @weapon_animation = Sapphire_Core::Default_Animation
    else
      @max_recover = get_weapon_recover(hero)
      #long grappler
      if $game_party.leader.equips[0] == $data_weapons[109] && $game_switches[3438] == true #long grappler
        @max_recover -= 20
      end
      ##########
      @aniId = hero.weapons[0].animation_id rescue nil
      if @aniId.nil?
        @aniId = 1
      end  
      @weapon_animation = @aniId
      ##########
    end
  end
  def play_voice
    RPG::SE.new(Sapphire_Core::Voice_Files[rand(Sapphire_Core::Voice_Files.size)],Sapphire_Core::Voice_Volume).play 
  end
  def encounter_progress_value
    return 1
  end
  def get_on_off_vehicle
    return false
  end
  def check_event_trigger_here(triggers)
    for event in $game_map.events.values
      if (event.px - @px).abs <= event.cx && (event.py - @py).abs <= event.cy
        event.start if triggers.include?(event.trigger) && event.priority_type != 1
      end
    end
  end
  def check_event_trigger_there(triggers)
    fx = @px+Trigger_Range[@direction][0]
    fy = @py+Trigger_Range[@direction][1]
    for event in $game_map.events.values
      if (event.px - fx).abs <= event.cx && (event.py - fy).abs <= event.cy
        if triggers.include?(event.trigger) && event.normal_priority?
          event.start
          return
        end
      end
    end
    if $game_map.pixel_table[fx,fy,5] == 1
      fx += Counter_Range[@direction][0]
      fy += Counter_Range[@direction][1]
      for event in $game_map.events.values
        if (event.px - fx).abs <= event.cx && (event.py - fy).abs <= event.cy
          if triggers.include?(event.trigger) && event.normal_priority?
            event.start
            return
          end
        end
      end
    end
  end
  def front_pixel_touch?(px,py)
    return if $game_map.interpreter.running?
    for event in $game_map.events.values
      if (event.px - px).abs <= event.cx && (event.py - py).abs <= event.cy
        if [1,2].include?(event.trigger) && event.normal_priority?
          event.start
          result = true
        end
      end
      end
    end
   def pixel_passable?(px,py,d)
    nx = px+Tile_Range[d][0]
    ny = py+Tile_Range[d][1]
    return false unless $game_map.pixel_valid?(nx,ny)
    return true if @through || debug_through?
    return false if $game_map.pixel_table[nx,ny,0] == 0
    return false if collision?(nx,ny)
    return true
  end
  def move_by_input
    return if !movable? || $game_map.interpreter.running?
    case Input.dir8
      when 1; move_dpixel(4,2)
      when 2; move_pixel(2,true)
      when 3; move_dpixel(6,2)
      when 4; move_pixel(4,true)
      when 6; move_pixel(6,true)
      when 7; move_dpixel(4,8)
      when 8; move_pixel(8,true)
      when 9; move_dpixel(6,8)
    end
  end
  def on_damage_floor?
    return false
  end
  def collision?(px,py)
    for event in $game_map.events.values
      if (event.px - px).abs <= event.cx && (event.py - py).abs <= event.cy
        next if event.through
        return true if event.priority_type == 1
      end
    end
    return false
  end
  def move_straight(d, turn_ok = true)
    super(d, turn_ok)
  end
  def move_diagonal(horz, vert)
    super(horz, vert)
  end
end

#-------------------------------------------------------------------------------
# * Game Event
#-------------------------------------------------------------------------------

class Game_Event < Game_Character
  attr_accessor :enemy
  alias sas_setup_page setup_page
  alias sas_initialize initialize
  alias sas_event_update update
  alias kp_move_type_toward_player move_type_toward_player
  alias kp_setup_page_settings setup_page_settings
  def initialize(m,e)
    @enemy = nil
    @recover = 0
    @request_view = false
    sas_initialize(m,e)
    setup_collision
  end
  def update
    if $game_map.sas_active && @enemy != nil
      @request_view ? update_view : update_skills
      @recover -= 1 if @recover > 0
    end
    sas_event_update
  end
  def update_skills
    return if @recover > 0 || @enemy.nature == 0
    if @enemy.auto_attack
      $game_map.skills << Sapphire_Skill.new(self)
      @recover = @enemy.recover
    else
      update_cast
    end
  end
  def damageSec_enemy(value,by_player=false)    
    if $game_party.members[0].state?(179) == true #tentacled
      @animation_id = 341
    elsif $game_variables[116] == "Thorns" || $game_party.members[0].state?(221) == true #Thorns skill 
      @animation_id = 13 
    elsif $game_variables[116] == "BigStrokes" #multihit skill
      @animation_id = 7
      value -= (value/2)
    elsif $game_variables[116] == "Chillo" #multihit skill
      if @enemy.typeundead #living only
        return
      end  
      @animation_id = 346
      value -= (value/4)     
      @move_frequency = 1         
    end
    @enemy.hp -= value #if @alivech > 0
    @alivech = @enemy.hp rescue 0     
    $game_map.show_text(self,value)
    if @alivech < 1
    if $game_switches[2932] == true
      $game_switches[2934] = true
    end    
    if $game_switches[3645] == true #killwish
       if @enemy.defence > 20 #no static
       $game_temp.reserve_common_event(209)
       end
     end            
    kill_enemy(by_player)
    if $game_switches[2932] == true
      $game_switches[2934] = true
    end
    elsif by_player && @request_view
      @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
      @move_type = 2
      @move_frequency = 6
      @request_view = false
      if $game_switches[883] == true 
          $game_temp.reserve_common_event(78)
      end
    end
  end   
  def damage_enemy(value,by_player=false)
    @chara = @character_name rescue nil
    if @chara == nil
      @character_name = ""
    end 
    if $game_variables[116] == "YinYang" #YinYang Skill
      @atkscore = $game_party.members[0].agi
    else
      @atkscore = $game_party.members[0].atk
    end     
    if $game_party.members[0].equips[0] == nil #unarmed combat
      value = @atkscore * @atkscore * 85 /100
    end    
    if $game_party.leader.class_id == 156 && $game_variables[4134] <= 2 #wendigo stress
      $game_variables[4134] += 1
      $game_temp.reserve_common_event(137)
    end      
    edf = @enemy.defence rescue 60  
    if @character_name.include? "Spika"
       if !$game_party.members[0].equips[0].nil?
         if $game_party.members[0].equips[0] == $data_weapons[86] || $game_party.members[0].equips[1] == $data_weapons[86] || $game_party.members[0].equips[0] == $data_weapons[109] || $game_party.members[0].equips[1] == $data_weapons[109]
      edf *= 2
      edf /= 3
         end
       end
     end       
    if @character_name.include? "Spika"
      if @character_name.include? "Atk"
        edf += (edf/2)
      elsif  @character_name.include? "Stealth"
        edf += (edf/2)
      end  
    end       
    if @character_name == "$CrusaderPcharge"
      edf -= 30
    elsif @character_name == "$Trauma" && $game_switches[4540] == false  #incr Defense
      edf *= 99         
    elsif @character_name.include?"ZegreShield"
      edf *= 20  
    elsif @character_name == "$SpinelATKR" || @character_name == "$SpinelATKD" || @character_name == "$SpinelATKL" || @character_name == "$SpinelATKU" #incr Defense
      edf *= 3
    elsif @character_name == "$AmelieATK" || @character_name == "$MandragoraHide" #inc mDefense
      edf *= 2
    elsif @character_name == "$ScarabCharge" || @character_name == "$ScarabEliteCharge" #red mDefense
      edf -= 20
    elsif @character_name == "$MimicTrapC"
      edf *= 5
    end      
    ######################
    value = (value/edf)/5*(rand(15)+85)/100    
    ######################
    value.round()
    if $game_switches[1186]
    value = 0
    end  
    value = 0 if value < 0    
    value.round()
    #####
    @multiHit = 0
    if $game_party.members[0].state?(179) == true #tentacled
       @multiHit = 1
       @multiRange = 20
     end   
    if $game_variables[116] == "BigStrokes" #multihit skill
       @multiHit = 3
       @multiRange = 3
    elsif $game_variables[116] == "Chillo" #multihit skill
       @multiHit = 3
       @multiRange = 3
     end   
    if @multiHit > 0
      @tarI = 0
      @tarS =  Array.new(250, 0)
      @tenI = 1      
        while @tenI <= 250 && @tarI <= 5
        if $game_map.events[@tenI]          
        @hpEnemy = $game_map.events[@tenI].enemy.hp rescue -1
        @mpEnemy = $game_map.events[@tenI].enemy.mp rescue 666
        #unless @tarS.include?@tenI
        if @id != @tenI && @hpEnemy != -1 && @mpEnemy != 666 && ($game_map.events[@tenI].x - $game_player.x).abs + ($game_map.events[@tenI].y - $game_player.y).abs < @multiRange
         @tarS[@tarI] = @tenI
         @tarI += 1 
        end               
        end  
        @tenI += 1
      end  
    ### get string
    @mmhits = [@tarI,@multiHit].min
    while @mmhits > 0
    if @tarI > 1
    @tarF = Array.new(@tarI, 0)
    @tTi = 0
    while @tTi < @tarF.length
      @tarF[@tTi] = @tarS[@tTi]
      @tTi += 1
    end
    @r = rand(@tarI)
    @tTt = @tarF[@r]   
    if $game_map.events[@tTt]
    @hpEnemy = $game_map.events[@tTt].enemy.hp rescue -1
    if @hpEnemy > 1
    $game_map.events[@tTt].damageSec_enemy(value)
    end
    end
    elsif @tarI == 1
    @tTf = @tarS[0]
    if $game_map.events[@tTf]
    @hpEnemy = $game_map.events[@tTf].enemy.hp rescue -1
    if @hpEnemy > 1
    $game_map.events[@tTf].damageSec_enemy(value)
    end
    end
    end    
    @mmhits -= 1
    end
    ### get string
    end         
    ##### TENTACLE END      
    if $game_variables[116] == "PlayfulKiller"
      @surv = [0,1].sample
    if @surv == 0 && value > @enemy.hp
      value = @enemy.hp - 1
      $game_map.show_text($game_player,"Minced!") unless @enemy.inanimate
    end   
    end
    @enemy.hp -= value #if @alivech > 0
    @alivech = @enemy.hp rescue 0
    if @animation_id.nil? || @animation_id == 0
      @animation_id = 377 #nil ani
    end  
    if $game_switches[1075] == true #dog dash
      @animation_id = 35 
    end
    if $game_switches[3787] == true #amelie rush
      @animation_id = 35 
    end    
    if $game_switches[7463] == true #sala bolero
      @animation_id = 57
    end    
    ### DAMAGE TEXT ###
    #$game_map.show_text(self,value)
    $game_map.show_textPhy(self,value) unless @enemy.inanimate
    ### DAMAGE TEXT ###
    ############                                  ############
    #if !$game_party.members[0].weapons[0].nil? #check no weap
    ############                                  ############
    if $game_party.members[0].equips[0] == $data_weapons[51] #sleep hammer
      then
      cus = rand(4)
      if cus < 1
      $game_temp.reserve_common_event(198)      
      @animation_id = 54
      message = "SLEEP!"
      $game_map.show_text($game_player,message) unless @enemy.inanimate
    end
  end  
  ms = 0
  if $game_party.members[0].equips[0] == $data_weapons[136]
      ms += 1  
    end
  if $game_party.members[0].equips[3] == $data_weapons[681]
      ms += 1  
    end         
  ls = 0
  @love = $game_party.members[0].parent_stat(0) 
     if $game_variables[116] == "TaintedLove" #Tainted Love Skill
      @love += $game_party.members[0].parent_stat(1)
     end  
    if $game_party.members[0].equips[4] == $data_armors[453] && @love >= 3
       if $game_variables[116] =="Manchild" #Manchild Skill
        ls = 2
       else
        ls = 1
       end
    elsif $game_party.members[0].equips[0] == $data_weapons[50] || $game_party.members[0].equips[0] == $data_weapons[34] || $game_party.members[0].equips[0] == $data_weapons[118] || $game_party.members[0].equips[0] == $data_weapons[10] || $game_party.members[0].equips[0] == $data_weapons[136] || $game_party.members[0].equips[0] == $data_weapons[142]
      ls = 1  
    elsif $game_party.members[0].equips[0] == $data_weapons[64] || $game_party.members[0].equips[0] == $data_weapons[84] || $game_party.members[0].equips[0] == $data_weapons[127]
      ls = 2
    end
    if $game_party.members[0].equips[5] == $data_armors[553] #mortal killer Vashti
      ls += 1  
    end  
      if $game_party.members[0].state?(196) == true #vamp
        ls += 2
      end       
      if $game_party.members[0].state?(200) == true #vamp
        ls += 2
        ms += 2
      end             
      if $game_party.members[0].state?(199) == true #vamp +
        ls += 5
      end        
      if $game_party.members[0].state?(220) == true #brood
        ls += 5
      end    
      if $game_variables[116] == "SyphonLife" && $game_switches[1909] == true
        $game_switches[1909] = false
        $game_temp.reserve_common_event(969)
        #AnubisSyphoning
        if $game_party.leader.class_id == 208 && $game_variables[1335] > 1
        $game_variables[1335] -= 1
        end
        ls = 100
      end      
      ls += $game_variables[1334] #varLS
    #Stop on non ATK enemies
    if @enemy.inanimate
      ls = 0 
      ms = 0
    #elsif $game_party.members[0].weapons[0].nil? #check no weap
    #  ls = 0
    #  ms = 0
    end
      retState192 = 0
      if $game_party.members[0].state?(192) == true #null Healing
        $game_party.members[0].remove_state(192)
        retState192 = 1
      end      
    if ls != 0 #LifeSteal
      then
      if ls == 100 #Syphon
      @animation_id = 417  
        else
      @animation_id = 134
      end
      actor = $game_party.members[0]
      lsVal = (value * ls / 100).to_i
      actor.hp += lsVal
      message = "+ #{lsVal}"      
      $game_map.show_text($game_player,message) unless @enemy.inanimate
      if ms != 0 #ManaSteal
      msVal = (value * ms / 100).to_i
      actor.mp += msVal  
      end        
      $game_map.sas_hud.refresh_bars    
    else  
     if ms != 0 #ManaSteal
      then
      @animation_id = 134
      actor = $game_party.members[0]
      msVal = (value * ms / 100).to_i
      actor.mp += msVal
      message = "+ #{msVal}" 
      $game_map.show_text($game_player,message) unless @enemy.inanimate
      $game_map.sas_hud.refresh_bars    
     end #ManaSteal END    
    end #LifeSteal END
    if retState192 == 1
     $game_party.members[0].add_state(192)
    end     
    if $game_party.leader.class_id == 191 # TasBOT
      if $game_party.members[0].equips.include?$data_weapons[158]
        $game_party.leader.add_state(217)
        $game_temp.reserve_common_event(971)
      end
    end          
    #end #end if !$game_party.leader.equips[0].nil?
    if @alivech < 1 #enemy death      
    if $game_variables[116] == "HungryKiller" #Orca
      actor = $game_party.members[0]
      lsVal = value.to_i
      actor.hp += lsVal
      message = "+ #{lsVal}"      
      $game_map.show_text($game_player,message) unless @enemy.inanimate     
    end      
    if $game_switches[2932] == true
      $game_switches[2934] = true
    end        
    if $game_switches[3645] == true #killwish
       if @enemy.defence > 20 #no static
       $game_temp.reserve_common_event(209)
       end
     end       
      if !$game_party.members[0].weapons[0].nil?
        unless @enemy.inanimate # check for ROCKS
        if $game_party.leader.equips[0] == $data_weapons[65] && $game_switches[3064] == false && $game_switches[1151] == false #kill with dagger
         # if $game_switches[1151] == true #transmute end 
         #  @revId = $game_variables[8787][0]
         #  $game_actors[@revId].remove_state(157)
         #  $game_actors[@revId].set_graphic($game_variables[8787][1],$game_variables[8787][2],
         #  $game_variables[8787][3],$game_variables[8787][4])
         #  $game_switches[1151] = false    
         #  $game_player.refresh
         #end  
           $game_variables[8787] = [$game_party.leader.id,$game_party.leader.character_name, $game_party.leader.character_index, $game_party.leader.face_name, $game_party.leader.face_index]
           #@atkSprite = ["ATKD","ATKU","ATKL","ATKR","ATK0","ATK1","ATK2","ATK3"]
           #if @atkSprite.include?@character_name             
           #end  
           $game_party.leader.set_graphic(@character_name, @character_index, $game_party.members[0].face_name, $game_party.members[0].face_index)
           $game_switches[1151] = true
           $game_party.leader.add_state(157)
           $game_player.refresh
          end
          end # check for ROCKS
        end
      kill_enemy(by_player)
      if $game_switches[2932] == true
      $game_switches[2934] = true
    end
      if $game_party.leader.id == 9
  #      if $game_actors[9].parent_stat(2) >= 3
  #        if $game_variables[866] <= 19
  #        $game_actors[9].add_param(2, 2)
  #        $game_variables[866] += 2
  #        $game_temp.reserve_common_event(131)
  #      end
  #      else
          if $game_variables[866] <= 2
          $game_actors[9].add_param(2, 10)
          $game_variables[866] += 1
          $game_temp.reserve_common_event(131)
        end
        end
  #    end 
    elsif by_player && @request_view
      @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
      @move_type = 2
      @move_frequency = 6
      @request_view = false
      if $game_switches[883] == true 
          $game_temp.reserve_common_event(78)
        end
      else
    if $game_party.members[0].equips[0] == $data_weapons[73] #love whip
      unless $game_party.leader.id >= 35 && $game_party.leader.id <= 39
      then
    @balloon_id = 4 if Sapphire_Core::Enemy_Exclamation  
    if $game_switches[1195] == false && !@enemy.whipres #BF Off and Prevent WhipBF Off
      $game_variables[6430] = @id
      $game_switches[1195] = true #BF
      $game_switches[2932] = true #whip BF    
    end
    end
  end
  end
end
  def fix_damage_enemy(value,by_player=false)    
    value = 0 if value < 0
    value.round()
    @enemy.hp -= value
    $game_map.show_text(self,value)
    if @enemy.hp <= 0
      if $game_switches[3645] == true && @enemy.mdefence >= 20 #killwish
      $game_temp.reserve_common_event(209)
      end      
      kill_enemy(by_player) 
      elsif by_player && @request_view
      @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
      @move_type = 2
      @move_frequency = 6
      @request_view = false
      if $game_switches[883] == true 
          $game_temp.reserve_common_event(78)
        end
    end
  end
  def skill_damage_enemy(value,by_player=false)
    @edf = @enemy.mdefence
    ######################
    value = value / @edf   
    ######################
    if @character_name == "$SpinelATKR" || @character_name == "$SpinelATKD" || @character_name == "$SpinelATKL" || @character_name == "$SpinelATKU" #incr Defense
      value /= 3
    elsif @character_name == "$ScarabCharge" || @character_name == "$ScarabEliteCharge"  #red mDefense
      @edf = @enemy.mdefence
      @edf -= 20
      value = value / @edf
    elsif @character_name == "$AmelieATK" || @character_name == "$MandragoraHide" #inc Defense
      value /= 2
    elsif @character_name == "$MimicTrapC"
      value /= 5
    elsif @character_name.include?"ZegreShield"
      value /= 20
    elsif @character_name == "$Trauma" && $game_switches[4540] == false  #incr Defense
      value /= 99  
    end        
    #if $game_switches[1186]
    #  value =0
    #end
    value = 0 if value < 0
    value.round()
    @enemy.hp -= value
    ### DAMAGE TEXT ###
    #$game_map.show_text(self,value)
    $game_map.show_textMag(self,value)
    ### DAMAGE TEXT ###
    if @enemy.hp <= 0
      if $game_switches[3645] == true && @enemy.mdefence >= 20 #killwish
      $game_temp.reserve_common_event(209)
      end      
      kill_enemy(by_player) 
      elsif by_player && @request_view
      @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
      @move_type = 2
      @move_frequency = 6
      @request_view = false
      if $game_switches[883] == true 
          $game_temp.reserve_common_event(78)
        end
    end
  end
#if $game_player.pixel_range?(tx,ty)  
def attack
    #ENEMY ATK
    if $game_switches[1284] == true #ignore ATKs
      return
    end
    allski = $game_variables[114] rescue ""   
    damage = 0
    @chara = @character_name rescue nil
    if @chara == nil
      @character_name = ""
    end   
    $game_variables[393] = @character_name #char name sperm gain    
    @recover = @enemy.recover
    tx = @px + Sapphire_Core::Weapon_Range[@direction][0]
    ty = @py + Sapphire_Core::Weapon_Range[@direction][1]
    if $game_variables[116] == "YinYang" #YinYang Skill
      @agiscore = $game_party.members[0].atk
    else
      @agiscore = $game_party.members[0].agi
    end 
      dch = @agiscore + ($game_party.members[0].luk / 2)
      den = @enemy.agility + (@enemy.luck / 2)
    #if @character_name.include? "Spika"
    #  if @character_name.include? "Atk"
    #    den *= 2
    #  elsif  @character_name.include? "Stealth"
    #    den *= 2
    #  end  
    #end  
      dodge = dch - den  
      dodge /= 2
      @love = $game_party.members[0].parent_stat(0)
   @wepId = $game_party.leader.equips[0].wtype_id rescue 0 
   if $game_party.members[0].id == 1 && @wepId == 2 && $game_variables[628] == 1026 #brawler++
      @mod = ($game_party.leader.hp/$game_party.leader.mhp)*100
        if @mod < 25
          dodge += (dodge/1.5) 
        else
          dodge += 0
        end     
   end      
   if $game_variables[116] == "TaintedLove" #Tainted Love Skill
     @love += $game_party.members[0].parent_stat(1)
   end
  if $game_party.leader.class.id == 2 && $game_switches[4120] == true
    then
      dodge -= (dodge/4)
    end            
      if $game_party.members[0].equips[4] == $data_armors[453] && @love >= 1 #KING 
      if $game_variables[116] == "Manchild" #Manchild Skill
        dodge += (dodge/5) 
      else
        dodge += (dodge/10) 
      end
      elsif $game_party.leader.equips[4] == $data_armors[93]
        dodge += (dodge/2) 
      elsif $game_party.leader.equips[4] == $data_armors[302] || $game_party.leader.equips[4] == $data_armors[377]
        dodge += (dodge/4) 
      end        
      if $game_variables[116] == "Limber" #Limber Skill
         dodge += (dodge/6.6) 
      elsif $game_variables[116] == "Gooey" #Gooey Skill
         dodge += (dodge/3.3)
      elsif $game_variables[116] == "Incorporeal" #Incorporeal Skill
         dodge = 75       
      elsif $game_variables[116] == "NoGuard" #No Guard Skill
         dodge -= (dodge/2) 
      elsif $game_variables[116] == "Moisture" && $game_switches[3438] == true #Moisture Skill + Underwater
         dodge += (dodge/4)      
      elsif $game_variables[116] == "Moisture" && $game_switches[523] == true #Moisture Skill + Rain
         dodge += (dodge/4)           
       end    
        ### adj ###  
    if dodge > 75
      dodge = 75
    elsif dodge < 1
      dodge = 1
    end
    ### adj ###
    chance = rand(100)
 if chance <= dodge
    then
    if @def = 0
    $game_player.animation_id = 119
      if $game_switches[2723] == false && $game_switches[7331] == false
    3.times do; $game_player.move_backward; end
    $game_player.do_step
      end
    damage = 0
    RPG::SE.new("evasion1", 100, 100).play
    $game_switches[749] = true
    $game_player.damage_hero(damage)
  end
else   
  if !$game_switches[1147] && $game_switches[874] && !$game_switches[875]
      if @def = 0
          $game_player.animation_id = 119
      if $game_switches[2723] == false && $game_switches[7331] == false
    3.times do; $game_player.move_backward; end
    $game_player.do_step
    end
          damage = 0
          RPG::SE.new("evasion1", 100, 100).play
          $game_switches[749] = true
          $game_player.damage_hero(damage)
      end
    else       
  @shield = 0       
  if $game_switches[746] == true
    if $game_player.direction == 2 && $game_player.y < $game_map.events[id].y
  @shield = 1 
    elsif $game_player.direction == 8 && $game_player.y > $game_map.events[id].y
  @shield = 1 
    elsif $game_player.direction == 4 && $game_player.x > $game_map.events[id].x
  @shield = 1 
     elsif $game_player.direction == 6 && $game_player.x < $game_map.events[id].x
  @shield = 1    
end
end
@love = $game_party.members[0].parent_stat(0)
   if $game_variables[116] == "TaintedLove" #Tainted Love Skill
     @love += $game_party.members[0].parent_stat(1)
   end
    if $game_party.leader.id == 1 || $game_party.leader.id == 5 || $game_party.leader.class_id == 121 || $game_party.leader.class_id == 209
     if @shield == 1
        if @def = 0
          $game_player.animation_id = @enemy.animation
      if $game_switches[2723] == false && $game_switches[7331] == false
          $game_player.turn_toward_character(self)
          3.times do; $game_player.move_backward; end
          $game_player.do_step
      end    
          damage = 0
          RPG::SE.new("parry", 100, 100).play
          $game_player.damage_hero(damage)
          $game_variables[630] += 1
          if $game_party.members[0].equips.include?$data_armors[243]
            $game_variables[3877] += 1
            if @love >= 2
            $game_variables[3877] += 1
            end
            $game_switches[3471] = true
          end  
          $game_temp.reserve_common_event(66)
        if $game_party.leader.id == 1
          $game_switches[749] = true
        end
      end 
    else
     if @def = 0
      $game_player.animation_id = @enemy.animation
      if $game_switches[2723] == false && $game_switches[7331] == false  
      $game_player.turn_toward_character(self)
      5.times do; $game_player.move_backward; end
      $game_player.do_step
      end
      damage = @enemy.attack * @enemy.attack
      damage += rand(damage*Sapphire_Core::Damage_Random).to_i
      crit = ($game_party.members[0].luk * 100) / @enemy.luck # crit calcs INIT      
      if crit < 100
        chance = rand(100)
      if $game_variables[116] == "Sturdy" #Sturdy Skill
      chance = 0
      elsif $game_party.leader.equips.include?$data_armors[835] #XXS Suit
      chance = 0
      end
     unless allski == "" || allski == 0
      if allski.include? "HighWall" #HighWall Skill  
        chance = 0
      end   
     end        
        if chance >= crit
         damage += damage
         RPG::SE.new("Reflection", 110, 100).play
       end
     else
      crit = (@enemy.luck * @enemy.luck) / 500
      if crit < 2
        crit = 2
      end
      if crit > 75
        crit = 75
      end  
        chance = rand(100)
      if $game_variables[116] == "Sturdy" #Sturdy Skill
      chance = 0
      elsif $game_party.leader.equips.include?$data_armors[835] #XXS Suit
      chance = 0
      end       
     unless allski == "" || allski == 0
      if allski.include? "HighWall" #HighWall Skill  
        chance = 0
      end   
     end     
        if chance <= crit
         damage += damage
         RPG::SE.new("Reflection", 110, 100).play
       end   
     end      # crit calcs END 
      touch = 0
      if $game_party.leader.class_id == 173 && $game_variables[7463] == true #dash
        touch = 1
      elsif $game_party.leader.class_id == 18 && $game_switches[3787] == true #amelie dash
        touch = 1
      end  
      if touch == 1
          then
          damage /= 2
          ##################
          if $game_party.leader.class_id == 173 #salizzie dash
          value = $game_party.members[0].atk * $game_party.members[0].agi * 90/100
          i = 0
          while i <= 5
            if $game_party.members[0].equips[i] == nil
              value += (value/10)
            end  
            i += 1
          end    
            else
          value = $game_party.members[0].atk * $game_party.members[0].def * 90/100
          end
          ##################
          acc = 1
          if acc == 0
          edf = @enemy.defence rescue 60    
          value = (value/edf)/5*(rand(15)+85)/100
          value = 0 if value < 0
          @alivech = @enemy.hp rescue 0
          value.round()
          @enemy.hp -= value if @alivech != 0
    if $game_switches[1075] == true #dog dash
      @animation_id = 35 
    end
    if $game_switches[3787] == true #amelie rush
      @animation_id = 35 
    end     
    if $game_switches[7463] == true #sala bolero
      @animation_id = 57
    end    
          $game_map.show_text(self,value)
        if @enemy.hp <= 0
        if $game_switches[2932] == true
          $game_switches[2934] = true
        end
          kill_enemy(by_player)
        if $game_switches[2932] == true
          $game_switches[2934] = true
        end
      end
      end
          ##################         
          damage_enemy(value)
          ################## 
          @recover = 25
        end                
      $game_player.damage_hero(damage)
      if $game_variables[116] == "Thorns" || $game_party.members[0].state?(221) == true #Thorns Skill
        damageEn = @enemy.attack / 10
        damageEn += rand(damage*Sapphire_Core::Damage_Random).to_i
        $game_map.events[@id].damageSec_enemy(damageEn)  
      end
    end
    end
    else
      if $game_party.leader.id == 16 && $game_switches[1075] == true #dog dash
          then
        if @def = 0
          $game_player.animation_id = @enemy.animation
          damage = 0
          RPG::SE.new("evasion1", 100, 100).play
          $game_player.damage_hero(damage)
          value = $game_party.members[0].atk * $game_party.members[0].agi * 90/100
          damage_enemy(value)
          @recover = 20
        end
      else    
    if @def = 0
      $game_player.animation_id = @enemy.animation
     if $game_switches[2723] == false && $game_switches[7331] == false
      $game_player.turn_toward_character(self)
      3.times do; $game_player.move_backward; end
      $game_player.do_step
    end      
      damage = @enemy.attack * @enemy.attack
      damage += rand(damage*Sapphire_Core::Damage_Random).to_i     
      crit = ($game_party.members[0].luk * 100) / @enemy.luck
      if crit < 100
        chance = rand(100)
        if chance >= crit
         damage += damage
         RPG::SE.new("Reflection", 110, 100).play
       end
     else
      crit = (@enemy.luck * @enemy.luck) / 500
      if crit < 2
        crit = 2
      end
      if crit > 75
        crit = 75
      end  
        chance = rand(100)
        if chance <= crit
         damage += damage
         RPG::SE.new("Reflection", 110, 100).play
       end   
     end      
      touch = 0
      if touch == 1
          then
          damage /= 2
          ##################
          if $game_party.leader.class_id == 173 #salizzie dash
          value = $game_party.members[0].atk * $game_party.members[0].agi * 90/100
          i = 0
          while i <= 5
            if $game_party.members[0].equips[i] == nil
              value += (value/10)
            end  
            i += 1
          end    
            else
          value = $game_party.members[0].atk * $game_party.members[0].def * 90/100
          end
          ##################
          damage_enemy(value)
          ##################
          @recover = 20
        end         
      $game_player.damage_hero(damage) 
      if $game_variables[116] == "Thorns" || $game_party.members[0].state?(221) == true #Thorns Skill
        damageEn = @enemy.attack / 10
        damageEn += rand(damage*Sapphire_Core::Damage_Random).to_i
        $game_map.events[@id].damageSec_enemy(damageEn)
      end             
    end
   end
   end
 end
end
  if $game_party.members[0].state?(51) == true && damage > 0 #crystal harden
    $game_party.members[0].remove_state(51)
  end  
 if damage > 0 && $game_switches[3908] == false
   $game_switches[3908] = true
 end  
      if $game_switches[2723] == false && $game_switches[7331] == false   
    do_step      
    move_forward
      end    
    end
def kill_enemy(by_player)
   ##### BESTIARY ADDITIONS #####
   @idEn = $game_map.events[@id].enemy.id
   unless @idEn.nil?
   if $game_variables[4159] == 0
    $game_variables[4159] = ""
   end  
   @idCheck = "-" + @idEn.to_s + "-"
   if !$game_variables[4159].include?@idCheck
   $game_variables[4159] += @idCheck
   end
   end
   ##### BESTIARY ADDITIONS #####  
    @direction = 2
    moveto(@x,@y)
    @request_view = false
    @step_anime = false
    @move_type = 0
    @character_name = ""
    @tile_id = 0
    @priority_type = 0
    @opacity = 255
    if by_player
      actor = $game_party.members[0] 
      current_level = actor.level
      actor.change_exp(actor.exp + @enemy.exp,false)
      if @enemy.inanimate # check for ROCKS
       1.times do; $game_player.move_backward; end
       $game_player.do_step        
      end  
	    unless @enemy.inanimate # check for ROCKS
      if $game_party.leader.class_id == 184
        $game_switches[7481] = true
        $game_map.screen.pictures[95].show("HarrietHUD", 0, 227, 33, 100, 100, 255, 0)
      end  
      if $game_party.members[0].equips[4] == $data_armors[565] || $game_party.members[0].equips[5] == $data_armors[567] #Huntress Favor
      @animation_id = 134
      actor = $game_party.members[0]
      value = 50
      actor.hp += value
      message = "+ #{value}"
      $game_map.show_text($game_player,message)
      $game_map.sas_hud.refresh_bars  
      end
     ####     
      if $game_variables[628] == 1028 && $game_party.leader.id == 1 #MonsterEater++
        @r = rand(20)
        @wep = $game_party.leader.equips[0].id rescue 0
        if @wep == 166
          @r -= 3
        end  
        if @r < 1
         @food = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14].sample
        if @enemy.typeseafolk
         @food = [7,10].sample                
        elsif @enemy.armorplant
          @food = [8,11,12].sample                 
        elsif @enemy.armorchitin
         @food = [0,1,7,13].sample         
        elsif @enemy.armorstone
         @food = [4,5,14].sample         
        elsif @enemy.armorbone          
          @food = [4,5,14].sample
        elsif @enemy.armorjello
          @food = [6,9,14].sample
        elsif @enemy.armorscale
          @food = [2,3].sample          
        end  
          @food += 500
          $game_party.gain_item($data_items[@food],1)
        end
      end  
      #MonsterEater++ END
      if $game_party.members[0].equips[0] == $data_weapons[112] && $game_variables[2879] > 0 #ecclesiastic claw
        $game_variables[2879] -= 1
      end                     
      if $game_party.leader.class_id == 175 && $game_variables[2879] <= 99 #marie       
        $game_variables[2879] += 1
      elsif $game_party.leader.class_id == 156 && $game_variables[3882] > 0 #wendigo       
        $game_variables[3882] -= 1
      elsif $game_party.leader.class_id == 18 && $game_variables[3882] <= 99  #amelie skill
        $game_variables[3882] += 1
      elsif $game_party.leader.class_id == 129 && $game_variables[3882] > 0 #dokuro skill
        $game_variables[3882] -= 1
      end 
      if $game_variables[116] == "BroodLeader" && $game_variables[3010] > 0
         $game_variables[3010] -= 1
         $game_temp.reserve_common_event(969)
      elsif $game_variables[116] == "Blasphemous" && $game_variables[3882] > 0 #Blasphemous Skill
         $game_variables[3882] -= 1
      elsif $game_variables[116] == "Sacred" && $game_variables[3882] < 100 #Sacred Skill
         $game_variables[3882] += 1         
      elsif $game_variables[116] == "Degenerate" && $game_variables[2879] <= 99 #Degenerate Skill
         $game_variables[2879] += 1
      elsif $game_variables[116] == "Chastised" && $game_variables[2879] >= 1 #Pious Skill
         $game_variables[2879] -= 1         
      end           
      if $game_party.leader.id == 9
          if $game_variables[866] <= 2
          $game_actors[9].add_param(2, 10)
          $game_variables[866] += 1
          $game_temp.reserve_common_event(131)
        end
      end
      # rotation kills
      if $game_switches[7331] == true #nocd
        if @enemy.defence > 20
        $game_variables[6530] += 1 
        end
      else
        if $game_variables[6530] >= 1
        $game_variables[6530] = 0
        end
      end  
	end # check for ROCKS - END
      if current_level != actor.level
        $game_map.sas_hud.refresh_base 
        $game_map.level_up
      end
      $game_map.sas_hud.refresh_bars
    end
    run_enemy_commands
  end
def update_view
   case @direction
     when 2
       if $game_switches[1391] == true || $game_switches[2604] == true || $game_switches[2468] == true || $game_switches[1096] == true || $game_switches[1681] == true || $game_switches[1680] == true || $game_switches[1679] == true || $game_switches[1662] == true || $game_switches[678] == true || $game_switches[622] == true || $game_switches[700] == true || $game_switches[1254] == true || $game_switches[1411] == true || $game_switches[1414] == true || $game_switches[614] == true || $game_switches[3334] == true || $game_switches[3058] == true || $game_switches[3429] == true || $game_switches[3461] == true || $game_switches[3464] == true || $game_switches[632] == true || $game_switches[3886] == true
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2  
                @move_frequency = 6
                @request_view = false             
       end
       if $game_switches[1771] == true     
       tri = -3
       else
       tri = -4  
       end
       if ($game_player.py - @py) >= tri
        if ($game_player.py - @py) <= 13
         if ($game_player.px - @px) <= 7
           if ($game_player.px - @px) >= -7
      if $game_switches[883] == true 
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                $game_temp.reserve_common_event(78)
            end
            end
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2  
                @move_frequency = 6
                @request_view = false
          end
        end
      end
    end
    end
    when 4  
       if $game_switches[1391] == true || $game_switches[2604] == true || $game_switches[2468] == true || $game_switches[1096] == true || $game_switches[1681] == true || $game_switches[1680] == true || $game_switches[1679] == true || $game_switches[1662] == true || $game_switches[678] == true || $game_switches[622] == true || $game_switches[700] == true || $game_switches[1254] == true || $game_switches[1411] == true || $game_switches[1414] == true || $game_switches[614] == true || $game_switches[3334] == true || $game_switches[3058] == true || $game_switches[3429] == true || $game_switches[3461] == true || $game_switches[3464] == true || $game_switches[632] == true || $game_switches[3886] == true
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2  
                @move_frequency = 6
                @request_view = false              
              end
        if $game_switches[1771] == true     
       tri = 3
       else
       tri = 4  
       end
      if ($game_player.px - @px) <= tri
        if ($game_player.py - @py) <= 7         
           if ($game_player.py - @py) >= -7
             if ($game_player.px - @px) >= -13
      if $game_switches[883] == true 
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                $game_temp.reserve_common_event(78)
            end
            end
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2
                @move_frequency = 6
                @request_view = false
          end
        end
      end
    end
    end
   when 6   
       if $game_switches[1391] == true || $game_switches[2604] == true || $game_switches[2468] == true || $game_switches[1096] == true || $game_switches[1681] == true || $game_switches[1680] == true || $game_switches[1679] == true || $game_switches[1662] == true || $game_switches[678] == true || $game_switches[622] == true || $game_switches[700] == true || $game_switches[1254] == true || $game_switches[1411] == true || $game_switches[1414] == true || $game_switches[614] == true || $game_switches[3334] == true || $game_switches[3058] == true || $game_switches[3429] == true || $game_switches[3461] == true || $game_switches[3464] == true || $game_switches[632] == true || $game_switches[3886] == true
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2  
                @move_frequency = 6
                @request_view = false              
              end
       if $game_switches[1771] == true     
       tri = -3
       else
       tri = -4  
       end       
     if ($game_player.px - @px) >= tri
     if ($game_player.py - @py) <= 7
         if ($game_player.px - @px) <= 13
           if ($game_player.py - @py) >= -7
      if $game_switches[883] == true 
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                $game_temp.reserve_common_event(78)
            end
            end
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2 
                @move_frequency = 6
                @request_view = false
          end
        end
      end
    end
    end
    when 8
       if $game_switches[1391] == true || $game_switches[2604] == true || $game_switches[2468] == true || $game_switches[1096] == true || $game_switches[1681] == true || $game_switches[1680] == true || $game_switches[1679] == true || $game_switches[1662] == true || $game_switches[678] == true || $game_switches[622] == true || $game_switches[700] == true || $game_switches[1254] == true || $game_switches[1411] == true || $game_switches[1414] == true || $game_switches[614] == true || $game_switches[3334] == true || $game_switches[3058] == true || $game_switches[3429] == true || $game_switches[3461] == true || $game_switches[3464] == true || $game_switches[632] == true || $game_switches[3886] == true
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2  
                @move_frequency = 6
                @request_view = false              
                  end
       if $game_switches[1771] == true     
       tri = 3
       else
       tri = 4  
       end      
      if ($game_player.py - @py) <= tri
         if ($game_player.px - @px) <= 7
           if ($game_player.py - @py) >= -13
            if ($game_player.px - @px) >= -7
      if $game_switches[883] == true 
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                $game_temp.reserve_common_event(78)
            end
            end
            if $game_switches[893] == false && $game_switches[3600] == false && $game_switches[2706] == false && $game_switches[1151] == false
                @balloon_id = 1 if Sapphire_Core::Enemy_Exclamation
                @move_type = 2 
                @move_frequency = 6
                @request_view = false
          end
        end
      end
    end
  end
end
end
  def update_cast
    case @direction
    when 2
      distance = ($game_player.py - @py)
      if ($game_player.px - @px).abs <= @cx && distance <= @enemy.view && distance >= Sapphire_Core::Enemy_Skill_Distance
        $game_map.skills << Sapphire_Skill.new(self)
        @recover = @enemy.recover
      end
    when 4
      distance = (@px - $game_player.px)
      if ($game_player.py - @py).abs <= @cx && distance <= @enemy.view && distance >= Sapphire_Core::Enemy_Skill_Distance
        $game_map.skills << Sapphire_Skill.new(self)
        @recover = @enemy.recover
      end
    when 6
      distance = ($game_player.px - @px)
      if ($game_player.py - @py).abs <= @cx && distance <= @enemy.view && distance >= Sapphire_Core::Enemy_Skill_Distance
        $game_map.skills << Sapphire_Skill.new(self)
        @recover = @enemy.recover
      end
    when 8
      distance = (@py - $game_player.py)
      if ($game_player.px - @px).abs <= @cx && distance <= @enemy.view && distance >= Sapphire_Core::Enemy_Skill_Distance
        $game_map.skills << Sapphire_Skill.new(self)
        @recover = @enemy.recover
      end
    end
  end
  def setup_page(np)
    sas_setup_page(np)
    setup_enemy(np.nil?)
  end
  def setup_enemy(dispose_enemy)
    unless @enemy.nil?
      $game_map.enemies.delete(self)
      @enemy = nil
    end
    unless dispose_enemy && @list.nil?
      for command in @list
        if command.code == 108 && command.parameters[0].include?("[enemy")
          command.parameters[0].scan(/\[enemy ([0.0-9.9]+)\]/)
          spawn_enemy($1.to_i)
          return
        end
      end
    end
  end
  def spawn_enemy(id)
    $game_map.enemies << self if @enemy.nil?
    @enemy = Sapphire_Enemy.new(self,id)
    @recover = 0
    @step_anime = @enemy.step_anime
    @request_view = true unless @enemy.object
    @character_name = @enemy.char_file unless @enemy.char_file.nil?
    @character_index = @enemy.char_index unless @enemy.char_file.nil?
    @priority_type = 1
    setup_parameters
  end
  def setup_parameters
    return if @list.nil?
    for value in 0...@list.size
      next if @list[value].code != 108 && @list[value].code != 408
      @enemy.atk_invincible = true if @list[value].parameters[0] == "[attack_invincible]"
      @enemy.skl_invincible = true if @list[value].parameters[0] == "[skill_invincible]"
      @enemy.die_erase = true if @list[value].parameters[0] == "[erase]"
      if @list[value].parameters[0].include?("[localsw")
        @list[value].parameters[0].scan(/\[localsw ([0.0-9.9]+)\]/)
        @enemy.die_localsw = $1.to_i
      end
      if @list[value].parameters[0].include?("[switch")
        @list[value].parameters[0].scan(/\[switch ([0.0-9.9]+)\]/)
        @enemy.die_switch = $1.to_i
      end
      if @list[value].parameters[0].include?("[variable")
        @list[value].parameters[0].scan(/\[variable ([0.0-9.9]+)\]/)
        @enemy.die_variable = $1.to_i
      end
    end
  end
  def run_enemy_commands
    ers = @enemy.die_erase
    $game_map.enemies.delete(self)
    unless @enemy.die_localsw.nil?
      key = [$game_map.map_id,@id,Sapphire_Core::Local_Switch[@enemy.die_localsw]]
      $game_self_switches[key] = true
      $game_map.need_refresh = true
    end
    unless @enemy.die_variable.nil?
      $game_variables[@enemy.die_variable] += 1
      $game_map.need_refresh = true
    end
    unless @enemy.die_switch.nil?
      $game_switches[@enemy.die_switch] = true
      $game_map.need_refresh = true
    end
    @enemy = nil
    erase if ers
  end
  def move_type_toward_player
    move_toward_player if near_the_player?
  end
  def setup_page_settings
    kp_setup_page_settings
    setup_collision
    multiply_commands
  end
  def collision?(px,py)
    for event in $game_map.events.values
      if (event.px - px).abs <= event.cx && (event.py - py).abs <= event.cy
        next if event.through || event == self
        return true if event.priority_type == 1
      end
    end
    if @priority_type == 1
      return true if ($game_player.px - px).abs <= @cx && ($game_player.py - py).abs <= @cy
    end
    return false
  end
  def setup_collision
    @cx = Default_Collision_X
    @cy = Default_Collision_Y
    unless @list.nil?
      for value in 0...@list.size
        next if @list[value].code != 108 && @list[value].code != 408
        if @list[value].parameters[0].include?("[collision_x ")
          @list[value].parameters[0].scan(/\[collision_x ([0.0-9.9]+)\]/)
          @cx = $1.to_i
        end
        if @list[value].parameters[0].include?("[collision_y ")
          @list[value].parameters[0].scan(/\[collision_y ([0.0-9.9]+)\]/)
          @cy = $1.to_i
        end
      end
    end
  end
  def front_pixel_touch?(px,py)
    return if $game_map.interpreter.running?
    if @enemy.nil?
      if @trigger == 2 && ($game_player.px - px).abs <= @cx && ($game_player.py - py).abs <= @cy
        start if !jumping? && normal_priority?
      end
    else
      return if jumping? || @recover > 0 || @enemy.nature == 2 || @enemy.object
      attack if $game_map.sas_active && ($game_player.px - px).abs <= @cx && ($game_player.py - py).abs <= @cy
    end
  end
end
#-------------------------------------------------------------------------------
# * Game Interpreter
#-------------------------------------------------------------------------------

class Game_Interpreter
  def self_event
    return $game_map.events[@event_id]
  end
end

#-------------------------------------------------------------------------------
# * Sapphire Bitcore
#-------------------------------------------------------------------------------

module Sapphire_Bitcore
  def self.initialize
    @@buffer = {}
    for skill in load_data("Data/Skills.rvdata2")
      next if skill.nil? || skill.particle.nil?
      Sapphire_Bitcore.push(skill.particle)
    end
  end
  def self::[](key)
    return @@buffer[key]
  end
  def self.push(key)
    return if @@buffer.keys.include?(key)
    @@buffer[key] = Cache.particle(key)
  end
end

Sapphire_Bitcore.initialize

#-------------------------------------------------------------------------------
# * Sapphire Action System IV - Script End
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------