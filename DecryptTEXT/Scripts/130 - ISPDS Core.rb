if true # << Make true to use this script, false to disable.
#===============================================================================
#
# ☆ $D13x - CORE
# -- Author   : Dekita
# -- Version  : 2.7
# -- Level    : Easy
# -- Requires : N/A
# -- Engine   : RPG Maker VX Ace.
#
#===============================================================================
# ☆ Import
#-------------------------------------------------------------------------------
$D13x={}if$D13x==nil
$D13x[:CORE] = true
#===============================================================================
# ☆ Updates
#-------------------------------------------------------------------------------
# D /M /Y
# 17/o4/2o14 - Added :script method for Effect Blocks module,
# 26/o3/2o14 - Added Detailed Status Windows, (used in my scenes)
# 17/o3/2o14 - Added More General Settings,
#            - Added Screen Fix Module,
# 16/o3/2o14 - Started Re-write,
#            - Changes Keys Module to support direct :symbol reference,
#            - Added Vocanicon module,
#            - Added Effect Block module,
#            - Improved info in script,
# 13/o3/2o14 - Update, (added this_event method for script calls) - v2.3
# 24/o2/2o14 - Update, (Added Default status window)
# o3/o6/2o13 - Bugfix, (Exp Showing incorrect info),
# 27/o5/2o13 - Added $game_party.alive_battle_members Method
# 22/o5/2o13 - Small Bugfix, (fixed max tp gauge bug)
# o4/o5/2o13 - Small Update, (added @database_id)
# 18/o4/2o13 - Bugfixx, (tp gauge),
#            - Added PrtSc Key,
# o4/o4/2o13 - Added more keyboard keys,
#            ^- :S_Colon, :Equal, :Comma, :Minus, :Period, :F_Slash, :HASH,
#            ^- :L_Sqr_Brack, :B_Slash, :R_Sqr_Brack, :S_Quote,
# o3/o4/2o13 - Fixed Keys.trigger? method
#            - Added Keys.release? method
# o1/o4/2o13 - Added More Keyboard Keys,
#            ^- :F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9, :F10, :F11, :F12
#            ^- :N_0, :N_1, :N_2, :N_3, :N_4, :N_5, :N_6, :N_7, :N_8, :N_9,
#            ^- :ADD, :MUL, :SUB, :DIV, :DECI, :TAB, :BACK, :ENTER, :CAPS,
#            ^- :SPACE, :ESC, :ALT
# 29/o3/2o13 - Added More Keyboard Keys,(Left/Right CTRL)
# 28/o3/2o13 - Improved Customisation Layout,
#            - Removed Some Methods,
#            - Improved Keyboard Code,
# 27/o3/2o13 - Added Keyboard Control,
# 26/o3/2o13 - Compatibility, (Status Scene)
#            - Update, (Icons w/Hue)
# 18/03/2013 - Compatibility, (Skill Scene)
# 23/o2/2o13 - Started, Finished,
#
#===============================================================================
# ☆ Introduction
#-------------------------------------------------------------------------------
# This script is the 'core' script for the $D13x Engine.
# It holds necessary information that is required by my other scripts.
#
# Currently, this script holds information for the following;
# -Fonts,
# -Vocab,
# -Icons (w/Hue),
# -Text Color,
# -Keyboard Control,
#
# You should place this script above all other scripts from the $D13x Engine.
#  
#===============================================================================
# ★☆★☆★☆★☆★☆★☆★☆★ TERMS AND CONDITIONS: ☆★☆★☆★☆★☆★☆★☆★☆★☆
#===============================================================================
# 1. You MUST give credit to "Dekita" !!
# 2. You are NOT allowed to repost this script.(or modified versions)
# 3. You are NOT allowed to convert this script.
# 4. You are NOT allowed to use this script for Commercial games.
# 5. ENJOY!
#
# "FINE PRINT"
# By using this script you hereby agree to the above terms and conditions,
#  if any violation of the above terms occurs "legal action" may be taken.
# Not understanding the above terms and conditions does NOT mean that
#  they do not apply to you.
# If you wish to discuss the terms and conditions in further detail you can
# contact me at http://dekitarpg.wordpress.com/ or DekitaRPG@gmail.com
#
#===============================================================================
# ☆ Instructions
#-------------------------------------------------------------------------------
# Place Below " ▼ Materials " and Above " ▼ Main " in your script editor.
# Place Above ALL Other $D13x Scripts.
#
#===============================================================================
# ☆ Notetags
# For use with Weapons / Armors
#-------------------------------------------------------------------------------
# <tcol: red, grn, blu>
# use this notetag to change the color of the items text shown in some of my
# scenes.
#
# <ihue: hue>
# use this notetag to change the color of icons used in some of my scenes.
# give to equip etc..
#
#===============================================================================
# ☆ Key Input Module Information ::
#-------------------------------------------------------------------------------
# Script Calls :
#--------------#
#
# Keys.press?(:symbol)
# ^- will be triggered if the key is being pressed down
#
# Keys.repeat?(:symbol)
# ^- will be triggered if the key is in the "on" state (caps lock ect)
#
# Keys.trigger?(:symbol)
# ^- will be triggered when they key is first pressed
#
# Keys.release?(:symbol)
# ^- will be triggered when they key is de-pressed (let go)
#
# List Of Key Symbols ::
# :F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9, :F10, :F11, :F12 # << F      KEYS
# :_1, :_2, :_3, :_4, :_5, :_6, :_7, :_8, :_9, :_0              # << NUMBER KEYS
# :A, :B, :C, :D, :E, :F, :G, :H, :I, :J, :K, :L, :M, :N,       # << LETTER KEYS  
# :O, :P, :Q, :R, :S, :T, :U, :V, :W, :X, :Y, :Z                # << LETTER KEYS
# :N_0, :N_1, :N_2, :N_3, :N_4, :N_5, :N_6, :N_7, :N_8, :N_9,   # << NUMPAD KEYS
# :ADD, :MUL, :SUB, :DIV, :DECI                                 # << NUMPAD KEYS
# :LEFT, :RIGHT, :UP, :DOWN                                     # << ARROW  KEYS
# -- -- -- -- -- OTHER KEYS ::
# :SHIFT, :LSHIFT, :RSHIFT, :TAB,   :PAUSE, :CTRL, :L_CTRL, :R_CTRL,
# :BACK,  :ENTER,  :CAPS,   :SPACE, :ESC,   :ALT
# :S_Colon, :Equal, :Comma, :Minus, :Period, :F_Slash, :HASH, :L_Sqr_Brack
# :B_Slash, :R_Sqr_Brack, :S_Quote,
#
# You can use any of the keys above in your own scripts, simply change the
# default Input.press? / Input.trigger? / Input.repeat? methods with the
# equivalent new method :
# Keys.press?(:SYMBOL)
# Keys.repeat?(:SYMBOL)
# Keys.trigger?(:SYMBOL)
# Keys.release?(:SYMBOL)
# :SYMBOL should be one of the symbols above.
# It can also be either the keys 'virtual key code' or you can reference
# the Keys module like so... Keys::Key[:SYMBOL]
#
#-------------------------------------------------------------------------------
# ☆ Effect Blocks Module Information ::
#-------------------------------------------------------------------------------
# Script Calls :
#--------------#
# block = the effect block ie, [:common, id].
# Effect_Blocks.trigger(block)
#
# An Effect Block is basically an array that holds information.
#
# Effect Blocks will always be used in the customization options.
# They are used for certain scripts that unlock achievements or change
# the environment at times that may not be able to be controlled by
# the Developer. e.g A new Level is reached,
 
# I have written them as easy to understand as possible..
# here is a "default" effect blocks to get things started..
# [:common, id]
# as you can see the effect block is surrounded by square brackets '[' ']'
# this is what holds the information held in the block ie. an array
# :common = basically the method, the method MUST ALWAYS be first in the block
# this tells the block what it was designed to control, in this case ,
# it triggers a common event.
# id = the id of the common event to trigger.
#
# And its that easy.
# Of course some more complex effect blocks can be a little complicated,
# But ALL Effect Blocks work in this way, ie. you can read it and it tells you
# EXACTLY what it does..
# [:common, id]
# [:switch, id, true]
# [:switch, id, false]
# [:switch, id, :alternate]
# [:variable, id, :set, value]
# [:variable, id, :add, value]
# [:variable, id, :sub, value]
# [:variable, id, :div, value]
# [:variable, id, :mul, value]
# [:variable, id, :mod, value]
# [:gold, :gain, value]
# [:gold, :lose, value]
# [:item, id, amount, include equip(bool)]
# [:weapon, id, amount, include equip(bool)]
# [:armor, id, amount, include equip(bool)]
# [:script, "code to eval"]
# Note ~
# for :weapon and :armor, if using my $D13x equip system, the amount will become
# the teir of the equip rather than the amount.(equip can also only be added)
#
# You can also create your own custom effect blocks in scripts that use them.
# And thats all there is to know about the basics of effect blocks..
#
#===============================================================================
module Text_Color
#===============================================================================
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ Color Settings
  #-----------------------------------------------------------------------------
  # You can use these colors in any of my scripts that offer color customisation.
  # simply put Text_Color::THE_COLOR_YOU_WANT as the setting.
  # eg.
  # Text_Color::Pure_White
  #-----------------------------------------------------------------------------
  # Shade's
  Pure_White  = Color.new(255,255,255)
  White       = Color.new(222,222,222)
  Grey        = Color.new(111,111,111)
  Black       = Color.new(0  ,0  ,0  )
  #-----------------------------------------------------------------------------
  # Yellow's
  Yellow      = Color.new(255,255,0)
  Gold        = Color.new(212,212,64)
  Orange      = Color.new(255,182,0)
  Deep_Orange = Color.new(212,64,0)
  Dirt_Orange = Color.new(182,64,0)
  Brown       = Color.new(128,32,0)
  #-----------------------------------------------------------------------------
  # Red's
  Red         = Color.new(251,111,111)
  Deep_Red    = Color.new(222,60,60)
  Pure_Red    = Color.new(255,0,0)
  Pink        = Color.new(255,0,255)
  Dark_Pink   = Color.new(182,0,156)
  #-----------------------------------------------------------------------------
  # Blue's
  Sky_Blue    = Color.new(0,182,255)
  Light_Blue  = Color.new(64,128,255)
  Dark_Blue   = Color.new(32,64,255)
  Purple      = Color.new(182,64,255)
  Magenta     = Color.new(156,156,255)
  #-----------------------------------------------------------------------------
  # Green's
  Green       = Color.new(111,251,111)
  Candy_Green = Color.new(0,255,0)
  Dirty_Green = Color.new(128,182,0)
  Khaki_Green = Color.new(111,156,64)
  Turquoise   = Color.new(0,255,182)
  #-----------------------------------------------------------------------------
  # Sets the default equipment text color
  Default_Equip_Color = White
                            #####################
                            # CUSTOMISATION END #
end                         #####################
#===============================================================================
module General
#===============================================================================
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ General Settings
  #-----------------------------------------------------------------------------
  # these settings are usined for visual scripts of mine, such as status screen.
  Fonts     = ["VL Gothic","Serif","Arial"]
  Font_Size = 14
  Font_Bold = true
  #-----------------------------------------------------------------------------
  # Gauges  = [ Color 1                 , Color 2               ]
  Hp_Colors = [ Text_Color::Dirt_Orange , Text_Color::Gold      ]
  Mp_Colors = [ Text_Color::Dark_Blue   , Text_Color::Sky_Blue  ]
  Tp_Colors = [ Text_Color::Grey        , Text_Color::Pure_Red  ]
  Exp_Color = [ Text_Color::Deep_Red    , Text_Color::Dark_Pink ]
  #-----------------------------------------------------------------------------
  # Show TP as a percentage ?
  # Only works in scripts i have written :p
  Show_Tp_As_Perc = false
  #-----------------------------------------------------------------------------
  Show_Icons      = true
  Box_Color       = Color.new(0,0,0,64)
  Page_Turn_Noise = ["Audio\\SE\\Book1", 80, "80+rand(50)"]
  No_Change_Vocab = "--"
 
                            #####################
                            # CUSTOMISATION END #
end                         #####################
#===============================================================================
module Screen_Fix
#===============================================================================
  #-----------------------------------------------------------------------------
  # Setup Screen Width and Height
  #-----------------------------------------------------------------------------
  Width  = 640              #####################
  Height = 416              # CUSTOMISATION END #
end                         #####################
#===============================================================================
module Vocanicon
#===============================================================================
  #-----------------------------------------------------------------------------
  # Actor Info
  # Format    = ["Name:"            , Text_Color::White,  icon,  hue]
  #-----------------------------------------------------------------------------
  Name        = ["Name:"            , Text_Color::White,  0,  0]
  Nick        = ["Alias:"           , Text_Color::White,  0,  0]
  Clas        = [""                 , Text_Color::White,  0,  0]
  Stts        = ["↓ Status ↓"       , Text_Color::White,  0,  0]
  Level       = ['Level:'           , Text_Color::White,  0,  0]
  TP          = ["Chi"              , Text_Color::White,119,  0]
  Exp         = ["Exp"              , Text_Color::White, 60,  0]
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ Statistic Settings
  #-----------------------------------------------------------------------------
  # This is where you would adjust the info shown in my scripts.
  #-----------------------------------------------------------------------------
  # Parameters
  def self.param(param_id)
    case param_id
    when 0 then ["HEALTH"           , Text_Color::White, 187, 0]
    when 1 then ["MANA"             , Text_Color::White, 188, 0]
    when 2 then ["ATK"              , Text_Color::White, 131, 0]
    when 3 then ["DEF"              , Text_Color::White, 139, 0]
    when 4 then ["M ATK"            , Text_Color::White, 416, 0]
    when 5 then ["M DEF"            , Text_Color::White, 15, 0]
    when 6 then ["AGI"              , Text_Color::White, 12, 0]
    when 7 then ["LUK (LOOT)"      , Text_Color::White, 202, 0]
    end
  end
  #-----------------------------------------------------------------------------
  # X - Parameters
  def self.xparam(xparam_id)
    case xparam_id
    when 0 then ["Accuracy"         , Text_Color::White, 133, 0]
    when 1 then ["Evasion"          , Text_Color::White, 134, 0]
    when 2 then ["Critical"         , Text_Color::White, 135, 0]
    when 3 then ["C. Evade"         , Text_Color::White, 136, 0]
    when 4 then ["M. Evade"         , Text_Color::White, 137, 0]
    when 5 then ["M. Reflect"       , Text_Color::White, 138, 0]
    when 6 then ["Counter"          , Text_Color::White, 139, 0]
    when 7 then ["HP Regen"         , Text_Color::White, 140, 0]
    when 8 then ["MP Regen"         , Text_Color::White, 141, 0]
    when 9 then ["TP Regen"         , Text_Color::White, 142, 0]
    end
  end
  #-----------------------------------------------------------------------------
  # S - Parameters
  def self.sparam(sparam_id)
    case sparam_id
    when 0 then ["Aggro"            , Text_Color::White, 149, 0]
    when 1 then ["Guard"            , Text_Color::White, 150, 0]
    when 2 then ["Recovery"         , Text_Color::White, 151, 0]
    when 3 then ["Medicine"         , Text_Color::White, 152, 0]
    when 4 then ["MP Cost"          , Text_Color::White, 153, 0]
    when 5 then ["TP Charge"        , Text_Color::White, 154, 0]
    when 6 then ["P DMG Taken"      , Text_Color::White, 155, 0]
    when 7 then ["M DMG Taken"      , Text_Color::White, 156, 0]
    when 8 then ["Floor DMG"        , Text_Color::White, 157, 0]
    when 9 then ["Exp Rate"         , Text_Color::White, 158, 0]
    end
  end
  #-----------------------------------------------------------------------------
  # Specials
  def self.specials(id)
    case id
    when 0 then ["Auto-Fight", Text_Color::White, 60, 0]
    when 1 then ["Guard", Text_Color::White, 60, 0]
    when 2 then ["Substitue", Text_Color::White, 60, 0]
    when 3 then ["Preserve TP", Text_Color::White, 60, 0]
    end
  end
  #-----------------------------------------------------------------------------
  # Collapse Type
  def self.collapse_type(id)
    case id
    when 0 then ["Boss", Text_Color::White, 60, 0]
    when 1 then ["Instant", Text_Color::White, 60, 0]
    when 2 then ["No Vanish", Text_Color::White, 60, 0]
    end
  end
  #-----------------------------------------------------------------------------
  # Party Ability
  def self.party_ability(id)
    case id
    when 0 then ["Encounter ½", Text_Color::White, 60, 0]
    when 1 then ["Encounter NA", Text_Color::White, 60, 0]
    when 2 then ["No Surprise", Text_Color::White, 60, 0]
    when 3 then ["Pre-Emptive +", Text_Color::White, 60, 0]
    when 4 then ["Gold Double", Text_Color::White, 60, 0]
    when 5 then ["Double Drops", Text_Color::White, 60, 0]
    end
  end
  #-----------------------------------------------------------------------------
  # Various Statistics
  Attack_Speed = ["Atk Speed", Text_Color::White, 60, 0]
  Attack_Times = ["Atks Per Turn", Text_Color::White, 60, 0] # "APT"
  Skill_Type   = ["Skillset", Text_Color::White, 60, 0]
  Skill        = ["Skills", Text_Color::White, 60, 0]
  Equip_Type   = ["Equipable", Text_Color::White, 60, 0]
  Action_Times = ["Action Time", Text_Color::White, 60, 0]
  Fixed        = ["Fixed ", Text_Color::White, 60, 0]
  Sealed       = ["Sealed ", Text_Color::White, 60, 0]
  Slot_Type    = ["Slot Type", Text_Color::White, 60, 0]
  Dual_Slot    = ["Dual Wield", Text_Color::White, 60, 0]
  One__Slot    = ["Single", Text_Color::White, 60, 0]
                            #####################
                            # CUSTOMISATION END #
end                         #####################
#===============================================================================
module Core_Notes
#===============================================================================
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ Notetag Settings
  #-----------------------------------------------------------------------------
  Icon_Hue = /<ihue:(.*)>/i
  Text_Col = /<tcol:(.*),(.*),(.*)>/i
                            #####################
                            # CUSTOMISATION END #
end                         #####################
 
#☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★#
#                                                                               #
#                       http://dekitarpg.wordpress.com/                         #
#                                                                               #
#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆#
# The following code is protected under the 2013 Dekita Data Protection Act.    #
# Ie. The “Do Not Fucking Look” Law.                                            #
# Breaking This One And Only Rule May Result In The Following Side Effects :    #
# Eyes Bleeding, Nightmares, Severe Head Ache's AND A Scratch On Your Knee :p   #
# That is all !                                                                 #
#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆#
#===============================================================================
module Screen_Fix
#===============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  Graphics.resize_screen(Width,Height)
end
#===============================================================================
module Vocab
#===============================================================================
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # This is to overwrite the methods used in vocab..
  #-----------------------------------------------------------------------------
  def self.param(param_id)    ; return Vocanicon.param(param_id)[0]       ;  end
  def self.x_param(x_param_id); return Vocanicon.xparam(x_param_id)[0]    ;  end
  def self.s_param(s_param_id); return Vocanicon.sparam(s_param_id)[0]    ;  end
  def self.specials(id)       ; return Vocanicon.specials(id)[0]          ;  end
  def self.collapse_type(id)  ; return Vocanicon.collapse_type(id)[0]     ;  end
  def self.party_ability(id)  ; return Vocanicon.party_ability(id)[0]     ;  end
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # This is to overwrite the methods used in vocab..
  #-----------------------------------------------------------------------------
  Attack_Speed = Vocanicon::Attack_Speed[0]
  Attack_Times = Vocanicon::Attack_Times[0]
  Skill_Type   = Vocanicon::Skill_Type[0]
  Skill        = Vocanicon::Skill[0]
  Equip_Type   = Vocanicon::Equip_Type[0]
  Action_Times = Vocanicon::Action_Times[0]
  Fixed        = Vocanicon::Fixed[0]
  Sealed       = Vocanicon::Sealed[0]
  Slot_Type    = Vocanicon::Slot_Type[0]
  Dual_Slot    = Vocanicon::Dual_Slot[0]
  One__Slot    = Vocanicon::One__Slot[0]
  Exp          = Vocanicon::Exp[0]
  Tp           = Vocanicon::TP[0]
end
#===============================================================================
module Effect_Blocks
#===============================================================================
  #-----------------------------------------------------------------------------
  # This is simply the module that holds the default effect blocks
  # DO NOT modify the exsisting code, but feel free to add to it, IF
  # you are confident in what you are doing and need to impliment
  # a new common effect block.
  #-----------------------------------------------------------------------------
  def self.trigger(block)
    return if block == nil
    case block[0]
    when :switch   then self.switch block
    when :variable then self.variable block
    when :common   then self.common block
    when :gold     then self.gold block
    when :item     then self.item block
    when :weapon   then self.weapon block
    when :armor    then self.armor block
    when :script   then      evaluate block
    when :popup    then self.popup block
    end
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.switch(block)
#    [:switch, id, :alternate]
    if block[2] == :alternate
      $game_switches[block[1]] = !$game_switches[block[1]]
    else
      $game_switches[block[1]] = block[2]
    end
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.variable(block)
    case block[2]
      when :set then value = block[3]
      when :add then value = ($game_variables[block[1]] + block[3]).to_i
      when :sub then value = ($game_variables[block[1]] - block[3]).to_i
      when :div then value = ($game_variables[block[1]] / block[3]).to_i
      when :mul then value = ($game_variables[block[1]] * block[3]).to_i
      when :mod then value = ($game_variables[block[1]] % block[3]).to_i
    end
    $game_variables[block[1]] = (value)
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.comomon(block)
    $game_temp.reserve_common_event( eff[1] )
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.gold(block)
    case block[1]
      when :gain ; $game_party.gain_gold(block[2].to_i)
      when :lose ; $game_party.lose_gold(block[2].to_i)
    end
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.item(block)
    $game_party.gain_item($data_items[block[1]],block[2].to_i)
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.weapon(block)
    inc_e = block[3] == nil ? false : block[3]
    if $D13x[:UniEquip]
      Cloning_101.start_clone(:weapon, block[1], block[2].to_i)
    else
      $game_party.gain_item($data_weapons[block[1]],block[2].to_i,inc_e)
    end
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.armor(block)
    inc_e = block[3] == nil ? false : block[3]
    if $D13x[:UniEquip]
      Cloning_101.start_clone(:armor, block[1], block[2].to_i)
    else
      $game_party.gain_item($data_armors[block[1]],block[2].to_i,inc_e)
    end
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.evaluate(block)
    return unless block[1].is_a?(String)
    eval(block[1]) rescue msgbox("the effect block you are trying to eval is wrong")
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.popup(block)
    return unless $D13x[:Epic_Popups]
  end
end
#===============================================================================
class Object
#===============================================================================
  #-------------------------------------------------------------------------
  # rand_between
  #-------------------------------------------------------------------------
  def rand_between(min, max)
    min + rand(max - min + 1)
  end
end
#===============================================================================
class Numeric
#===============================================================================
  #---------------------------------------------------------------------------
  # To Float (with limited digits after decimal point)
  #---------------------------------------------------------------------------
  def to_flim(limit = 5, saftey = "0")
    str = self.to_f.to_s + saftey
    new_str = ""
    limit.times do |i|
      break if new_str =~ /[0-9].[0-9][0-9]/
      break if str[i] == nil
      new_str += str[i]
    end
    return new_str
  end
  #---------------------------------------------------------------------------
  # To A Percentage Of (num)
  #---------------------------------------------------------------------------
  def perc_of(num)
    self.to_f / num.to_f * 100.0
  end
  #---------------------------------------------------------------------------
  # Even ?
  #---------------------------------------------------------------------------
  def even?
    e = self.to_s
    e[e.size] == ("0"||"2"||"4"||"6"||"8")
  end
  #---------------------------------------------------------------------------
  # 0dd?
  #---------------------------------------------------------------------------
  def odd?
    o = self.to_s
    o[o.size] == ("1"||"3"||"5"||"7"||"9")
  end
end
#===============================================================================
module Keys
#===============================================================================
  #-----------------------------------------------------------------------------
  # Win32API Information
  #-----------------------------------------------------------------------------
  def self.w  ; Win32API           ;  end
  def self.u  ; "user32"           ;  end
  def self.i  ; "i"                ;  end
  def self.gk ; "GetKeyState"      ;  end
  def self.ga ; "GetAsyncKeyState" ;  end
  #---------------------------------------------------------------------------
  # Key Settings
  #---------------------------------------------------------------------------
  Key={
  # Func's
  :F1 => 0x70,:F2 => 0x71,:F3 => 0x72,:F4  => 0x73,:F5  => 0x74,:F6  => 0x75,
  :F7 => 0x76,:F8 => 0x77,:F9 => 0x78,:F10 => 0x7a,:F11 => 0x7b,:F12 => 0x7c,
  # Numbers
  :_0 => 0x30,:_1 => 0x31,:_2 => 0x32,:_3 => 0x33,:_4 => 0x34,
  :_5 => 0x35,:_6 => 0x36,:_7 => 0x37,:_8 => 0x38,:_9 => 0x39,
  # Letters
  :A => 0x41,:B => 0x42,:C => 0x43,:D => 0x44,:E => 0x45,:F => 0x46,:G => 0x47,
  :H => 0x48,:I => 0x49,:J => 0x4A,:K => 0x4B,:L => 0x4C,:M => 0x4D,:N => 0x4E,
  :O => 0x4F,:P => 0x50,:Q => 0x51,:R => 0x52,:S => 0x53,:T => 0x54,:U => 0x55,
  :V => 0x56,:W => 0x57,:X => 0x58,:Y => 0x59,:Z => 0x5A,
  # NumPad
  :N_0   => 0x60, :N_1  => 0x61, :N_2  => 0x62, :N_3  => 0x63, :N_4  => 0x64,
  :N_5   => 0x65, :N_6  => 0x66, :N_7  => 0x67, :N_8  => 0x68, :N_9  => 0x69,
  :ADD   => 0x6b, :MUL  => 0x6a, :SUB  => 0x6d, :DIV  => 0x6f, :DECI => 0x6e,
  # Arrows
  :LEFT => 0x25, :RIGHT => 0x27, :UP => 0x26, :DOWN => 0x28,
  # Symbols
  :S_Colon => 0xBA, :Equal       => 0xBB, :Comma   => 0xBC, :Minus       => 0xBD,
  :Period  => 0xBE, :F_Slash     => 0xBF, :HASH    => 0xDE, :L_Sqr_Brack => 0xDB,
  :B_Slash => 0xDC, :R_Sqr_Brack => 0xDD, :S_Quote => 0xC0,
  # Other
  :SHIFT => 0x10, :LSHIFT   => 0xa0, :RSHIFT   => 0xa1, :TAB    => 0x09,
  :PAUSE => 0x13, :L_CTRL   => 0xa2, :R_CTRL   => 0xa3, :CTRL   => 0x11,
  :BACK  => 0x08, :ENTER    => 0x0D, :CAPS     => 0x14, :SPACE  => 0x20,
  :ESC   => 0x1B, :ALT      => 0x12, :PrtSc    => 0x2c,
  } # << End Key {}
  #---------------------------------------------------------------------------
  # Constants
  #---------------------------------------------------------------------------
  KS = w.new(u,gk,[i],i)
  AK = w.new(u,ga,[i],i)
  #---------------------------------------------------------------------------
  # Variables
  #---------------------------------------------------------------------------
  @trigger  = Array.new(256) { false }
  @presses  = Array.new(256) { false }
  @release  = Array.new(256) { false }
  @repeats  = Array.new(256) { false }
  #---------------------------------------------------------------------------
  # Update All Key's State's
  #---------------------------------------------------------------------------
  def self.update
    @trigger = Array.new(256) { false }
    @release = Array.new(256) { false }
    Key.each do |key|
      akey = AK.call(key[1])
      ktri = KS.call(key[1])
      @trigger[ key[1] ] = true if ((!@presses[key[1]]) && (akey != 0))
      @release[ key[1] ] = true if (( @presses[key[1]]) && (akey == 0))
      @presses[ key[1] ] = (akey != 0) ? true : false
      @repeats[ key[1] ] = (ktri == 1) ? true : false
    end
  end
  #---------------------------------------------------------------------------
  # Key Got Triggered? [ inital key press ]
  #---------------------------------------------------------------------------
  def self.trigger?(key)
    return if key.nil?
    if key.is_a?(Symbol)
      return @trigger[Key[key]]
    end
    return @trigger[key]
  end
  #---------------------------------------------------------------------------
  # Key Got Released? [ inital key depress ]
  #---------------------------------------------------------------------------
  def self.release?(key)
    return if key.nil?
    if key.is_a?(Symbol)
      return @release[Key[key]]
    end
    return @release[key]
  end
  #---------------------------------------------------------------------------
  # Key Being Pressed Currently ?
  #---------------------------------------------------------------------------
  def self.press?(key)
    return if key.nil?
    if key.is_a?(Symbol)
      return @presses[Key[key]]
    end
    return @presses[key]
  end
  #---------------------------------------------------------------------------
  # Key Turned On? [Caps Lock, Num Lock, ect..]
  #---------------------------------------------------------------------------
  def self.repeat?(key)
    return if key.nil?
    if key.is_a?(Symbol)
      return @repeats[Key[key]]
    end
    return @repeats[key]
  end
end
#===============================================================================
module Input
#===============================================================================
  #---------------------------------------------------------------------------
  # Alias List
  #---------------------------------------------------------------------------
  class << self
    alias :update_dekita_core_keys :update
  end
  #---------------------------------------------------------------------------
  # Update $D13x Keys
  #---------------------------------------------------------------------------
  def self.update(*args)
    update_dekita_core_keys(*args)
    Keys.update
  end
end
#===============================================================================
module Cache
#===============================================================================
  #--------------------------------------------------------------------------
  # * Get System Graphic
  #--------------------------------------------------------------------------
  def self.icon(filename = "IconSet", hue = 0)
    load_bitmap("Graphics/System/", filename, hue)
  end
end
#===============================================================================
module DataManager
#===============================================================================
  #---------------------------------------------------------------------------
  # Alias List
  #---------------------------------------------------------------------------
  class << self
    alias :lbd_dekita_core :load_database
  end
  #---------------------------------------------------------------------------
  # Load Database (alias)
  #---------------------------------------------------------------------------
  def self.load_database
    lbd_dekita_core
    loa_dekita_core
  end
  #---------------------------------------------------------------------------
  # Load Unique Shit
  #---------------------------------------------------------------------------
  def self.loa_dekita_core
    classes = [$data_weapons, $data_armors , $data_items  , $data_skills ,
               $data_actors , $data_classes, $data_enemies, $data_states ]
    classes.each do |c|
      c.each do |o|
        next if o == nil
        o.load_dekita_core
      end
    end
  end
end # << DataManager
#===============================================================================
class RPG::BaseItem
#===============================================================================
  #--------------------------------------------------------------------------
  # Pi Variables
  #--------------------------------------------------------------------------
  attr_accessor  :item_disp_color
  attr_accessor  :database_id
  attr_accessor  :icon_hue
  #--------------------------------------------------------------------------
  # Loads Unique Shit
  #--------------------------------------------------------------------------
  def load_dekita_core
    @item_disp_color = Text_Color::Default_Equip_Color
    @database_id     = @id
    @icon_hue        = 0
    self.note.split(/[\r\n]+/).each do |line|
      case line
      when Core_Notes::Icon_Hue
        @icon_hue = $1.to_i
      when Core_Notes::Text_Col
        @item_disp_color = Color.new($1.to_i,$2.to_i,$3.to_i)
      end
    end
  end  
  #--------------------------------------------------------------------------
  # Returns features for item filtered by code (credits Tsukihime)
  #--------------------------------------------------------------------------
  def feature_val(code)
    self.features.select {|ft| ft.code == code}
  end
  #--------------------------------------------------------------------------
  # Returns features for item filtered by code and data ID (credits Tsukihime)
  #--------------------------------------------------------------------------
  def feature_val_with_id(code, data_id)
    self.features.select {|ft| ft.code == code && ft.data_id == data_id}
  end
  #--------------------------------------------------------------------------
  # Returns sum of all features for item, by code and data ID (credits Tsukihime)
  #--------------------------------------------------------------------------
  def features_sum(code, data_id)
    feature_val_with_id(code, data_id).inject(0.0) {|r, ft| r += ft.value }    
  end
  #--------------------------------------------------------------------------
  # Returns features pi
  #--------------------------------------------------------------------------
  def features_pi(code, data_id)
    feature_val_with_id(code, data_id).inject(1.0) {|r, ft| r *= ft.value }    
  end
  #--------------------------------------------------------------------------
  # Calculate Set Sum of Features
  #--------------------------------------------------------------------------
  def features_set(code)
    feature_val(code).inject([]) {|r, ft| r |= [ft.data_id] }
  end  
end
#==============================================================================
class Game_Party < Game_Unit
#==============================================================================
  #-----------------------------------------------------------------------------
  # Get Battle Members
  #-----------------------------------------------------------------------------
  def alive_battle_members
    all_members[0, max_battle_members].select {|a| a.exist? && a.hp > 0 }
  end
end
#===============================================================================
class Game_Troop < Game_Unit
#===============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def setup(troop_id)
    clear
    @troop_id = troop_id
    @enemies = []
    troop.members.each do |member|
      next unless $data_enemies[member.enemy_id]
      enemy = Game_Enemy.new(@enemies.size, member.enemy_id)
      enemy.hide if member.hidden
      enemy.screen_x = member.x + (Graphics.width - 544)/2
      enemy.screen_y = member.y + (Graphics.height - 416)
      @enemies.push(enemy)
    end
    init_screen_tone
    make_unique_names
  end
end
#==============================================================================
class Game_Event < Game_Character
#==============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def near_the_screen?(dx = nil, dy = nil)
    dx = [Graphics.width, $game_map.width * 256].min/32 - 5 if dx.nil?
    dy = [Graphics.height, $game_map.height * 256].min/32 - 5 if dy.nil?
    ax = $game_map.adjust_x(@real_x) - Graphics.width / 2 / 32
    ay = $game_map.adjust_y(@real_y) - Graphics.height / 2 / 32
    ax >= -dx && ax <= dx && ay >= -dy && ay <= dy
  end
end # Game_Event
#===============================================================================
class Game_Interpreter
#===============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def this_event
    return $game_map.events[@event_id]
  end
end
#===============================================================================
module Spriteset_MapBattle
#===============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def init_map_battle
    @deki_vp   = Viewport.new
    @deki_vp.z = 200
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def disp_map_battle
    @deki_vp.dispose
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def updt_map_battle
    #@deki_vp.update
  end
end
#===============================================================================
class Spriteset_Map
#===============================================================================
  #-----------------------------------------------------------------------------
  # Included Modules
  #-----------------------------------------------------------------------------
  include Spriteset_MapBattle
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  alias :init_dekiview :initialize
  alias :disp_dekiview :dispose
  alias :updt_dekiview :update
  #-----------------------------------------------------------------------------
  # Initialize
  #-----------------------------------------------------------------------------
  def initialize
    init_map_battle
    init_dekiview
  end
  #-----------------------------------------------------------------------------
  # Dispose
  #-----------------------------------------------------------------------------
  def dispose
    disp_map_battle
    disp_dekiview
  end
  #-----------------------------------------------------------------------------
  # Update
  #-----------------------------------------------------------------------------
  def update
    updt_map_battle
    updt_dekiview
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def create_viewports
    if Graphics.width > $game_map.width * 32 && !$game_map.loop_horizontal?
      dx = (Graphics.width - $game_map.width * 32) / 2
    else
      dx = 0
    end
    dw = [Graphics.width, $game_map.width * 32].min
    dw = Graphics.width if $game_map.loop_horizontal?
    if Graphics.height > $game_map.height * 32 && !$game_map.loop_vertical?
      dy = (Graphics.height - $game_map.height * 32) / 2
    else
      dy = 0
    end
    dh = [Graphics.height, $game_map.height * 32].min
    dh = Graphics.height if $game_map.loop_vertical?
    @viewport1 = Viewport.new(dx, dy, dw, dh)
    @viewport2 = Viewport.new(dx, dy, dw, dh)
    @viewport3 = Viewport.new(dx, dy, dw, dh)
    @viewport2.z = 50
    @viewport3.z = 100
  end
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def update_viewport_sizes
    if Graphics.width > $game_map.width * 32 && !$game_map.loop_horizontal?
      dx = (Graphics.width - $game_map.width * 32) / 2
    else
      dx = 0
    end
    dw = [Graphics.width, $game_map.width * 32].min
    dw = Graphics.width if $game_map.loop_horizontal?
    if Graphics.height > $game_map.height * 32 && !$game_map.loop_vertical?
      dy = (Graphics.height - $game_map.height * 32) / 2
    else
      dy = 0
    end
    dh = [Graphics.height, $game_map.height * 32].min
    dh = Graphics.height if $game_map.loop_vertical?
    rect = Rect.new(dx, dy, dw, dh)
    for viewport in [@viewport1, @viewport2, @viewport3, @deki_vp]
      viewport.rect = rect
    end
  end  
end
#===============================================================================
class Spriteset_Battle
#===============================================================================
  #-----------------------------------------------------------------------------
  # Included Modules
  #-----------------------------------------------------------------------------
  include Spriteset_MapBattle
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  alias :init_dekiview :initialize
  alias :disp_dekiview :dispose
  alias :updt_dekiview :update
  #-----------------------------------------------------------------------------
  # Initialize
  #-----------------------------------------------------------------------------
  def initialize
    init_map_battle
    init_dekiview
  end
  #-----------------------------------------------------------------------------
  # Dispose
  #-----------------------------------------------------------------------------
  def dispose
    disp_map_battle
    disp_dekiview
  end
  #-----------------------------------------------------------------------------
  # Update
  #-----------------------------------------------------------------------------
  def update
    updt_map_battle
    updt_dekiview
  end
end
#==============================================================================
class Window_Base < Window
#==============================================================================
  #--------------------------------------------------------------------------
  #
  #--------------------------------------------------------------------------
  def refresh_fonts
    if !General::Fonts.include?(self.contents.font.name)
      self.contents.font.name = General::Fonts
    end
    if self.contents.font.size != General::Font_Size
      self.contents.font.size = General::Font_Size
    end
    if self.contents.font.bold != General::Font_Bold
      self.contents.font.bold = General::Font_Bold
    end
  end
  #--------------------------------------------------------------------------
  # Draw Gauge (w/height)
  #--------------------------------------------------------------------------
  def draw_deki_gauge(gx, gy, gw, gh, rate, color1, color2)
    empty_gauge_color = Color.new(0,0,0,128)
    fill_w = [(gw * rate).to_i, gw].min
    gauge_h = gh
    gauge_y = gy + line_height - 2 - gauge_h
    contents.fill_rect(gx, gauge_y, gw, gauge_h, empty_gauge_color)
    contents.gradient_fill_rect(gx, gauge_y, fill_w, gauge_h, color1, color2)
  end
  #--------------------------------------------------------------------------
  # Draw Hp
  #--------------------------------------------------------------------------
  def draw_de_hp(x, y, wid = nil)
    wid = self.width/2 - (standard_padding*2) if wid == nil
    rate = @actor.hp_rate
    color1 = General::Hp_Colors[0]
    color2 = General::Hp_Colors[1]
    draw_deki_gauge(x, y, wid-x-2, 2, rate, color1, color2)
    draw_text(x+4, y, wid, line_height, Vocanicon.param(0)[0])
    draw_text(x, y, wid-x-6, line_height, "#{@actor.hp}/#{@actor.mhp}",2)
  end
  #--------------------------------------------------------------------------
  # Draw Mp
  #--------------------------------------------------------------------------
    def draw_de_mp(x, y, wid = nil)
    wid = self.width/2 - (standard_padding*2) if wid == nil
    rate = @actor.mp_rate
    color1 = General::Mp_Colors[0]
    color2 = General::Mp_Colors[1]
    draw_deki_gauge(x, y, wid-x-2, 2, rate, color1, color2)
    draw_text(x+4, y, wid, line_height, Vocanicon.param(1)[0])
    draw_text(x, y, wid-x-6, line_height, "#{@actor.mp}/#{@actor.mmp}",2)
  end
  #--------------------------------------------------------------------------
  # Draw Tp
  #--------------------------------------------------------------------------
    def draw_de_tp(x, y, wid = nil)
    wid = self.width/2 - (standard_padding*2) if wid == nil
    rate = @actor.max_tp == 0 ? 0 : @actor.tp.to_i.to_f / @actor.max_tp.to_i
    color1 = General::Tp_Colors[0]
    color2 = General::Tp_Colors[1]
    draw_deki_gauge(x, y, wid-x-2, 2, rate, color1, color2)
    draw_text(x+4, y, wid, line_height, Vocanicon::TP[0])
    text = "#{(@actor.tp).to_i}/#{@actor.max_tp.to_i}"
    text = "#{(@actor.tp.perc_of(@actor.max_tp)).to_flim}%" if General::Show_Tp_As_Perc
    draw_text(x, y, wid-x-6, line_height, text,2)
  end
  #--------------------------------------------------------------------------
  # Draw Exp (w/gauge)
  #--------------------------------------------------------------------------
  def draw_de_xp(x, y, gauge = true)
    s1 = @actor.current_level_exp
    s2 = @actor.next_level_exp
    s1_g = @actor.exp - @actor.current_level_exp
    s2_g = @actor.next_level_exp - @actor.current_level_exp
    wid = self.width/2 - (standard_padding*2)
    wid_b = self.width/2 - (standard_padding)
    rate = (s1_g).to_f / (s2_g)
    color1 = General::Exp_Color[0]
    color2 = General::Exp_Color[1]
    draw_deki_gauge(wid_b, y, wid-x-2, 2, rate, color1, color2) if gauge
    draw_text(wid_b+4, y, wid, line_height, Vocanicon::Exp[0])
    draw_text(wid_b, y, wid-x-2, line_height, "#{@actor.exp}/#{s2}",2)
  end
  #--------------------------------------------------------------------------
  # Draw Icon (w/Hue)
  #--------------------------------------------------------------------------
  def draw_de_icon(icon_index, x, y, hue = 0, enabled = true)
    bitmap = Cache.icon("IconSet",hue)
    rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
  end
end
#==============================================================================
class Deki_Help < Window_Base
#==============================================================================
  #--------------------------------------------------------------------------
  # Object Initialization
  #--------------------------------------------------------------------------
  def initialize(line_number = 2)
    super(0, 0, Graphics.width/4*3, fitting_height(line_number))
    @item = nil
  end
  #--------------------------------------------------------------------------
  # Set Text
  #--------------------------------------------------------------------------
  def set_text(text)
    if text != @text
      @text = text
      refresh
    end
  end
  #--------------------------------------------------------------------------
  # Clear
  #--------------------------------------------------------------------------
  def clear
    set_text("")
  end
  #--------------------------------------------------------------------------
  # Set Item  , item : Skills and items etc.
  #--------------------------------------------------------------------------
  def set_item(item)
    return if @item == item
    @item = item
    refresh
    set_text(item ? item.description : "")
  end
  #--------------------------------------------------------------------------
  # Refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    draw_text_ex(4, 0, @text)
  end
  #--------------------------------------------------------------------------
  # Reset Font Settings
  #--------------------------------------------------------------------------
  def reset_font_settings
    change_color(normal_color)
    self.contents.font.name = General::Fonts
    self.contents.font.size = General::Font_Size
    self.contents.font.bold = General::Font_Bold
  end
end
#===============================================================================
class Window_StatusDekita < Window_Selectable
#===============================================================================
  #-----------------------------------------------------------------------------
  # Initialization
  #-----------------------------------------------------------------------------
  def initialize(actor, y)
    super(0, y, Graphics.width, 104)
    @actor = actor
    refresh
  end
  #-----------------------------------------------------------------------------
  # Line Height
  #-----------------------------------------------------------------------------
  def line_height
    return 22
  end
  #-----------------------------------------------------------------------------
  # Window Padding
  #-----------------------------------------------------------------------------
  def standard_padding
    return 8
  end
  #-----------------------------------------------------------------------------
  # Set Actor
  #-----------------------------------------------------------------------------
  def actor=(actor)
    return unless @actor != actor
    @actor = actor
    refresh
  end
  #-----------------------------------------------------------------------------
  # Do Refresh
  #-----------------------------------------------------------------------------
  def refresh
    contents.clear
    return unless @actor
    if !General::Fonts.include?(self.contents.font.name)
      self.contents.font.name = General::Fonts
    end
    if self.contents.font.size != General::Font_Size
      self.contents.font.size = General::Font_Size
    end
    if self.contents.font.bold != General::Font_Bold
      self.contents.font.bold = General::Font_Bold
    end
    draw_actor_face(@actor,0,-2,enabled = true)    
    draw_names
    draw_infonshit
  end
  #-----------------------------------------------------------------------------
  # Draw Info And Shit
  #-----------------------------------------------------------------------------
  def draw_infonshit
    x = 104
    y = line_height
    w = self.width/2 - (standard_padding*2)
    draw_info_box(x,y * 1,w-100)
    draw_de_hp(x,y*1,w+6)
    draw_info_box(x,y * 2,w-100)
    draw_de_mp(x,y*2,w+6)
    draw_info_box(x,y * 3,w-100)
    draw_de_tp(x,y*3,w+6)
  end
  #-----------------------------------------------------------------------------
  # Draw Names ( and Lv )
  #-----------------------------------------------------------------------------
  def draw_names
    x = self.width/2-(standard_padding)+4
    y = line_height
    nx = self.width/2 - (standard_padding*2)
    # // Name
    draw_info_box(104,0,nx-100)
    draw_text(108, 0, nx, line_height, Vocanicon::Name[0])
    draw_text(108, 0, nx-108, line_height, @actor.name.to_s, 2)
    # // NickName
    draw_info_box(x,0,nx/2-2)
    draw_text(x+4, 0, nx/2-2, line_height, Vocanicon::Nick[0])
    draw_text(x, 0, nx/2-6, line_height, @actor.nickname.to_s, 2)
    # // Class
    draw_info_box(x,y*1,nx/2-2)
    draw_text(x+4, y*1, nx/2-2, line_height, Vocanicon::Clas[0])
    draw_text(x, y*1, nx/2-6, line_height, @actor.class.name,2)
    # // Status(s)
    draw_info_box(x+(nx/2),0,nx/2+4)
    draw_text(x+(nx/2), 0, nx/2-4, line_height, Vocanicon::Stts[0],1)
    draw_info_box(x+(nx/2),y*1,nx/2+4)
    draw_actor_icons(@actor, x+(nx/2), line_height * 1 - 2,nx/2)
    # // Level
    lw = nx/3-2
    draw_info_box(x,y*2,nx/3-2)
    draw_text(x+4, y*2, nx/3-2, line_height, Vocanicon::Level[0])
    draw_text(x  , y*2, nx/3-6, line_height, "#{@actor.level}",2)
    # // SPDS Stats
    draw_info_box(x+(nx/3),y*2,nx/3)
    if $D13x[:ISPDS]
      draw_text(x+(nx/3)+2, y*2, nx/3, line_height, SPDS::DP_Vocab[0])
      draw_text(x+(nx/3), y*2, nx/3-4, line_height, "#{@actor.points}", 2)
    end
    # // SUG Stats
    draw_info_box(x+(nx/3*2)+2,y*2,nx/3+6)
    if $D13x[:SUG]
      draw_text(x+(nx/3*2)+6, y*2, nx/3, line_height, Skill_Upgrade::SP_Vocab[2])
      draw_text(x+(nx/3*2), y*2, nx/3, line_height, "#{@actor.skill_points.to_i}", 2)
    end
    # // Exp
    draw_info_box(x,y*3,nx+4)
    draw_de_xp(x, y * 3)
  end
  #-----------------------------------------------------------------------------
  # Draw Info Box
  #-----------------------------------------------------------------------------
  def draw_info_box(x,y,w)
    contents.fill_rect(x,y+1,w,line_height-2,Color.new(0,0,0,64))
  end
  #-----------------------------------------------------------------------------
  # Draw Exp (w/gauge)
  #-----------------------------------------------------------------------------
  def draw_de_xp(x, y, gauge = true)
    s1 = @actor.exp # current_level_exp
    s2 = @actor.next_level_exp
    s1_g = @actor.exp - @actor.current_level_exp
    s2_g = @actor.next_level_exp - @actor.current_level_exp
    wid = self.width/2 - (standard_padding*2)
    wid_b = self.width/2 - (standard_padding)
    rate = (s1_g).to_f / (s2_g)
    color1 = General::Exp_Color[0]
    color2 = General::Exp_Color[1]
    draw_deki_gauge(x, y, wid+4, 2, rate, color1, color2) if gauge
    draw_text(x+4, y, wid, line_height, Vocanicon::Exp[0])
    draw_text(x, y, wid, line_height, "#{s1}/#{s2}",2)
  end
end
#===============================================================================
class Dekita_Core_Status < Window_Selectable
#===============================================================================
  attr_reader :page
  #-----------------------------------------------------------------------------
  # Initialization
  #-----------------------------------------------------------------------------
  def initialize(x,y,w,h,actor=nil,page=nil)
    super(x,y,w,h)
    @just_startingg = true
    @actor = actor
    @page  = page
    refresh
  end
  #-----------------------------------------------------------------------------
  # Set Actor
  #-----------------------------------------------------------------------------
  def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
  end
  #-----------------------------------------------------------------------------
  # Set Page
  #-----------------------------------------------------------------------------
  def page=(page)
    return if @page == page
    @page = page
    sound = General::Page_Turn_Noise
    Audio.se_play(sound[0], sound[1], eval(sound[2])) if !@just_startingg
    @just_startingg = false if @just_startingg
    refresh
  end
  #-----------------------------------------------------------------------------
  # Refresh
  #-----------------------------------------------------------------------------
  def refresh
    contents.clear
    freshen
    draw_status_inf if @page
  end
  #-----------------------------------------------------------------------------
  # Refresh Fonts
  #-----------------------------------------------------------------------------
  def freshen
    if !General::Fonts.include?(self.contents.font.name)
      self.contents.font.name = General::Fonts
    end
    if self.contents.font.size != General::Font_Size
      self.contents.font.size = General::Font_Size
    end
    if self.contents.font.bold != General::Font_Bold
      self.contents.font.bold = General::Font_Bold
    end
  end
  #-----------------------------------------------------------------------------
  # Define wid
  #-----------------------------------------------------------------------------
  def wid
    self.width-(standard_padding*2)
  end
  #-----------------------------------------------------------------------------
  # Enable ALL Icons (make opacity = 255)
  #-----------------------------------------------------------------------------
  def all_icons_enable?
    return true
  end
  #-----------------------------------------------------------------------------
  # Get Setup Info
  #-----------------------------------------------------------------------------
  def setup_info
    return []
  end
  #-----------------------------------------------------------------------------
  # Draw Status Page Info
  #-----------------------------------------------------------------------------
  def draw_status_inf
    x = 0 ; y = 0
    data = setup_info
    for i in data
      case i[0]
#     [:header, "TEXT", Text_Color, icon_id, icon_hue, alignment],
      when :header    then y = draw_header(x,y,i[1],i[2],i[3],i[4],i[5])
      when :param     then y = draw_parameters(x,y,i[1])
      when :x_param   then y = draw_xparameters(x,y,i[1])
      when :s_param   then y = draw_sparameters(x,y,i[1])
      when :atk_ele   then y = draw_atk_eles(x,y,i[1])
      when :def_ele   then y = draw_def_eles(x,y,i[1])
      when :atk_lev   then y = draw_atk_level(x,y)
      when :def_lev   then y = draw_def_level(x,y)
      when :tp_info   then y = draw_tp_info(x,y)
      when :spds_stat then y = draw_spds_info(x,y,i[1])
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Draw Stat Icons
  #-----------------------------------------------------------------------------
  def draw_stat_icons(icon, x, y, hue, enabled = true)
    return x+4 unless icon != 0
    draw_de_icon(icon, x, y, hue, enabled)
    return x += 26
  end
  #-----------------------------------------------------------------------------
  # Draw Box
  #-----------------------------------------------------------------------------
  def draw_box(x, y)
    contents.fill_rect(x,y+1,wid,line_height-2,General::Box_Color)
  end
  #-----------------------------------------------------------------------------
  # Draw Box
  #-----------------------------------------------------------------------------
  def draw_box_ww(x, y, w)
    contents.fill_rect(x,y+1,w,line_height-2,General::Box_Color)
  end
  #-----------------------------------------------------------------------------
  # Draw Header
  #-----------------------------------------------------------------------------
  def draw_header(x,y,text,col,icon,hue,align)
    draw_box(x, y)
    x = draw_stat_icons(icon, x, y, hue, all_icons_enable?)
    change_color(col)
    draw_text(x, y, wid, line_height, text.to_s, align)
    return y += line_height
  end
  #-----------------------------------------------------------------------------
  # Draw Data
  #-----------------------------------------------------------------------------
  def draw_data(x,y,text,colo,icon,ihue,valu,alig)
    draw_box(x, y)
    x = draw_stat_icons(icon, x, y, ihue, all_icons_enable?)
  #  change_color(colo) if colo != nil
    draw_text(x, y, wid, line_height, text)
    change_color(Text_Color::White)
    draw_text(x, y, wid-34, line_height, valu, alig)
    return y += line_height
  end
  #-----------------------------------------------------------------------------
  # Draw Parameters
  #-----------------------------------------------------------------------------
  def draw_parameters(x,y,i)
    data = Vocanicon.param(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%s", @actor.param(i))
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw x Parameters
  #-----------------------------------------------------------------------------
  def draw_xparameters(x,y,i)
    data = Vocanicon.xparam(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%1.2f%%",@actor.xparam(i)*100)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw sParameters
  #-----------------------------------------------------------------------------
  def draw_sparameters(x,y,i)
    data = Vocanicon.sparam(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%1.2f%%",@actor.sparam(i)*100)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Attack Elements
  #-----------------------------------------------------------------------------
  def draw_atk_eles(x,y,i)
    return y unless $D13x[:Elems_Control]
    data = Vocanicon.atk_element(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%1.2f%%",@actor.atk_element_rate(i)*100)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Defence Elements
  #-----------------------------------------------------------------------------
  def draw_def_eles(x,y,i)
    return y unless $D13x[:Elems_Control]
    data = Vocanicon.def_element(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%1.2f%%",@actor.element_rate(i)*100)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Attack Level
  #-----------------------------------------------------------------------------
  def draw_atk_level(x,y)
    return y unless $D13x[:Atk_Def_Lvs]
    data = Vocanicon::Atk_Level
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%s",@actor.atl.to_i)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Defence Level
  #-----------------------------------------------------------------------------
  def draw_def_level(x,y)
    return y unless $D13x[:Atk_Def_Lvs]
    data = Vocanicon::Def_Level
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%s",@actor.dfl.to_i)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw TP Info
  #-----------------------------------------------------------------------------
  def draw_tp_info(x,y)
    return y unless $D13x[:TP_Control]
    data = Vocanicon::TP
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%s",@actor.maximum_tp.to_i)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw TP Info
  #-----------------------------------------------------------------------------
  def draw_spds_info(x,y,i)
    return y unless $D13x[:ISPDS]
    data = Vocanicon.spds_stat(@actor,i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    valu = sprintf("%s",@actor.spds_stats(i).to_i)
    y = draw_data(x,y,text,colo,icon,ihue,valu,2)
    return y
  end
end
#===============================================================================
class Dekita_Core_Status_Changes < Dekita_Core_Status
#===============================================================================
  #-----------------------------------------------------------------------------
  # Initialization
  #-----------------------------------------------------------------------------
  def initialize(x,y,w,h,actor=nil,page=nil)
    super(x,y,w,h,actor,page)
    @temp_actor = Marshal.load(Marshal.dump(@actor))
    @dis_window = nil
    refresh
  end
  #-----------------------------------------------------------------------------
  # Set Actor
  #-----------------------------------------------------------------------------
  def actor=(actor)
    return if @actor == actor
    @actor      = actor
    @temp_actor = Marshal.load(Marshal.dump(@actor))
    refresh
  end
  #-----------------------------------------------------------------------------
  # Set Dis Window
  #-----------------------------------------------------------------------------
  def dis_window=(window)
    return if @dis_window == window
    @dis_window            = window
    refresh
  end
  #-----------------------------------------------------------------------------
  # Get No Stats
  #-----------------------------------------------------------------------------
  def show_no_stats
    return unless @dis_window
    @temp_actor = Marshal.load(Marshal.dump(@actor))
    refresh
  end
  #-----------------------------------------------------------------------------
  # Draw Data
  #-----------------------------------------------------------------------------
  def draw_data(x,y,text,colo,icon,ihue,valu,alig)
    draw_box(x, y)
    change_color(Text_Color::White)
    draw_text(x, y, wid, line_height, valu, alig)
    return y += line_height
  end
  #-----------------------------------------------------------------------------
  # Draw Parameters
  #-----------------------------------------------------------------------------
  def draw_parameters(x,y,i)
    data = Vocanicon.param(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = @temp_actor.param(i) - @actor.param(i)
    valu = General::No_Change_Vocab
    valu = sprintf("%s", stat)  if stat < 0
    valu = sprintf("+%s", stat) if stat > 0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw x Parameters
  #-----------------------------------------------------------------------------
  def draw_xparameters(x,y,i)
    data = Vocanicon.xparam(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.xparam(i)-@actor.xparam(i))*100
    valu = General::No_Change_Vocab
    valu = sprintf("%1.2f%%", stat)  if stat < 0.0
    valu = sprintf("+%1.2f%%", stat) if stat > 0.0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw sParameters
  #-----------------------------------------------------------------------------
  def draw_sparameters(x,y,i)
    data = Vocanicon.sparam(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.sparam(i)-@actor.sparam(i))*100
    valu = General::No_Change_Vocab
    valu = sprintf("%1.2f%%", stat)  if stat < 0.0
    valu = sprintf("+%1.2f%%", stat) if stat > 0.0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Attack Elements
  #-----------------------------------------------------------------------------
  def draw_atk_eles(x,y,i)
    return y unless $D13x[:Elems_Control]
    data = Vocanicon.atk_element(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.atk_element_rate(i)-@actor.atk_element_rate(i))*100
    valu = General::No_Change_Vocab
    valu = sprintf("%1.2f%%", stat)  if stat < 0.0
    valu = sprintf("+%1.2f%%", stat) if stat > 0.0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Defence Elements
  #-----------------------------------------------------------------------------
  def draw_def_eles(x,y,i)
    return y unless $D13x[:Elems_Control]
    data = Vocanicon.def_element(i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.element_rate(i)-@actor.element_rate(i))*100
    valu = General::No_Change_Vocab
    valu = sprintf("%1.2f%%", stat)  if stat < 0.0
    valu = sprintf("+%1.2f%%", stat) if stat > 0.0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Attack Level
  #-----------------------------------------------------------------------------
  def draw_atk_level(x,y)
    return y unless $D13x[:Atk_Def_Lvs]
    data = Vocanicon::Atk_Level
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.atl-@actor.atl).to_i
    valu = General::No_Change_Vocab
    valu = sprintf("%s", stat)  if stat < 0
    valu = sprintf("+%s", stat) if stat > 0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw Defence Level
  #-----------------------------------------------------------------------------
  def draw_def_level(x,y)
    return y unless $D13x[:Atk_Def_Lvs]
    data = Vocanicon::Def_Level
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.dfl-@actor.dfl).to_i
    valu = General::No_Change_Vocab
    valu = sprintf("%s", stat)  if stat < 0
    valu = sprintf("+%s", stat) if stat > 0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw TP Info
  #-----------------------------------------------------------------------------
  def draw_tp_info(x,y)
    return y unless $D13x[:TP_Control]
    data = Vocanicon::TP
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.maximum_tp-@actor.maximum_tp).to_i
    valu = General::No_Change_Vocab
    valu = sprintf("%s", stat)  if stat < 0
    valu = sprintf("+%s", stat) if stat > 0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
  #-----------------------------------------------------------------------------
  # Draw TP Info
  #-----------------------------------------------------------------------------
  def draw_spds_info(x,y,i)
    return y unless $D13x[:ISPDS]
    data = Vocanicon.spds_stat(@actor,i)
    text = data[0]
    colo = data[1]
    icon = data[2]
    ihue = data[3]
    stat = (@temp_actor.spds_stats(i)-@actor.spds_stats(i)).to_i
    valu = General::No_Change_Vocab
    valu = sprintf("%s", stat)  if stat < 0
    valu = sprintf("+%s", stat) if stat > 0
    y = draw_data(x,y,text,colo,icon,ihue,valu,1)
    return y
  end
end
#===============================================================================
class Scene_Map < Scene_Base
#===============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  attr_reader :spriteset
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  alias :postrns_dekita_core :post_transfer
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def post_transfer
    @spriteset.update_viewport_sizes
    postrns_dekita_core
  end
end
#===============================================================================
class Scene_Battle < Scene_Base
#===============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  attr_reader :spriteset
end
#==============================================================================#
#                      http://dekitarpg.wordpress.com/                         #
#==============================================================================#
end # if true # << Make true to use this script, false to disable.