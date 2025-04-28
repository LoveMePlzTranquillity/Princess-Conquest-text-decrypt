#-------------------------------------------------------------------------------
# * [ACE] SAS IV Damage Sprites
#-------------------------------------------------------------------------------
# * By Khas Arcthunder - arcthunder.site40.net
# * Version: 4.1 EN
# * Released on: 13/02/2012
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
# SAS IV damage popup system.
# 
#-------------------------------------------------------------------------------
# * Configuration
#-------------------------------------------------------------------------------
module Damage_Core
  Damage_Font = "Georgia"
  Damage_Size = 22
  Damage_Italic = false
  Damage_Bold = true
  Damage_Color = Color.new(255,255,255)
  Damage_Level = true
  Damage_LString = "Level up!"
end
#-------------------------------------------------------------------------------
# * Register
#-------------------------------------------------------------------------------
if $khas_awesome.nil? 
  $khas_awesome = []
end
scripts = []
$khas_awesome.each { |script| scripts << script[0] }
unless scripts.include?("Sapphire Action System")
  error = Sprite.new
  error.bitmap = Bitmap.new(544,416)
  error.bitmap.draw_text(0,208,544,32,"Please install the Sapphire Action System IV",1)
  continue = Sprite.new
  continue.bitmap = Bitmap.new(544,416)
  continue.bitmap.font.color = Color.new(0,255,0)
  continue.bitmap.font.size = error.bitmap.font.size - 3
  continue.bitmap.draw_text(0,384,544,32,"Tecle ENTER para sair",1)
  add = Math::PI/80; max = 2*Math::PI; angle = 0
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

$khas_awesome << ["SAS Damage Sprites",4.0]

#-------------------------------------------------------------------------------
# * Script
#-------------------------------------------------------------------------------

class Spriteset_Map
  def update_damage_sprites
    $game_map.damage_sprites.each { |damage_sprite| damage_sprite.update; @trash << damage_sprite if damage_sprite.done }
    @trash.each { |item| $game_map.damage_sprites.delete(item) }
    @trash.clear
  end
end

class Game_Map
  def level_up
    return unless Damage_Core::Damage_Level
    @damage_sprites << Sprite_Damage.new($game_player,Damage_Core::Damage_LString)
  end
  def show_text(target,value)
    @damage_sprites << Sprite_Damage.new(target,value)
  end
  def show_textPhy(target,value)
    @damage_sprites << Sprite_DamagePhy.new(target,value)
  end  
  def show_textMag(target,value)
    @damage_sprites << Sprite_DamageMag.new(target,value)
  end    
  def hide_damage_sprites
    virtual_damage = []
    @damage_sprites.each { |damage_sprite| virtual_damage << damage_sprite.release; damage_sprite.dispose }
    @damage_sprites = virtual_damage
  end
  def show_damage_sprites
    virtual_damage = @damage_sprites
    @damage_sprites = []
    virtual_damage.each { |vd| @damage_sprites << Restored_Damage.new(vd) }
    virtual_damage.clear
  end
  def delete_damage_sprites
    if @damage_sprites.nil?
      @damage_sprites = []
    else
      @damage_sprites.each { |damage_sprite| damage_sprite.dispose }
      @damage_sprites.clear
    end
  end
end

class Virtual_Damage
  attr_reader :x
  attr_reader :y
  attr_reader :value
  attr_reader :x_speed
  attr_reader :y_speed
  attr_reader :g_force
  attr_reader :erase
  attr_reader :opacity
  def initialize(x,y,value,xs,ys,gf,e,op)
    @x = x
    @y = y
    @value = value
    @x_speed = xs
    @y_speed = ys
    @g_force = gf
    @erase = e
    @opacity = op
  end
end

class Restored_Damage < Sprite
  attr_accessor :done
  include Damage_Core
  def initialize(vd)
    super(nil)
    @value = vd.value
    self.bitmap = Bitmap.new(160,20)
    self.bitmap.font.name = Damage_Font
    self.bitmap.font.size = Damage_Size
    self.bitmap.font.bold = Damage_Bold
    self.bitmap.font.italic = Damage_Italic
    self.bitmap.font.color = Damage_Color
    self.bitmap.draw_text(0,0,160,20,@value,1)
    self.x = vd.x
    self.y = vd.y
    self.ox = 50
    self.oy = 50
    self.opacity = vd.opacity
    @x_speed = vd.x_speed
    @y_speed = vd.y_speed
    @g_force = vd.g_force
    @erase = vd.erase
  end
  def update
    self.x += @x_speed
    if @erase
      if self.opacity <= 0
        dispose
      else
        @y_speed += @g_force unless @y_speed < -6
        self.y -= @y_speed
        self.opacity -= 10
      end
    else
      if @y_speed < -7
        @erase = true
        @y_speed = 5
      else
        self.y -= @y_speed
        @y_speed += @g_force
      end
    end
  end
  def release
    return Virtual_Damage.new(self.x,self.y,@value,@x_speed,@y_speed,@g_force,@erase,self.opacity)
  end
  def dispose
    self.bitmap.dispose
    self.bitmap = nil
    super
    @done = true
  end
end

class Sprite_Damage < Sprite
  attr_accessor :done
  include Damage_Core
  def initialize(target,value)
    super(nil)
    @value = value.to_s
    self.bitmap = Bitmap.new(160,30)
    self.bitmap.font.name = Damage_Font
    self.bitmap.font.size = Damage_Size
    self.bitmap.font.bold = Damage_Bold
    self.bitmap.font.italic = Damage_Italic
    self.bitmap.font.color = Damage_Color 
     #SUCC DMG#
     if target.is_a?(Game_Event) && $game_switches[2932] == true
        target.animation_id = 375
        self.bitmap.font.size = 22
        self.bitmap.font.color = Color.new(255,125,255)        
     end 
    self.bitmap.draw_text(0,0,160,30,@value,1)
    self.x = target.screen_x
    self.y = target.screen_y
    self.ox = 50
    self.oy = 50
    side = (rand(2) == 0 ? 1 : -1)
    @x_speed = (rand(2)+1)*side
    @y_speed = 6
    @g_force = -0.5
    @erase = false
  end
def update
    self.x += @x_speed
    if @erase
      if self.opacity <= 0
        dispose
      else
        @y_speed += @g_force unless @y_speed < -6
        self.y -= @y_speed
        self.opacity -= 10
      end
    else
      if @y_speed < -7
        @erase = true
        @y_speed = 5
      else
        self.y -= @y_speed
        @y_speed += @g_force
      end
    end
  end
  def release
    return Virtual_Damage.new(self.x,self.y,@value,@x_speed,@y_speed,@g_force,@erase,self.opacity)
  end
  def dispose
    self.bitmap.dispose
    self.bitmap = nil
    super
    @done = true
  end
end

class Sprite_DamagePhy < Sprite
  attr_accessor :done
  include Damage_Core
  def initialize(target,value)
    super(nil)
    @value = value.to_s
    self.bitmap = Bitmap.new(160,30)
    self.bitmap.font.name = Damage_Font
    self.bitmap.font.size = Damage_Size
    self.bitmap.font.bold = Damage_Bold
    self.bitmap.font.italic = Damage_Italic
    self.bitmap.font.color = Damage_Color 
    ###########################
    if target.is_a?(Game_Event)
     calc_atkType(1)   
     calc_armorMod(target)
      if @dmgMod > 0
        self.bitmap.font.size = 24
        self.bitmap.font.color = Color.new(255,0,0)
      elsif @dmgMod < 0
        self.bitmap.font.size = 20
        self.bitmap.font.color = Color.new(155,155,155)
      end       
    end      
    ###########################
    self.bitmap.draw_text(0,0,160,30,@value,1)
    self.x = target.screen_x
    self.y = target.screen_y
    self.ox = 50
    self.oy = 50
    side = (rand(2) == 0 ? 1 : -1)
    @x_speed = (rand(2)+1)*side
    @y_speed = 6
    @g_force = -0.5
    @erase = false
  end
def update
    self.x += @x_speed
    if @erase
      if self.opacity <= 0
        dispose
      else
        @y_speed += @g_force unless @y_speed < -6
        self.y -= @y_speed
        self.opacity -= 10
      end
    else
      if @y_speed < -7
        @erase = true
        @y_speed = 5
      else
        self.y -= @y_speed
        @y_speed += @g_force
      end
    end
  end
  def release
    return Virtual_Damage.new(self.x,self.y,@value,@x_speed,@y_speed,@g_force,@erase,self.opacity)
  end
  def dispose
    self.bitmap.dispose
    self.bitmap = nil
    super
    @done = true
  end
end

class Sprite_DamageMag < Sprite
  attr_accessor :done
  include Damage_Core
  def initialize(target,value)
    super(nil)
    @value = value.to_s
    self.bitmap = Bitmap.new(160,30)
    self.bitmap.font.name = Damage_Font
    self.bitmap.font.size = Damage_Size
    self.bitmap.font.bold = Damage_Bold
    self.bitmap.font.italic = Damage_Italic
    self.bitmap.font.color = Damage_Color 
    ###########################
    if target.is_a?(Game_Event)
     calc_atkType(2)
     calc_armorMod(target)     
      if @dmgMod > 0
        self.bitmap.font.size = 24
        self.bitmap.font.color = Color.new(255,0,0)
      elsif @dmgMod < 0
        self.bitmap.font.size = 20
        self.bitmap.font.color = Color.new(155,155,155)
      end       
    end      
    ###########################
    self.bitmap.draw_text(0,0,160,30,@value,1)
    self.x = target.screen_x
    self.y = target.screen_y
    self.ox = 50
    self.oy = 50
    side = (rand(2) == 0 ? 1 : -1)
    @x_speed = (rand(2)+1)*side
    @y_speed = 6
    @g_force = -0.5
    @erase = false
  end
def update
    self.x += @x_speed
    if @erase
      if self.opacity <= 0
        dispose
      else
        @y_speed += @g_force unless @y_speed < -6
        self.y -= @y_speed
        self.opacity -= 10
      end
    else
      if @y_speed < -7
        @erase = true
        @y_speed = 5
      else
        self.y -= @y_speed
        @y_speed += @g_force
      end
    end
  end
  def release
    return Virtual_Damage.new(self.x,self.y,@value,@x_speed,@y_speed,@g_force,@erase,self.opacity)
  end
  def dispose
    self.bitmap.dispose
    self.bitmap = nil
    super
    @done = true
  end
end

def calc_atkType(atkType)
  @atkType = atkType.to_s
  @wtype = ""
  @eleType = ""
  #####
   if $game_variables[1495] == 0 #fixed ele
     $game_variables[1495] = ""
   end  
   if $game_variables[1495] != ""
     @wtype = $game_variables[1495]
     @eleType = $game_variables[1495]
   return
   end   
  #####   
  if @atkType == "1" #Phys
      unless $game_party.members[0].weapons[0].nil?  
      @mainType = $game_party.members[0].weapons[0].wtype_id rescue nil
        @slash = [1,4,5,11,13,14,18]
        @pierce = [3,7]
        @blunt = [2,8,9,10,15,17]       
       if @slash.include?@mainType
         @wtype = "Slash"
       elsif @pierce.include?@mainType
         @wtype = "Pierce"
       elsif @blunt.include?@mainType
         @wtype = "Blunt"
       else  
         @wtype = "Other"
       end
       ###############################
        @mainWep = $game_party.leader.equips[0].id rescue 0
        if @mainWep == 75 || @mainWep == 94 || @mainWep == 144 || @mainWep == 153 #rapier/pestle
        @wtype = "Pierce"
        elsif @mainWep == 88 || @mainWep == 127 #sickle
        @wtype = "Slash"
        end 
       ###############################
     if $game_party.leader.equips.include?$data_armors[750]
       @eleType += "Fire"
     end  
     if $game_party.leader.equips.include?$data_armors[751]
       @eleType += "Water"
     end  
     if $game_party.leader.equips.include?$data_armors[752]
       @eleType += "Thunder"
     end  
     if $game_party.leader.equips.include?$data_armors[753]
       @eleType += "Ice"
     end  
     if $game_party.leader.equips.include?$data_armors[754]
       @eleType += "Rock"
     end  
     if $game_party.leader.equips.include?$data_armors[755]
       @eleType += "Wind"
     end  
     if $game_party.leader.equips.include?$data_armors[756]
       @eleType += "Holy"
     end  
     if $game_party.leader.equips.include?$data_armors[757]
       @eleType += "Dark"
     end
     if $game_party.leader.equips.include?$data_armors[758]
       @eleType += "Mech"
     end
     if $game_party.leader.equips.include?$data_armors[748] #black dice
       @eleType += "Dark"
     end  
     if $game_party.leader.equips.include?$data_armors[749] #dreamcaller
       @eleType += "Wind"
     end          
       ###############################     
        @fire = [63,72,127,148,53]
        @water = [81,83,90,94,129,172]
        @rock = [35,91,125,135,151,60]
        @mech = [80,96,106,130,131,158,159,160,161,162,163]
        @ice = [61,66,74,93,102,103,164,174]
        @wind =[113,114,115,116,138,154]
        @thunder = [43,75,95,132,54]
        @holy = [39,52,64,84,107]
        @dark = [71,85,105,153,156,168]
        @null = [55,56,57,58,169]
       #Default    
       if @fire.include?@mainWep
         @eleType += "Fire"    
       end  
       if @water.include?@mainWep
         @eleType += "Water"
       end  
       if @rock.include?@mainWep
         @eleType += "Rock"
       end  
       if @mech.include?@mainWep
         @eleType += "Mech"         
       end  
       if @ice.include?@mainWep
         @eleType += "Ice"
       end  
       if @wind.include?@mainWep
         @eleType += "Wind"
       end  
       if @thunder.include?@mainWep
         @eleType += "Thunder"
       end  
       if @holy.include?@mainWep
         @eleType += "Holy"        
       end  
       if @dark.include?@mainWep
         @eleType += "Dark"    
       end
      if $game_variables[116] == "Electrophorus" #Electrophorus Skill
        if !@wtype.include?"Blunt"
         @eleType += "Thunder"
        end
      end           
      if $game_switches[1877] == true #mou skill
        @eleType += "Mech"
      end      
      if $game_variables[116] == "Gooey" #Gooey Skill
        @eleType += "Water"
      end        
       if @eleType == ""
         @eleType += "Phys"
       end  
       if @null.include?@mainWep
         @wtype = "Null"
         @eleType = ""
       end  
       if $game_party.leader.state?(243) #Oblivious
         @wtype = "Null"
         @eleType = ""         
       end               
       @wtype += @eleType 
     end  
    #prior Electrophorus
     else #Mag
      @skiNam = $game_player.current_skill[1] rescue nil   
      unless @skiNam.nil?
        @fire = ["fire","sun","fae","XXX","XXX","XXX","XXX","XXX","XXX"]
        @water = ["spit","XXX","XXX","XXX","XXX","XXX","XXX","XXX","XXX"]
        @rock = ["Cry","rock","XXX","XXX","XXX","XXX","XXX","XXX","XXX"]
        @mech = ["gear","XXX","XXX","XXX","XXX","XXX","XXX","XXX","XXX"]
        @ice = ["snow","froz","snoman","XXX","XXX","XXX","XXX","XXX","XXX"]
        @wind = ["spin","circle","plume","note","XXX","XXX","XXX","XXX","XXX"]
        @thunder = ["elec","Cosmo","laser","XXX","XXX","XXX","XXX","XXX","XXX"]
        @holy = ["holy","smite","XXX","XXX","XXX","XXX","XXX","XXX","XXX"]
        @dark = ["DARK","XXX","XXX","XXX","XXX","XXX","XXX","XXX","XXX"]
       #Default
       @eleType = "Phys"
       @i = 0
       while @i < @fire.length         
       if @skiNam.include?@fire[@i]
         @eleType = "Fire"         
       elsif @skiNam.include?@water[@i]
         @eleType = "Water"
       elsif @skiNam.include?@rock[@i]
         @eleType = "Rock"
       elsif @skiNam.include?@mech[@i]
         @eleType = "Mech"         
       elsif @skiNam.include?@ice[@i]
         @eleType = "Ice"
       elsif @skiNam.include?@wind[@i]
         @eleType = "Wind"
       elsif @skiNam.include?@thunder[@i]
         @eleType = "Thunder"
       elsif @skiNam.include?@holy[@i]
         @eleType = "Holy"        
       elsif @skiNam.include?@dark[@i]
         @eleType = "Dark"          
       end
       @i += 1
     end
     if $game_variables[116] == "FierySpirit" #FierySpirit Skill
       @eleType += "Fire"
     end     
     if $game_variables[116] == "Upbeat"
       @eleType += "Blunt"
     end  
     #puts("@eleType = " + @eleType.to_s)
    end
  end  
end

def calc_armorMod(value)
       if $game_variables[1495] == 0
         $game_variables[1495] = "" 
       end  
       @char = value
       ### Enemy Armor ###
         @dmgMod = 0   
       ###### BEGIN WEAPON TYPE ADD ######
         @slashMod = 0
         @pierceMod = 0
         @bluntMod = 0
         @fireRes = 0
         @waterRes = 0
         @thunderRes = 0
         @iceRes = 0
         @rockRes = 0
         @windRes = 0
         @mechRes = 0
         @holyRes = 0
         @darkRes = 0
         @soundRes = 0
         @weakTo = ""
         @resTo = ""
       if @char.enemy.typeundead
         @weakTo += "Holy"
         @resTo += "Dark"
       end    
       if @char.enemy.armorRES
         @slashMod -= 0.25   
         @pierceMod -= 0.25   
         @bluntMod -= 0.25        
         @weakTo += ""
         @resTo += ""            
       elsif @char.enemy.armorskin
         @slashMod = 0
         @pierceMod = 0
         @bluntMod = 0
         @weakTo += ""
         @resTo += ""
       elsif @char.enemy.armorfur
         @slashMod = 0
         @pierceMod += 0.25
         @bluntMod -= 0.25     
         @weakTo += ""
         @resTo += ""      
       elsif @char.enemy.armorjello
         @slashMod = 0
         @pierceMod += 0.25 
         @bluntMod -= 0.5   
         @weakTo += ""
         @resTo += ""            
       elsif @char.enemy.armorchitin
         @slashMod -= 0.25
         @pierceMod -= 0.25
         @bluntMod += 0.25  
         @weakTo += ""
         @resTo += ""   
       elsif @char.enemy.armorscale
         @slashMod -= 0.25
         @pierceMod += 0.25
         @bluntMod += 0.25   
         @weakTo += ""
         @resTo += ""    
       elsif @char.enemy.armorstone
         @slashMod -= 1
         @pierceMod -= 0.25
         @bluntMod += 0.5    
         @weakTo += ""
         @resTo += ""    
       elsif @char.enemy.armorbone
         @slashMod -= 0.5
         @pierceMod -= 1
         @bluntMod += 0.5
         @weakTo += ""
         @resTo += ""
       elsif @char.enemy.armorplant
         @slashMod += 0.25
         @pierceMod = 0
         @bluntMod -= 0.25        
         @weakTo += ""
         @resTo += ""     
       end  
       if @char.enemy.weakphys
         @weakTo += "Phys"
       elsif @char.enemy.resphys
         @resTo += "Phys"
       end         
       if @char.enemy.weakfire
         @weakTo += "Fire"
       elsif @char.enemy.resfire
         @resTo += "Fire"
       end         
       if @char.enemy.weakwater
         @weakTo += "Water"
       elsif @char.enemy.reswater
         @resTo += "Water"
       end         
       if @char.enemy.weakrock
         @weakTo += "Rock"
       elsif @char.enemy.resrock
         @resTo += "Rock"
       end         
       if @char.enemy.weakmech
         @weakTo += "Mech"
       elsif @char.enemy.resmech
         @resTo += "Mech"
       end         
       if @char.enemy.weakice
         @weakTo += "Ice"
       elsif @char.enemy.resice
         @resTo += "Ice"
       end         
       if @char.enemy.weakwind
         @weakTo += "Wind"
       elsif @char.enemy.reswind
         @resTo += "Wind"
       end         
       if @char.enemy.weakthun
         @weakTo += "Thunder"
       elsif @char.enemy.resthun
         @resTo += "Thunder"
       end         
       if @char.enemy.weakholy
         @weakTo += "Holy"
       elsif @char.enemy.resholy
         @resTo += "Holy"
       end       
       if @char.enemy.weakdark
         @weakTo += "Dark"
       elsif @char.enemy.resdark
         @resTo += "Dark"
       end         
       if @char.enemy.weaksound
         @weakTo += "Sound"
       elsif @char.enemy.ressound
         @resTo += "Sound"
       end           
       ### Applying Mods ###          
        if !@wtype.nil?
        if @wtype.include?"Slash"
           @dmgMod += @slashMod
         elsif @wtype.include?"Pierce"
           @dmgMod += @pierceMod
         elsif @wtype.include?"Blunt"
           @dmgMod += @bluntMod
         end     
        end #@wtype.nil?
        if !@eleType.nil?
        if @eleType != "Phys"
         if @char.enemy.weakall
           @dmgMod += 0.5
         elsif @char.enemy.resall
           @dmgMod -= 0.5
         end            
       end  
        if @weakTo.include?@eleType
          @dmgMod += 0.5
        elsif @resTo.include?@eleType
          @dmgMod -= 0.5
        end  
      end #@eleType.nil?
      ############################
      if @char.enemy.typeDMGwind
        @rockRes += 0.25
        @thunderRes += 0.25
        @windRes -= 0.5
      end  
      if @char.enemy.typeDMGdark
        @fireRes += 0.25
        @holyRes += 0.25
        @darkRes -= 0.5
      end       
      if @char.enemy.typeDMGfae
        @mechRes += 0.25
        @darkRes += 0.25
        @holyRes -= 0.5
      end    
      if @char.enemy.typeDMGfire
        @waterRes += 0.5
        @rockRes += 0.25
        @fireRes -= 0.5
      end    
      if @char.enemy.typeDMGwater
        @thunderRes += 0.25
        @waterRes -= 0.5
        @fireRes -= 0.25
      end
      if @char.enemy.typeDMGice
        @rockRes += 0.25
        @fireRes += 0.25
        @iceRes -= 0.5
        @waterRes -= 0.25
      end
      if @char.enemy.typeDMGrock
        @waterRes += 0.25
        @mechRes += 0.25
        @rockRes -= 0.5
        @fireRes -= 0.25
        @thunderRes -= 0.25
        @windRes -= 0.25
      end
      if @char.enemy.typeDMGmech
        @thunderRes += 0.25
        @waterRes += 0.25
        @mechRes -= 0.5
        @windRes -= 0.25
        @iceRes -= 0.25
      end
      if @char.enemy.typeDMGthunder
        @rockRes += 0.25
        @thunderRes -= 0.5
        @windRes -= 0.5
      end      
      if @char.enemy.typeDMGbug
        @rockRes += 0.25
        @fireRes += 0.25
        @darkRes -= 0.5
      end 
      if @char.enemy.typeDMGgrass
        @windRes += 0.25
        @fireRes += 0.25
        @waterRes -= 0.5
      end     
      if @char.enemy.typeDMGfight
        @slashMod -= 0.25
        @windRes -= 0.25
        @holyRes += 0.25
        @darkRes += 0.25
        @rockRes -= 0.25
      end       
      if @char.enemy.typeDMGghost
         @slashMod -= 0.25
         @pierceMod -= 0.25
         @bluntMod -= 0.25
         @holyRes += 0.25
         @darkRes += 0.25
       end     
      if @char.enemy.typeDMGdragon
         @thunderRes += 0.25
         @windRes -= 0.25
         @holyRes -= 0.25
       end        
      ############################
      if @char.enemy.weakall
         @fireRes += 0.5
         @waterRes += 0.5
         @thunderRes += 0.5
         @iceRes += 0.5
         @rockRes += 0.5
         @windRes += 0.5
         @mechRes += 0.5
         @holyRes += 0.5
         @darkRes += 0.5 
         @soundRes += 0.5 
       elsif @char.enemy.resall
         @fireRes -= 0.5
         @waterRes -= 0.5
         @thunderRes -= 0.5
         @iceRes -= 0.5
         @rockRes -= 0.5
         @windRes -= 0.5
         @mechRes -= 0.5
         @holyRes -= 0.5
         @darkRes -= 0.5  
         @soundRes -= 0.5  
       end #no weak/res all
      if @weakTo.include?"Fire"
         @fireRes += 0.5    
       end  
      if @resTo.include?"Fire"
        @fireRes -= 0.5  
      end    
      if @weakTo.include?"Water"
         @waterRes += 0.5
      end  
      if @resTo.include?"Water"
         @waterRes -= 0.5
      end   
      if @weakTo.include?"Thunder"
         @thunderRes += 0.5
      end  
      if @resTo.include?"Thunder"
         @thunderRes -= 0.5 
      end   
      if @weakTo.include?"Rock"
         @rockRes += 0.5   
      end  
      if @resTo.include?"Rock"
         @rockRes -= 0.5  
      end   
      if @weakTo.include?"Ice"
         @iceRes += 0.5
      end  
      if @resTo.include?"Ice"
         @iceRes -= 0.5
      end   
      if @weakTo.include?"Wind"
         @windRes += 0.5
      end  
      if @resTo.include?"Wind"
         @windRes -= 0.5
      end   
      if @weakTo.include?"Mech"
         @mechRes += 0.5     
      end  
      if @resTo.include?"Mech"
         @mechRes -= 0.5     
      end   
      if @weakTo.include?"Holy"
         @holyRes += 0.5     
      end  
      if @resTo.include?"Holy"
         @holyRes -= 0.5
      end   
      if @weakTo.include?"Dark"
         @darkRes += 0.5        
      end  
      if @resTo.include?"Dark"
         @darkRes -= 0.5   
       end     
      if @weakTo.include?"Sound"
         @soundRes += 0.5        
      end  
      if @resTo.include?"Sound"
         @soundRes -= 0.5   
       end        
     if @slashMod < -1
       @slashMod = -1
     end  
     if @pierceMod < -1
       @pierceMod = -1
     end  
     if @bluntMod < -1 
       @bluntMod = -1
     end  
     if @fireRes < -1 
      @fireRes = -1
     end  
     if @waterRes < -1 
      @waterRes = -1
     end  
     if @thunderRes < -1 
      @thunderRes = -1
     end  
     if @iceRes < -1 
      @iceRes = -1
     end  
     if @rockRes < -1 
      @rockRes = -1
     end  
     if @windRes < -1 
      @windRes = -1
     end  
     if @mechRes < -1 
      @mechRes = -1
     end  
     if @holyRes < -1 
      @holyRes = -1
     end  
     if @darkRes < -1 
      @darkRes = -1
    end     
     if @soundRes < -1 
      @soundRes = -1
    end      
      unless @eleType.nil?
      if @eleType.include?"Fire"
         @dmgMod += @fireRes
      end  
      if @eleType.include?"Water"
         @dmgMod += @waterRes
      end  
      if @eleType.include?"Thunder"
         @dmgMod += @thunderRes
      end  
      if @eleType.include?"Rock"
         @dmgMod += @rockRes
      end  
      if @eleType.include?"Ice"
         @dmgMod += @iceRes
      end   
      if @eleType.include?"Wind"
         @dmgMod += @windRes
      end  
      if @eleType.include?"Mech"
         @dmgMod += @mechRes
      end    
      if @eleType.include?"Holy"
         @dmgMod += @holyRes
      end     
      if @eleType.include?"Dark"
         @dmgMod += @darkRes
       end       
      if @eleType.include?"Sound"
         @dmgMod += @soundRes
      end          
      end 
       ###############################
     if !@wtype.nil?
       if @wtype.include?"Null"
          @dmgMod = 0
        end 
      end  
       ###############################      
     if $game_variables[628] == 1032 #magik - elemental mastery
       @dmgMod *= 2
     end  
       ###############################
     #puts($game_variables[1495])  
     $game_variables[1495] = ""  
     #puts("wtype = " + @wtype.to_s)  
end