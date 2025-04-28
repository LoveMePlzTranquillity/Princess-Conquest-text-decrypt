#-------------------------------------------------------------------------------
# * [ACE] SAS IV Heal Player
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
# This script heals the player when level up.
# 
#-------------------------------------------------------------------------------
# * Configuração
#-------------------------------------------------------------------------------
module Heal_Core
  # Heal HP
  HP_Heal = 99999
  # Heal MP
  MP_Heal = 9999
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

$khas_awesome << ["SAS Heal Player",4.0]

#-------------------------------------------------------------------------------
# * Script
#-------------------------------------------------------------------------------

class Game_Map
  alias saslu level_up
  def level_up
    $game_party.members[0].hp += Heal_Core::HP_Heal
    $game_party.members[0].mp += Heal_Core::MP_Heal
    saslu
  end
end