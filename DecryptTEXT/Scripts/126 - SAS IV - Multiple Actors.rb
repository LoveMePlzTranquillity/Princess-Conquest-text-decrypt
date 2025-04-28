#-------------------------------------------------------------------------------
# * [ACE] SAS IV Multiple Actors
#-------------------------------------------------------------------------------
# * By Khas Arcthunder - arcthunder.site40.net
# * Version: 4.2 EN
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
# This script enables the changing of actors, so you can change both voice
# and graphic files (for SAS IV HUD).
# 
#-------------------------------------------------------------------------------
# * Instructions
#-------------------------------------------------------------------------------
# Paste this script below SAS IV and below SAS IV HUD (if you're using the
# SAS IV default HUD). When changing actors, call the following script:
# Multiple_Core.refresh
#-------------------------------------------------------------------------------
# * Configuration
#-------------------------------------------------------------------------------

module Multiple_Core
  
  Multiple_Voice = true
  
  Multiple_Graphics = true
  
  Voice_Files = {
  # Voice hash. Use the following form:
  # actor_id => [voicefile1,voicefile2,voicefile3,...],
  
  1 => ["Hero1","Hero2","Hero3","Hero4","Hero5","Hero6"],
  2 => ["VoiceKob1","VoiceKob2","VoiceKob3","VoiceKob4"],
  4 => ["VoiceDes1","VoiceDes2","VoiceDes3","VoiceDes4"],
  5 => ["VoiceHum1","VoiceHum2","VoiceHum3","VoiceHum4"],
  6 => ["VoiceGol1","VoiceGol2","VoiceGol3","VoiceGol4"],
  7 => ["VoiceSli1","VoiceSli2","VoiceSli3","VoiceSli4"],
  8 => ["VoiceIns1","VoiceIns2","VoiceIns3","VoiceIns4"],
  9 => ["VoiceSke1","VoiceSke2","VoiceSke3","VoiceSke4"],
  11 => ["VoiceWyv1","VoiceWyv2","VoiceWyv3","VoiceWyv4"],
  12 => ["VoiceGho1","VoiceGho2","VoiceGho3","VoiceGho4"],
  14 => ["VoiceGob1","VoiceGob2","VoiceGob3","VoiceGob4"],
  15 => ["sapphire_voice_1","sapphire_voice_2","sapphire_voice_3","sapphire_voice_4","sapphire_voice_5","sapphire_voice_6","sapphire_voice_7"],
  16 => ["VoiceDog1","VoiceDog2","VoiceDog3","VoiceDog4"],
  18 => ["VoiceWyv1","VoiceWyv2","VoiceWyv3","VoiceWyv4"],
  21 => ["VoiceMot1","VoiceMot2","VoiceMot3","VoiceMot4"],
  23 => ["VoiceCat1","VoiceCat2","VoiceCat3","VoiceCat4"],
  24 => ["VoiceWyv1","VoiceWyv2","VoiceWyv3","VoiceWyv4"],
  26 => ["VoiceMou1","VoiceMou2","VoiceMou3","VoiceMou4"],
  30 => ["VoiceRab1","VoiceRab2","VoiceRab3","VoiceRab4"],
  32 => ["VoiceHar1","VoiceHar2","VoiceHar3","VoiceHar4"],
  35 => ["sapphire_voice_1","sapphire_voice_2","sapphire_voice_3","sapphire_voice_4","sapphire_voice_5","sapphire_voice_6","sapphire_voice_7"],
  36 => ["sapphire_voice_1","sapphire_voice_2","sapphire_voice_3","sapphire_voice_4","sapphire_voice_5","sapphire_voice_6","sapphire_voice_7"],
  37 => ["sapphire_voice_1","sapphire_voice_2","sapphire_voice_3","sapphire_voice_4","sapphire_voice_5","sapphire_voice_6","sapphire_voice_7"],
  38 => ["sapphire_voice_1","sapphire_voice_2","sapphire_voice_3","sapphire_voice_4","sapphire_voice_5","sapphire_voice_6","sapphire_voice_7"],
  39 => ["sapphire_voice_1","sapphire_voice_2","sapphire_voice_3","sapphire_voice_4","sapphire_voice_5","sapphire_voice_6","sapphire_voice_7"],
  41 => ["VoiceWyv1","VoiceWyv2","VoiceWyv3","VoiceWyv4"],
  46 => ["VoiceFin1","VoiceFin2","VoiceFin3","VoiceFin4"],
  48 => ["VoiceMer1","VoiceMer2","VoiceMer3","VoiceMer4"],
  53 => ["VoiceBir1","VoiceBir2","VoiceBir3","VoiceBir4"],
  54 => ["VoiceOni1","VoiceOni2","VoiceOni3","VoiceOni4"],
  56=> ["VoicePla1","VoicePla2","VoicePla3","VoicePla4"],
  57=> ["VoiceSha1","VoiceSha2","VoiceSha3","VoiceSha4"]
  # End of Voice hash.
  }
  
  Graphic_Files = {
  # Graphic hash. Use the following form:
  # actor_id => graphic_name,
  
  1 => "BattleHUD",
  2 => "BattleHUD",
  4 => "BattleHUD",
  5 => "BattleHUD",
  6 => "BattleHUD",
  7 => "BattleHUD",
  8 => "BattleHUD",
  9 => "BattleHUD",
  11 => "BattleHUD",
  12 => "BattleHUD",
  14 => "BattleHUD",
  15 => "BattleHUD",
  16 => "BattleHUD",
  18 => "BattleHUD",
  21 => "BattleHUD",
  23 => "BattleHUD",
  26 => "BattleHUD",
  30 => "BattleHUD",
  32 => "BattleHUD",
  35 => "BattleHUD",
  36 => "BattleHUD",
  37 => "BattleHUD",
  38 => "BattleHUD",
  39 => "BattleHUD",
  41 => "BattleHUD",
  46 => "BattleHUD",
  48 => "BattleHUD",
  53 => "BattleHUD",
  54 => "BattleHUD",
  56 => "BattleHUD",
  57 => "BattleHUD"
  # End of Graphic hash.
  
  }
  
  def self.refresh
    $game_map.sas_hud.hide
    $game_map.sas_hud.show
    $game_player.next_skill
    $game_player.refresh_weapon_stats
    SceneManager.scene.spriteset.refresh_weapon rescue return
  end
end

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

$khas_awesome << ["SAS MULTIPLE",4.2]

class Scene_Map <  Scene_Base
  attr_accessor :spriteset
end

if Multiple_Core::Multiple_Voice
  class Game_Player < Game_Character
    def play_voice
      v = $game_party.members[0].id
      if Multiple_Core::Voice_Files[v][rand(Multiple_Core::Voice_Files[v].size)].include?"Voice"
        pitch = 100 + (rand(5)*5)
      else
        pitch = 100
      end  
      RPG::SE.new(Multiple_Core::Voice_Files[v][rand(Multiple_Core::Voice_Files[v].size)],Sapphire_Core::Voice_Volume,pitch).play 
    end
  end
end

if Multiple_Core::Multiple_Graphics && scripts.include?("SAS HUD")
  class Sapphire_Hud
    def initialize
      @contents = Sprite.new
      @background = Sprite.new
      @base = Sprite.new
      @contents.bitmap = Bitmap.new(Contents_Width, Contents_Height)
      @base.bitmap = Bitmap.new(Contents_Width, Contents_Height)
      @background.bitmap = Bitmap.new(1,1)
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
    def show(unlock=false)
      @actor = $game_party.members[0]
      return if @locked && !unlock
      @contents = Sprite.new
      @background = Sprite.new
      @base = Sprite.new
      @contents.bitmap = Bitmap.new(Contents_Width, Contents_Height)
      @base.bitmap = Bitmap.new(Contents_Width, Contents_Height)
      refresh_background
      @base.bitmap.font.bold = Font_Bold
      @base.bitmap.font.italic = Font_Italic
      @base.bitmap.font.size = Font_Size
      @base.bitmap.font.color = Font_Color
      @base.bitmap.font.name = Font_Name
      @contents.z = 200
      @background.z = 210
      @base.z = 220
      @hidden = false
      refresh_base
      refresh_bars
      @locked = false
    end
    def refresh_background
      if $game_switches[4660] == true        
      @background.bitmap = Cache.system("BattleHUDclean")  
      elsif WolfPad.plugged_in?(0) or WolfPad.plugged_in?(1) or WolfPad.plugged_in?
      @background.bitmap = Cache.system("BattleHUDgamepad")
      else
      @background.bitmap = Cache.system("BattleHUD")
      end
    end
  end
end