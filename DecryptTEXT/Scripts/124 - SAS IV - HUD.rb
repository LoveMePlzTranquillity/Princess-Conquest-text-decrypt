#-------------------------------------------------------------------------------
# * [ACE] SAS IV HUD
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
# Optimized SAS IV HUD.
#
#-------------------------------------------------------------------------------
# * Configuration
#-------------------------------------------------------------------------------
module HUD_Core
  Background_Name = "hud_bg"
  Contents_Width = 800
  Contents_Height = 120
  Font_Size = 18
  Font_Size2 = 23
  Font_Name = "RuneScape-ENA"
  Font_Color =  Color.new(255,255,255)
  Font_Bold = false
  Font_Italic = false
  No_Skill_Icon = 141
  Health_X = 92
  Health_Y = 42    
  Health_Width = 118
  Health_Height = 21
  Health_Color = Color.new(200,20,60)
  Exp_X = 72
  Exp_Y = 65  
  Exp_Width = 68
  Exp_Height = 4
  Exp_Color = Color.new(0,255,255)
  Magic_X = 660
  Magic_Y = 42  
  Magic_Width = 94
  Magic_Height = 21
  Magic_Color = Color.new(50,60,180)
  Name_X = 128
  Name_Y = 15  
  ###############
  #Spell_X = 650
  #Spell_Y = 76  
  Spell_X = 663
  Spell_Y = 15  
  ###############
  Icon_X = 636
  Icon_Y = 40  
  Level_X = 70
  Level_Y = 15  
  Level_String = "Lv "
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
  error.bitmap = Bitmap.new(800,600)
  error.bitmap.draw_text(0,208,544,32,"Please install the Sapphire Action System IV",1)
  continue = Sprite.new
  continue.bitmap = Bitmap.new(800,600)
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

$khas_awesome << ["SAS HUD",4.0]

#-------------------------------------------------------------------------------
# * Script
#-------------------------------------------------------------------------------

class Sapphire_Hud
  include HUD_Core
  def initialize
    @contents = Sprite.new
    @background = Sprite.new
    @base = Sprite.new
    @contents.bitmap = Bitmap.new(Contents_Width, Contents_Height)
    @base.bitmap = Bitmap.new(Contents_Width, Contents_Height)
    @background.bitmap = Cache.system(Background_Name)
    @base.bitmap.font.bold = Font_Bold
    @base.bitmap.font.italic = Font_Italic
    @base.bitmap.font.size = Font_Size
    @base.bitmap.font.color = Font_Color
    @base.bitmap.font.name = Font_Name
    @contents.z = 200
    @background.z = 210
    @base.z = 220
    @locked = false
    hide(true)
  end
  def refresh_bars(current_hp=@actor.hp)
    return if @hidden
    if @actor.mhp <= 1
      mhpv = 1
    else 
      mhpv = @actor.mhp
    end          
    hp = ((current_hp)*Health_Width)/mhpv
    if @actor.mmp <=  1
      mmpv = 1
    else 
      mmpv = @actor.mmp
    end      
    mp = (@actor.mp*Magic_Width)/mmpv
    exp = ((@actor.exp-@actor.current_level_exp)*Exp_Width)/(@actor.next_level_exp-@actor.current_level_exp)
    @contents.bitmap.clear
    ######################    
    fightParty = 0
    pm = 0
    while pm < $game_party.members.size
       if $game_party.members[pm].hp > 1
        fightParty += 1
      end   
      pm += 1
    end  
    ######################     
    yFac = 76
    if fightParty <= 2
      xFac = 108
    elsif fightParty == 3
      xFac = 94
    elsif fightParty == 4
      xFac = 88
    end  
    pm = 1
    while pm < $game_party.members.size
      if $game_party.members[pm].hp > 1
    fNam = $game_party.members[pm].face_name
    fIndex = $game_party.members[pm].face_index
    picFace = Cache.face(fNam)
    fiStrX = [0,96,192,288,0,96,192,288]
    fiStrY = [40,40,40,40,136,136,136,136]
    iFacx = fiStrX[fIndex]
    iFacy = fiStrY[fIndex]
    if fNam.include?"GoblinP"
      iFacy += 10
    elsif fNam.include?"CatP"
      iFacy += 10
    elsif fNam.include?"DesertP"
      iFacy += 10      
    elsif fNam.include?"GhostP"
      iFacy += 15            
    elsif fNam.include?"DogP"
      iFacy += 5
    elsif fNam.include?"MouP"
      iFacy += 5      
    elsif fNam.include?"RabbitP"
      iFacy += 5      
    elsif fNam.include?"RabH"
      iFacy += 15 
      iFacx += 15 
    end      
    @contents.bitmap.blt(xFac,yFac,picFace,Rect.new(iFacx,iFacy,56+(20*(4-fightParty)),32))
    xFac += 36 +(12*(4-fightParty))
      end
    pm += 1
    end
    #####################    
    @contents.bitmap.fill_rect(Health_X,Health_Y,hp,Health_Height,Health_Color)
    @contents.bitmap.fill_rect(Magic_X+Magic_Width-mp,Magic_Y,mp,Magic_Height,Magic_Color)
  end
  def refresh_base
    return if @hidden
    @base.bitmap.clear
    ###################### 
    ###################### 
    @actor = $game_party.members[0]
    skill = $game_player.current_skill[0]
    @base.bitmap.draw_text(Name_X, Name_Y,100,Font_Size+4,@actor.name)
    @base.bitmap.draw_text(Level_X, Level_Y,64,Font_Size+4,Level_String+@actor.level.to_s,1)
    temp = Cache.system("Iconset")
    unless skill.nil?
      @base.bitmap.draw_text(Spell_X,Spell_Y,134,Font_Size2+4,skill.name)
      @base.bitmap.blt(Icon_X,Icon_Y,temp,Rect.new(skill.icon_index%16*24,skill.icon_index/16*24,24,24))
    else
      @base.bitmap.blt(Icon_X,Icon_Y,temp,Rect.new(No_Skill_Icon%16*24,No_Skill_Icon/16*24,24,24))
    end
    temp.dispose
    temp = nil
  end
  def hide(lock=false)
    unless @background.nil?
      @background.bitmap.dispose
      @background.dispose
      @background = nil
    end
    unless @base.nil?
      @base.bitmap.dispose
      @base.dispose
      @base = nil
    end
    unless @contents.nil?
      @contents.bitmap.dispose
      @contents.dispose
      @contents = nil
    end
    @hidden = true
    @locked = lock unless @locked
  end
  def show(unlock=false)
    @actor = $game_party.members[0]
    return if @locked && !unlock
    @contents = Sprite.new
    @background = Sprite.new
    @base = Sprite.new
    @contents.bitmap = Bitmap.new(Contents_Width, Contents_Height)
    @base.bitmap = Bitmap.new(Contents_Width, Contents_Height)
    @background.bitmap = Cache.system(Background_Name)
    @base.bitmap.font.bold = Font_Bold
    @base.bitmap.font.italic = Font_Italic
    @base.bitmap.font.size = Font_Size
    @base.bitmap.font.color = Font_Color
    @base.bitmap.font.name = Font_Name
    @contents.z = 200
    @background.z = 21
    @base.z = 220
    @hidden = false
    refresh_base
    refresh_bars
    @locked = false
  end
end
