if true # << Make true to use this script, false to disable.
#===============================================================================
#
# ☆ $D13x - Insane Stat Point Distribution System
# -- Author   : Dekita
# -- Version  : 1.5
# -- Level    : Hard / Insane
# -- Requires : $D13x Core v2.0+
#             : You, To Read ALL Instructions CAREFULLY !!
# -- Engine   : RPG Maker VX Ace.
#
#===============================================================================
# ☆ Import
#-------------------------------------------------------------------------------
$D13x={}if$D13x==nil
$D13x[:ISPDS] = true
#===============================================================================
# ☆ Updates
#-------------------------------------------------------------------------------
# D /M /Y
# 29/o3/2o14 - Use R/L Shift to change pages,
# 17/o3/2o14 - HUGE Efficiency Update,
#            - Added Text Color for parent stat names,
# 21/o2/2o14 - Bugfixx, (Max TP mods bug),
# 18/06/2o13 - Bugfixx, (Enemy HP/MP Increase)
# 31/o5/2o13 - Added More Help Info For Script Calls,
#            - Added .reset_some_points(STAT_ID, VALUE) Script Call,
# 29/o5/2o13 - Finished Script, (v1.0)
#            - Slight Reposition of HP/MP/TP/EXP Gauges,
#            - Added Menu Customisation,
# 28/o5/2o13 - Bugfix, (Changing Class Not Re-Calculating Stat Values)
#            - Compatibility, (WindowSkins && Scene BGs)
#            - Added IBox Window,
# 22/o5/2o13 - Added Max Limit For Each Stat,
#            - Improved Windows Display,
#            - Compatibility, (TP Control)
# 21/o5/2o13 - Finished Advanced Features,
#            - Compatibility, (Atk/Def Lv)
# 19/o5/2o13 - Beta Phase Begin, (v0.9)
#            - Finished Script Base,
# 1o/o4/2o13 - Started,
#
#===============================================================================
# ☆ Instructions !!
#-------------------------------------------------------------------------------
# Place Below >>
# " ▼ Materials "
# " $D13x Statistic Control "
# " $D13x Elements Control "
# " $D13x Max TP Control "
# " $D13x Atk | Def Lvls "
# Place Above >>
# " ▼ Main "
# " $D13x Equipment Sets "
# " $D13x Learn Skill Reqs "
# " $D13x Equip Reqs "
#
# Placing these script in this order will prevent bugs / faults / FPS drop.
#
# This script will NOT work without at least 1 of the following scripts...
# $D13x - Statistic Control v1.5+ - Enables Param/s-Param/x-Param's Distribution
# $D13x - Elements  Control v1.0+ - Enables Atk/Def Elements Distribution
# $D13x - Max TP Control    v1.0+ - Enables Max TP Distribution.
# $D13x - Atk | Def Levels  v1.0+ - Enables Atk/Def Level Distribution
# You can use all of the above scripts in conjunction with each other
#
# Please Note : This list could be updated at any time !!
#
#===============================================================================
# ☆ Introduction
#-------------------------------------------------------------------------------
# I have a dream...
# I dream of a game where my characters growth is in my control...
# A game where my choices mean everything...
# Where a slight mistake can mean the end of all life...
# I dream of a game that i can design my own character, while playing...
# A game that i can customize my character to suit my playing style...
# That not only allows creativity, but rewards it...
# I dream...
# Of a game...
# Made by this script...
#
# This script allows the creation of MULTIPLE HIGHLY UNIQUE && DYNAMIC
# Stat Distribution Systems...
# It not only provides you with new "parent" stats, that control ANY other
# statistics, it actually allows you to then distribute them !!
#
# EASILY set up a basic distribution system.
# ELEMENT DISTRIBUTION SYSTEM ? Look No Further !!
# Distribute Maximum TP with ease..
# Set up your very own unique distribution system with no scripting knowledge !!
# ( Requires ability to read instructions )
#
#===============================================================================
# ☆ Features
#-------------------------------------------------------------------------------
# - UNLIMITED New Parent Stats that give you control over ALL other stats.
# - Multiple ways to modify ALL of your newly created stats.
# - Use your new stats in SKILL FORMULA's and CONDITIONAL BRANCHES.
# - HIGHLY Informative Distribution Screen (Fully Customisable).
# - Multiple Growth Set-ups (each actor can grow differently).
#   ^- Each Growth Set-up can have a completetly unique setup
#      Than an other, things like name, cost, stat changes...
# - Highly Complex && Unique Stat Handling System (FULLY LAG FREE)
# - Easily Distribute All Statistics (listed below)
#   ^- Params             << Requires $D13x Statistic Control.
#   ^- x-Params           << Requires $D13x Statistic Control.
#   ^- s-Params           << Requires $D13x Statistic Control.
#   ^- Attack Elements    << Requires $D13x Elements  Control.
#   ^- Defence Elements   << Requires $D13x Elements  Control.
#   ^- Atk | Def Levels   << Requires $D13x Atk | Def Level.
#   ^- Max TP Limit       << Requires $D13x Max TP  Control.
# - Spend DP (distribution points), Gold and even Exp to gain stats.
# - A Smile On Your Face ( Money Back Guarantee !! )
#
# And If That Was'nt Enough...
# you can pair this script with multiple scripts from the $D13x Engine...
#
# - Skill Levels
#   ^- Give a parent stat to a skill and the value will increase
#      using the skill levels DMG Multi.
#
# - Dev Stat Lv Up Distribution
#   ^- ability to distribute your new parent stats via level up
#      (could be used for actors who cannot access distribution screen)
#
# - Equipment Sets
#   ^- Control new parent stats as a set bonus for an equipment set.
#
# - Learn Skill Requirements
#   ^- Use new parent stats as skill learning requirements.
#
# - Equipment Requirements
#   ^- Use new parent stats as requirements for equipping equipment.
#
# NOTE:
# If using Exp to increase statistics, you are only able to use the actors
# "spare exp", spare exp is the exp you have gained above the required
# exp for your current level, but is still below the required exp for next level.
# This means that your actor cannot decrease their level distributing stats.
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
# contact me at http://dekitarpg.wordpress.com/
#
#===============================================================================
# ☆ Script Calls
#-------------------------------------------------------------------------------
# $game_actors[ACTOR_ID].add_spds_stats(STAT_ID, VALUE)
# $game_actors[ACTOR_ID].sub_spds_stats(STAT_ID, VALUE)
# $game_actors[ACTOR_ID].div_spds_stats(STAT_ID, VALUE)
# $game_actors[ACTOR_ID].mul_spds_stats(STAT_ID, VALUE)
# $game_actors[ACTOR_ID].mod_spds_stats(STAT_ID, VALUE)
# ^- Script calls to change parent stat values
#
# There is also a third arguement for all the above script calls,
# it is a boolean arguement to determine if the player should be refreshed.
# eg.. $game_actors[1].add_spds_stats(0, 5, false)
# this is very helpfull for maintaining FPS when adding LOTS of stats..
# The default to this arguemet is true.
# If you don't understand what this mean, just disregard this information :)
#
#-------------------------------------------------------------------------------
# $game_actors[ACTOR_ID].parent_stat(STAT_ID)
# ^- Script call to check the value of a parent stat.
#
#-------------------------------------------------------------------------------
# $game_actors[ACTOR_ID].get_total_spds_stats
# ^- Script call to check the total value of all parent stats.
#
#-------------------------------------------------------------------------------
#
# $game_actors[ACTOR_ID].reduce_points(VALUE)
# ^- Script calls to change available distribution points
#
#-------------------------------------------------------------------------------
# $game_actors[ACTOR_ID].points
# ^- Script call to check the value of available distribution points.
#
#-------------------------------------------------------------------------------
# $game_actors[ACTOR_ID].reset_all_points(false)
# $game_actors[ACTOR_ID].reset_all_points(true)
# $game_actors[ACTOR_ID].reset_all_points
# ^- Script calls to reset all used distribution points,
#    if arguement is false points will not be returned.
#    if true then all spent points will be returned.
#    Default arguement is true.
# NOTE: Does Not Support Gold && Exp Cost Formulas.
#
#-------------------------------------------------------------------------------
# $game_actors[ACTOR_ID].reset_some_points(STAT_ID, VALUE)
# ^- Same as above but only reduces points from STAT_ID by VALUE and then
#    returns the spent points.
# NOTE: Does Not Support Gold && Exp Cost Formulas.
#
#-------------------------------------------------------------------------------
# $game_actors[ACTOR_ID].change_spds_set_id_to(STAT_SET_ID)
# ^- Script call to change Distribution Set ID
#
#-------------------------------------------------------------------------------
# ACTOR_ID = The database id for the actor
# STAT_ID  = The id of the parent stat you wish to increase
# VALUE    = The value to change this stat
# STAT_SET_ID  = The id of the distribution stat set to change to.
#
#===============================================================================
# ☆ Notetags ( default )
#-------------------------------------------------------------------------------
# <SPDS: X>
# Replace X with the SPDS::Stat_Set id for that actor / class / enemy
#
#-------------------------------------------------------------------------------
# <DPts: X>
# Replace X with the value for an actors initial available distribution points.
# Alternativley, give this notetag to enemies and X distribution points
# will be evenly devided between each alive battle member :)
#
#-------------------------------------------------------------------------------
# <no spds>
# Give this notetag to actors who should not be taken to distribution screen
# on level up.. eg, actor's that the player has no control over...
# Temporary party members and the like..
#
#-------------------------------------------------------------------------------
# <spds stat: STAT_ID, VALUE>
# Use this notetag to increase parent stats.
# give to actors, classes, enemies, equipment, skills, states...
# STAT_ID  = The id of the parent stat you wish to increase
# VALUE    = The value to change this stat
#
#-------------------------------------------------------------------------------
# <all spds stat: VALUE>
# Use this notetag to increase ALL parent stats by VALUE.
# give to actors, classes, enemies, equipment, skills, states...
#
#-------------------------------------------------------------------------------
# <spds stat limit: STAT_ID, VALUE>
# give to actors, classes, enemies, equipment, skills, states...
# STAT_ID  = The id of the parent stat whose max value you wish to increase
# VALUE    = The value to change the maximum value this stat can reach
#
#===============================================================================
# ☆ VERY Helpfull Info
#-------------------------------------------------------------------------------
# Q - What is the basis for a distribution system ?
# A - The ability to add / remove statistics.
# Although when you increase a stat, lets say Vitality (for example)
# it may "increase" hp (along with other stats) but it DOES NOT actually
# increase the HP parameter...
# You may be thinking "Of course it does !!".
# And you would be right... In most cases...
# This script IS NOT most cases...
# Instead of adding a PERMANENT stat, like most distribution systems,
# this script instead adds 1 to a counter, ie a parent stat.
# It then calculates how much each stat (params ect..) should increase
# for each counter.
# eg. if the counter (parent stat) was 5 and that parent
# stat is set to increase hp by 10, the actor would get 50 (10 * 5)
# TEMPORARILTY added to the stat.
# This calculation gets done so frequently it has no effect on miscalulations.
#
# This method also provides MANY benefits compared to "Less Qualified"
# Distribution systems...
#
# By Calculating stats this way it allows for more dynamic distribution.
# For Example...
# Actor 1 has 50 vit (parent stat 0)
# Actor 1 is Class 1
# Class 1 Has 1 base MHP
# Class 1 Has Stat_Set id 0
# Stat_Set id 0's vit modifies MHP by 10
# Actor 1's MHP Becomes 501 (1 + (50 * 10))
# Actor 1 Changes to Class 2
# Class 2 Has 1 base MHP
# Class 2 Has SPDS::Stat_Set id 1
# Stat_Set id 1's vit modifies MHP by 5
# Actor 1's MHP Becomes 251 (1 + (50 * 5))
#
# Another Advantage is that if you give equips/skills/states
# parent stats, their stats will change accordingly based against
# the actor/enemies' parent stat values, this of course means that...
# if Actor 1 & 2 both have THE SAME equip but DIFFERENT Stat_Set's
# Then the equip item will recognize that and only modify the params
# based on the actors Stat_Set.
#
#===============================================================================
# ☆ Statistic Help
#-------------------------------------------------------------------------------
# PARAMS :   # XPARAMS :  # SPARAMS :  #
# stat = id  # stat = id  # stat = id  #
# mhp  = 0   #  hit = 0   #  tgr = 0   #
# mmp  = 1   #  eva = 1   #  grd = 1   #
# atk  = 2   #  cri = 2   #  rec = 2   #
# def  = 3   #  cev = 3   #  pha = 3   #
# mat  = 4   #  mev = 4   #  mcr = 4   #
# mdf  = 5   #  mrf = 5   #  tcr = 5   #
# agi  = 6   #  cnt = 6   #  pdr = 6   #
# luk  = 7   #  hrg = 7   #  mdr = 7   #
#            #  mrg = 8   #  fdr = 8   #
#            #  trg = 9   #  exr = 9   #
#-------------------------------------------------------------------------------
# Remember :
# All Params work with integer values, eg. 1, 5, 123, 653, 198123
# Atk | Def Levels && Max TP also work with integer values.
# All x/s-Params work with float values, eg. 1.0, 0.5, 0.1, 0.05, 0.01
# 1.0 = 100%, 0.01 = 1%,
# Atk | Def Elements also work using percentage values (floats).
#
#===============================================================================
module SPDS
#===============================================================================
Stat_Set={} # << Keep  
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ General Settings
  #-----------------------------------------------------------------------------
  # Format = [:cmnd , 'Name'],
 # Main_Commands =[
  #  [:spend, 'Distribute'],
  #  [:exit,  'Leave'],
  #]
  #-----------------------------------------------------------------------------
  # Max Amount Of Parent Stats Allowed,
  # Parent Stat id begin at 0, if the max was 4 their id's would be
  # 0, 1, 2 & 3   <<   always remember this.
  # If you try to access a parent stat that is higher than the max stat
  # you will get error messages !
  Max_Parent_Stats = 5
  #-----------------------------------------------------------------------------
  # Number of visible distribution commands shown in distribution selection
  # window.
  Visible_Distribution_Commands = 4
  #-----------------------------------------------------------------------------
  # Finish Command Vocab, Format = ["Command Name", "Help Text"]
  Finish_Data = ['Finish', "Return To Command Window."]
  #-----------------------------------------------------------------------------
  # Allow Finish Command To Be Visible ? (distribution command window)
  Allow_Finish = true
  #-----------------------------------------------------------------------------
  # Vocab Used For Changes Header.
  Changes_Vocab = "Changes:"
  #-----------------------------------------------------------------------------
  # Vocab Used When No Future Change Will Happen (shown in Changes Window)
  No_Change_Vocab = "-"
  #-----------------------------------------------------------------------------
  # Distribution Points Vocab
  DP_Vocab   = ["DP: ", "Distribution Points"]
  #-----------------------------------------------------------------------------
  # Max Distribution Points
  Max_Points = 999
  #-----------------------------------------------------------------------------
  # Vocab for when distribution points are gained from an enemy.
  # NOTE: points gained will be divided between ALIVE BATTLE MEMBERS !!
  Gain_Pts_Vocab = "%s Has Gained %s %s."
  #-----------------------------------------------------------------------------
  # Here is where you change the menu settings for the distribution scene,
  # the format = [Visible?, "VOCAB", Switch]
  # make visible true to add a new distribute command to the main menu,
  # change the vocab to suit your needs.
  # Switch is the id of the switch to disable/enable the menu command
  # leave 0 to always enable command.
  Menu_Info = [false, "Distribute", 0]
  #-----------------------------------------------------------------------------
  # Show distribution screen automatically when actor levels ?
  Show_Screen = false
 
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ Page Settings
  #-----------------------------------------------------------------------------
  # This is where you adjust what information is shown on each page
  # the options are :
  #  [:header, "FOR DISPLAYING TEXT LIKE THIS" , icon, hue, alignment],
  #  [:spds_stat,  stat id],
  #  [:param,     param_id],
  #  [:x_param,  xparam_id],
  #  [:s_param,  sparam_id],
  #  [:atk_ele, element_id],
  #  [:def_ele, element_id],
  #  [:atk_lev],
  #  [:def_lev],
  #  [:tp_info],
  # NOTE :
  # If icon is 0 the text will be positioned where the icon would have been.
  # Use Left + Right to switch pages
  #-----------------------------------------------------------------------------
  # Values have same coloring as main text ?
  Values_Colored = true
  #-----------------------------------------------------------------------------
  # Show Icons ?
  Use_Icons = true
  #-----------------------------------------------------------------------------
  # Page Turn Audio Settings , Format = ["Sound\\File\\Name", Volume, Pitch]
  Page_Turn_Noise = ["Audio\\SE\\Book1", 80, "80+rand(50)"]
  #-----------------------------------------------------------------------------
  # Begin Info Hash. See Above for Detailed Instructions..
  Info={
  :page_1=>[
#    [:header, "Parameter Info :", Text_Color::White,0,0,1],
    [:param,   0, Text_Color::White, 10, 200],
    [:param,   1, Text_Color::White, 10,   0],
    [:tp_info, 7, Text_Color::White, 10,   0],
    [:param,   2],
    [:param,   3],
    [:param,   4],
    [:param,   5],
    [:param,   6],
    [:param,   7],
   ],
  :page_2=>[
    [:atk_lev],
    [:def_lev],
    [:param, 2],
    [:param, 3],
    [:s_param, 6],
    [:param, 4],
    [:param, 5],
    [:s_param, 7],
    [:s_param, 1],
  ],
  :page_3=>[
    [:x_param, 0],
    [:x_param, 2],
    [:x_param, 1],
    [:x_param, 3],
    [:x_param, 4],
    [:x_param, 5],
    [:x_param, 6],
    [:s_param, 2],
    [:s_param, 3],
  ],
  :page_4=>[
    [:atk_ele, 1],
    [:atk_ele, 3],
    [:atk_ele, 4],
    [:atk_ele, 5],
    [:atk_ele, 6],
    [:atk_ele, 7],
    [:atk_ele, 8],
    [:atk_ele, 9],
    [:atk_ele, 10],
  ],
  :page_5=>[
    [:def_ele, 1],
    [:def_ele, 3],
    [:def_ele, 4],
    [:def_ele, 5],
    [:def_ele, 6],
    [:def_ele, 7],
    [:def_ele, 8],
    [:def_ele, 9],
    [:def_ele, 10],
  ],
  :page_6=>[
    [:header, "Extra Stats", Text_Color::White,0,0,1],
  ],
  } # << End Page's Settings
  #-----------------------------------------------------------------------------
  # Max Pages To Show, Never Have Below 1.
  Max_Pages = 2
 
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ Info-Box Settings
  #-----------------------------------------------------------------------------
  # the info box is a small box located in the bottom left of the distribution
  # screen. It can ony be seen if there are less than 9 visible commands.
  # :info=>[ icon, hue, "Text"  ],
  IBox={
  :pts  => [  363,  90, "DP:"],
  :gold => [  361,   0, "Gold :"],
#  :time => [  29 ,   0, "Time :"],
#  :exp  => [  362, 180, "Spare Exp :"],
  }
  #-----------------------------------------------------------------------------
  # If :time is being shown make this setting = true
  # this will make the time be refreshed each second.
  # By default it is false to reduce system power usage.
  Showing_Time = false
 
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ Distribution Settings Begin
  #-----------------------------------------------------------------------------
  # :pts_on_lv = How many points are gained on level up.
  # :extra_pts = Extra Points Gained.
  # :xtra_p_lv = [Array of levels that :extra_pts are gained on].
  #  STAT ID   = {Hash of information for this stat}.
  #    ^- :name = The name displayed on distribution screen.
  #    ^- :icon = [icon_id, hue, enable]
  #    ^- :help = "Help Window Text Settings"
  #    ^- :cost = [:type, "cost formula"]
  #            ^- [:points, "1"],
  #            ^- [:gold,   "10"],
  #            ^- [:exp,    "(@level * 4) / (parent_stat(0)/100).to_i"],
  #            ^- ### NOTE:   :gold && :exp Costs are in Beta Phase !! ###
  #    ^- :limit= > Max Value This Stat Can Reach (before other modifications).
  #    ^- :mods = [Array of information storing this stats statistic mods]
  #            ^- [:add_param , id, value],
  #            ^- [:sub_param , id, value],
  #            ^- [:div_param , id, value],
  #            ^- [:mul_param , id, value],
  #            ^- [:mod_param , id, value],
  #            ^- [:add_xparam , id, value],
  #            ^- [:sub_xparam , id, value],
  #            ^- [:div_xparam , id, value],
  #            ^- [:mul_xparam , id, value],
  #            ^- [:mod_xparam , id, value],
  #            ^- [:add_sparam , id, value],
  #            ^- [:sub_sparam , id, value],
  #            ^- [:div_sparam , id, value],
  #            ^- [:mul_sparam , id, value],
  #            ^- [:mod_sparam , id, value],
  #            ^- [:add_atk_ele , id, value],
  #            ^- [:sub_atk_ele , id, value],
  #            ^- [:div_atk_ele , id, value],
  #            ^- [:mul_atk_ele , id, value],
  #            ^- [:mod_atk_ele , id, value],
  #            ^- [:add_def_ele , id, value],
  #            ^- [:sub_def_ele , id, value],
  #            ^- [:div_def_ele , id, value],
  #            ^- [:mul_def_ele , id, value],
  #            ^- [:mod_def_ele , id, value],
  #            ^- [:add_atl , value],
  #            ^- [:sub_atl , value],
  #            ^- [:div_atl , value],
  #            ^- [:mul_atl , value],
  #            ^- [:mod_atl , value],
  #            ^- [:add_dfl , value],
  #            ^- [:sub_dfl , value],
  #            ^- [:div_dfl , value],
  #            ^- [:mul_dfl , value],
  #            ^- [:mod_dfl , value],
  #            ^- [:add_mtp , value],
  #            ^- [:sub_mtp , value],
  #            ^- [:div_mtp , value],
  #            ^- [:mul_mtp , value],
  #            ^- [:mod_mtp , value],
  #-----------------------------------------------------------------------------
  # ☆ Distribution Setup 0 Begin
  #-----------------------------------------------------------------------------
  Stat_Set[0]={# << Begin Kobold
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     9.25],
        [:add_param, 3,     7.75],
        [:add_param, 4,     8.25],
        [:add_param, 5,     7.75],
        [:add_param, 6,     10.25],
        [:add_param, 7,     9.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "Corruption score",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[0] Kobold
  
  Stat_Set[99]={# << Begin Slave
  :pts_on_lv => 1,
  :extra_pts => 0,
  :xtra_p_lv => [],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "STR",
    :icon   => [116, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Strength.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     1.8],
        [:add_param, 3,     1.3],
        [:add_param, 4,     0.1],
        [:add_param, 5,     0.8],
        [:add_param, 6,     0.2],
        [:add_param, 7,     0.2],
       ],
  },
  1=>{
    :name   => "END",
    :icon   => [121, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Endurance.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     0.1],
        [:add_param, 3,     1.6],
        [:add_param, 4,     0.2],
        [:add_param, 5,     1.1],
        [:add_param, 6,     1.8],
        [:add_param, 7,     0.2],
       ],
    },
  2=>{
    :name   => "INT",
    :icon   => [371, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Intelligence.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     0.2],
        [:add_param, 3,     0.3],
        [:add_param, 4,     2.3],
        [:add_param, 5,     0.7],
        [:add_param, 6,     0.2],
        [:add_param, 7,     1.3],
       ],
  },
  3=>{
    :name   => "DEX",
    :icon   => [114, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Dexterity.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     0.5],
        [:add_param, 3,     0.8],
        [:add_param, 4,     0.5],
        [:add_param, 5,     0.2],
        [:add_param, 6,     1.8],
        [:add_param, 7,     1.2],
       ],
  },
  }# << End Stat_Set[99] Slave
  
  
  Stat_Set[1]={# << Begin DesertP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.75],
        [:add_param, 3,     7.25],
        [:add_param, 4,     10.25],
        [:add_param, 5,     9.25],
        [:add_param, 6,     9.25],
        [:add_param, 7,     9.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     5],
        [:add_param, 3,     5],
        [:add_param, 4,     5],
        [:add_param, 5,     5],
        [:add_param, 6,     5],
        [:add_param, 7,     5],
       ],
  },
  }# << End Stat_Set[1] DesertP
  
  Stat_Set[3]={# << Begin HumanP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.75],
        [:add_param, 3,     9.75],
        [:add_param, 4,     7.25],
        [:add_param, 5,     9.75],
        [:add_param, 6,     8.25],
        [:add_param, 7,     8.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[3] HumanP
  
  Stat_Set[4]={# << Begin GolemP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     10.25],
        [:add_param, 3,     10.75],
        [:add_param, 4,     8.25],
        [:add_param, 5,     7.25],
        [:add_param, 6,     7.25],
        [:add_param, 7,     7.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[4] GolemP
  
  Stat_Set[5]={# << Begin SlimeP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.25],
        [:add_param, 3,     7.25],
        [:add_param, 4,     9.75],
        [:add_param, 5,     9.25],
        [:add_param, 6,     9.75],
        [:add_param, 7,     9.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[5] SlimeP
  
  Stat_Set[6]={# << Begin SkeletonP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     11.25],
        [:add_param, 3,     7.75],
        [:add_param, 4,     9.75],
        [:add_param, 5,     9.25],
        [:add_param, 6,     8.25],
        [:add_param, 7,     6.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[6] SkeletonP
  
  Stat_Set[7]={# << Begin InsectP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     10.25],
        [:add_param, 3,     8.75],
        [:add_param, 4,     8.25],
        [:add_param, 5,     6.75],
        [:add_param, 6,     9.75],
        [:add_param, 7,     8.25],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[7] InsectP
  
  Stat_Set[8]={# << Begin DPII
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.75],
        [:add_param, 3,     6.75],
        [:add_param, 4,     7.25],
        [:add_param, 5,     7.75],
        [:add_param, 6,     7.75],
        [:add_param, 7,     7.25],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[8] DPII
  
    Stat_Set[9]={# << Begin GhostP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.25],  #45
        [:add_param, 3,     10.25], #75
        [:add_param, 4,     8.75],  #60
        [:add_param, 5,     10.25], #75
        [:add_param, 6,     6.75],  #40
        [:add_param, 7,     7.75],  #50
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[9] GhostP
  
  Stat_Set[10]={# << Begin GoblinP
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     9.25],
        [:add_param, 3,     8.25],
        [:add_param, 4,     7.25],
        [:add_param, 5,     7.25],
        [:add_param, 6,     10.25],
        [:add_param, 7,     10.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[10] GoblinP
  
    Stat_Set[11]={# << Begin Dog Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     9.75],
        [:add_param, 3,     8.75],
        [:add_param, 4,     6.75],
        [:add_param, 5,     8.25],
        [:add_param, 6,     10.75],
        [:add_param, 7,     8.25],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[11] Dog Princess
  
      Stat_Set[12]={# << Begin Dragon Princess I
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     6.5],
        [:add_param, 3,     7],
        [:add_param, 4,     6.5],
        [:add_param, 5,     7],
        [:add_param, 6,     6],
        [:add_param, 7,     5],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[12] Dragon Princess I  
        Stat_Set[15]={# << Begin Dragon Princess 3
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.5],
        [:add_param, 3,     7],
        [:add_param, 4,     6],
        [:add_param, 5,     7],
        [:add_param, 6,     6],
        [:add_param, 7,     5],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[15] Dragon Princess 3  
  Stat_Set[13]={# << Begin Moth Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     8.75],
        [:add_param, 3,     6.75],
        [:add_param, 4,     10.75],
        [:add_param, 5,     8.25],
        [:add_param, 6,     8.75],
        [:add_param, 7,     10.25],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[13] Moth Princess  
  Stat_Set[14]={# << Begin Cat Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     9.25],
        [:add_param, 3,     7.75],
        [:add_param, 4,     9.25],
        [:add_param, 5,     8.25],
        [:add_param, 6,     10.25],
        [:add_param, 7,     7.25],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[14] Cat Princess  
    Stat_Set[16]={# << Begin Mouse Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     8.25],
        [:add_param, 3,     7.75],
        [:add_param, 4,     9.25],
        [:add_param, 5,     8.25],
        [:add_param, 6,     10.25],
        [:add_param, 7,     9.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[16] Mouse Princess  
      Stat_Set[17]={# << Begin Rabbit Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.25],
        [:add_param, 3,     9.25],
        [:add_param, 4,     8.75],
        [:add_param, 5,     9.75],
        [:add_param, 6,     8.75],
        [:add_param, 7,     10.25],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[17] Rabbit Princess    
      Stat_Set[18]={# << Begin Harvest Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     8.25],
        [:add_param, 3,     8.25],
        [:add_param, 4,     7.75],
        [:add_param, 5,     7.75],
        [:add_param, 6,     9.75],
        [:add_param, 7,     9.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[18] Harvest Princess     
      Stat_Set[19]={# << Begin Wyvern Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     11.75],
        [:add_param, 3,     10.75],
        [:add_param, 4,     8.75],
        [:add_param, 5,     9.75],
        [:add_param, 6,     11.75],
        [:add_param, 7,     10.75],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[19] Wyvern Princess   
      Stat_Set[20]={# << Begin Finhead Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     8.75], #60
        [:add_param, 3,     7.75], #50
        [:add_param, 4,     8.75], #60
        [:add_param, 5,     8.25], #55
        [:add_param, 6,     9.75], #75
        [:add_param, 7,     8.75], #60
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[20] Finhead Princess    
      Stat_Set[21]={# << Begin Mermaid Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     12.25], #95
        [:add_param, 3,     11.25], #85
        [:add_param, 4,     8.25],  #55
        [:add_param, 5,     9.75],  #70
        [:add_param, 6,     10.25],  #75
        [:add_param, 7,     6.75],  #40
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[21] Mermaid Princess      
     Stat_Set[22]={# << Begin Bird Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     9.25],  #65
        [:add_param, 3,     7.75],  #50
        [:add_param, 4,     9.25],  #65
        [:add_param, 5,     8.25],  #55
        [:add_param, 6,     10.25], #75
        [:add_param, 7,     7.25],  #45
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[22] Bird Princess    
     Stat_Set[23]={# << Begin Oni Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     11.75], #90
        [:add_param, 3,     11.25], #85
        [:add_param, 4,     7.85],  #45
        [:add_param, 5,     7.75],  #50
        [:add_param, 6,     9.75],  #70
        [:add_param, 7,     8.75],  #60
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[23] Oni Princess     
        Stat_Set[24]={# << Begin Dragon Princess 4
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     6],
        [:add_param, 3,     6.5],
        [:add_param, 4,     6.5],
        [:add_param, 5,     7],
        [:add_param, 6,     7.5],
        [:add_param, 7,     5],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[24] Dragon Princess 4    
        Stat_Set[25]={# << Begin Plant Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7.25], #45
        [:add_param, 3,     9.75], #70
        [:add_param, 4,     9.25], #65
        [:add_param, 5,     9.75], #70
        [:add_param, 6,     7.25], #45
        [:add_param, 7,     9.25], #65
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[25] Plant Princess   
        Stat_Set[26]={# << Begin Shadow Princess
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     6.75], #40
        [:add_param, 3,     7.75], #50
        [:add_param, 4,     11.75], #90
        [:add_param, 5,     11.25], #85
        [:add_param, 6,     8.75], #60
        [:add_param, 7,     7.75], #50
       ],
  },  
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[26] Plant Princess  
        Stat_Set[27]={# << Begin Dragon Princess 5
  :pts_on_lv => 1,
  :extra_pts => 1,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     7],
        [:add_param, 3,     7.5],
        [:add_param, 4,     6.5],
        [:add_param, 5,     6.5],
        [:add_param, 6,     6],
        [:add_param, 7,     5],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[27] Dragon Princess 5   
      Stat_Set[35]={# << Begin Progeny
  :pts_on_lv => 1,
  :extra_pts => 0,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     2.5],
        [:add_param, 3,     2.5],
        [:add_param, 4,     2.5],
        [:add_param, 5,     2.5],
        [:add_param, 6,     2.5],
        [:add_param, 7,     2.5],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[35] Progeny   
      Stat_Set[36]={# << Begin Crusader
  :pts_on_lv => 1,
  :extra_pts => 0,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
           ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     2.5],
        [:add_param, 3,     2.5],
        [:add_param, 4,     2.5],
        [:add_param, 5,     2.5],
        [:add_param, 6,     2.5],
        [:add_param, 7,     2.5],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     -5],
        [:add_param, 3,     -5],
        [:add_param, 4,     -5],
        [:add_param, 5,     -5],
        [:add_param, 6,     -5],
        [:add_param, 7,     -5],
       ],
  },
  }# << End Stat_Set[36] Crusader   
      Stat_Set[37]={# << Begin Zalfos
  :pts_on_lv => 1,
  :extra_pts => 0,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Love",
    :icon   => [122, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Love.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
       ],
  },
  1=>{
    :name   => "Lust",
    :icon   => [222, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Lust.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
       ],
  },
  2=>{
    :name   => "Power",
    :icon   => [11, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Power.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
        [:add_param, 2,     2.5],
        [:add_param, 3,     2.5],
        [:add_param, 4,     2.5],
        [:add_param, 5,     2.5],
        [:add_param, 6,     2.5],
        [:add_param, 7,     2.5],
       ],
  },
  3=>{
    :name   => "Wealth",
    :icon   => [361, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Wealth.",
    :cost   => [:points, "1"],
    :limit  => 10,
    :mods   =>[
       ],
  },
  4=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[37] Zalfos     
    Stat_Set[2]={# << Begin Knight
  :pts_on_lv => 0,
  :extra_pts => 1,
  :xtra_p_lv => [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30],
  :extra_pts2 => 1,
  :xtra_p_lv2 => [10,20,30],  
  0=>{
    :name   => "STR",
    :icon   => [116, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Strength.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     5],
        [:add_param, 3,     3.25],
        [:add_param, 4,     0],
        [:add_param, 5,     1.25],
        [:add_param, 6,     1.75],
        [:add_param, 7,     0.75],
       ],
  },
  1=>{
    :name   => "END",
    :icon   => [121, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Endurance.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     0.75],
        [:add_param, 3,     4.5],
        [:add_param, 4,     0.75],
        [:add_param, 5,     3.75],
        [:add_param, 6,     1.5],
        [:add_param, 7,     0.75],
       ],
    },
  2=>{
    :name   => "INT",
    :icon   => [371, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Intelligence.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     0],
        [:add_param, 3,     0.75],
        [:add_param, 4,     5.25],
        [:add_param, 5,     2.75],
        [:add_param, 6,     1],
        [:add_param, 7,     2.25],
       ],
  },
  3=>{
    :name   => "DEX",
    :icon   => [114, 0, true],
    :text   => Text_Color::White,
    :help   => "Increases Dexterity.",
    :cost   => [:points, "1"],
    :limit  => 30,
    :mods   =>[
        [:add_param, 2,     2.25],
        [:add_param, 3,     0.5],
        [:add_param, 4,     1.5],
        [:add_param, 5,     1],
        [:add_param, 6,     4.25],
        [:add_param, 7,     2.5],
       ],
  },
  9=>{
    :name   => "Corruption",
    :icon   => [7574, 0, true],
    :text   => Text_Color::White,
    :help   => "",
    :cost   => [:points, "99"],
    :limit  => 10,
    :mods   =>[
            ],
  },
  }# << End Stat_Set[2]
  #-----------------------------------------------------------------------------
  # ☆ Distribution Setup 0 End
  #-----------------------------------------------------------------------------
  # ☆ Distribution Setup 1 Begin
  #-----------------------------------------------------------------------------
  Stat_Set[99999]={# << Begin
  :pts_on_lv => 1,
  :extra_pts => 5,
  :xtra_p_lv => [5,10,15,20],
  :extra_pts2 => 0,
  :xtra_p_lv2 => [],   
  0=>{
    :name   => "Ifrit",
    :icon   => [104, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Fire God Ifrit To Increase Bond.",
    :cost   => [:points, "parent_stat(0)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele, 3,  0.01],
        [:add_atk_ele, 4, -0.01],
        [:add_def_ele, 3, -0.01],
        [:add_def_ele, 4,  0.01],
    ],
  },
  1=>{
    :name   => "Shiva",
    :icon   => [105, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Ice Goddess Shiva To Increase Bond.",
    :cost   => [:points, "parent_stat(1)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele, 3, -0.01],
        [:add_atk_ele, 4,  0.01],
        [:add_def_ele, 3,  0.01],
        [:add_def_ele, 4, -0.01],
    ],
  },
  2=>{
    :name   => "Ramuh",
    :icon   => [106, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Thunder God Ramuh To Increase Bond.",
    :cost   => [:points, "parent_stat(2)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele, 5,  0.01],
        [:add_atk_ele, 6, -0.01],
        [:add_def_ele, 5, -0.01],
        [:add_def_ele, 6,  0.01],
    ],
  },
  3=>{
    :name   => "Levithon",
    :icon   => [107, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Water God Levithon To Increase Bond.",
    :cost   => [:points, "parent_stat(3)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele, 5, -0.01],
        [:add_atk_ele, 6,  0.01],
        [:add_def_ele, 5,  0.01],
        [:add_def_ele, 6, -0.01],
    ],
  },
  4=>{
    :name   => "Titan",
    :icon   => [108, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Earth God Titan To Increase Bond.",
    :cost   => [:points, "parent_stat(4)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele, 7,  0.01],
        [:add_atk_ele, 8, -0.01],
        [:add_def_ele, 7, -0.01],
        [:add_def_ele, 8,  0.01],
    ],
  },
  5=>{
    :name   => "Bahamut",
    :icon   => [109, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Wind God Bahamut To Increase Bond.",
    :cost   => [:points, "parent_stat(5)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele, 7, -0.01],
        [:add_atk_ele, 8,  0.01],
        [:add_def_ele, 7,  0.01],
        [:add_def_ele, 8, -0.01],
    ],
  },
  6=>{
    :name   => "Ashura",
    :icon   => [110, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Holy Goddess Ashura To Increase Bond.",
    :cost   => [:points, "parent_stat(6)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele,  9,  0.01],
        [:add_atk_ele, 10, -0.01],
        [:add_def_ele,  9, -0.01],
        [:add_def_ele, 10,  0.01],
        [:add_dfl , 1],
    ],
  },
  7=>{
    :name   => "Hades",
    :icon   => [111, 0, true],
    :text   => Text_Color::White,
    :help   => "Pray To The Dark God Hades To Increase Bond.",
    :cost   => [:points, "parent_stat(7)+1"],
    :limit  => 105,
    :mods   =>[
        [:add_atk_ele,  9, -0.01],
        [:add_atk_ele, 10,  0.01],
        [:add_def_ele,  9,  0.01],
        [:add_def_ele, 10, -0.01],
        [:add_atl , 1],
    ],
  },
  }# << End Stat_Set[1]
  #-----------------------------------------------------------------------------
  # ☆ Distribution Setup 1 end
  #-----------------------------------------------------------------------------
  # You can add more Stat_Set[id] below this point..
  # Remember to follow the hash layout perfectly or you will encounter errors
  # if you make a mistake, delete your stat set and try again...
  # I DO NOT want to be harrassed by questions of how to make a good setup
  # i have given examples, use them to your advantage..
  #-----------------------------------------------------------------------------
  # Default Stat_Set[ id ] used for all actors / classes / enemies
  Default_Stat_Set = 0
  #-----------------------------------------------------------------------------
  # Initial Distribution Points For ALL Actors.
  Initial_Points   = 2
 
  #-----------------------------------------------------------------------------
  # ☆ Notetag Settings
  #-----------------------------------------------------------------------------
  Notes={
  :SPDS_SET  => /<SPDS:(.*)>/i,
  :INIT_DPs  => /<DPts:(.*)>/i,
  :NO_SPDS   => /<no spds>/i,
  :SPDS_STAT => /<spds stat:(.*),(.*)>/i,
  :ALL_STATS => /<all spds stat:(.*)>/i,
  :SPDS_MAXX => /<spds stat limit:(.*),(.*)>/i,
  }
 
  #-----------------------------------------------------------------------------
  # This option only works if using my $D13x Scene Backgrounds Script.
  # The background folder is set in the Scene BackGrounds script.
  #-----------------------------------------------------------------------------
  BGs=[
  # ['NAME'        ,   x,   y, x scroll, y scroll, z, hue, init opac, max opac],
    ['Sunbeam_Overlay_by ShinGamix',0,0, 0,     0, 1,  0,       105,      255],
    ['ShinGamox_by ShinGamix',0,0, 0,     0,    1,  0,       105,      245],
    ['Fog_By_hyde' , 100, 100,        2,       -2,  1,  0,        74,       155],
    ['$Dekita_II' ,   0,   0,         1,        1,  2,  0,       0,      255],
  ]# << end
 
  #=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  # ☆ Window Settings
  #-----------------------------------------------------------------------------
  # This is where you set the windowskin for each window.
  # Simply put a # at the start of lines you want to keep the default
  # NOTE : This setting requires $D13x Window Skins Script.
  # The windowskin folder is set in the WindowSkins script also.
  #-----------------------------------------------------------------------------
  Skins={ # << KEEP !!
  # :window type    => ["Skin Name"    , hue,  opacity]
    :main_command   => ["PWI_Style_Blu",   0,      225],
    :spds_command   => ["PWI_Style_Blu",   0,      225],
    :spds_help      => ["PWI_Style_Blu",   0,      225],
    :main_status    => ["PWI_Style_Blu",   0,      225],
    :dist_status    => ["PWI_Style_Blu",   0,      225],
    :ibox_window    => ["PWI_Style_Blu",   0,      225],
  } # << Keep
                            #####################
                            # CUSTOMISATION END #
end                         #####################
#☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★#
#                                                                               #
#                       http://dekitarpg.wordpress.com/                         #
#                                                                               #
#★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆#
#===============================================================================#
# ARE YOU MODIFYING BEYOND THIS POINT? \.\.                                     #
# YES?\.\.                                                                      #
# OMG, REALLY? \|                                                               #
# WELL SLAP MY FACE AND CALL ME A DRAGONITE.\..\..                              #
# I REALLY DIDN'T THINK YOU HAD IT IN YOU.\..\..                                #
#===============================================================================#
module SPDS ; Commands = [] ; Max_Parent_Stats.times { |i| Commands << i } ; end
#===============================================================================
module Vocanicon
#===============================================================================
  #-----------------------------------------------------------------------------
  #
  #-----------------------------------------------------------------------------
  def self.spds_stat(actor,i)
    set = actor.spds_set[i]
    [set[:name],set[:text],set[:icon][0],set[:icon][1]]
  end
end
#===============================================================================
module DataManager
#===============================================================================
  #---------------------------------------------------------------------------
  # Alias List
  #---------------------------------------------------------------------------
  class << self
    alias :lbd__SPDS :load_database
  end
  #---------------------------------------------------------------------------
  # Load Database (alias)
  #---------------------------------------------------------------------------
  def self.load_database
    lbd__SPDS
    loa_SPDS
  end
  #---------------------------------------------------------------------------
  # Load Unique Shit
  #---------------------------------------------------------------------------
  def self.loa_SPDS
    classes = [$data_weapons, $data_armors , $data_items  , $data_skills ,
               $data_actors , $data_classes, $data_enemies, $data_states ]
    for g in classes
      for o in g
        next if o == nil
        o.load__SPDS
      end
    end
  end
end # DataManager
#===============================================================================
module BattleManager
#===============================================================================
  #-----------------------------------------------------------------------------
  # Alias Lust
  #-----------------------------------------------------------------------------
  class << self
    alias :gain_disti_pts :gain_exp
  end
  #-----------------------------------------------------------------------------
  # EXP Acquisition and Level Up Display
  #-----------------------------------------------------------------------------
  def self.gain_exp
    gain_disti_pts
    gained = ($game_troop.disti_total / $game_party.alive_battle_members.size)
    vocab  = SPDS::Gain_Pts_Vocab
    dp_voc = SPDS::DP_Vocab[1]
    if gained > 0
      for actor in $game_party.alive_battle_members
        actor.gain_points(gained)
        text = sprintf(vocab, actor.name, gained, dp_voc)
        $game_message.add('\.' + text)
      end
    end
    wait_for_message
  end
end
#===============================================================================
class RPG::BaseItem
#===============================================================================
  #-----------------------------------------------------------------------------
  # Pi Variables
  #-----------------------------------------------------------------------------
  attr_accessor :_SPDS_SET_ID_
  attr_accessor :init_SPDS_points
  attr_accessor :can_distribute
  attr_accessor :spds_stats
  attr_accessor :spds_stats_limit
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  def load__SPDS
    @can_distribute   = true
    @spds_stats       = [0] * SPDS::Commands.size
    @spds_stats_limit = [0] * SPDS::Commands.size
    @_SPDS_SET_ID_    = SPDS::Default_Stat_Set
    @init_SPDS_points = self.is_a?(RPG::Actor) ? SPDS::Initial_Points : 0
    self.note.split(/[\r\n]+/).each do |line|
      case line
      when SPDS::Notes[:SPDS_SET ] then @_SPDS_SET_ID_ = $1.to_i
      when SPDS::Notes[:INIT_DPs ] then @init_SPDS_points = $1.to_i
      when SPDS::Notes[:NO_SPDS  ] then @can_distribute = false
      when SPDS::Notes[:SPDS_STAT] then @spds_stats[$1.to_i] = $2.to_i
      when SPDS::Notes[:SPDS_MAXX] then @spds_stats_limit[$1.to_i] = $2.to_i
      when SPDS::Notes[:ALL_STATS] then SPDS::Commands.each {|i| @spds_stats[i] = $1.to_i }
      end
    end
  end
end
#===============================================================================
class Game_BattlerBase
#===============================================================================
  #-----------------------------------------------------------------------------
  # ISPDS Feature Code (For Parent Stats)
  #-----------------------------------------------------------------------------
  FEATURE_ISPDS = 2013
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  alias :ispds_init_GB         :initialize
  alias :spds_fis_refresh      :refresh
  alias :parp_spds_plus        :param_plus
  alias :xparp_spds_plus       :xparam_plus   if $D13x[:Stats_Control]
  alias :sparp_spds_plus       :sparam_plus   if $D13x[:Stats_Control]
  alias :def_ele_plus_spds     :def_ele_plus  if $D13x[:Elems_Control]
  alias :atk_ele_plus_spds     :atk_ele_plus  if $D13x[:Elems_Control]
  alias :at_dfl_plus_mods_spds :atl_dfl_plus  if $D13x[:Atk_Def_Lvs]
  alias :mtp_plus_ispds        :max_tp_plus   if $D13x[:TP_Control]
  #-----------------------------------------------------------------------------
  # Initialize
  #-----------------------------------------------------------------------------
  def initialize(*args, &block)
    @spds_stats_prefix = [0] * gdecoms.size
    setup_spds_set_info
    clear_spds_stats  
    ispds_init_GB(*args, &block)
  end
  #-----------------------------------------------------------------------------
  # Get The Commands
  #-----------------------------------------------------------------------------
  def gdecoms
    return SPDS::Commands
  end
  #-----------------------------------------------------------------------------
  # Initialize SPDS System ++ (Default)
  #-----------------------------------------------------------------------------
  def setup_spds_set_info
    @spds_set = SPDS::Default_Stat_Set
    get_stat_val_for__RPG_Items
  end
  #-----------------------------------------------------------------------------
  # Get SPDS Set Info
  #-----------------------------------------------------------------------------
  def spds_set
    return SPDS::Stat_Set[@spds_set]
  end
  #-----------------------------------------------------------------------------
  # Get SPDS Stat Value
  #-----------------------------------------------------------------------------
  def get_stat_val_for__RPG_Items
    init_spds_stats_RPG_Fix
    gdecoms.each do |stat|
      next unless spds_set[stat]
      spds_set[stat][:mods].each do |mod|
        case mod[0]
        # << reg-Params
        when :add_param  then @param_per_stat[stat][mod[1]] += mod[2]
        when :sub_param  then @param_per_stat[stat][mod[1]] -= mod[2]
        when :div_param  then @param_per_stat[stat][mod[1]] /= mod[2]
        when :mul_param  then @param_per_stat[stat][mod[1]] *= mod[2]
        when :mod_param  then @param_per_stat[stat][mod[1]] %= mod[2]
        # << x-Params
        when :add_xparam then @xparam_per_stat[stat][mod[1]] += mod[2]
        when :sub_xparam then @xparam_per_stat[stat][mod[1]] -= mod[2]
        when :div_xparam then @xparam_per_stat[stat][mod[1]] /= mod[2]
        when :mul_xparam then @xparam_per_stat[stat][mod[1]] *= mod[2]
        when :mod_xparam then @xparam_per_stat[stat][mod[1]] %= mod[2]
        # << s-Params
        when :add_sparam then @sparam_per_stat[stat][mod[1]] += mod[2]
        when :sub_sparam then @sparam_per_stat[stat][mod[1]] -= mod[2]
        when :div_sparam then @sparam_per_stat[stat][mod[1]] /= mod[2]
        when :mul_sparam then @sparam_per_stat[stat][mod[1]] *= mod[2]
        when :mod_sparam then @sparam_per_stat[stat][mod[1]] %= mod[2]
        # << Attack Elements
        when :add_atk_ele then @atk_ele_per_stat[stat][mod[1]] += mod[2]
        when :sub_atk_ele then @atk_ele_per_stat[stat][mod[1]] -= mod[2]
        when :div_atk_ele then @atk_ele_per_stat[stat][mod[1]] /= mod[2]
        when :mul_atk_ele then @atk_ele_per_stat[stat][mod[1]] *= mod[2]
        when :mod_atk_ele then @atk_ele_per_stat[stat][mod[1]] %= mod[2]
        # << Defence Elements
        when :add_def_ele then @def_ele_per_stat[stat][mod[1]] += mod[2]
        when :sub_def_ele then @def_ele_per_stat[stat][mod[1]] -= mod[2]
        when :div_def_ele then @def_ele_per_stat[stat][mod[1]] /= mod[2]
        when :mul_def_ele then @def_ele_per_stat[stat][mod[1]] *= mod[2]
        when :mod_def_ele then @def_ele_per_stat[stat][mod[1]] %= mod[2]
        # << Attack Level
        when :add_atl then @atl_dfl_per_stat[stat][0] += mod[1]
        when :sub_atl then @atl_dfl_per_stat[stat][0] -= mod[1]
        when :div_atl then @atl_dfl_per_stat[stat][0] /= mod[1]
        when :mul_atl then @atl_dfl_per_stat[stat][0] *= mod[1]
        when :mod_atl then @atl_dfl_per_stat[stat][0] %= mod[1]
        # << Defence Level
        when :add_dfl then @atl_dfl_per_stat[stat][1] += mod[1]
        when :sub_dfl then @atl_dfl_per_stat[stat][1] -= mod[1]
        when :div_dfl then @atl_dfl_per_stat[stat][1] /= mod[1]
        when :mul_dfl then @atl_dfl_per_stat[stat][1] *= mod[1]
        when :mod_dfl then @atl_dfl_per_stat[stat][1] %= mod[1]
        # << Max TP
        when :add_mtp then @tp_max_per_stat[stat] += mod[1]
        when :sub_mtp then @tp_max_per_stat[stat] -= mod[1]
        when :div_mtp then @tp_max_per_stat[stat] /= mod[1]
        when :mul_mtp then @tp_max_per_stat[stat] *= mod[1]
        when :mod_mtp then @tp_max_per_stat[stat] %= mod[1]
        end
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Initialize SPDS Stats FPS Fix
  #-----------------------------------------------------------------------------
  def init_spds_stats_RPG_Fix
    @param_per_stat   = {}
    @xparam_per_stat  = {}
    @sparam_per_stat  = {}
    @atk_ele_per_stat = {}
    @def_ele_per_stat = {}
    @atl_dfl_per_stat = {}
    @tp_max_per_stat  = {}
    gdecoms.each do |stat|
      @tp_max_per_stat     [stat] = 0
      @atl_dfl_per_stat    [stat] = [0] * 2
      @param_per_stat      [stat] = [0] * 8
      @xparam_per_stat     [stat] = [0] * 10
      @sparam_per_stat     [stat] = [0] * 10
      @atk_ele_per_stat    [stat] = [0] * $data_system.elements.size
      @def_ele_per_stat    [stat] = [0] * $data_system.elements.size
    end
  end
  #-----------------------------------------------------------------------------
  # Get SPDS Stats
  #-----------------------------------------------------------------------------
  def spds_stats(id)

    base = (features_sum(FEATURE_ISPDS, id) + spds_plus(id))
    esab = [[base, spds_stats_max(id)].min, 0].max
    @spds_stats_prefix[id] = esab.to_i
    @spds_stats_prefix[id]
  end
  #-----------------------------------------------------------------------------
  # Get SPDS Stats Max
  #-----------------------------------------------------------------------------
  def spds_stats_max(id)
    base = spds_set[id][:limit] rescue 0
    return base
  end  
  #-----------------------------------------------------------------------------
  # Get SPDS Stats
  #-----------------------------------------------------------------------------
  def parent_stat(id)
    return @spds_stats_prefix[id]
  end
  #-----------------------------------------------------------------------------
  # Get SPDS Stats Plus
  #-----------------------------------------------------------------------------
  def spds_plus(id)
    @spds_stats[id]
  end
  #-----------------------------------------------------------------------------
  # Clear SPDS Stats Plus
  #-----------------------------------------------------------------------------
  def clear_spds_stats
    @spds_stats = [0] * gdecoms.size
  end
  #-----------------------------------------------------------------------------
  # Add SPDS Stats
  #-----------------------------------------------------------------------------
  def add_spds_stats(id, value, ref = true)
    @spds_stats[id] += value
    refresh if ref
  end
  #-----------------------------------------------------------------------------
  # Sub SPDS Stats
  #-----------------------------------------------------------------------------
  def sub_spds_stats(id, value, ref = true)
    @spds_stats[id] -= value
    refresh if ref
  end
  #-----------------------------------------------------------------------------
  # Div SPDS Stats
  #-----------------------------------------------------------------------------
  def div_spds_stats(id, value, ref = true)
    @spds_stats[id] /= value
    refresh if ref
  end
  #-----------------------------------------------------------------------------
  # Mul SPDS Stats
  #-----------------------------------------------------------------------------
  def mul_spds_stats(id, value, ref = true)
    @spds_stats[id] *= value
    refresh if ref
  end
  #-----------------------------------------------------------------------------
  # Mod SPDS Stats
  #-----------------------------------------------------------------------------
  def mod_spds_stats(id, value, ref = true)
    @spds_stats[id] %= value
    refresh if ref
  end
  #-----------------------------------------------------------------------------
  # Refresh
  #-----------------------------------------------------------------------------
  def refresh
    gdecoms.each { |i| spds_stats(i) }
    spds_fis_refresh
  end
  #-----------------------------------------------------------------------------
  # Param Plus
  #-----------------------------------------------------------------------------
  def param_plus(param_id)
    base = parp_spds_plus(param_id)
    SPDS::Commands.each do |i|
      base += (@param_per_stat[gdecoms[i]][param_id]*@spds_stats_prefix[i])
    end
    base.to_i
  end
  if $D13x[:Stats_Control]
    #---------------------------------------------------------------------------
    # x-Param Plus
    #---------------------------------------------------------------------------
    def xparam_plus(xparam_id)
      base = xparp_spds_plus(xparam_id)
      SPDS::Commands.each do |i|
        base += (@xparam_per_stat[gdecoms[i]][xparam_id]*@spds_stats_prefix[i])
      end
      base.to_f
    end
    #---------------------------------------------------------------------------
    # s-Param Plus
    #---------------------------------------------------------------------------
    def sparam_plus(sparam_id)
      base = sparp_spds_plus(sparam_id)
      SPDS::Commands.each do |i|
        base += (@sparam_per_stat[gdecoms[i]][sparam_id]*@spds_stats_prefix[i])
      end
      base.to_f
    end
  end # if $D13x[:Stats_Control]
  if $D13x[:Elems_Control]
    #---------------------------------------------------------------------------
    # Defence Element Plus
    #---------------------------------------------------------------------------
    def def_ele_plus(element_id)
      base = def_ele_plus_spds(element_id)
      SPDS::Commands.each do |i|
        base += (@def_ele_per_stat[gdecoms[i]][element_id]*@spds_stats_prefix[i])
      end
      base.to_f
    end
    #---------------------------------------------------------------------------
    # Attack Element Plus
    #---------------------------------------------------------------------------
    def atk_ele_plus(element_id)
      base  = atk_ele_plus_spds(element_id)
      SPDS::Commands.each do |i|
        base += (@atk_ele_per_stat[gdecoms[i]][element_id]*@spds_stats_prefix[i])
      end
      base.to_f
    end
  end # if $D13x[:Elems_Control]
  if $D13x[:Atk_Def_Lvs]
    #---------------------------------------------------------------------------
    # Atk Lv | Def Lv ++
    #---------------------------------------------------------------------------
    def atl_dfl_plus(id)
      base = at_dfl_plus_mods_spds(id)
      SPDS::Commands.each do |i|
        base += (@atl_dfl_per_stat[gdecoms[i]][id]*@spds_stats_prefix[i])
      end
      base.to_i
    end
  end # if $D13x[:Atk_Def_Lvs]
  if $D13x[:TP_Control]
    #---------------------------------------------------------------------------
    # Max TP Plus
    #---------------------------------------------------------------------------
    def max_tp_plus
      base  = mtp_plus_ispds
      SPDS::Commands.each do |i|
        base  += (@tp_max_per_stat[gdecoms[i]]*@spds_stats_prefix[i])
      end
      base.to_i
    end
  end
end # Game_BattlerBase
#===============================================================================
class Game_Actor < Game_Battler
#===============================================================================
  #-----------------------------------------------------------------------------
  # Pi Variables
  #-----------------------------------------------------------------------------
  attr_reader  :points
  attr_reader  :SPDSFLAG
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  alias :sD13x_SPDS_init       :initialize
  alias :lev_up_SPDS           :level_up
  alias :change_SPDS_class     :change_class
  #-----------------------------------------------------------------------------
  # Initialization
  #-----------------------------------------------------------------------------
  def initialize(actor_id)
    sD13x_SPDS_init(actor_id)
    init_SPDS
    refresh
    recover_all
  end
  #-----------------------------------------------------------------------------
  # Initialize SPDS System
  #-----------------------------------------------------------------------------
  def init_SPDS
    @points   = actor.init_SPDS_points
    @SPDSFLAG = false
    setup_spds_set_info_overwrite
  end
  #-----------------------------------------------------------------------------
  # Initialize SPDS System ++ (from super)
  #-----------------------------------------------------------------------------
  def setup_spds_set_info_overwrite
    act = actor._SPDS_SET_ID_
    cla = self.class._SPDS_SET_ID_
    @spds_set = SPDS::Default_Stat_Set
    @spds_set = cla if cla != SPDS::Default_Stat_Set
    @spds_set = act if act != SPDS::Default_Stat_Set
    get_stat_val_for__RPG_Items
  end
  #-----------------------------------------------------------------------------
  # Change_SPDS_Set_ID
  #-----------------------------------------------------------------------------
  def change_spds_set_id_to(id)
    return if SPDS::Stat_Set[id] == nil
    @spds_set = id
    get_stat_val_for__RPG_Items
  end
  #--------------------------------------------------------------------------
  # Change Class  |  keep_exp:  Keep EXP
  #--------------------------------------------------------------------------
  def change_class(class_id, keep_exp = true)
    old_cla = @class_id
    change_SPDS_class(class_id, keep_exp)
    setup_spds_set_info_overwrite if old_cla != @class_id
  end
  #-----------------------------------------------------------------------------
  # Level Up
  #-----------------------------------------------------------------------------
  def level_up
    lev_up_SPDS
    on_lv_SPDS
  end
  #-----------------------------------------------------------------------------
  # Level Up SPDS
  #-----------------------------------------------------------------------------
  def on_lv_SPDS
    return unless can_distribute?
    @points  += spds_set[:pts_on_lv]
    @points  += spds_set[:extra_pts] if spds_set[:xtra_p_lv].include?(@level)
    @points  += spds_set[:extra_pts2] if spds_set[:xtra_p_lv2].include?(@level)
    @SPDSFLAG = true  if @points > 0
  end
  #-----------------------------------------------------------------------------
  # Can Distribute Stats?
  #-----------------------------------------------------------------------------
  def can_distribute?
    return actor.can_distribute
  end
  #-----------------------------------------------------------------------------
  # Reset SPDSFLAG
  #-----------------------------------------------------------------------------
  def reset_SPDSFLAG
    @SPDSFLAG = false
  end
  #-----------------------------------------------------------------------------
  # Do SPDS Stat Modifications <><>
  #-----------------------------------------------------------------------------
  def spds_stat_mods(mods,spds_stat_id,does_cost = true)
    @spds_stats[spds_stat_id] += 1
    cost = get_point_cost(mods[:cost][1])
    return refresh unless does_cost
    case mods[:cost][0]
    when :points then reduce_points(cost)
    when :gold   then $game_party.gain_gold(-cost)
    when :exp    then reduce_spds_exp(cost)
      end
    refresh
  end
  #-----------------------------------------------------------------------------
  # Reduce Points
  #-----------------------------------------------------------------------------
  def reduce_points(val)
    @points -= val
    @points = 0 if @points < 0
  end
  #-----------------------------------------------------------------------------
  # Reset All Points
  #-----------------------------------------------------------------------------
  def reset_all_points(pts_bk = true)
    old_pts = get_total_spds_stats
    clear_spds_stats
    new_pts = get_total_spds_stats
    gain_points(old_pts-new_pts) if ((old_pts > new_pts) && (pts_bk))
  end
  #-----------------------------------------------------------------------------
  # Reset Some Points
  #-----------------------------------------------------------------------------
  def reset_some_points(stat_id, points, pts_bk = true)
    old_pts = parent_stat(stat_id)
    sub_spds_stats(stat_id, points)
    new_pts = parent_stat(stat_id)
    gain_points(old_pts-new_pts) if ((old_pts > new_pts) && (pts_bk))
  end
  #-----------------------------------------------------------------------------
  # Gain Points
  #-----------------------------------------------------------------------------
  def gain_points(val)
    @points += val
    @points = SPDS::Max_Points if @points > SPDS::Max_Points
  end
  #-----------------------------------------------------------------------------
  # Reduce SPDS Exp
  #-----------------------------------------------------------------------------
  def reduce_spds_exp(val)
    gain_exp(-val)
  end
  #-----------------------------------------------------------------------------
  # Get Spendable Exp
  #-----------------------------------------------------------------------------
  def spendable_exp
    exp - current_level_exp
  end
  #-----------------------------------------------------------------------------
  # Get Points Cost
  #-----------------------------------------------------------------------------
  def get_point_cost(string)
    return [eval(string), 1].max.to_i rescue 0
  end
  #-----------------------------------------------------------------------------
  # Get Total SPDS Stats
  #-----------------------------------------------------------------------------
  def get_total_spds_stats(base = 0)
    gdecoms.each { |i| base += parent_stat(i) }
    return base
  end
  #-----------------------------------------------------------------------------
  # SPDS Plus
  #-----------------------------------------------------------------------------
  def spds_plus(id)
    base  = super(id)
    base += actor.spds_stats[id]
    base += self.class.spds_stats[id]
    base += equips.compact.inject(0) {|r, i| r += i.spds_stats[id] }
    base += states.compact.inject(0) {|r, i| r += i.spds_stats[id] }
    if $D13x[:Skill_Lv]
      base += skills.compact.inject(0) {|r, i| r += (i.spds_stats[id]*
      Skill_Levels::Exp_Set[i.exp_set][@skills_lv[i.id]][2] ).to_f}
    else
      base += skills.compact.inject(0) {|r, i| r += i.spds_stats[id] }
    end
    base
  end
  #-----------------------------------------------------------------------------
  # Get SPDS Stats Max
  #-----------------------------------------------------------------------------
  def spds_stats_max(id)
    base = super(id)
    base += actor.spds_stats_limit[id]
    base += self.class.spds_stats_limit[id]
    base += equips.compact.inject(0) {|r, i| r += i.spds_stats_limit[id] }
    base += states.compact.inject(0) {|r, i| r += i.spds_stats_limit[id] }
    if $D13x[:Skill_Lv]
      base += skills.compact.inject(0) {|r, i| r += (i.spds_stats_limit[id]*
      Skill_Levels::Exp_Set[i.exp_set][@skills_lv[i.id]][2] ).to_f}
    else
      base += skills.compact.inject(0) {|r, i| r += i.spds_stats_limit[id] }
    end
    base
  end
end
#===============================================================================
class Game_Enemy < Game_Battler
#===============================================================================
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  alias :sD13x_SPDS_init  :initialize
  #-----------------------------------------------------------------------------
  # Initialization
  #-----------------------------------------------------------------------------
  def initialize(index, enemy_id)
    sD13x_SPDS_init(index, enemy_id)
    setup_spds_set_info_overwrite
    refresh
    recover_all
  end
  #-----------------------------------------------------------------------------
  # Get Distribution Points
  #-----------------------------------------------------------------------------
  def disti_pts
    enemy.init_SPDS_points
  end
  #-----------------------------------------------------------------------------
  # Initialize SPDS System ++ (from super)
  #-----------------------------------------------------------------------------
  def setup_spds_set_info_overwrite
    @spds_set = SPDS::Default_Stat_Set
    @spds_set = enemy._SPDS_SET_ID_ if enemy._SPDS_SET_ID_ != @spds_set
    get_stat_val_for__RPG_Items
  end
  #-----------------------------------------------------------------------------
  # SPDS Plus
  #-----------------------------------------------------------------------------
  def spds_plus(id)
    base  = super(id)
    base += enemy.spds_stats[id]
    base += states.compact.inject(0) {|r, i| r += i.spds_stats[id] }
    base
  end
  #-----------------------------------------------------------------------------
  # Get SPDS Stats Max
  #-----------------------------------------------------------------------------
  def spds_stats_max(id)
    base = super(id)
    base += enemy.spds_stats_limit[id]
    base += states.compact.inject(0) {|r, i| r += i.spds_stats_limit[id] }
    base
  end
end
#===============================================================================
class Game_Troop < Game_Unit
#===============================================================================
  #-----------------------------------------------------------------------------
  # Calculate Distribution Points Gain Total
  #-----------------------------------------------------------------------------
  def disti_total
    dead_members.inject(0) {|r, enemy| r += enemy.disti_pts }
  end
end
#===============================================================================
class Game_Party < Game_Unit
#===============================================================================
  #-----------------------------------------------------------------------------
  # Check if member needs to be taken to distribution screen.
  #-----------------------------------------------------------------------------
  def check_need_spds?
    return nil unless SPDS::Show_Screen
    alive_battle_members.each do |a|
      next unless a.SPDSFLAG
      a.reset_SPDSFLAG
      return a
    end
    return nil
  end
end
#===============================================================================
class Window_SPDS_DistributeCommand < Window_Command
#===============================================================================
  #-----------------------------------------------------------------------------
  # Pi Variables
  #-----------------------------------------------------------------------------
  attr_reader :actor
  #-----------------------------------------------------------------------------
  # Initialize
  #-----------------------------------------------------------------------------
  def initialize(x, y)
    @dey = y
    @actor = $game_party.menu_actor
    super(x, y)
    deactivate
    @index = -1
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
  # Get Window Width
  #-----------------------------------------------------------------------------
  def window_width
    return Graphics.width / 3
  end
  #-----------------------------------------------------------------------------
  # Get Window Height
  #-----------------------------------------------------------------------------
  def window_height
    return (line_height*(SPDS::Visible_Distribution_Commands+1))
  end
  #-----------------------------------------------------------------------------
  # Create Command List
  #-----------------------------------------------------------------------------
  def make_command_list
    return unless @actor
    ind = 0
    for command in SPDS::Commands
      next unless @actor.spds_set[command]
      set  = @actor.spds_set[command]
      cost = @actor.get_point_cost(set[:cost][1])
      enab = can_enable_spend?(set[:cost][0], cost, ind)
      add_command(set[:name], :spend_pts, enab, set)
      ind += 1
    end
    return unless SPDS::Allow_Finish
    add_command(SPDS::Finish_Data[0], :end_distribute,true, {})
  end
  #-----------------------------------------------------------------------------
  # Draws Items
  #-----------------------------------------------------------------------------
  def draw_item(index)
    change_color(normal_color, command_enabled?(index))
    self.contents.font.name   = General::Fonts
    self.contents.font.size   = General::Font_Size
    self.contents.font.bold   = General::Font_Bold
    rect = item_rect_for_text(index)
    icon = command_icon(index)
    contents.fill_rect(rect.x-2,rect.y+1,rect.width+4,rect.height-2,Color.new(0,0,0,64))
    if command_name(index) == SPDS::Finish_Data[0]
      draw_text(rect, command_name(index), 1)
    else
      draw_de_icon(icon[0], rect.x, rect.y, icon[1], icon[2])
      rect.x += 25
      draw_text(rect, command_name(index), 0)
      rect.x -= 28
      change_color(normal_color)
      draw_text(rect, @actor.spds_stats(index).to_s, 2)
    end
  end
  #-----------------------------------------------------------------------------
  # Get Command Icon
  #-----------------------------------------------------------------------------
  def command_icon(index)
    @list[index][:ext][:icon]
  end
  #-----------------------------------------------------------------------------
  # Get Command Icon
  #-----------------------------------------------------------------------------
  def get_command_help
    text = @actor.spds_set[SPDS::Commands[@index]][:help] rescue nil
    return SPDS::Finish_Data[1] unless text
    data = @actor.spds_set[SPDS::Commands[@index]]
    cost = @actor.get_point_cost(data[:cost][1])
    add_cost_info_to_help(cost, data[:cost][0], text)
  end
  #-----------------------------------------------------------------------------
  # Add Cost Info to Help Window
  #-----------------------------------------------------------------------------
  def add_cost_info_to_help(cost, data, text)
    curr = @actor.parent_stat   (@index)
    maxx = @actor.spds_stats_max(@index)
    text += "\nCost: --" if curr >= maxx
    case data
    when :points then text += "\nCost: #{cost} #{SPDS::DP_Vocab[1]}"
    when :gold   then text += "\nCost: #{cost} Gold"
    when :exp    then text += "\nCost: #{cost} Exp Points"
    end  ;return text
  end
  #-----------------------------------------------------------------------------
  # Can Enable Buy Stat ?
  #-----------------------------------------------------------------------------
  def can_enable_spend?(type, cost, id)
    return false if (@actor.parent_stat(id) >= @actor.spds_stats_max(id))
    return false if (@actor.spendable_exp < cost) && (type == :exp      )
    return false if (@actor.points        < cost) && (type == :points   )
    return false if ($game_party.gold     < cost) && (type == :gold     )
    return true
  end  
end
#===============================================================================
class Window_SPDSCommandII < Window_Command
#===============================================================================
  #-----------------------------------------------------------------------------
  # Get Window Width
  #-----------------------------------------------------------------------------
  def window_width
    return 0
  end
  #-----------------------------------------------------------------------------
  # Create Command List
  #-----------------------------------------------------------------------------
  def make_command_list
    for command in SPDS::Info
      add_command("", command[0])
    end
  end
  #-----------------------------------------------------------------------------
  # Get Page ID
  #-----------------------------------------------------------------------------
  def get_page_id
    i = 0
    for command in SPDS::Info
      return command[0] if i == index
      i += 1
    end
    return :page_1
  end
end
#===============================================================================
class Window_StatusSPDS < Window_StatusDekita
#===============================================================================
  #--------------------------------------------------------------------------
  # Set Windowskin (overwrite from super)
  #--------------------------------------------------------------------------
  def set_the_skin
    @skin = SPDS::Skins[:main_status]
  end
end
#===============================================================================
class Window_SPDSStatus < Dekita_Core_Status
#===============================================================================
  #-----------------------------------------------------------------------------
  # Initialization
  #-----------------------------------------------------------------------------
  def initialize(actor,y)
    x = Graphics.width/3
    w = Graphics.width/3*2 - (Graphics.width / 4) + 20
    h = Graphics.height-y
    super(x, y, w, h, actor)
    self.opacity = 0
  end
  #-----------------------------------------------------------------------------
  # Get Setup Info
  #-----------------------------------------------------------------------------
  def setup_info
    return SPDS::Info[@page]
  end
end
#===============================================================================
class Window_SPDSStatusCHANGES < Dekita_Core_Status_Changes
#===============================================================================
  #-----------------------------------------------------------------------------
  # Initilize
  #-----------------------------------------------------------------------------
  def initialize(actor, y)
    x = Graphics.width/4*3
    w = Graphics.width/4
    h = Graphics.height-y
    super(x,y,w,h,actor)
    self.opacity = 0
  end
  #-----------------------------------------------------------------------------
  # Get Future Stats
  #-----------------------------------------------------------------------------
  def future_stat
    return unless @dis_window
    @temp_actor = Marshal.load(Marshal.dump(@actor))
    spds = @actor.spds_set
    page = SPDS::Commands[@dis_window.index]
    @temp_actor.spds_stat_mods(spds[page],@dis_window.index) if @dis_window.index >= 0
    refresh
  end
  #-----------------------------------------------------------------------------
  # Get Setup Info
  #-----------------------------------------------------------------------------
  def setup_info
    return SPDS::Info[@page]
  end
  #-----------------------------------------------------------------------------
  # Draw Header
  #-----------------------------------------------------------------------------
  def draw_header(x,y,text,col,icon,hue,align)
    draw_box(x, y)
#    x = draw_stat_icons(icon, x, y, hue, all_icons_enable?)
    change_color(col)
    draw_text(x, y, wid, line_height, SPDS::Changes_Vocab, align)
    return y += line_height
  end
end
#===============================================================================
class Window_SPDS_Blank < Window_Selectable
#===============================================================================
  #-----------------------------------------------------------------------------
  # Initialization
  #-----------------------------------------------------------------------------
  def initialize(y)
    super(Graphics.width/3, y, Graphics.width/3*2+1, Graphics.height - y)
    refresh
  end
end
#===============================================================================
class Window_SPDS_Gold_n_Time < Window_Base
#===============================================================================
  #-----------------------------------------------------------------------------
  # Object Initialization
  #-----------------------------------------------------------------------------
  def initialize(y,actor)
    @actor = actor
    super(0, y, Graphics.width/3, Graphics.height-y)
    refresh
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
  # Refresh
  #-----------------------------------------------------------------------------
  def refresh
    contents.clear
    drAW_DE_INFO
  end
  #-----------------------------------------------------------------------------
  # Draw The Info
  #-----------------------------------------------------------------------------
  def drAW_DE_INFO
    y = 0
    SPDS::IBox.each do |halp|
      case halp[0]
      when :gold then y = draw_degol(y,halp[1])
      when :time then y = draw_detim(y,halp[1])
      when :exp  then y = draw_deexp(y,halp[1])
      when :pts  then y = draw_depts(y,halp[1])
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Draw The Gold
  #-----------------------------------------------------------------------------
  def draw_degol(y,halp)
    x = get_de_x(halp[0])
    contents.fill_rect(0,y+1,wid,line_height-2,Color.new(0,0,0,64))
    draw_de_icon(halp[0],0,y,halp[1], true) if halp[0] > 0
    draw_text(x,y,wid,line_height, halp[2])
    draw_text(0,y,wid-4,line_height, $game_party.gold.to_i ,2)
    return y += line_height
  end
  #-----------------------------------------------------------------------------
  # Draw The Time
  #-----------------------------------------------------------------------------
  def draw_detim(y,halp)
    t = Time.now
    x = get_de_x(halp[0])
    contents.fill_rect(0,y+1,wid,line_height-2,Color.new(0,0,0,64))
    draw_de_icon(halp[0],0,y,halp[1], true) if halp[0] > 0
    text = "#{t.strftime("%H")}:#{t.strftime("%M")}:#{t.strftime("%S")}"
    draw_text(x,y,wid,line_height, halp[2])
    draw_text(0,y,wid-4,line_height, text, 2)
    return y += line_height
  end
  #-----------------------------------------------------------------------------
  # Draw The Exp
  #-----------------------------------------------------------------------------
  def draw_deexp(y,halp)
    return y unless @actor
    x = get_de_x(halp[0])
    contents.fill_rect(0,y+1,wid,line_height-2,Color.new(0,0,0,64))
    draw_de_icon(halp[0],0,y,halp[1], true) if halp[0] > 0
    text = "#{@actor.spendable_exp}"
    draw_text(x,y,wid,line_height, halp[2])
    draw_text(0,y,wid-4,line_height, text, 2)
    return y += line_height
  end
  #-----------------------------------------------------------------------------
  # Draw The Points
  #-----------------------------------------------------------------------------
  def draw_depts(y,halp)
    return y unless @actor
    x = get_de_x(halp[0])
    contents.fill_rect(0,y+1,wid,line_height-2,Color.new(0,0,0,64))
    draw_de_icon(halp[0],0,y,halp[1], true) if halp[0] > 0
    text = "#{@actor.points}"
    draw_text(x,y,wid,line_height, halp[2])
    draw_text(0,y,wid-4,line_height, text, 2)
    return y += line_height
  end
  #-----------------------------------------------------------------------------
  # Get Width
  #-----------------------------------------------------------------------------
  def wid
    self.width - (standard_padding*2)
  end
  #-----------------------------------------------------------------------------
  # Get x Position
  #-----------------------------------------------------------------------------
  def get_de_x(icon)
    return 0 if icon <= 0
    return 25
  end
end
#===============================================================================
class Scene_Map < Scene_Base
#===============================================================================
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  alias :updat_SPDSFLAG  :update_scene
  #-----------------------------------------------------------------------------
  # Update Scene Transition
  #-----------------------------------------------------------------------------
  def update_scene
    updat_SPDSFLAG
    start_SPDS unless scene_changing?
  end
  #-----------------------------------------------------------------------------
  # Update Scene Transition (To SPDS)
  #-----------------------------------------------------------------------------
  def start_SPDS
    actor = $game_party.check_need_spds?
    if actor != nil
      SceneManager.call(Scene_SPDS)
      SceneManager.scene.prepare(actor)
    end
  end
end
#===============================================================================
class Scene_Menu < Scene_MenuBase
#===============================================================================
  #-----------------------------------------------------------------------------
  # Alias List
  #-----------------------------------------------------------------------------
  #alias :spdsmenu_create_command_window :create_command_window
  #alias :opok_spds_SM                   :on_personal_ok
  #-----------------------------------------------------------------------------
  # Create Command Window
  #-----------------------------------------------------------------------------
 # def create_command_window
 #   spdsmenu_create_command_window
 #   @command_window.set_handler(:distribute, method(:command_personal))
 # end
  #-----------------------------------------------------------------------------
  # On Personal Ok
  #-----------------------------------------------------------------------------
 # def on_personal_ok
 #   opok_spds_SM
 #   call_distriute if @command_window.current_symbol == :distribute
 # end
  #-----------------------------------------------------------------------------
  # Call SPDS Scene
  #-----------------------------------------------------------------------------
  def call_distriute
    actor = $game_party.members[@status_window.index]
    return @command_window.activate if !actor.can_distribute?
    SceneManager.call(Scene_SPDS)
    SceneManager.scene.prepare(actor)
  end
end
#===============================================================================
class Scene_SPDS < Scene_MenuBase
#===============================================================================
  #-----------------------------------------------------------------------------
  # Prepare
  #-----------------------------------------------------------------------------
  def prepare(actor)
    @real_actor = actor
    @actor = @real_actor
  end
  #-----------------------------------------------------------------------------
  # Start Processing
  #-----------------------------------------------------------------------------
  def start
    super
    @actor = @real_actor
    create_command_window
    create_help_window
    create_SPDS_window
    create_distribute_list
    make_ibox_window
    update_windows
  end
  #-----------------------------------------------------------------------------
  # Create Command Window
  #-----------------------------------------------------------------------------
  def create_command_window
    @command_window = Window_SPDSCommand.new(0,0)
    @command_window.set_handler(:cancel,   method(:return_scene))
    @command_window.set_handler(:pagedown, method(:next_actor))
    @command_window.set_handler(:pageup,   method(:prev_actor))
    @command_window.set_handler(:pageup,   method(:prev_actor))
    @command_window.set_handler(:spend,    method(:spend_pts))
    @command_window.set_handler(:exit,     method(:return_scene))
    @fake_command_window = Window_SPDSCommandII.new(0,0)
    @fake_command_window.deactivate
  end
  #-----------------------------------------------------------------------------
  # Create Halp Window
  #-----------------------------------------------------------------------------
  def create_help_window
    @help_window = Deki_Help.new
    @help_window.viewport = @viewport
    @help_window.x = Graphics.width / 4
  end
  #-----------------------------------------------------------------------------
  # Create SPDS Window
  #-----------------------------------------------------------------------------
  def create_SPDS_window
    y = @help_window.height
    @status_window = Window_StatusSPDS.new(@actor, y)
    y = (@status_window.y+@status_window.height)
    @blank_window = Window_SPDS_Blank.new(y)
    @SPDS_window  = Window_SPDSStatus.new(@actor, y)
  end
  #-----------------------------------------------------------------------------
  # Create Distribution List
  #-----------------------------------------------------------------------------
  def create_distribute_list
    y = @status_window.y + @status_window.height
    @dis_window = Window_SPDS_DistributeCommand.new(0,y)
    @dis_window.set_handler(:spend_pts,      method(:spend_dis_point))
    @dis_window.set_handler(:end_distribute, method(:cancel_spend))
    @dis_window.set_handler(:cancel,         method(:cancel_spend))
    @dis_window.actor = @actor if @actor
    @dis_window.index = -1
    # << Changes Window
    @temp_act_SPDS_Window = Window_SPDSStatusCHANGES.new(@actor, y)
    @temp_act_SPDS_Window.dis_window = @dis_window
  end
  #-----------------------------------------------------------------------------
  # Make IBox Window
  #-----------------------------------------------------------------------------
  def make_ibox_window
    y = @status_window.y+@status_window.height+@dis_window.height
    @gold_time_wind = Window_SPDS_Gold_n_Time.new(y,@actor)
    @ibox_time = Time.now.sec
  end
  #-----------------------------------------------------------------------------
  # Change Actors
  #-----------------------------------------------------------------------------
  def on_actor_change
    @temp_act_SPDS_Window.actor = @actor
    @gold_time_wind.actor = @actor
    @status_window.actor  = @actor
    @SPDS_window.actor    = @actor
    @dis_window.actor     = @actor
    @command_window.activate
  end
  #-----------------------------------------------------------------------------
  # Spend Points
  #-----------------------------------------------------------------------------
  def spend_pts
    @command_window.deactivate
    @command_window.index = -1
    @dis_window.activate
    @dis_window.index = 0
    @temp_act_SPDS_Window.future_stat
  end
  #-----------------------------------------------------------------------------
  # Cancel Spend Points
  #-----------------------------------------------------------------------------
  def cancel_spend
    @dis_window.deactivate
    @dis_window.index = -1
    @temp_act_SPDS_Window.future_stat
    @command_window.activate
    @command_window.index = 0
  end
  #-----------------------------------------------------------------------------
  # Confirm Spend Points
  #-----------------------------------------------------------------------------
  def spend_dis_point
    spds = @actor.spds_set
    page = SPDS::Commands[@dis_window.index]
    @actor.spds_stat_mods(spds[page],@dis_window.index)
    @temp_act_SPDS_Window.future_stat
    @gold_time_wind.refresh
    @SPDS_window.refresh
    @status_window.refresh
    @dis_window.refresh
    @dis_window.activate
      end
  #-----------------------------------------------------------------------------
  # Update
  #-----------------------------------------------------------------------------
  def update
    super
    update_windows
    update_gold_n_time
  end
  #-----------------------------------------------------------------------------
  # Update windows
  #-----------------------------------------------------------------------------
  def update_windows
    update_fake_command
    @SPDS_window.page          = @fake_command_window.get_page_id
    @temp_act_SPDS_Window.page = @fake_command_window.get_page_id
    if @dis_window.active
      @help_window.set_text(@dis_window.get_command_help)
      if @dis_window.current_symbol == :end_distribute
        @temp_act_SPDS_Window.show_no_stats
#        @temp_act_SPDS_Window.page = nil
      end
    else
      @help_window.set_text(@actor.description) if @actor
    end
    update_dis_window
  end
  #-----------------------------------------------------------------------------
  # Update Fake Command Window
  #-----------------------------------------------------------------------------
  def update_fake_command
    max_page = SPDS::Max_Pages-1
    if Keys.trigger?(:RSHIFT)
      @fake_command_window.index += 1 if @fake_command_window.index <= max_page
    end
    if Keys.trigger?(:LSHIFT)
      @fake_command_window.index -= 1 if @fake_command_window.index >= 0
    end
    @fake_command_window.index = 0 if @fake_command_window.index > max_page
    @fake_command_window.index = max_page if @fake_command_window.index < 0
  end
  #-----------------------------------------------------------------------------
  # Update dis Window
  #-----------------------------------------------------------------------------
  def update_dis_window
    return unless @dis_window.active
    return unless @dis_window.current_symbol != :end_distribute
    return unless Input.trigger?(:DOWN) || Input.trigger?(:UP)
    @temp_act_SPDS_Window.future_stat
  end
  #-----------------------------------------------------------------------------
  # Update Gold / Time Window
  #-----------------------------------------------------------------------------
  def update_gold_n_time
    return unless SPDS::Showing_Time
    return unless @ibox_time != Time.now.sec
    @gold_time_wind.refresh
    @ibox_time = Time.now.sec
  end
  #-----------------------------------------------------------------------------
  # Create Backgrounds
  #-----------------------------------------------------------------------------
  def get_all_bgs
    return unless $D13x[:Scene_BGs]
    @bg_set = SPDS::BGs
  end    
end
#==============================================================================#
#                      http://dekitarpg.wordpress.com/                         #
#==============================================================================#
end  # if true # << Make true to use this script, false to disable.