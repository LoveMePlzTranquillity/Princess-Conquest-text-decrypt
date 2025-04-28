if true
  $D13x={}if$D13x==nil
  $D13x[:Common_Ev_Keys]=true
  module CMN_Ev_Keys
    Trigger_While_Move = true
    Triggers=[
    # [ :ID , Event , switch , show?, x  , y   , icon , hue]
      [ :Q  ,    420  ,    23   , true , 184, 2   , 114  , 0  ],
      [ :q  ,    420  ,    23   , true , 184, 2   , 114  , 0  ],      
      [ :N  ,    354  ,    2479   , true , 184, 2   , 114  , 0  ],
      [ :n  ,    354  ,    2479   , true , 184, 2   , 114  , 0  ],  
      [ :B  ,    827  ,    2765   , true , 184, 2   , 114  , 0  ],
      [ :b  ,    827  ,    2765   , true , 184, 2   , 114  , 0  ],       
      [ :C  ,    38  ,    413   , true , 184, 2   , 114  , 0  ],
      [ :c  ,    38  ,    413   , true , 184, 2   , 114  , 0  ],
      [ :K ,    40 ,    0   , true , 210, 2   , 4    , 0  ],
      [ :k ,    40 ,    0   , true , 210, 2   , 4    , 0  ],
      [ :ESC ,    42  ,    579   , true , 210, 2   , 4    , 0  ],
    ]
  end
  module CMN_Ev_Keys
    def update_cmn_ev_keys          
    return unless !$game_map.interpreter.running?
    return if $game_player.moving? unless Trigger_While_Move
    Triggers.each do |block|
      next if (block[2] != 0) && (!$game_switches[block[2]])
      if (Keys.trigger?(Keys::Key[block[0]])) && (block[1] != 0)
        $game_temp.reserve_common_event( block[1] )        
      end
    #CONTROLLER CHECK
  if WolfPad.plugged_in?(0) || WolfPad.plugged_in?(1) || WolfPad.plugged_in?  
    if $game_switches[1320] == false
     $game_switches[1320] = true   
    end  
  else
    if $game_switches[1320] == true
    $game_switches[1320] = false
    end      
  end          
    #CAMPSITE#
    if $game_switches[413] == true
     camp = 0
    if WolfPad.trigger?(:R1,0) || WolfPad.trigger?(:R1,1)
     camp = 1 
    end
    if camp == 1
      $game_temp.reserve_common_event(38)
    end  
  end
    #CONFIRM#  
    #if WolfPad.press?(:X)
    # $game_temp.reserve_common_event(226)
    #end
    #MENU SCREEN#
    if WolfPad.trigger?(:START,0) || WolfPad.trigger?(:START,1)
     $game_temp.reserve_common_event(41)
    end    
    #STATUS SCREEN#
    menu = 0
    if WolfPad.trigger?(:SELECT,0) || WolfPad.trigger?(:SELECT,1)
     menu = 1      
    end
    if menu == 1
      $game_temp.reserve_common_event(40)
    end  
    #SWAP#
    swap = 0
    if (Keys.trigger?(:TAB))
     swap = 1      
    elsif WolfPad.trigger?(:L1,0) || WolfPad.trigger?(:L1,1) 
     swap = 1     
   end
    if swap == 1 && $game_switches[500] == false && $game_switches[2569] == false
      $game_switches[500] = true
      $game_temp.reserve_common_event(45)
      dispel = 1
    end      
###############
press = 0
rel = 0
trig = 0  
skill = 0
dash = 0
dashR = 0
succ = 0
dispel = 0 
#DASH
if (Keys.press?(:LSHIFT))
  dash = 1
elsif WolfPad.trigger?(:A,0) || WolfPad.trigger?(:A,1)  
  dash = 1
end  
if (Keys.release?(:LSHIFT))
  dashR = 1
end  
#SKILL
if (Keys.trigger?(:S))
  skill = 1
elsif WolfPad.trigger?(:R1,0) || WolfPad.trigger?(:R1,1) 
  skill = 1
end 
#TRIGGER
if (Keys.trigger?(:L_CTRL))
  trig = 1
elsif WolfPad.trigger?(:Y,0) || WolfPad.trigger?(:Y,1) 
  trig = 1
end  
#PRESS
if (Keys.press?(:L_CTRL))
  press = 1
elsif WolfPad.press?(:Y,0) || WolfPad.press?(:Y,1)
  press = 1
end  
if $game_party.leader.state?(204) == true #incapacitated
 if trig == 1
  RPG::SE.new("Cancel1", 100, 100).play
 $game_map.show_text($game_player,"Incapacitated!")
 press = 0
 trig = 0
 skill = 0
 elsif [press,skill].max == 1
 press = 0
 trig = 0
 skill = 0
 end
end
#RELEASE
if (Keys.release?(:L_CTRL))
  rel = 1
end  
if $game_party.leader.class_id == 28 || $game_party.leader.class_id == 72 || $game_party.leader.class_id == 201
  succ = 1
end 
#Samba!
 if $game_party.members[0].equips[4] == $data_armors[258] && succ == 0
  if trig == 1
    dispel = 1
    if $game_switches[739] 
          $game_temp.reserve_common_event(106)
    end
  end
elsif $game_party.leader.id == 21 || succ == 1 #Moth Dust
      if trig == 1      
      dispel = 1
      if $game_switches[739]
         $game_temp.reserve_common_event(164)
      end
   end
end  
#Dragons fly
        fly = 0
        lead = $game_party.leader.id
        if $game_party.leader.class_id >= 115 && $game_party.leader.class_id <= 117
          fly = 1 
        elsif $game_party.leader.class_id >= 149 && $game_party.leader.class_id <= 155
            fly = 1
        elsif $game_party.leader.class_id == 38 && $game_switches[4592] == false #birdNofin
            fly = 1           
        elsif $game_party.leader.class_id == 32 && $game_switches[4593] == true #finBirdV
            fly = 1                       
        elsif $game_party.leader.class_id == 30 #wyv
            fly = 1                 
        elsif $game_party.leader.id == 11 || $game_party.leader.id == 18 || $game_party.leader.id == 41
            fly = 1
        elsif $game_party.leader.class_id >= 137 && $game_party.leader.class_id <= 141 #fairies
            fly = 1
        elsif $game_party.leader.class_id == 164 #idol
            fly = 1    
        elsif $game_party.leader.class_id == 182 && $game_switches[497] == true #pruszka
            fly = 1                  
         elsif $game_actors[lead].equips[5] == $data_armors[253] || $game_actors[lead].equips[5] == $data_armors[480]
              fly = 1
         elsif $game_switches[2445] == true && $game_party.leader.id == 7 #bubble slime
                fly = 1
         elsif $game_party.leader.class_id == 28 && $game_switches[413] == true #succubi at night
              fly = 1      
         elsif $game_party.leader.class_id == 72 && $game_switches[413] == true #succubi at night
              fly = 1         
         elsif $game_party.leader.class_id == 201 && $game_switches[413] == true #onyxxx at night
              fly = 1   
         elsif $game_party.leader.class_id == 202 #feather
              fly = 1                
            end
        if $game_switches[3435] == true || $game_switches[1770] == true
           fly = 0
         end  
        if fly == 1 && $game_switches[7333] == false
          if $game_map.map_id == 2 || $game_map.map_id == 70 || $game_map.map_id == 319 || $game_map.map_id == 271 || $game_map.map_id == 343 || $game_map.map_id == 344
            if press == 1
              dispel = 1
              if $game_switches[500] == false && $game_switches[3433] == false && $game_switches[3434] == false  && $game_switches[3435] == false && $game_switches[3438] == false && $game_switches[3451] == false && $game_switches[3825] == false && $game_switches[3826] == false && $game_switches[4638] == false
                #return if $game_map.map_id == 343 && $game_player.region_id != 1 && $game_player.region_id != 3 #return if in WM water
                $game_switches[500] = true #fly/swap command
                $game_temp.reserve_common_event(858)
              end
              elsif $game_switches[500] == false && $game_switches[3433] == true && $game_switches[3434] == false && $game_switches[3435] == false && $game_switches[3438] == false && $game_switches[3451] == false && $game_switches[4638] == false && $game_player.region_id != 60 && $game_player.region_id != 61 && $game_player.region_id != 62
                    dispel = 1   
                    $game_switches[500] = true #fly/swap command
                    $game_temp.reserve_common_event(859)
                  end
              end
          end     
if $game_party.members[0].equips[4] != $data_armors[258] #maracas stop everything        
if succ == 0    
#Skeleton Fear
    if $game_party.leader.id == 9 && $game_actors[9].equips[5] == $data_armors[183] #skeleton fear
    if trig == 1
        dispel = 1
         if $game_switches[739] 
          $game_temp.reserve_common_event(98)
        end
      end
      end
#Ghost/Scarecrow fear 
    if $game_party.leader.id == 12 || $game_party.leader.class_id == 122 #Ghost/Scarecrow fear 
    if trig == 1
        dispel = 1
         if $game_switches[739] 
          $game_temp.reserve_common_event(98)
        end
      end
    end    
#SyphonLife Skill    
    if $game_variables[116] == "SyphonLife" && $game_switches[1909] == false && $game_switches[739] == true
      if trig == 1
        dispel = 1
      $game_temp.reserve_common_event(971)
      end
    end      
#Charge! Skill    
    if $game_variables[116] == "Charge!" && $game_switches[7461] == false && $game_switches[739] == true
      if trig == 1
        dispel = 1
      $game_temp.reserve_common_event(971)
      end
    end  
#Charge! Skill    
    if $game_variables[116] == "Bomber" && $game_switches[786] == false && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_switches[786] = true
      $game_temp.reserve_common_event(971)
      end
    end  
#Oni Stomp
    if $game_party.leader.id == 54 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end        
#Oni Stomp
    if $game_party.leader.id == 57 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end          
#Mer Wave 
    if $game_party.leader.id == 48 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end    
#Gun Gob   
    if $game_party.leader.id == 14 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end 
#Harvest Skills  
    if $game_party.leader.id == 32 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end         
#Wyv Skills  
    if $game_party.leader.id == 41 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end      
#Mech Wep Mou  
    if $game_party.leader.id == 26 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end     
#Dance Des  
    if $game_party.leader.id == 4 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end       
#XZap Gol  
    if $game_party.leader.id == 6 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end        
#Hammer Rab    
    if $game_party.leader.id == 30 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end     
#Orca    
    if $game_variables[116] == "PlayfulKiller" && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_variables[116] = "HungryKiller"
        $game_temp.reserve_common_event(971)
      end
    end         
#Bloo Sonar / Gaita charge / Sala Twister / Monkey BANANA / Spritz Blink / CHARGE!! Skill
    if trig == 1
     #TasBOT
    if $game_party.leader.class_id == 191 && $game_switches[739] == true && $game_switches[1739] == false
    $game_switches[1739] = true #no swap
    $game_temp.reserve_common_event(971)
    end       
    if $game_party.leader.class_id == 192 && $game_switches[739] == true && $game_variables[3010] < 3
    $game_temp.reserve_common_event(971)
    end         
    @classS = [166,167,173,174,177,179,180,182,183,184,190,181,207,213,215]
    @classSswF = [7460,7461,7463,7465,8,490,0,0,7477,0,7496,7498,0,7511,7517]
    @classSswT = [0,0,0,0,0,0,0,0,0,7481,0,0,0,0,0]    
    if $game_switches[739] == true
    if @classS.include?$game_party.leader.class_id
      @i = 0
      while @i < @classS.length
        if @classS[@i] == $game_party.leader.class_id
          break
        else  
        @i += 1
        end
      end              
      @swF = @classSswF[@i]
      @swT = @classSswT[@i]
      okSk = 0      
      if @classSswF[@i] != 0
        if $game_switches[@swF] == false
        $game_switches[@swF] = true
        okSk = 1
        end
      elsif @classSswT[@i] != 0
        if $game_switches[@swT] == true
        $game_switches[@swT] = false
        okSk = 1
        end
      elsif @classS[@i] == 180 || @classS[@i] == 182 || @classS[@i] == 207
        okSk = 1
      end  
     if okSk == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
     end      
   end
 end
 end
#Amelie Rush
    if $game_party.leader.class_id == 18 
    if trig == 1
        dispel = 1
         if $game_switches[739] == true && $game_switches[3786] == false && $game_switches[1075] == false
          $game_temp.reserve_common_event(971)
        end
      end
    end 
#Fin Skewer
    if $game_party.leader.id == 46 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end
#Bir Fin Form Skewer
    if $game_party.leader.id == 53 && $game_switches[739] == true
      if trig == 1
        dispel = 1
        $game_temp.reserve_common_event(971)
      end
    end    
#404B    
if $game_party.leader.class_id == 163   
  @stop = 1
  $game_switches[2723] = true
#Crystal Crash
elsif $game_party.leader.class_id == 120 
  @stop = 1
  $game_switches[2723] = true
   if press == 1
        dispel = 1
    if $game_switches[739] && !$game_switches[3694]
      $game_switches[3694] = true
      $game_temp.reserve_common_event(955)
    end  
  else
    $game_switches[3694] = false
    end
else
  @stopch = @stop rescue -1
  if @stopch == 1
   $game_switches[2723] = false
  end
 end
#Slime puddle     
   if $game_party.leader.id == 7 
   if press == 1
        dispel = 1
     if $game_switches[739] && !$game_switches[892] && !$game_switches[893]
       $game_switches[893] = true
     $game_temp.reserve_common_event(82)
     end
   elsif $game_switches[893]
     $game_switches[893] = false
           $game_temp.reserve_common_event(83)
     end
   end
#Plant puddle     
   if $game_party.leader.id == 56
   if press == 1
        dispel = 1
     if $game_switches[739] && $game_switches[3600] == false
     $game_temp.reserve_common_event(82)
     end
      elsif $game_switches[3600]
           $game_temp.reserve_common_event(83)
     end
   end   
 #Wendigo 
    if $game_party.leader.class_id == 156 
    if trig == 1
        dispel = 1
         if $game_switches[739] == true && $game_switches[4450] == false && $game_variables[4134] >= 3
          $game_temp.reserve_common_event(138)
        end
      end
    end  
 #Eldritch 
    if $game_party.leader.class_id == 157 
    if trig == 1
        dispel = 1
         if $game_switches[739] == true && $game_switches[3786] == false && $game_switches[3787] == false && $game_switches[4564] == false
           $game_switches[4564] = true
          $game_temp.reserve_common_event(161)
        end
      end
      end  
 #Moss    
if $game_party.leader.class_id == 119
  if $game_switches[739] == true 
  if press == 1
        dispel = 1
     if $game_switches[739] && !$game_switches[3559]
     $game_temp.reserve_common_event(880)
     end
     elsif $game_switches[3559] == true
        dispel = 1 
             $game_temp.reserve_common_event(881)
          end
      end             
   end
#Mimic / Vashti   
@sneak = 0
if $game_party.leader.class_id == 123 || $game_party.leader.class_id == 176 || $game_variables[116] == "SneakATK"
@sneak = 1
elsif $game_actors[8].state?(29) == false && $game_party.leader.class_id == 9 #Std InsP
@sneak = 1
end
if @sneak == 1
  if $game_switches[739] == true 
  if press == 1
        dispel = 1
     if $game_switches[739] && !$game_switches[3865] && !$game_switches[73] && !$game_switches[3600]
       $game_switches[3600] = true
       $game_temp.reserve_common_event(935)
     end
     elsif $game_switches[3865] == true || $game_switches[73] == true && $game_switches[3600] == true
        dispel = 1  
             $game_switches[3600] = false
             $game_temp.reserve_common_event(936)
             end
        end            
       end  
#Dog dash
    if $game_party.leader.id == 16
    if trig == 1
        dispel = 1
          if !$game_switches[1075] && !$game_switches[1076] && $game_switches[739] 
            $game_switches[1075] = true
            $game_temp.reserve_common_event(118)
        end
    end
    end            
### SHIELDS ###
   @traitK = $game_variables[628]
   if $game_party.leader.id == 1 || $game_party.leader.id == 5 || $game_party.leader.class_id == 121 || $game_party.leader.class_id == 209 #Knight shield || #HumanP shield || #Crusader shield || #DeeKnight
      @shield = $game_party.leader.armors[0].atype_id rescue -1
         if $game_switches[3775] == true #SKE ENDING
           @shield = 0
         end  
         if @traitK == 31 || @traitK == 131 || @traitK == 1031 #RabiK
           if $game_party.leader.id == 1
            @shield = 0 
           end  
         end  
      if @shield == 5 || @shield == 6
        if press == 1 || trig == 1
          dispel = 1
              if $game_switches[739] && !$game_switches[746]
               $game_switches[746] = true
               $game_temp.reserve_common_event(61)
             end
           elsif $game_switches[746] == true
            $game_switches[746] = false 
            dispel = 1
            $game_temp.reserve_common_event(63)
          end 
        end
    end    
### JUMP ###
    @jumper = 0
    if $game_party.leader.id == 2 || $game_party.leader.id == 23 || $game_party.leader.class_id == 178 || $game_party.leader.class_id == 210 #Kob/Cat/Candy/Spika dodge
      @jumper = 1
    end
     if @traitK == 31 || @traitK == 131 || @traitK == 1031 #RabiK
      if $game_party.leader.id == 1
       @jumper = 1 
      end  
    end 
         if trig == 1 && @jumper == 1
            dispel = 1
            if !$game_switches[875] && !$game_switches[874] && $game_switches[739] 
               $game_switches[874] = true
               $game_temp.reserve_common_event(75)
            end
        end 
    ###
    # insert Command choice
    ###
end #if not maracas
  if dispel == 1
    dispel = 0
    if $game_switches[1151] == true
    @revId = $game_variables[8787][0]
    $game_actors[@revId].set_graphic($game_variables[8787][1],$game_variables[8787][2],$game_variables[8787][3],$game_variables[8787][4])
    $game_switches[1151] = false
    $game_player.refresh
    end
 end
######    
      end
     end
   end
 end  #succ end   
#===============================================================================
class Scene_Map < Scene_Base
#===============================================================================
  #--------------------------------------------------------------------------
  # Included Modules
  #--------------------------------------------------------------------------
  include CMN_Ev_Keys
  #--------------------------------------------------------------------------
  # Alias List
  #--------------------------------------------------------------------------
  alias :update_deki_cmnevs :update
  #--------------------------------------------------------------------------
  # Frame Update
  #--------------------------------------------------------------------------
  def update
    update_deki_cmnevs
    update_cmn_ev_keys
  end 
end
end