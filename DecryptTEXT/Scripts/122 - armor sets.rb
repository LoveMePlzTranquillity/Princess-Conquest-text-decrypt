#============================================================================
# Equipment Sets v2.1e
# By Emerald
#----------------------------------------------------------------------------
# You're free to use the script for any game, as long as you give credits
#----------------------------------------------------------------------------
# Version History
# 1.0 -> Script fully ready for public use. Addes sets, unlimited set items,
#        set bonuses for the 8 basic stats, set bonuses requirement (how many
#        items of the set is the actor wearing?)
# 1.1 -> a. changed the set bonuses work. Instead of [parameter, bonus] you now
#        use [sort, parameter, bonus]. Also added sorts 0 and 2. Check SPECIAL
#        VALUES for their corresponding parameters.
#        b. Added sort 1: Standard Parameters (Percentage). The corresponding
#        parameters are the same as for sort 0. See SPECIAL VALUES for extra
#        notes.
# 1.2 -> Added Sort 3: Special Parameters. The values for the parameters can be
#        found in SPECIAL VALUES, just as usual. Addes Sort 4: Skills!! These
#        use a different syntax than the other bonuses, so be sure to check
#        SPECIAL VALUES if you are unfamiliar with them.
# 1.3 -> a. rewritten most of the code to remove so major bugs. Also cleaned
#        code (about 140 lines less this time, WITH 4 added Sorts). Added
#        Module Emerald (EME). Sets and Set_Bonuses move to Module EME. Added
#        MAX_ELEMENTS to Module EME. Added Sort 5 (Elemental Efficiency), Sort
#        6 (Debuff Rate), Sort 7 (State Rate), Sort 8 (State Resist) and Sort 9
#        (Attack Elements). See SPECIAL VALUES for instructions.
#        WARNING these are still in Beta Stage, so report all bugs found.  
#        b. removed many, MANY major bugs! Removed a bug where unequipping
#        resulted in an undefined array, removed some typos, fixed the bonuses
#        for almost EVERY Sort, removed some more typos, shortened code a little
#        bit, removed some more minor bugs regarding change_equip.
# 1.4 -> More bug fixes. Also added Sort 10 (Attack States), Sort 11 (Equipment
#        Types) and Sort 12 (Attack Specials). Refer to SPECIAL VALUES for
#        all needed information.
# 1.5 -> Bug fix to discard_equip(...). Added the foruth value of Sort 11
#        (Dual Wielding), added Sort 13, Sort 14, Sort 15, Sort 16 and Sort 17
#        which are Additional Skill Types, Sealed Skill Types, Sealed Skills,
#        Fixed Equip Types and Sealed Equip Types respectively. As usual, go to
#        SPECIAL VALUES for the needed instructions.
# 1.6 -> Added a compatibility patch for Fomar's Dual Wield -> Free Hands script.
# 1.7 -> Added Sorts 18 (special flags), 19 (party abilities) and 20 (other 
#        traits). See SPECIAL VALUES for the instructions.
# 1.8a-> Added sounds to be played when a certain amount of set pieces has been
#        equipped. Also removed a bug regarding skipping amounts of pieces.
# 1.8b-> Small bugfix regarding set sounds.
# 1.8c-> Small bugfix regarding attack states.
#
# 2.0 -> MAJOR REWRITE. Aliased a few more methods than before, to further
#        increases compatability. Added a method which initializes sets which
#        are worn by actors at the start of the game. Halved the code used to
#        determine if items belong to sets. Scraped a few uneccessairy methods.
#        Practically removed 2/3 of my version of release_unequipable_equips,
#        and made the EES + Fomar123's Dual Wield -> Free Hands script patch
#        1 line instead of 10. Almost entirely changed the way Set Skills and
#        Set Equipment Options work. Also fixed a few bugs in the progress 
#        (for example additions of variable 2 which I accidentally left in the 
#        script.)
# 2.1a-> Start of the debugging patch. Added a function to remove bonuses when
#        unequipping stuff, like usual. Forgot to re-add in 2.0 >.<
# 2.1b-> Fixed a small typo.
# 2.1c-> Fixed initalizition of set equips.
# 2.1d-> Fixed a bug regarding bonuses not being applied upon optimizing equips
#        and a bug regarding the removing of bonuses when unequipping stuff.
# 2.1e-> Removed something which I should have added (regarding the BaseItem 
#        class) in release_unequippable_items. This also fixed the compatibility
#        issues with Tsukihime's Effect Manager.
#----------------------------------------------------------------------------
# Started with a Iron Sword? Pretty good. Found a Gold Sword? Awesome! Found
# the complete Bronze Set? Bad stuff...
# Unless, they give you bonuses! In other words, this script allows you to create
# bonuses for wearing multiple items of a set... Just wanted to make it sound
# more fun...
#
# Instructions:
#
# Just as always, put this script between Бе Materials and Бе Main. Put this script
# below any script which rewrites change_equip and above any script which aliases
# 'param' in Game_Actor (usually in Game_BattlerBase, but it only matters if it
# is rewritten/aliased in Game_Actor).
#
# Set MAX_ELEMENTS below module EME and above Sets to the maximum number of
# elements in the database. Else, the script won't recognize any above the value.
#
#
# SETS
#
# To create sets (sorry, no names yet) go to Sets in the configuration part.
# Add the set id, followed by an array containing arrays. The latter arrays
# must be at least two elements long, one for the type of equipment, one for the 
# id.
# Examples:
#
# 1 => [[0, 1], [1, 2]], <- The []'s define an array. The arrays like the [0,1]
# and [1, 2] should be at least two elements long (each element is separated by
# a comma.
#
# 2 => [[0, 5], [0, 6], [1, 5], [1,7]], <- If the array is not the last in the 
# list, add a comma or you'll get an error. This goes for every array.
#
# set id => [[equipment type, equipment id], [equipment type, equipment id]]
#
# NOTE:
# The set id MUST be 0 or higher. The variable in which the sets are stored (which
# is called a hash) usually begins with 1 =>, so that's why that's also in the
# standard config. 
# The Equipment Types are 0 (weapons) and 1 (armors.)
# DO NOT COPY the ID of items in the database. If you put all the useless 0's
# in front of the real ID, you'll get an error/the script won't work.
# Furthermore, you can have an infinite amount of equipment belonging (is that a
# word?) to a set, so don't worry about compatibility issues with Extra Equipment
# Slots scripts. Unless they rewrite change_equip, than there's a slight chance
# on problems. This can be fixed, however, by putting this script below any
# script which rewrites change_equip.
# Also, you can have multiple weapons in array and the same equipment in different
# sets.
#
#
# SET BONUSES
#
# For set bonuses, go to Set_Bonuses. Use the follwing syntax to add bonuses:
#
# set id => {
#    amount of pieces required => [[sort, parameter, bonus]]
#           },
#
# Specifications:
# set id = the same set id as in Sets.
#
# amount of pieces required = the amount of pieces the player must be wearing in
# order to receive the bonuses. If you want to skip one, just skip it. Like:
# 1 => blablabla
# 3 => blablabla
#
# sort = type of bonus. For all sorts, see SPECIAL VALUES.
#
# parameter = the parameter which receives the bonus. For all parameters, see
# SPECIAL VALUES.
#
# bonus = the bonus to be added to parameter. Note that this is a direct bonus,
# not a percentage. If the vale is negative, the bonus will become negative. If
# the value is 0, there will be no bonus to that stat.
#
#
# SPECIAL VALUES
# Sets
# ----
# Equipment types: 0 and 1. 0 is the Weapons tab in the database, 1 is the
# Armors tab in the database.
#
# Set_Bonuses
# ---
# Sorts:
# 0  - Standard Parameter
# 1  - Standard Parameter (Percentage)
# 2  - Extra Parameter
# 3  - Special Paramater
# 4  - Skills (WARNING, DIFFERENT SYNTAX!! See Skills on how to use them)
# 5  - Elemental Efficiency
# 6  - Debuff Rate
# 7  - State Rate
# 8  - State Resistance (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 9  - Attack Elements (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 10 - Attack States
# 11 - Equipment Types (WARNING, DIFFERENT SYNTAX!! See Equipment Types on how 
#                       to use them)
# 12 - Attack Specials
# 13 - Additional Skill Types (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 14 - Sealed Skill Types (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 15 - Sealed Skills (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 16 - Fixed Equip Types (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 17 - Sealed Equip Types (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 18 - Special Flags (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 19 - Party Abilities (WARNING, VALUE HAS A DIFFERENT FUNCTION!!)
# 20 - Other Traits
#
# Standard Parameters: (Sort 0)
# 0 - MaxHp
# 1 - MaxMp
# 2 - Attack
# 3 - Defense
# 4 - Magic Attack (Spirit)
# 5 - Magic Defence (Resistance)
# 6 - Agility
# 7 - Luck
#
# Standard Parameters (Percentage): (Sort 1)
# 0 - MaxHp
# 1 - MaxMp
# 2 - Attack
# 3 - Defense
# 4 - Magic Attack (Spirit)
# 5 - Magic Defence (Resistance)
# 6 - Agility
# 7 - Luck
# Note that stats are calculated this way:
# Basic + Equipment Bonuses + Set Bonuses (normal) + Set Bonuses (percentages,
# equal to bonus% (in [1, parameter, bonus]) * basic + equipment bonuses)
#
# Extra Parameters: (Sort 2)
# 0 - Hit Rate
# 1 - Evasion
# 2 - Critical Rate
# 3 - Critical Evasion
# 4 - Magical Evasion
# 5 - Magical Reflection
# 6 - Counter Rate
# 7 - HP Regen
# 8 - MP Regen
# 9 - TP Regen
#
# Special Parameters: (Sort 3)
# 0 - Target Rate/ Accuracy Rate(in Eng Translation Patch)/ Aggro Rate
# 1 - Guard Effect Rate
# 2 - Recovery Effect Rate
# 3 - Pharmacology/ Knowledge in Medicine(in Eng Translation Patch)
# 4 - MP Cost Rate
# 5 - TP Charge Rate
# 6 - Physical Damage Rate
# 7 - Magical Damage Rate
# 8 - Floor Damage Rate
# 9 - Experience Rate
#
# Skills: (Sort 4)
# These skills don't have parameter values. Instead, the last two elements in 
# their array have a different effect than usual:
# [sort (4), -----, skill_id]
# Sort = still the same and of course 4
# ----- = before this was Active, but that is no longer required. In order to
# by-pass the need to change this to skill_id (for people who had this script
# before v2.0), this variable has become unused instead of deleted all-together.
# You can put anything you want here, it doesn't even have to be an integer.
# Skill_Id = the id of the skill which the actor learns.
#
# Elemental Efficiency: (Sort 5)
# Values are the same as Element IDs in the database. (SO NO 0!!)
# If the bonus is negative, the actor becomes more resistant to the element.
# If the bonus is positive, the actor becomes weaker to the element.
#
# Debuff Rate: (Sort 6)
# 0 - MaxHp
# 1 - MaxMp
# 2 - Attack
# 3 - Defense
# 4 - Magic Attack (Spirit)
# 5 - Magic Defence (Resistance)
# 6 - Agility
# 7 - Luck
# If the bonus is negative, the actor becomes more resistant to debuffs regarding
# the set parameter.
# If the bonus is positive, the actor becomes weaker to debuffs regarding the set
# parameter.
# 
# State Rate: (Sort 7)
# Values are the same as the State IDs in the database (SO NO 0!!)
# If the bonus is negative, the actor becomes more resistant to the state.
# If the bonus is positive, the actor becomes weaker to the state.
#
# State Resist: (Sort 8)
# Values are the same as the State IDs in the database (SO NO 0!!)
# If the bonus is positive, the actor becomes fully resistant to the set state.
# However, if the bonus is negative, the actor LOSES full resistance to the set
# state!
#
# Attack Elements: (Sort 9)
# Values are the same as the Element IDs in the database (SO NO 0!!)
# If the bonus is positive, the element is added to the attack elements.
# However, if the bonus is negative, the element is REMOVED from the attack 
# elements!
#
# Attack States: (Sort 10)
# Values are the same as the State IDs in the database (SO NO 0!!)
# Bonus is the chance of the state to occur.
#
# Equipment Types: (Sort 11)
# 0 as parameter means that the bonus type is a Weapon Type.
# 1 as parameter means that the bonus type is a Weapon Type, but instead it will
# be REMOVED from the list of weapon types.
# 2 as parameter means that the bonus type is an Armor Type.
# 3 as parameter means that the bonus type is an Armor Type, but instead it will
# be REMOVED from the list of armor types.
# 4 as parameter allows Dual Wielding.
# Bonus is the same as the ID of the Equipment Types in the database.
# Note that removed types override added types. So you can first remove an
# equip type and afterwards add it, but you can first add it and then remove it.
#
# Attack Specials: (Sort 12)
# 0 - Attack Speed
# 1 - Additional Attacks
# Both in percentages. So for additional attacks, not 1 but 100.
#
# Additional Skill Types: (Sort 13)
# Values are the same as the Skill Types IDs in the database (SO NO 0!!)
# If the bonus is positive, the skill types is added.
# However, if the bonus is negative, the skill type is REMOVED!
#
# Sealed Skill Types: (Sort 14)
# Exact the same as above, only if the bonus is positive the type gets sealed,
# if the bonus is negative the type gets removed from the sealed types.
#
# Sealed Skills: (Sort 15)
# Again, exact the same as above. Only this time, replace the skill type id by
# the skill id.
#
# Fixed Equip Types: (Sort 16)
# Exact the same as Sealed Skill Types, only the equip types get fixed. Of course,
# replace skill type id by equip type id.
#
# Sealed Equip Types: (Sort 17)
# And yet again, exact the same only the equip types get sealed. Of course,
# replace skill type id by equip type id.
#
# Special Flags: (Sort 18)
# 0 - Auto Combat
# 1 - Guard
# 2 - Substitute/Cover
# 3 - Same TP in next battle
# For bonus, put a positive number (or 0) for added trait, and negative number
# for removed trait.
#
# Party Abilities: (Sort 19)
# 0 - Encounter cut down by half
# 1 - No encounters
# 2 - No suprise attacks
# 3 - Preemptive strike rate up
# 4 - Double currency from battles
# 5 - Double items from battles
# For bonus, put a positive number (or 0) for added trait, and negative number
# for removed trait.
#
# Others Traits: (Sort 20)
# 0 - Max TP up by bonus
# 1 - Atk Skill becomes bonus (skill ID) / So, if you have [20, 1, 10] the actor's
# attack skill becomes 10.
# 2 - Guard Skill becomes bonus (skill ID) / So, if you have [20, 2, 10] the 
# actor's guard skill becomes 10,
#----------------------------------------------------------------------------
# Credits to:
# Lettuce, if it wasn't for his RMVX Item Sets script, I would not have learned
# how Arrays and Hashes work.
# Many members at www.rpgmakervxace.net for pointing out various bugs and whatnot.
# You for reading through the wall of text ^^ (at least... I hope you did that..)
#----------------------------------------------------------------------------
# If you have any issues with this script, contact me at
# http://www.rpgmakervxace.net/index.php?/topic/1092-ees-emeralds-equipment-sets/
#============================================================================
#
# CONFIGURATION
#
#============================================================================

module EME
  
  MAX_ELEMENTS = 20

#----------------------------------------------------------------------------
# Sets syntax
#----------------------------------------------------------------------------
# Sets = {
#          set_id => [[equipment_type, equipment_id]]
#        }
#
# set_id must be bigger than 0
# equipment_type can be either 0 (weapon) or 1 (armor)
# Add a comma after a ']' if it's not the last element in the array/hash.
#
# Don't forget to add a ungettable item at the end! Else, the last item will
# count for two!
#----------------------------------------------------------------------------

Sets = {
         1 => [[1, 68], [1, 69], [1, 70]], #Sphinx Set
         2 => [[0, 63], [1, 64], [1, 65], [1, 66], [1, 67]], #DragonK
         3 => [[1, 160], [1, 161], [1, 162], [1, 163]], #Gossamer
         4 => [[1, 243], [1, 244], [0, 70]], #Medusa
         5 => [[0, 80], [1, 261]], #Galatea
         6 => [[0, 89], [1, 372]], #Hippo
         7 => [[0, 84], [1, 71], [1, 229]] #Nun
         }

#----------------------------------------------------------------------------
# Sets syntax
#----------------------------------------------------------------------------
# Set_Bonuses = {
#       set id => {
#         amount of pieces required => [[sort, parameter, bonus]], [sort, random parameter, 0]]
#                 }
#                }
#
# set_id must correspond to set_id of Sets
# amount of pieces required indicates how many pieces of the set the actor must
# be wearing before receiving the bonus. If you want to skip one, make the only
# element in it's array [0, 0, 0].
# sort indicates which kind of parameters the bonuses change. See SPECIAL VALUES
# for all sorts.
# parameter can be a value depending on sort. See SPECIAL VALUES in the 
# instructions for their corresponding stats.
# Bonus is a direct value added to 'parameter'. If 0, no bonus is added. If
# negative, bonus becomes negative.
# Random paramter is just a random parameter to prevent the last bonus from
# being doubled. Always make the bonus of this element 0.
#
# Add a comma after a ']' or '}' if it's not the last element in the array/hash.
#
# Don't forget to add a bonus of [0, 0, 0] at the end! Or else, the last bonus 
# will be doubled!
#----------------------------------------------------------------------------
Set_Bonuses =
{
  1 => {  #Sphinx Set
    3 => [[0, 3, 15],[0, 4, 5],[0, 5, 30],[0, 6, 10]]
       },
       
  2 => { #DragonK
    5 => [[0, 3, 30],[0, 4, 30],[0, 5, 30],[4,0,208]]
       },
       
   3 => { #Gossamer
    3 => [[0, 5, 10],[0, 6, 15],[0, 7, 20],[4,0,199]]
         },
         
   4 => { #Medusa
    3 => [[0, 2, 60],[0, 3, 10],[0, 5, 10]]
         },   
         
   5 => { #Galatea
    2 => [[0, 4, 30],[0, 5, 20]]
         },
         
   6 => { #Hippo
    2 => [[0, 0, 500]]
         },        
         
   7 => { #Nun
    2 => [[0, 1, 250],[0, 4, 30],[0, 5, 60],[0, 0, 0]]
         }
                   
 }

#-----------------------------------------------------------------------------
# Sets syntax
#-----------------------------------------------------------------------------
# Set_Sounds = {
#   set_id => {
#     amount_of_pieces_required => [file_name, volume, pitch]
#   }
# }
#
# Resembles the other two parts so I think not much of an explanation is needed.
# When the required amount of pieces has been equipped, the sound sound will be
# played. Doesn't apply for unequipping. Again, watch the comma's!!
#----------------------------------------------------------------------------
Set_Sounds =
{
  1 => {
    3 => ["Flash1", 100, 100] # <- comma here since it isn't the last one!
     },
     
  3 => {
    3 => ["Flash1", 100, 100] # <- comma here since it isn't the last one!
     }     
}

end

# Only edit things past here if you know what you're doing

$imported = {} if $imported.nil?
$imported["Emerald's Equipment Sets"] = true

#============================================================================
#
# Game_Actor
# Handles everything for this script.
#============================================================================
class Game_Actor < Game_Battler
  
  attr_reader :active_sets
  attr_reader :item_sets
  
  alias eme_ees_setup setup
  def setup(actor_id)
    @non_set_skills = []
    @skill_from_sets = false
    reset_bonuses
    @active_sets = []
    @item_sets = [0] * (EME::Sets.size + 1)
    eme_ees_setup(actor_id)
  end

  alias eme_init_equips init_equips
  def init_equips(equips)
    eme_init_equips(equips)
    equips.each_with_index{|item_id, i|
      etype_id = index_to_etype_id(i)
      slot_id = empty_slot(etype_id)
      for set_id in 1..EME::Sets.size
        for ees_set_equip in EME::Sets[set_id]
          if item_id != nil and slot_id != nil and ees_is_the_set_item?(etype_id == 0 ? $data_weapons[item_id] : $data_armors[item_id], ees_set_equip)
            @item_sets[set_id] += 1
            @active_sets.push(set_id) unless @active_sets.include?(set_id)
          end
        end
      end
    }
    refresh
  end
   
  def ees_is_the_set_item?(item, ees_set_equip)
    return (((ees_set_equip[0] == 0 and item.is_a?(RPG::Weapon)) or (ees_set_equip[0] == 1 and item.is_a?(RPG::Armor))) and ees_set_equip[1] == item.id)
  end

  alias eme_ees_learn_skill learn_skill
  def learn_skill(skill_id)
    eme_ees_learn_skill(skill_id)
    @non_set_skills.push(skill_id) unless @skill_from_sets
    @skill_from_sets = false
  end
 
  alias eme_ebs_change_equip change_equip
  def change_equip(slot_id, item)
      for set_id in 1..EME::Sets.size
        for ees_set_equip in EME::Sets[set_id]
          if slot_id != nil and @equips[slot_id] != nil and @equips[slot_id].object != nil
            if ees_is_the_set_item?(@equips[slot_id].object, ees_set_equip)
              if @item_sets[set_id].nil?
               @item_sets = [0] * (EME::Sets.size + 1)
              end              
              @item_sets[set_id] -= 1
              @active_sets.delete(set_id) if @item_sets[set_id] == 0
            end
          end
          if item != nil and ees_is_the_set_item?(item, ees_set_equip)
            if @item_sets[set_id].nil?
             @item_sets = [0] * (EME::Sets.size + 1)
            end
            @item_sets[set_id] += 1
            @active_sets.push(set_id) unless @active_sets.include?(set_id)
            if EME::Set_Sounds.has_key?(set_id) and EME::Set_Sounds[set_id].has_key?(set_amount_wearing(set_id))
              sound = EME::Set_Sounds[set_id][set_amount_wearing(set_id)]
              Audio.se_play("Audio/SE/" + sound[0], sound[1], sound[2]) 
            end
          end
        end
      end
    set_check
    eme_ebs_change_equip(slot_id, item)
  end

  def unlearn_set_skills(set_id)
    EME::Set_Bonuses[set_id].each_value{|bonus_array|
      bonus_array.each{|bonus| 
        if bonus[0] == 4
          forget_skill(bonus[2]) unless @non_set_skills.include?(bonus[2])
          @ees_skills.delete(bonus[2])
        end
      }
    }
  end
  
  def item_set_reset_all
    @active_sets.each{|set_id| item_set_reset(set_id)}
  end
  
  def item_set_reset(set_id)
    return unless set_id > 0 and @item_sets[set_id] > 0
    unlearn_set_skills(set_id)
  end
  
  #def release_unequippable_items(item_gain = true)
  #  @equips.each_with_index do |item, i|
  #    if !equippable?(item.object) || item.object.etype_id != equip_slots[i]
  #      trade_item_with_party(nil, item.object) if item_gain
  #    item.object = nil
  #   end
  # end
  # end

  def release_unequippable_items(item_gain = true)
    loop do
      change_equips = 0
      @equips.each_with_index do |item, i|
        unless i >= 6
        if !equippable?(item.object) or item.object.etype_id != equip_slots[i]
          next if (RPG::Weapon.method_defined?(:two_handed?) and dual_wield? and (equip_slots[i] == 1 and item.object.etype_id == 0))
          trade_item_with_party(nil, item.object) if item_gain
          change_equips += 1 unless item.object.nil?
          unless item.object.nil?
          for set_id in 1..EME::Sets.size
            for ees_set_equip in EME::Sets[set_id]
              if ees_is_the_set_item?(item.object, ees_set_equip)
                if @item_sets[set_id].nil?
                  @item_sets = [0] * (EME::Sets.size + 1)
                end                
                @item_sets[set_id] -= 1
                @active_sets.delete(set_id) if @item_sets[set_id] == 0
              end
            end
          end
          end
          item.object = nil
        end
      end
      end #unless i >= 6
      set_check
      break if change_equips == 0
    end
  end

  alias eme_ebs_discard_equip discard_equip
  def discard_equip(item)
    slot_id = equips.index(item)
    if slot_id != nil
      for set_id in 1..EME::Sets.size
        for ees_set_equip in EME::Sets[set_id]
          if ees_is_the_set_item?(item, ees_set_equip)
            if @item_sets[set_id].nil?
             @item_sets = [0] * (EME::Sets.size + 1)
            end             
            @item_sets[set_id] -= 1
            @active_sets.delete(set_id) if @item_sets[set_id] == 0
          end
        end
      end
    end
    eme_ebs_discard_equip(item)
    refresh
  end
  
  def set_amount_wearing(set_id)
    return @item_sets[set_id]
  end

  def set_check
    item_set_reset_all
    reset_bonuses
    @active_sets.each{|set| change_bonuses(set) unless set == nil}
  end
  
  def change_bonuses(set_id)
    return if set_id == 0 or set_amount_wearing(set_id) == 0
    EME::Set_Bonuses[set_id].each_key{|key|
      if set_amount_wearing(set_id) >= key
        for g in 0...EME::Set_Bonuses[set_id][key].size
          sort = EME::Set_Bonuses[set_id][key][g][0]
          stat = EME::Set_Bonuses[set_id][key][g][1]
          stat_bonus = EME::Set_Bonuses[set_id][key][g][2]
          case EME::Set_Bonuses[set_id][key][g][0]
          when 0
            sets_param_change(stat, stat_bonus)
          when 1
            sets_per_param_change(stat, stat_bonus)
          when 2
            sets_xparam_change(stat, stat_bonus)
          when 3
            sets_sparam_change(stat, stat_bonus)
          when 4
            next if skill_learn?(stat_bonus)
            @skill_from_sets = true
            learn_skill(stat_bonus) 
            @ees_skills.push(stat_bonus)
          when 5
            stat -= 1
            sets_element_rate_change(stat, stat_bonus)
          when 6
            stat -= 1
            sets_debuff_rate_change(stat, stat_bonus)
          when 7
            stat -= 1
            sets_state_rate_change(stat, stat_bonus)
          when 8
            sets_state_resist_change(stat, stat_bonus)
          when 9
            sets_atk_elements_change(stat, stat_bonus)
          when 10
            sets_atk_states_change(stat) if stat_bonus > 0
            sets_atk_states_rate_change(stat, stat_bonus)
          when 11
            if stat < 2
              change_sets_additional_wtypes(stat_bonus, (stat == 0 ? true : false))
            elsif stat < 4
              change_sets_additional_atypes(stat_bonus, (stat == 2))
            elsif stat == 4
              @eme_ebs_two_swords_style = true
            end
          when 12
            sets_atk_specials_change(stat, stat_bonus)
          when 13
            add_sets_skill_types(stat, stat_bonus)
          when 14
            add_sets_sealed_skill_types(stat, stat_bonus)
          when 15
            add_sets_sealed_skills(stat, stat_bonus)
          when 16
            add_sets_fixed_equip_types(stat, stat_bonus)
          when 17
            add_sets_sealed_equip_types(stat, stat_bonus)
          when 18
            stat_bonus < 0 ? change_special_flags(stat, true) : change_special_flags(stat)
          when 19
            stat_bonus < 0 ? change_party_abilities(stat, true) : change_party_abilities(stat)
          when 20
            case stat
            when 0
              set_bonus_max_tp(stat_bonus)
            when 1
              set_atk_skill(stat_bonus)
            when 2
              set_grd_skill(stat_bonus)
            end
          end
        end
      end
    }
  end

#-------------------------------------------#
# LABEL FOR AUTHOR                          #
# Don't mind this ;)                        #
#-------------------------------------------#

  def reset_bonuses
    @sets_param_plus = [0] * 8
    @sets_per_param_plus = [0] * 8
    @sets_xparam_plus = [0] * 10
    @sets_sparam_plus = [0] * 10
    @sets_element_rate = [0] * (EME::MAX_ELEMENTS)
    @sets_debuff_rate = [0] * 8
    @sets_state_rate = [0] * ($data_states.size + 1)
    @sets_state_resist = []
    @sets_state_resist_remove = []
    @sets_atk_elements = []
    @sets_atk_elements_remove = []
    @sets_atk_states = []
    @sets_atk_states_rate = [0] * $data_states.size
    @sets_atk_speed_plus = 0
    @sets_atk_times_plus = 0
    @sets_skill_types = []
    @sets_skill_types_remove = []
    @sets_sealed_skill_types = []
    @sets_sealed_skill_types_remove = []
    @sets_sealed_skills = []
    @sets_sealed_skills_remove = []
    @sets_fixed_equip_types = []
    @sets_fixed_equip_types_remove = []
    @sets_sealed_equip_types = []
    @sets_sealed_equip_types_remove = []
    
    @ees_added_special_flags = []
    @ees_removed_special_flags = []
    @ees_added_party_abilities = []
    @ees_removed_party_abilities = []
    @ees_bonus_max_tp = 0
    @new_atk_skill = nil
    @new_grd_skill = nil
    
    @ees_skills = []
    @sets_wtypes = []
    @sets_atypes = []
    @sets_removed_wtypes = []
    @sets_removed_atypes = []
    @eme_ebs_two_swords_style = false
  end

  def sets_param_plus(param_id)
    @sets_param_plus[param_id]
  end

  def sets_param_change(param_id, value)
    @sets_param_plus[param_id] += value
  end
 
  def sets_per_param_plus(param_id)
    value = param_base(param_id) + param_plus(param_id)
    value *= @sets_per_param_plus[param_id] / 100
    return value
  end

  def sets_per_param_change(param_id, value)
    @sets_per_param_plus[param_id] += value
  end
  
  def sets_xparam_plus(param_id)
    @sets_xparam_plus[param_id]
  end

  def sets_xparam_change(param_id, value)
    @sets_xparam_plus[param_id] += value
  end

  def sets_sparam_plus(param_id)
    @sets_sparam_plus[param_id]
  end
  
  def sets_sparam_change(param_id, value)
    @sets_sparam_plus[param_id] += value
  end
  
  def sets_element_rate(element_id)
    @sets_element_rate[element_id]
  end
  
  def sets_element_rate_change(element_id, value)
    @sets_element_rate[element_id] += value
  end
  
  def sets_debuff_rate(param_id)
    @sets_debuff_rate[param_id]
  end

  def sets_debuff_rate_change(param_id, value)
    @sets_debuff_rate[param_id] += value
  end
  
  def sets_state_rate(state_id)
    @sets_state_rate[state_id]
  end

  def sets_state_rate_change(state_id, value)
    @sets_state_rate[state_id] += value
  end
  
  def sets_state_resist(state_id)
    @sets_state_resist[state_id]
  end
  
  def sets_state_resist_remove(state_id)
    @sets_state_resist_remove[state_id]
  end
  
  def sets_state_resist_change(state_id, value)
    value >= 0 ? (@sets_state_resist.push(state_id) unless @sets_state_resist.include?(state_id)) : (@sets_state_resist_remove.delete(state_id) unless @sets_state_resist_remove.include?(state_id))
  end
  
  def sets_atk_elements(element_id)
    @sets_atk_elements[element_id]
  end
  
  def sets_atk_elements_remove(element_id)
    @sets_atk_elements_remove[element_id]
  end

  def sets_atk_elements_change(element_id, value)
    value >= 0 ? (@sets_atk_elements.push(element_id) unless @sets_atk_elements.include?(element_id)) : (@sets_attack_elements_remove.delete(element_id) unless @sets_atk_elements_remove.include?(element_id))
  end
  
  def sets_atk_states(state_id)
    @sets_atk_states[state_id]
  end

  def sets_atk_states_change(state_id)
    @sets_atk_states.push(state_id) unless @sets_atk_states.include?(state_id)
  end
  
  def sets_atk_states_rate(state_id)
    @sets_atk_states_rate[state_id]
  end

  def sets_atk_states_rate_change(state_id, value)
    @sets_atk_states_rate[state_id] += value
  end
  
  def sets_atk_speed_plus
    @sets_atk_speed_plus
  end

  def sets_atk_times_plus
    @sets_atk_times_plus
  end
  
  def sets_atk_specials_change(parameter, value)
    parameter == 0 ? @sets_atk_speed_plus += value : @sets_atk_times_plus += value
  end 
    
  def sets_skill_types(skill_type_id)
    @sets_skill_types[skill_type_id]
  end
  
  def sets_skill_types_remove(skill_type_id)
    @sets_skill_types_remove[skill_type_id]
  end

  def add_sets_skill_types(skill_type_id, value)
    value >= 0 ? (@sets_skill_types.push(skill_type_id) unless @sets_skill_types.include?(skill_type_id)) : (@sets_skill_types_remove.delete(skill_type_id) unless @sets_skill_types_remove.include?(skill_type_id))
  end
  
  def sets_sealed_skill_types(skill_type_id)
    @sets_sealed_skill_types[skill_type_id]
  end
  
  def sets_sealed_skill_types_remove(skill_type_id)
    @sets_sealed_skill_types_remove[skill_type_id]
  end

  def add_sealed_skill_types(skill_type_id, value)
    value >= 0 ? (@sets_sealed_skill_types.push(skill_type_id) unless @sets_sealed_skill_types.include?(skill_type_id)) : (@sets_sealed_skill_types_remove.delete(skill_type_id) unless @sets_sealed_skill_types_remove.include?(skill_type_id))
  end
  
  def sets_sealed_skills(skill_id)
    @sets_sealed_skills[skill_id]
  end
  
  def sets_sealed_skills_remove(skill_id)
    @sets_sealed_skills_remove[skill_id]
  end

  def add_sets_sealed_skills(skill_id, value)
    value > 0 ? (@sets_sealed_skills.push(skill_id) unless @sets_sealed_skills.include?(skill_id)) : (@sets_attack_elements_remove.delete(skill_id) unless @sets_sealed_skills_remove.include?(skill_id))
  end
  
  def sets_additional_wtypes
    @sets_wtypes
  end
  
  def sets_additional_atypes
    @sets_atypes
  end
  
  def sets_removed_wtypes
    @sets_removed_wtypes
  end
  
  def sets_removed_atypes
    @sets_removed_atypes
  end
  
  def change_sets_additional_wtypes(wtype_id, positive_change = true)
    positive_change ? @sets_wtypes.push(wtype_id) : @sets_removed_wtypes.push(wtype_id)
  end
  
  def change_sets_additional_atypes(atype_id, positive_change = true)
    positive_change ? @sets_atypes.push(atype_id) : @sets_removed_atypes.push(atype_id)
  end
  
  def sets_fixed_equip_types(equip_type_id)
    @sets_fixed_equip_types[equip_type_id]
  end
  
  def sets_fixed_equip_types_remove(equip_type_id)
    @sets_fixed_equip_types_remove[equip_type_id]
  end

  def add_fixed_equip_types(equip_type_id, value)
    value >= 0 ? @sets_fixed_equip_types.push(equip_type_id) : @sets_fixed_equip_types_remove.delete(sequip_type_id)
  end
  
  def sets_sealed_equip_types(equip_type_id)
    @sets_sealed_equip_types[equip_type_id]
  end
  
  def sets_sealed_equip_types_remove(equip_type_id)
    @sets_sealed_equip_types_remove[equip_type_id]
  end

  def add_sealed_equip_types(equip_type_id, value)
    value > 0 ? (@sets_sealed_equip_types.push(equip_type_id) unless @sets_sealed_equip_types.include?(equip_type_id)) : (@sets_sealed_equip_types_remove.delete(equip_type_id) unless @sets_sealed_equip_types_remove.include?(equip_type_id))
  end
  
  def change_special_flags(flag_id, negative = false)
    !negative ? @ees_added_special_flags.push(flag_id) : @ees_removed_special_flags.push(flag_id)
  end
  
  def change_party_abilities(ability_id, negative = false)
    !negative ? @ees_added_party_abilities.push(ability_id) : @ees_removed_party_abilities.push(ability_id)
  end
  
  def set_bonus_max_tp(value)
    @ees_bonus_max_tp += value
  end
  
  def set_atk_skill(skill_id)
    @new_atk_skill = skill_id
  end
  
  def set_grd_skill(skill_id)
    @new_grd_skill = skill_id
  end
  
#-------------------------------------------#
# 'NOTHER LABEL FOR AUTHOR                  #
# Don't mind this ;)                        #
#-------------------------------------------#

  def param(param_id)
    value = param_base(param_id) + param_plus(param_id) + sets_param_plus(param_id) #+ [sets_per_param_plus(param_id), 0].max
    value *= param_rate(param_id) * param_buff_rate(param_id)
    [[value, param_max(param_id)].min, param_min(param_id)].max.to_i
  end 
  
  alias eme_ebs_xparam xparam
  def xparam(xparam_id)
    value = eme_ebs_xparam(xparam_id) + sets_xparam_plus(xparam_id) / 100
    return value
  end
  
  alias eme_ebs_sparam sparam
  def sparam(sparam_id)
    value = eme_ebs_sparam(sparam_id) + sets_sparam_plus(sparam_id) / 100
    return value
  end
  
  alias eme_ebs_element_rate element_rate
  def element_rate(element_id)
    value = eme_ebs_element_rate(element_id) + sets_element_rate(element_id) / 100
    return value
  end
  
  alias eme_ebs_debuff_rate debuff_rate
  def debuff_rate(param_id)
    value = eme_ebs_debuff_rate(param_id) + sets_debuff_rate(param_id) / 100
    return value
  end

  alias eme_ebs_state_rate state_rate
  def state_rate(state_id)
    value = eme_ebs_state_rate(state_id) + sets_state_rate(state_id) / 100
    return value
  end

  alias eme_ebs_state_resist_set state_resist_set
  def state_resist_set
    value = eme_ebs_state_resist_set
    @sets_state_resist.each{|state| value.push(state) unless value.include?(element)}
    @sets_state_resist_remove.each{|state| value.delete(state)}
    return value
  end
  
  alias eme_ebs_atk_elements atk_elements
  def atk_elements
    value = eme_ebs_atk_elements
    @sets_atk_elements.each{|element| value.push(element) unless value.include?(element)}
    @sets_atk_elements_remove.each{|element| value.delete(element)}
    return value
  end
  
  alias eme_ebs_atk_states atk_states
  def atk_states
    value = eme_ebs_atk_states
    @sets_atk_states.each{|state| value.push(@sets_atk_states[i]) }
    return value
  end
  
  alias eme_ebs_atk_states_rate atk_states_rate
  def atk_states_rate(state_id)
    value = eme_ebs_atk_states_rate(state_id) + sets_atk_states_rate(state_id) / 100
    return value
  end
  
  alias eme_ebs_atk_speed atk_speed
  def atk_speed
    value = eme_ebs_atk_speed + sets_atk_speed_plus / 100
    return value
  end

  alias eme_ebs_atk_times atk_times_add
  def atk_times_add
    value = [eme_ebs_atk_times + sets_atk_times_plus / 100, 0].max
    return value
  end

  alias eme_ebs_dual_wield? dual_wield?
  def dual_wield?
    return true if @eme_ebs_two_swords_style
    eme_ebs_dual_wield?
  end
  
  alias eme_ebs_added_skill_types added_skill_types
  def added_skill_types
    value = eme_ebs_added_skill_types
    @sets_skill_types.each{|sk_type| value.push(sk_type)}
    @sets_skill_types_remove.each{|sk_type| value.delete(sk_type)}
    return value
  end
  
  def skill_type_sealed?(stype_id)
    value = features_set(FEATURE_STYPE_SEAL)
    @sets_sealed_skill_types.each{|sk_type| value.push(sk_type)}
    @sets_sealed_skill_types_remove.each{|sk_type| value.delete(sk_type)}
    return true if value.include?(stype_id)
  end

  def skill_sealed?(skill_id)
    value = features_set(FEATURE_SKILL_SEAL)
    @sets_sealed_skills.each{|skill| value.push(skill)}
    @sets_sealed_skills_remove.each{|skill| value.delete(skill)}
    return true if value.include?(skill_id)
  end
  
  def equip_wtype_ok?(wtype_id)
    value = features_set(FEATURE_EQUIP_WTYPE)
    @sets_wtypes.each{|w_type| value.push(w_type)}
    @sets_removed_wtypes.each{|w_type| value.delete(w_type)}
    return true if value.include?(wtype_id)
  end

  def equip_atype_ok?(atype_id)
    value = features_set(FEATURE_EQUIP_ATYPE)
    @sets_atypes.each{|a_type| value.push(a_type)}
    @sets_removed_atypes.each{|a_type| value.delete(a_type)}
    return true if value.include?(atype_id)
  end

  def equip_type_fixed?(etype_id)
    value = features_set(FEATURE_EQUIP_FIX)
    @sets_fixed_equip_types.each{|e_type| value.push(e_type)}
    @sets_fixed_equip_types_remove.each{|e_type| value.delete(e_type)}
    return true if value.include?(etype_id)
  end
  
  def equip_type_sealed?(etype_id)
    value = features_set(FEATURE_EQUIP_SEAL)
    @sets_sealed_equip_types.each{|e_type| value.push(e_type)}
    @sets_sealed_equip_types_remove.each{|e_type| value.delete(e_type)}
    return true if value.include?(etype_id)
  end
  
  alias eme_ees_special_flag special_flag
  def special_flag(flag_id)
    return false if @ees_removed_special_flags.include?(flag_id)
    return @ees_added_special_flags.include?(flag_id) ? true : eme_ees_special_flag(flag_id)
  end
  
  alias eme_ees_party_ability party_ability
  def party_ability(ability_id)
    return false if @ees_removed_party_abilities.include?(ability_id)
    return @ees_added_party_abilities.include?(ability_id) ? true : eme_ees_party_ability(ability_id)
  end
  
  alias eme_ees_max_tp max_tp
  def max_tp
    return eme_ees_max_tp + @ees_bonus_max_tp
  end
  
  alias eme_ees_attack_skill attack_skill_id
  def attack_skill_id
    return @new_atk_skill unless @new_atk_skill == nil
    return eme_ees_attack_skill
  end

  alias eme_ees_guard_skill guard_skill_id
  def guard_skill_id
    return @new_grd_skill unless @new_grd_skill == nil
    return eme_ees_guard_skill
  end

end