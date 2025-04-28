#==============================================================================
# ** Game_Picture
#------------------------------------------------------------------------------
#  This class handles pictures. It is created only when a picture of a specific
# number is required internally for the Game_Pictures class.
#==============================================================================

class Game_Picture
	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_reader   :number                   # picture index
	attr_reader   :name                     # filename
	attr_reader   :origin                   # starting point
	attr_reader   :x                        # x-coordinate
	attr_reader   :y                        # y-coordinate
	attr_reader   :zoom_x                   # x directional zoom rate
	attr_reader   :zoom_y                   # y directional zoom rate
	attr_reader   :opacity                  # opacity level
	attr_reader   :blend_type               # blend method
	attr_reader   :tone                     # color tone
	attr_reader   :angle                    # rotation angle
	#--------------------------------------------------------------------------
	# * Object Initialization
	#--------------------------------------------------------------------------
	#--------------------------------------------------------------------------
  def initialize(number)
	  @number = number
	if @number == 1
		then
		@number = 100        
	  elsif @number == 2
		then
		@number = 101
	  elsif @number == 3
		then
		@number = 102
	  elsif @number == 4
		then
		@number = 103
	  end
	  init_basic
	  init_target
	  init_tone
	  init_rotate
	end
	#--------------------------------------------------------------------------
	# * Initialize Basic Variable
	#--------------------------------------------------------------------------
	def init_basic
	  @name = ""    
	  @origin = @x = @y = 0
	  @zoom_x = @zoom_y = 100.0
	  @opacity = 255.0
	  @blend_type = 1
	end
	#--------------------------------------------------------------------------
	# * Initialize Movement Target
	#--------------------------------------------------------------------------
	def init_target
	  @target_x = @x
	  @target_y = @y
	  @target_zoom_x = @zoom_x
	  @target_zoom_y = @zoom_y
	  @target_opacity = @opacity
	  @duration = 0
	end
	#--------------------------------------------------------------------------
	# * Initialize Color Tone
	#--------------------------------------------------------------------------
	def init_tone
	  @tone = Tone.new
	  @tone_target = Tone.new
	  @tone_duration = 0
	end
	#--------------------------------------------------------------------------
	# * Initialize Rotation
	#--------------------------------------------------------------------------
	def init_rotate
	  @angle = 0
	  @rotate_speed = 0
	end
	#--------------------------------------------------------------------------
	# * Show Picture
	#--------------------------------------------------------------------------
	def show(name, origin, x, y, zoom_x, zoom_y, opacity, blend_type) 
    voiceAc = ""
    voiceV = 90
    voiceP = 100  
    ############
	  nkdCheat = 0
  	if $game_actors[1].equips.include?$data_armors[713]
	  	nkdCheat = 1
    elsif $game_switches[2764] == true
      nkdCheat = 1
  	end	    
    ############
	  $game_variables[4000] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	  $game_variables[4000][2] = 0
	  if $game_switches[2687] == false
	   if @number == 1 || @number == 100
     ######### 
     @sw = 4000
     while @sw <= 4030
       $game_switches[@sw] = false
       @sw += 1
     end   
	   #########  
	   $game_map.screen.pictures[1].erase  
	   #########
	   for n in 111..122
	   $game_map.screen.pictures[n].erase
		 end
	   end
	 end
	 @dra = 0
	 if name == "Gauge0"
	   if $game_variables[1276] == 0
		 name = "Gauge0"
  elsif $game_variables[1276] == 1
		 name = "Gauge1"
  elsif $game_variables[1276] == 2
		 name = "Gauge2"
  elsif $game_variables[1276] == 3
		 name = "Gauge3"
  elsif $game_variables[1276] == 4
		 name = "Gauge4"
  elsif $game_variables[1276] == 5
		 name = "Gauge5"
  elsif $game_variables[1276] == 6
		 name = "Gauge6"
  elsif $game_variables[1276] == 7
		 name = "Gauge7"
  elsif $game_variables[1276] == 8
		 name = "Gauge8"
  elsif $game_variables[1276] == 9
		 name = "Gauge9"
	   end  
	   if $game_variables[1276] >= 10
		 name = "Gauge10"
	   end  
	 end     
  ##################################   
    fest = ""
    if RTime::month == 3 && RTime::day >= 21
     fest = "Bloom"  
    elsif RTime::month == 4 && RTime::day <= 15 
      fest = "Bloom"
    elsif RTime::month == 10 && RTime::day >= 28
      fest = "Spook"
    elsif RTime::month == 11 && RTime::day <= 2
      fest = "Spook"
    elsif RTime::month == 12 && RTime::day >= 19
      fest = "Chill"
    elsif RTime::month == 1 && RTime::day <= 6 
      fest = "Chill"
    elsif RTime::month == 6 && RTime::day >= 21
      fest = "Heat"
    elsif RTime::month == 7 && RTime::day <= 15 
      fest = "Heat"      
    end     
  ##################################   
   @heirSW = [0,0,2509,2510,2511,2512,2513,2514,2515,2516,2517,2518,0,2519,2926,2521,0,4087,4267,4421,4722,3168,2838,3696,0,0]
   @heirVAR = [0,0,2181,2182,2183,2184,2185,2186,2187,2188,2189,2190,2191,2192,2193,2194,2195,2196,2197,2198,2199,2200,2201,2202,0,0]
  ##################################   
   @wei = [0,52,64,83,330,40,18,65,7,40,90,58,61,46,77,64,270,55,1000,15,525,110,55,43,0,0]
	 if $game_switches[2452] == true
	   @wei[4] = 184 #hum form
	 end
	  if $game_switches[2395] == true
	   @wei[6] = 77 #hum form
	 end      
	  if $game_switches[2454] == true
	   @wei[8] = 61 #hum form
	 end      
	  if $game_switches[1719] == true
	   @wei[23] = 61 #toy hum form
	 end     
  ##################################   
	 unless $game_variables[6202] == 0
   @i = 1
   while @i <= 20
     @v = 4000 + @i
     if $game_variables[6202][@i] >= @wei[@i]
       $game_variables[@v][28] = 1
     else
       $game_variables[@v][28] = 0
     end
   @i += 1
   end
 end
 # @i == 30/31/32 for plant/shadow/toy should also have their chubby var
  ################################## 
  pPort = ""
  pRace = 0
  pVar = 0
  ##################################
  #########   VOICE SCR    #########
  ##################################
  dialSE = 0
  if name.include? "dialogueframe" 
    dialSE = 1
  end
  if name.include? "dialogueframeNoSE" 
    dialSE = 0
  end  
  #if name.include? "Dial"  
  #  dialSE = 1
  #end
  if dialSE == 1
  if $game_variables[7330] == 1
   if voiceAc == ""
   voiceAc = "VoiceRND"
   voiceV = 90
   voiceP = 100  
   end
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   end  
 end
inMenu = 1
  ##################################
if $game_switches[3416] == false && $game_switches[2359] == false && $game_switches[2411] == false && $game_switches[2466] == false && $game_switches[579] == false && $game_switches[3451] == false && $game_switches[3215] == false 
  inMenu = 0
end
  ##################################	
  ###########  Dial Box ###########
  ################################## 
  if name.include? "dialogueframeNoSE" 
    name = "dialogueframe"
  end  
  if name == "dialogueframe" && $game_variables[7334] != 0
    box = ["","Dragon","Wooden","Porgy","Dusk","Knight","Bird","Slime","Insect","Skeleton","Mermaid","Candy"]
    i = $game_variables[7334]
    if i < 0
      i = 0
    elsif i > (box.length - 1)
      i = box.length - 1
    end  
    name = "dialogueframe" + box[i]
  end   
  ##################################
  ##########  Little Nuns ##########
  ##################################
  nun = 0
  if name.include? "Nun dial"
    nun = 1
  elsif name.include? "Nun Lam dial"
    nun = 1    
  elsif name.include? "GuardianNun dial"
    nun = 1   
  end  
  if nun == 1
	  px = 100
	  py = 100
  if name.include? "GuardianNun dial"
		xp = -100
		yp = -20
    n = "DragonNun"    
  elsif name.include? "Nun Lam dial"
		xp = 20
		yp = 105
    n = "LamiaNun" 
  else
		xp = 40
		yp = 120
    n = "HumanNun"
  end      
    if name.include? "sad"
     n += "Sad"  
    elsif name.include? "rage"
     n += "Sad"   
    elsif name.include? "glad"
     n += "Glad"  
    elsif name.include? "vision"
     n += "Vision"          
    end      
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ############    MASUKA  ############
  ##################################
  if name.include? "MasukaBOT dial"
	  px = 100
	  py = 100 	
		xp = 225
		yp = 75
    n = "Masuka"
    exp = "MasukaExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "embarass"
     exp += "Embarassed"  
    elsif name.include? "unimpress"
     exp += "Unimpressed"       
    else
     exp += "Std"  
   end    
    $game_map.screen.pictures[111].show("MouSuitX6Back", 0, 0, -30, px, py, 255, 0)
    $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[113].show(exp, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[114].show("MouSuitX6-Masuka", 0, 0, -30, px, py, 255, 0)
    $game_map.screen.pictures[115].show("MouSuitX6Visor", 0, 0, -30, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ############    MASUKA  ############
  ##################################
  if name.include? "Masuka dial"
	  px = 100
	  py = 100 	
		xp = -5
		yp = 45
    n = "Masuka"
    exp = "MasukaExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "embarass"
     exp += "Embarassed"  
    elsif name.include? "unimpress"
     exp += "Unimpressed"       
    else
     exp += "Std"  
    end    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ############    ERI  ############
  ##################################
  if name.include? "Eri dial"
	  px = 100
	  py = 100 	
		xp = -5
		yp = 45
    n = "Eri"
    exp = "EriExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "evil"
     exp += "Evil"  
    else
     exp += "Std"  
    end    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ########### SEKOIA  ##############
  ##################################
  if name.include? "Sekoia dial"
	  px = 100
	  py = 100 	
		xp = -120
		yp = -70
    n = "Sekoia"
    exp = "SekoiaExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "joy"
     exp += "Joy"  
    else
     exp += "Std"  
    end    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  #########   Moth Mamma   #########
  ##################################
  if name.include? "MothMamma dial"
	  px = 100
	  py = 100 	
		xp = -60
		yp = -50
    n = "MothMamma"
    ###########
    voiceAc = "VoiceMot"
    voiceV = 70 
    voiceP = 85  
    ###########    
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
   end     
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true
     voiceAc += (rand(4)+1).to_s
     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #   
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  #########   Moth Pupa   #########
  ##################################
  if name.include? "MothPupa dial"
	  px = 100
	  py = 100 	
		xp = -15
		yp = -140
    n = "MothPupa"
    ###########
    voiceV = 90
    voiceP = 100  
    ###########
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true
	     RPG::SE.new("Rustle", voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  #########   Moth Larva   #########
  ##################################
  if name.include? "MothLarva dial"
	  px = 100
	  py = 100 	
		xp = -50
		yp = -85
    ###########
    voiceV = 90
    voiceP = 100  
    ###########    
    n = "MothLarva"
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true
	     RPG::SE.new("Splat", voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #       
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  #######   Dryad Huntress   #######
  ##################################
  if name.include? "DryadHuntress dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "DryadHunt"
    exp = "DryadHuntExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end     
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "rage"
     exp += "Rage"    
    elsif name.include? "love"
     exp += "Love"      
    elsif name.include? "prey"
     exp += "Prey"      
    else      
     exp += "Std"       
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   Root Sprite   ##########
  ##################################
  if name.include? "RootSprite dial"
	  px = 100
	  py = 100 	
		xp = 15
		yp = 85
    n = "RootSprite"
    exp = "RootSpriteExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end     
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "rage"
     exp += "Rage"    
    elsif name.include? "glad"
     exp += "Glad"      
    else 
     exp += "Std"       
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Wood Golem   ##########
  ##################################
  if name.include? "WoodGolem dial"
	  px = 100
	  py = 100 	
		xp = -45
		yp = -85
    n = "WoodGolem"
    exp = "WoodGolemExp"
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "rage"
     exp += "Rage"       
    else 
     exp += "Std"       
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   Turnips   ##########
  ##################################
  if name.include? "Nip dial"
	  px = 100
	  py = 100 	
		xp = 15
		yp = 115
    n = "Turnip"    
    if name.include? "rage"
     n += "Rage"      
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Tinnitus   ##########
  ##################################
  if name.include? "Tinnitus dial"
	  px = 100
	  py = 100 	
		xp = 200
		yp = 20
    n = "Tinnitus"  
    ###########
    voiceAc = ""
    voiceV = 90 
    voiceP = 140  
    ###########   
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   ZombieP   ###########
  ##################################
  if name.include? "ZombieP dial"
	  px = 100
	  py = 100 	
		xp = -25
		yp = 105
    n = "ZombieP"
    exp = "ZombiePExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end     
    ###########
    voiceAc = "VoiceSke"
    voiceV = 80 
    voiceP = 100  
    ###########      
    if name.include? "sad"
     exp += "Sad"   
      voiceV -= 10
      voiceP -= 15
    elsif name.include? "rage"
     exp += "Rage"   
      voiceV += 15
      voiceP += 20          
    elsif name.include? "love"
     exp += "Love"     
      voiceV += 10
      voiceP -= 10  
    elsif name.include? "laugh"
     exp += "Laugh"
      voiceV += 15
      voiceP += 20          
    elsif name.include? "LOL"
     exp += "LOL"     
      voiceV += 15
      voiceP += 20          
    else 
     exp += "Std"       
   end         
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true || $game_variables[7330] == 2
       voiceAc += (rand(4)+1).to_s
	     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ########   Fever Dream   ########
  ##################################
  if name.include? "FeverDream dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "FeverDream"
    exp = "FeverDreamExp"
    if name.include? "rage"
     exp += "Rage"   
    else
     exp += "Std"       
    end         
    t = 255
    if name.include? "Trasp"
      t = 155
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, t, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, t, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, t, 0)      
	  return
	end      
  ##################################
  ##########   Slender   ##########
  ##################################
  if name.include? "Slender dial"
	  px = 100
	  py = 100 	
		xp = 190
		yp = -20
    n = "SlenderGal"
    exp = "SlenderGalExp"
    if name.include? "DARK"
     n += "DARK"  
     exp += "DARK"  
    end 
    ###########
    voiceAc = "Breath"
    voiceV = 80 
    voiceP = 120  
    ###########          
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"
    end    
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "rage"
     exp += "Rage"     
    elsif name.include? "love"
     exp += "Love"                 
    else
     exp += "Std"
    end         
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true
	     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #          
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Hagga   ##########
  ##################################
  if name.include? "Hagga dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = -20
    n = "Hagga"
    exp = "HaggaExp"
    if name.include? "laugh"
     exp += "Laugh"   
    elsif name.include? "grin"
     exp += "Grin"       
    else 
     exp += "Std"       
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   Merchant P.  ##########
  ##################################
  if name.include? "Merchant pri dial"
	  px = 100
	  py = 100 	
		xp = 40
		yp = 105
    n = "MerchantP"
    exp = "MerchantPExp"
    if name.include? "tanuki"
     n += "Tanuki"  
    end     
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"
    end 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "mad"
     exp += "Rage"   
    elsif name.include? "rage"
     exp += "Rage"        
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "grumpy"
     exp += "Grumpy"  
    else
     exp += "Std"  
    end    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end 
  ##################################
  ##########   Hippo P.  ##########
  ##################################
  if name.include? "HippoP dial"
	  px = 100
	  py = 100 	
		xp = -110
		yp = 0
    n = "HippoP"
    ###########
    voiceAc = "VoiceHippo"
    voiceV = 80 
    voiceP = 100  
    ###########        
    exp = "HippoPExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad"
     exp += "Sad"   
      voiceV -= 10
      voiceP -= 15
    elsif name.include? "rage"
     exp += "Rage"   
      voiceV += 15
      voiceP += 20          
    elsif name.include? "love"
     exp += "Love"     
      voiceV += 10
      voiceP -= 10  
    elsif name.include? "cry"
     exp += "Laugh"
      voiceV += 15
      voiceP += 20                  
    else 
     exp += "Std"       
   end      
    if name.include? "hidden"
    n = "HippoPH"
    exp = ""
  end      
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true || $game_variables[7330] == 2
	     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ##########   Ninja P.  ##########
  ##################################
  if name.include? "Ninja Princess Dial"
	  px = 100
	  py = 100 	
		xp = 35
		yp = 180
    n = "NinjaP"
    exp = "NinjaPExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad2"
     exp += "Sad2"  
    elsif name.include? "sad"
     exp += "Sad"        
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "misch"
     exp += "Misch"  
    elsif name.include? "dork"
     exp += "Dork"       
   else
     exp += "Std"
   end     
    if name.include? "hidden"
    n = "NinjaPH"
    exp = ""
    end    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end 
  ##################################
  ##########   TraumaChibi   ##########
  ##################################
  if name.include? "TraumaChibi dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = -60
    n = "TraumaChibi"
	  if name.include? "naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	  end    
    exp = "TraumaChibiExp"
    if name.include? "defeat"
     exp += "Defeat"    
    else
     exp += "Std"        
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end          
  ##################################
  ##########   Trauma   ##########
  ##################################
  if name.include? "Trauma dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Trauma"
	  if name.include? "naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	  end    
    exp = "TraumaExp"
    if name.include? "defeat"
     exp += "Defeat"    
    else
     exp += "Std"        
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   PrettyScare   ##########
  ##################################
  if name.include? "Scarecrow dial pretty"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "PrettyScarecrow"        
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   MrPawPaw   ##########
  ##################################
  if name.include? "PawPaw dial"
	  px = 100
	  py = 100 	
		xp = 70
		yp = -65
    n = "MrPawPaw"        
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Nami   ##########
  ##################################
  if name.include? "Nami dial"
	  px = 100
	  py = 100 	
		xp = 25
		yp = 28
    n = "Nami"
    exp = "NamiExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end     
    if name.include? "disappoint"
     exp += "Sad"   
    elsif name.include? "smile"
     exp += "Glad"               
    else
     exp += "Std"
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   Trevor   ##########
  ##################################
  if name.include? "Trevor Dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Trevor"
    if name.include? "sad"
     n += "Sad"   
    elsif name.include? "rage"
     n += "Rage"       
   elsif name.include? "oyvey"
     n += "Deject"        
    elsif name.include? "laugh"
     n += "Laugh"          
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Mugen   ##########
  ##################################
  if name.include? "Mugen dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Mugen"
    if name.include? "scoff"
     n += "Scoff"   
    elsif name.include? "laugh"
     n += "Laugh"       
   elsif name.include? "bitter"
     n += "Bitter"        
    elsif name.include? "embarass"
     n += "Emb"          
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  ##########   Mary-Annette   ##########
  ##################################
  if name.include? "MaryAnn dial"
	  px = 100
	  py = 100 	
		xp = 35
		yp = 85
    n = "MaryAnnette"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"
    end  
    exp = "MaryAnnExp"    
    if name.include? "crazy"
     exp += "Crazy"   
    elsif name.include? "rage"
     exp += "Rage"       
    elsif name.include? "lust"
     exp += "Love"        
    elsif name.include? "giggle"
     exp += "Giggle" 
   else
     exp += "Std"
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   Jozzlyn   ##########
  ##################################
  if name.include? "Jozzlyn dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = -20
    n = "Jozzlyn"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"
    end     
    exp = "JozzlynExp"
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "pout"
     exp += "Rage"       
    elsif name.include? "lust"
     exp += "Love"        
    elsif name.include? "serious"
     exp += "Serious"      
    else
     exp += "Std"
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   Lizz   ##########
  ##################################
  if name.include? "Lizz dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 125
    n = "Lizz"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"
    end  
    exp = "LizzExp"
    if name.include? "lipbite"
     exp += "Lip"   
    elsif name.include? "rage"
     exp += "Rage"       
    elsif name.include? "tongue"
     exp += "Tongue"        
    elsif name.include? "disgust"
     exp += "Disgust"    
   else
     exp += "Std"
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end          
  ##################################
  ##########   Komachi   ##########
  ##################################
  if name.include? "Komachi dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Komachi"
    if name.include? "sad2"
     n += "Sad2"   
    elsif name.include? "sad"
     n += "Sad"       
    elsif name.include? "rage"
     n += "Rage"        
    elsif name.include? "amused"
     n += "Glad"          
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   Jokul   ##########
  ##################################
  if name.include? "Jokul dial"
	  px = 100
	  py = 100 	
		xp = -70
		yp = 0
    n = "Jokul"
    if name.include? "lipbit"
     n += "Sad"   
    elsif name.include? "rage"
     n += "Rage"       
    elsif name.include? "enthusiast"
     n += "Glad"        
    elsif name.include? "whiteeye"
     n += "Vision"          
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  #########   Debt Shark   #########
  ##################################
  if name.include? "DebtShark dial"
	  px = 100
	  py = 100 	
		xp = -40
		yp = 12
    n = "DebtShark"
    if name.include? "scared"
     n += "Rage"   
    elsif name.include? "rage"
     n += "Rage"       
    elsif name.include? "glad"
     n += "Glad"        
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Sharkman   ##########
  ##################################
  if name.include? "HSharkmen dial"
	  px = 100
	  py = 100 	
		xp = -40
		yp = 12
    n = "HSharkman"
    if name.include? "scared"
     n += "Rage"   
    elsif name.include? "rage"
     n += "Rage"       
    elsif name.include? "glad"
     n += "Glad"        
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ##########   Talon Guard  ##########
  ##################################
  if name.include? "Talon Guard dial"
	  px = 100
	  py = 100 	
		xp = 15
		yp = 60
    n = "TalonGuard"
    exp = "TalonGuardExp"
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "sus"
     exp += "Sus"   
    elsif name.include? "squak"
     exp += "Squak"   
    else
     exp += "Std"        
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########   JobJob  ##########
  ##################################
  if name.include? "JobJob dial"
	  px = 100
	  py = 100 	
		xp = -68
		yp = -36
    n = "JobJob"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   Starchy  ##########
  ##################################
  if name.include? "Starchy dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Starchy"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   Old Nick  ##########
  ##################################
  if name.include? "Old Nick dial"
	  px = 100
	  py = 100 	
		xp = 41
		yp = -36
    n = "OldNick"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ############   Wilty  ############
  ##################################
  if name.include? "Wilty dial"
	  px = 100
	  py = 100 	
		xp = 10
		yp = 90
    n = "Wilty"
    exp = "WiltyExp"
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "cheer"
     exp += "Cheer"   
    else
     exp += "Std"  
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########   Niuya  ##########
  ##################################
  if name.include? "Niuya Dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    acc = "NiuyaHead"
    n = "Niuya"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    elsif name.include? "bottom"
      n += "Bottom"            
    elsif $game_map.map_id == 170 || $game_map.map_id == 294 #std in tavern/room
      n += ""
    elsif fest != "" #RT festival
      if fest == "Bloom"
      n += "F20"
      elsif fest == "Spook" 
      n += "H20"
      acc += "H20"
      elsif fest == "Chill"
      n += "C20"
      end      
    elsif $game_switches[4318] == true #spookfest
      n += "H20"
      acc += "H20"
    elsif $game_switches[4333] == true #chillbite
      n += "C20"
    elsif $game_switches[4440] == true #flowerfest
      n += "F20"
    elsif $game_variables[1794] == 2 && $game_switches[523] == false #no rain/heatfall
      n += "s"
      acc += "s"
    end    
    exp = "NiuyaExp"
    #voice Base
    voiceAc = "VoiceMou"
    if $game_switches[4600] == true || $game_variables[7330] == 2
      voiceAc += "susp"
    end      
    voiceV = 70
    voiceP = 80
    if name.include? "sad2"
     exp += "Sad2"   
      voiceV -= 10
      voiceP -= 15
    elsif name.include? "sad"
     exp += "Sad"   
      voiceV -= 10
      voiceP -= 15   
    elsif name.include? "rage"
     exp += "Rage"
      voiceV += 15
      voiceP += 20      
    elsif name.include? "love"
     exp += "Love"
      voiceV += 10
      voiceP -= 10     
    elsif name.include? "glad"
     exp += "Glad"   
      voiceV += 10
      voiceP -= 10    
    else
     exp += "Std"     
    end         
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[113].show(acc, 0, xp, yp, px, py, 255, 0) 
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########   Slime Titan  ##########
  ##################################
  if name.include? "Slime Titan dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "SlimeTitan"
    if name.include? "rage"
     n += "Rage"   
    elsif name.include? "hidden"
     n += "Hidden"   
    end         
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end
  ##################################
  ##########   Jackalope  ##########
  ##################################
  if name.include? "Jackalope dialXXX"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Jackalope"
    if name.include? "sad"
     n += "Sad"  
    elsif name.include? "rage"
     n += "Rage"        
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  ##########   Minky  ##########
  ##################################
  if name.include? "Minky dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Minky"
    if name.include? "wounded"
     n += "Wounded"  
    elsif name.include? "rage"
     n += "Rage"   
    elsif name.include? "catty"
     n += "Catty"   
    elsif name.include? "bitter"
     n += "Bitter"        
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   WORR  ##########
  ##################################
  if name.include? "WORR dial"
	  px = 100
	  py = 100 	
		xp = -15
		yp = 85
    n = "Worr"
    exp = "WorrExp"
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    else     
     exp += "Std" 
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Silenus  ##########
  ##################################
  if name.include? "Silenus dial"
	  px = 100
	  py = 100 	
		xp = -140
		yp = 0
    n = "Silenus"
    if name.include? "cry"
     n += "Sad"  
    elsif name.include? "rage"
     n += "Rage"   
    elsif name.include? "tongue"
     n += "Tongue"   
    elsif name.include? "Hidden"
     n = "SilenusH"        
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   Old Barnacle  ##########
  ##################################
  if name.include? "Old Barnacle dial"
	  px = 100
	  py = 100 	
		xp = 70
		yp = 140
    n = "OldBarnacle"
    if name.include? "sad"
     n += "Sad"  
    elsif name.include? "glad"
     n += "Glad"   
    elsif name.include? "grumpy"
     n += "Grumpy"         
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   Vesta  ##########
  ##################################
  if name.include? "Vesta dial"
	  px = 100
	  py = 100 	
		xp = 10
		yp = 10
    n = "Vesta"
    exp = "VestaExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "fan"
     exp += "Fan"  
    elsif name.include? "fan2"
     exp += "Fan2"       
   else
     exp += "Std"
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   Momoko  ##########
  ##################################
  if name.include? "Momoko dial"
	  px = 100
	  py = 100 	
		xp = -80
		yp = -35
    n = "Momoko"
    exp = "MomokoExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"  
    end 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "ara"
     exp += "Ara"  
   else
     exp += "Std"
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Medulla  ##########
  ##################################
  if name.include? "Medulla"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "DonMedu"    
    if name.include? "Sad"
     n += "Sad"  
    elsif name.include? "Rage"
     n += "Rage"   
    elsif name.include? "Moved"
     n += "Moved"         
    elsif name.include? "Shock"
     n += "Shock"         
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Lina  ##########
  ##################################
  if name.include? "Lina Dial"
	  px = 100
	  py = 100 	
		xp = -8
		yp = 75
    acc = "LinaHead"
    n = "Lina"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
     elsif fest != "" #RT festival
      if fest == "Bloom"
      n += "F20"
      elsif fest == "Spook" 
      n += "H20"      
      elsif fest == "Chill"
      n += "C20"
      acc += "C20"
      end      
    elsif $game_switches[4318] == true #spookfest
      n += "H20"
    elsif $game_switches[4333] == true #chillbite
      n += "C20"
      acc += "C20"
    elsif $game_switches[4440] == true #flowerfest
      n += "F20"
    elsif $game_variables[1794] == 2 && $game_switches[523] == false #no rain/heatfall
      n += "s"
      acc += "s"
    end      
    exp = "LinaExp"  
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "starstruck"
     exp += "Star"   
    else
     exp += "Std"   
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)    
    $game_map.screen.pictures[113].show(acc, 0, xp, yp, px, py, 255, 0) 
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   LeChef   ##########
  ##################################
  if name.include? "LeChef dial"
	  px = 100
	  py = 100 	
		xp = -75
		yp = -75
    n = "LeChef"    
    if name.include? "sad"
     n += "Sad"        
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   Sekoia  ##########
  ##################################
  if name.include? "Sekoia dial"
	  px = 100
	  py = 100 	
		xp = -130
		yp = -80
    n = "Sekoia"    
    exp = "SekoiaExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end           
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "joy"
     exp += "Joy"    
    else
     exp += "Std"    
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Helias  ##########
  ##################################
  if name.include? "Helias dial"
	  px = 100
	  py = 100 	
		xp = -60
		yp = 0
    n = "Helias" 
    exp = "HeliasExp" 
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end     
    if name.include? "pout"
     exp  += "Pout"  
    elsif name.include? "disgust"
     exp  += "Disgust"   
    elsif name.include? "love"
     exp  += "Love"         
    elsif name.include? "glad"
     exp  += "Glad"   
    else
     exp += "Std"
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ##########     Qhala    ##########
  ##################################
  if name.include? "Qhala dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Qhala"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end         
    exp = "QhalaExp"
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "orgasm"
     exp += "Orgasm"           
    else
     exp += "Std" 
    end                     
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  #######   Grampa Lich  ##########
  ##################################
  if name.include? "Senile Lich dial"
	  px = 100
	  py = 100 	
		xp = 30
		yp = 10
    n = "GrampaLich"
    if name.include? "LICHING"
      n += "LICHING"
    end                 
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  #######   Michael  ##########
  ##################################
  if name.include? "Michael Dial"
	  px = 100
	  py = 100 	
		xp = 2
		yp = 71
    n = "Michael"
    exp = "MichaelExp"
    if name.include? "CoC"
      n = "MichaelCoC"
    end      
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "pleased"
     exp += "Pleased"         
    elsif name.include? "disgust"
     exp += "Disgust"         
    else
     exp += "Std" 
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  #######   Milk Maiden  ##########
  ##################################
  if name.include? "MilkM dial"
	  px = 100
	  py = 100 	
		xp = -20
		yp = 30
    n = "MilkM"
    exp = "MilkMExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end      
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "horny"
     exp += "Horny"         
    elsif name.include? "pleased"
     exp += "Pleased"         
    else
     exp += "Std" 
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  #######   Mouse Banker  ##########
  ##################################
  if name.include? "Mouse Banker"
	  px = 100
	  py = 100 	
		xp = 10
		yp = 160
    n = "MouseBanker" 
    exp = "MouseBankerExp"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end    
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"         
    elsif name.include? "scared"
     exp += "Scared"         
    else
     exp += "Std" 
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  #######   Wendigo Monster  ##########
  ##################################
  if name.include? "WendigoGoon dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "WendigoGoon"                   
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  #######   Shiruku  ##########
  ##################################
  if name.include? "Shiruku dial"
	  px = 100
	  py = 100 	
		xp = -250
		yp = -100
    n = "Shiruku" 
    if nkdCheat == 1
     n += "N"
    elsif name.include? "naked"
     n += "N"
    end      
    exp = "ShirukuExp" 
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "rage"
     exp += "Rage" 
    elsif name.include? "confident"
     exp += "Confident"
    elsif name.include? "embarass"
     exp += "Embarass"
    else 
     exp += "Std"
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end           
  ##################################
  #######   Baarometz  ##########
  ##################################
  if name.include? "Baarometz dial"
	  px = 100
	  py = 100 	
		xp = -10
		yp = 10
    n = "Baarometz" 
    if nkdCheat == 1
     n += "N"
    elsif name.include? "naked"
     n += "N"
    end      
    exp = "BaarometzExp" 
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "rage"
     exp += "Rage" 
    elsif name.include? "love"
     exp += "Love"
    elsif name.include? "scared"
     exp += "Scared"
    else 
     exp += "Std"
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  #######   SpikaP  ##########
  ##################################
  if name.include? "SpikaP dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "SpikaP" 
    #voice Base
    voiceAc = "VoiceSha"
    voiceV = 90
    voiceP = 100    
    #voice Base - End
    if nkdCheat == 1
     n += "N"
    elsif name.include? "naked"
     n += "N"
    end      
    exp = "SpikaPExp" 
    if name.include? "sad"
     exp += "Sad"   
    elsif name.include? "rage"
     exp += "Rage" 
    elsif name.include? "love"
     exp += "Love"
    elsif name.include? "shock"
     exp += "Shock"
    else 
     exp += "Std"
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  #######   MirageP  ##########
  ##################################
  if name.include? "MirageP dial"
	  px = 100
	  py = 100 	
		xp = 70
		yp = 20
    n = "MirageP" 
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end      
    exp = "MiragePExp" 
    if name.include? "reveal"
     exp += "Std"   
    else
     exp += "Smile" 
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  #######   MartyrP  ##########
  ##################################
  if name.include? "MartyrP dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 40
    n = "MartyrP" 
    halo = "MartyrPHalo" 
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end      
    exp = "MartyrPExp" 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "condescending"
     exp += "Cond"         
    else
     exp += "Std" 
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[113].show(halo, 0, xp, yp, px, py, 255, 0) 
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  #######   Ice Maiden  ##########
  ##################################
  if name.include? "IceMaiden dial"
	  px = 100
	  py = 100 	
		xp = -50
		yp = 5
    n = "IceMaiden" 
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end      
    exp = "IceMaidenExp" 
    if name.include? "sad"
     exp += "Sad"  
    elsif name.include? "rage"
     exp += "Rage"   
    elsif name.include? "love"
     exp += "Love"      
    elsif name.include? "OMD"
     exp += "OMD"      
    else
     exp += "Std" 
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  #######   GolemSoldier  ##########
  ##################################
  if name.include? "Golem Soldier dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "GolemSold" 
    if name.include? "rage"
     n += "Rage"  
    elsif name.include? "hungry"
     n += "Hungry"       
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  #######   Shrimps  ##########
  ##################################
  if name.include? "Finhead Soldier dial"
	  px = 100
	  py = 100 	
		xp = 20
		yp = 15
    n = "ShrimpK" 
    if name.include? "dialQ"
     n += "ShrimpKQ"  
    end              
    if name.include? "rage"
     n += "Rage"  
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########     Drusy    ##########
  ##################################
  if name.include? "Drusy dial"
	  px = 100
	  py = 100 	
		xp = 50
		yp = 140
    n = "Drusy"  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ###########   Dur  ##############
  ##################################
  dur = 0
  if name.include? "Dur Free dial"
    dur = 1
  elsif name.include? "Dur Leash dial"  
    dur = 1
  end  
  if dur == 1
	  px = 100
	  py = 100 	
		xp = -150
		yp = 150
    n = "Dur" 
    if name.include? "Free"
     n += "Free"    
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  #######   Crowley  ##########
  ##################################
  if name.include? "Crowley Dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0
    n = "Crowley" 
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "rage"  
     n += "Rage"    
    elsif name.include? "pleased"  
     n += "Pleased"    
    elsif name.include? "shy"  
     n += "Shy"    
    end                
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  #######   Dokuro  ##########
  ##################################
  if name.include? "Dokuro dial"
	  px = 100
	  py = 100 	
		xp = 40
		yp = 145
    n = "Dokuro"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end    
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "rage"  
     n += "Rage"    
    end      
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  #######   Colony  ##########
  ##################################
  if name.include? "ColonyF dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 130
    n = "ColonyF"
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "glad"  
     n += "Glad"    
    end      
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  if name.include? "ColonyM dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 130
    n = "ColonyM"
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "glad"  
     n += "Glad"    
    end     
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  #######   Creamy+Emi  ##########
  ##################################
  if name.include? "CreamyEmi"
	  px = 100
	  py = 100 	
		xp = -7
		yp = 111
    n = "CreEmi"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    end
    if name.include? "CreamyEmi E"
      n += "E"
    elsif name.include? "CreamyEmi C"
      n += "C"
    end        
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  #######        MQ       ##########
  ##################################
  if name.include? "MQ dial"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  #######        MQh       ##########
  ##################################
  if name.include? "MQh dial"
	  px = 100
	  py = 100 	   
		xp = 10
		yp = -90
    n = "MQBod"
    ###########
    voiceAc = "VoiceGho"
    voiceV = 70 
    voiceP = 85 
    ###########    
    if name.include? "unveil"
     n += "U"
    end     
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"
    end    
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true || $game_variables[7330] == 2
       voiceAc += (rand(4)+1).to_s
	     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #      
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  #######   CHILL  ##########
  ##################################
  if name.include? "CHILL dial"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  #######   Rosebuds  ##########
  ##################################
  if name.include? "Bud1 dial"
	  px = 100
	  py = 100 	
		xp = 30
		yp = 170
    n = "Bud1"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  if name.include? "Bud2 dial"
	  px = 100
	  py = 100 	
		xp = 30
		yp = 170
    n = "Bud2"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  if name.include? "Buds dial"
	  px = 100
	  py = 100 	
		xp = 120
		yp = 150
    n = "Buds"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  #######   Brownie  ##########
  ##################################
  if name.include? "Brownie dial"
	  px = 100
	  py = 100 	
		xp = 15
		yp = 115
    n = "Brownie"
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "rage"  
     n += "Rage"    
    elsif name.include? "cry"  
     n += "Cry"    
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  #######   Derert Dweller  ##########
  ##################################
  if name.include? "DesDweller dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 95
    n = "DesDweller"
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "rage"  
     n += "Rage"    
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  #######    Cyclop Seer  ##########
  ##################################
  if name.include? "CySeer dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 0 
    if name.include? "shadow"
     n = "CySeer"  
    else
     n = "CySeer2" 
    end  
    if nkdCheat == 1
      n += "N"
    elsif name.include? "naked"
      n += "N"
    end    
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    exp = "CySeerExp"
    unless n == "CySeer" 
    if name.include? "sad"
     exp += "Sad" 
    elsif name.include? "worried"
     exp += "Worried"     
    elsif name.include? "relief"
     exp += "Relief"     
    elsif name.include? "happy"
     exp += "Happy"    
    else
     exp += "Std"    
    end  
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
    end
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########    Bobba     ##########
  ##################################
  if name.include? "Bobba dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 150   
    n = "Bobba"
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "rage"  
     n += "Rage"  
    elsif name.include? "mock"
     n += "Mock"     
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ########     Zenko     ########
  ##################################
  zenko = 0
  if name.include? "Zenko dial"
    zenko = 1
  end    
  if name.include? "ZenkoB dial"
    zenko = 1
  end  
  if zenko == 1
	  px = 100
	  py = 100 	
		xp = -10
		yp = 25    
   if name.include? "ZenkoB dial"
     n = "ZenkoB"
   else
     n = "Zenko"    
   end
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"   
   end
   exp = "ZenkoExp"
    if name.include? "cry"
     exp += "Cry" 
    elsif name.include? "sad"  
     exp += "Sad"      
    elsif name.include? "shock"  
     exp += "Shock"        
    elsif name.include? "love"  
     exp += "Love"  
    elsif name.include? "rage"
     exp += "Rage"     
    elsif name.include? "giggle"
     exp += "Giggle"     
    elsif name.include? "deject"
     exp += "Deject"
    elsif name.include? "tch"
     exp += "Tch"     
    else
     exp += "Std"        
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ########     Keaton     ########
  ##################################
  keaton = 0
  if name.include? "KeatonG dial"
    keaton = 1
  end    
  if name.include? "Keaton dial"
    keaton = 1
  end  
  if keaton == 1
	  px = 100
	  py = 100 	
  if name.include? "KeatonG dial"
		xp = 50
		yp = 40 
    n = "KeatonG"
  else
		xp = -35
		yp = -50 
    n = "Keaton"    
  end  
    if name.include? "cry"
     n += "Cry" 
    elsif name.include? "grin"  
     n += "Grin"  
    elsif name.include? "shock"
     n += "Shock"     
    elsif name.include? "giggle"
     n += "Giggle"     
    else
     n += "Std"   
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ########     Gazzetta     ########
  ##################################
  if name.include? "Gazzetta dial"
	  px = 100
	  py = 100 	
		xp = 0
		yp = 190   
    n = "Gazzetta"
    if name.include? "sad"
     n += "Sad" 
    elsif name.include? "rage"  
     n += "Rage"  
    elsif name.include? "love"
     n += "Love"     
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ########     WendigoX     ########
  ##################################     
  if name.include? "WendigoP dial HUM X" 
	  px = 100
	  py = 100  
		xp = 26
		yp = 47    
    n = "WendigoPHUMX"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  if name.include? "WendigoP dial" 
	  px = 100
	  py = 100  
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	end       
  if name.include? "Wendigo X dial" 
	  px = 100
	  py = 100  
		xp = -25
		yp = -35
    n = "WendigoX1"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"     
    end 
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ########   Crusader Head  ########
  ##################################
  if name.include? "CrusaderH dial"
	  px = 100
	  py = 100 	
		xp = 25
		yp = 240   
    n = "CrusaderH"
    if name.include? "cry"
     n += "Cry" 
    elsif name.include? "ecstasy"  
     n += "Ecstasy"  
    elsif name.include? "love"
     n += "Love"  
    elsif name.include? "rage"
     n += "Rage" 
    elsif name.include? "scoff"
     n += "Scoff"       
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ########   PumpkinHead  ##########
  ##################################
  if name.include? "PumpkinHead dial"
	  px = 100
	  py = 100 	
		xp = 25
		yp = 240   
    n = "PumpkinHead"
    if name.include? "cheer"
     n += "Cheer" 
    elsif name.include? "rage"  
     n += "Rage"  
    elsif name.include? "scary"
     n += "Scary"  
    end  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Bakeneko    ##########
  ##################################
  if name.include? "Bakeneko dial"
	  px = 100
	  py = 100 
		xp = 0
		yp = 0    
    n = "Bakeneko"
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########   Selkie    ##########
  ##################################
  if name.include? "Selkie dial"
	  px = 100
	  py = 100 	    
		xp = 0
		yp = 28    
    n = "Selkie"
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"     
    end     
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########   Moth Boss    ##########
  #################################
  if name.include? "Moth Princess Dial Boss"
	  px = 100
	  py = 100 	  
		xp = -169
		yp = -52
    n = "MothBoss"
    if name.include? "sad"
     n += "Sad"  
   elsif name.include? "rage" 
     n += "Rage"  
   end       
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)      
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end 
  ##################################
  ##########   Moth Boss    ##########
  #################################
  if name.include? "Djinn dial"
	  px = 100
	  py = 100 	  
		xp = 20
		yp = 0
    n = "DarkDjinn"
    exp = "DarkDjinnExp"
    if name.include? "sad"
     exp += "Sad"  
   elsif name.include? "rage" 
     exp += "Rage"  
   elsif name.include? "resign" 
     exp += "Resign"       
   else  
     exp += "Std"       
   end       
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)      
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)        
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ###########   Rusty  ###########
  #################################
  rusty = 0
  if name.include? "Rusty sad"
    rusty = 1
  elsif name.include? "Rusty rage"
    rusty = 1
  elsif name.include? "Rusty surprise"
    rusty = 1
  end  
  if rusty == 1
	  px = 100
	  py = 100 	   
		xp = 0
		yp = 0
    n = "Rusty"    
   if name.include? "rage" 
     n += "Rage"  
   elsif name.include? "surprise" 
     n += "Surprise"       
   end        
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0) 
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ########   Mouse Patron ########
  #################################
  if name.include? "Mouse Patreon FS"
	  px = 100
	  py = 100 	   
		xp = 0
		yp = 150
    n = "MouPatron"       
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0) 
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  ##########   PortWin    ##########
  #################################
  if name.include? "PortWin"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ##########   EmptyDial    ##########
  #################################
  if name.include? "EmptyDial"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end          
  ##################################
  ##########   QCham    ##########
  #################################
  if name.include? "Queen Chamberlain"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end           
  ##################################
  ##########   Nymph    ##########
  #################################
  if name.include? "Nymph Dial"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  ##########   Agathe    ##########
  ##################################
  if name.include? "Agathe dial"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ##########   Wendigo    ##########
  ##################################
  if name.include? "Wendigo dial"
	  px = 100
	  py = 100 	    
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   CHI/M/P    ##########
  ##################################
  if name.include? "Wartomaton dial"
	  px = 100
	  py = 100 	    
    n = "Chimp"
    xp = -60
    yp = -25
    px = 100
    py = 100
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   MOLE P    ##########
  ##################################
  if name.include? "MoleP dial"
		px = 100
		py = 100   
		xp = 5
		yp = 60
	  n = "MoleP"      
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end      
	 expE = "MolePExp"
	 expS = "Std"
    ###########
    voiceAc = "VoiceDog"
    voiceV = 80 
    voiceP = 100  
    ###########        
	 if name.include? "sad"
	 expS = "Sad"    
      voiceV -= 10
      voiceP -= 15   
	 elsif name.include? "rage"
	 expS = "Rage"
      voiceV += 15
      voiceP += 20       
	 elsif name.include? "love"
	 expS = "Love"
      voiceV += 10
      voiceP -= 10     
	 elsif name.include? "mole"
	 expS = "MOLE"
      voiceV += 15
      voiceP += 20     
	 end
	 expE += expS   
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true || $game_variables[7330] == 2
       voiceAc += (rand(4)+1).to_s
	     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #      
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   MHYRRA    ##########
  ##################################
  if name.include? "Mhyrra dial"
		px = 100
		py = 100   
		xp = -10
		yp = 75
	  n = "Mhyrra"      
	 if name.include? "2"
	   n += "2"
	 end  
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end      
	 expE = "MhyrraExp"
	 expS = ""
	 if name.include? "vis"
	 expS = "Vis"    
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ##########   BORDEAUX    ##########
  ##################################
  if name.include? "Bordeaux dial"
		px = 100
		py = 100   
		xp = 25
		yp = 125
	  n = "Bordeaux"     
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end      
	 expE = "BordeauxExp"
	 expS = "Calm"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "smile"
	 expS = "Smile"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   PAPA WEN    ##########
  ##################################
  if name.include? "PapaWendy dial"
		px = 100
		py = 100   
		xp = -45
		yp = -35
	  n = "PapaWendy"
	 if name.include? "silent"
	 n = "PapaWendySilent"    
	 end
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   QPEE    ##########
  ##################################
  if name.include? "Qpee dial"
		px = 100
		py = 100   
		xp = -70
		yp = 40
	  n = "Qpee"
	 expE = "QpeeExp"
	 expS = "Std"
	 if name.include? "shock"
	 expS = "Shock"    
	 elsif name.include? "malice"
	 expS = "Malice"
	 elsif name.include? "kiss"
	 expS = "Kiss"
	 elsif name.include? "jolly"
	 expS = "Jolly"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ##########   MIRA    ##########
  ##################################
  if name.include? "Mira dial"
		px = 100
		py = 100   
		xp = -50
		yp = 90
	  n = "Mira"    
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "MiraExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "pout"
	 expS = "Pout"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  #######   TRICLOP WICCA    #######
  ##################################
  tricky = 0
  if name.include? "Triclop Wicca"  
    tricky = 1
  end  
  if name.include? "Triclop Guard"  
    tricky = 1
  end    
  if tricky == 1
		px = 100
		py = 100   
		xp = -30
		yp = -30
	  n = "TriclopWicca"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end          
	 exp = "TriclopWiccaExp"
	 if name.include? "rage"
	 exp += "Rage"
	 elsif name.include? "sad"
	 exp += "Sad"
	 elsif name.include? "love"
	 exp += "Love"   
	 elsif name.include? "laugh"
	 exp += "Laugh"
	 else
	 exp += "Std"
	 end
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ##########   SVAARA    ##########
  ##################################
  if name.include? "ForgeP dial"
		px = 100
		py = 100   
		xp = -70
		yp = -10
	  n = "ForgeP"       
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end 
  ##################################
  #######   FORGE SPRITE    #######
  ##################################
  if name.include? "Forge Sprite dial"
		px = 100
		py = 100   
		xp = -70
		yp = -40	  
    n = "ForgeSprite"
	 if name.include? "rage"
	 n += "Rage"
	 elsif name.include? "sad"
	 n += "Sad"
	 else
	 n += "Std"
	 end
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  #######   ASHA    #######
  ##################################
  if name.include? "Asha dial"
		px = 100
		py = 100   
		xp = -120
		yp = 10
	  n = "Asha"
	 expE = "AshaExp"
	 expS = "Std"    
	 if name.include? "fiery"
	 n += "Fiery"
   expE = "AshaFieryExp"
   	xp = 70
		yp = 0
   end       
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end       
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "tch"
	 expS = "Tch"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  #######   ONI MERCHANT    #######
  ##################################
  if name.include? "Oni Merch"
		px = 100
		py = 100   
		xp = -80
		yp = -200
	  n = "OniMerch"
	 if name.include? "rage"
	 n += "Rage"
	 elsif name.include? "smile"
	 n += "Smile"
	 else
	 n += "Std"
	 end
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   CLARA    ##########
  ##################################
  if name.include? "Clara dial"
		px = 100
		py = 100   
		xp = 0
		yp = 35
	  n = "Clara"       
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "ClaraExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "serious"
	 expS = "Serious"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  ##########   Rigbu    ##########
  ##################################
  if name.include? "Rigbu dial"
		px = 100
		py = 100   
		xp = -20
		yp = -70
	  n = "Rigbu"       
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "RigbuExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "roar"
	 expS = "Roar"
	 elsif name.include? "shock"
	 expS = "Shock"
	 end
	 expE += expS
   if $game_map.map_id == 511
    $game_map.screen.pictures[113].show("RigbuH", 0, xp, yp, px, py, 255, 0)  
   end     
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end              
  ##################################
 ##########   Lezgar    ##########
  ##################################
  if name.include? "Lezgar dial"
		px = 100
		py = 100   
		xp = -20
		yp = -70
	  n = "Lezgar"       
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "LezgarExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "roar"
	 expS = "Roar"
	 elsif name.include? "shock"
	 expS = "Shock"
	 end
	 expE += expS
   if $game_map.map_id == 511
    $game_map.screen.pictures[113].show("LezgarH", 0, xp, yp, px, py, 255, 0)  
   end  
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end          
  ##################################
  ##########   Lezgar+Rigbu    ##########
  ##################################
  if name.include? "LezRib dial"
		px = 100
		py = 100   
		xp = 75
		yp = -150
	  n = "LezRib"
	  if name.include? "rage"
	  n += "Rage"    
	  else 
	  n += "Std"
    end
	  if name.include? "naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	  end 
    if $game_map.map_id == 511
     $game_map.screen.pictures[113].show("LezRibH", 0, xp, yp, px, py, 255, 0)  
    end  
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ########   Cat Sensei    ########
  ##################################
  if name.include? "Cat Sensei dial"
		px = 100
		py = 100   
		xp = 5
		yp = 60
	 n = "CatSensei"
	 expE = "CatSenseiExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 end
   expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ##########   Kaius    ##########
  ##################################
  if name.include? "Kaius dial"
		px = 100
		py = 100   
		xp = -135
		yp = -160
	 n = "Kaius"
	 if name.include? "chariot"
	 n += "Chariot"    
	 end
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ##########   Orata    ##########
  ##################################
  if name.include? "Orata dial"
		px = 100
		py = 100   
		xp = 0
		yp = -90
	 n = "Orata"
	 if name.include? "beaten"
	 n += " Beaten"    
	 end
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########   TANTRA P    ##########
  ##################################
  if name.include? "TantraP dial"
		px = 100
		py = 100   
		xp = -70
		yp = 0
	  n = "TantraP"      
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "TantraPExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "glad"
	 expS = "Glad"
	 elsif name.include? "calm"
	 expS = "Calm"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ##########   RABIES    ##########
  ##################################
  if name.include? "Rabies dial"
		px = 100
		py = 100   
		xp = -70
		yp = -150
	  n = "Rabies"  
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end            
	 expE = "RabiesExp"
	 expS = "Std"
	 if name.include? "rabid"
	 expS = "Rabid"    
	 elsif name.include? "sad"
	 expS = "Sad"    
	 end
	 expE += expS
    if name.include? "defeat"
    $game_map.screen.pictures[111].show("RabiesWep", 0, xp, yp, px, py, 255, 0)
    end
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ##########   FANG P    ##########
  ##################################
  if name.include? "FangP dial"
		px = 100
		py = 100   
		xp = 30
		yp = 70
	  n = "FangP"        
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "FangPExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "smirk"
	 expS = "Smirk"
	 elsif name.include? "shock"
	 expS = "Shock"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ##########   SNAILP    ##########
  ##################################
  if name.include? "SnailP dial"
		px = 100
		py = 100   
		xp = -50
		yp = 50
	  n = "SnailP"
	  if name.include? "Naked"  
		n += "N"
	  elsif nkdCheat == 1  
		n += "N"		
	  elsif name.include? "naked"
		n += "N"
	  elsif name.include? "f20"  
		n += "f20"
	  end        
	 expE = "SnailPExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "horny"
	 expS = "Horny"
	 elsif name.include? "disgust"
	 expS = "Disgust"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ###########   BABS    ###########
  ##################################
  if name.include? "Babs Dial"
		px = 100
		py = 100   
		xp = 0
		yp = 43
	  n = "Babs"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "BabsExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ########   Hypersonja    #########
  ##################################
  if name.include? "Hypersonja dial"
		px = 100
		py = 100   
		xp = -134
		yp = 106
	  n = "Hypersonja"      
	 expE = "HypersonjaExp"
	 expS = "Std"
	 if name.include? "awake"
	 expS = "Awake"    
	 elsif name.include? "passing"
	 expS = "Passing"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ###########   DIANA    ###########
  ##################################
  if name.include? "Diana dial"
		px = 100
		py = 100   
		xp = -10
		yp = 0
	  n = "Diana"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked" 
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "DianaExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "ara"
	 expS = "Ara"
	 elsif name.include? "glad"
	 expS = "Glad"
	 elsif name.include? "calm"
	 expS = "Calm"
	 end
	 expE += expS
	  $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ######   MOUSE#0 - Dot    ######
  ##################################
  dotCh = 0
  if name.include? "DotSis dial"
    dotCh = 1
  elsif name.include? "DotSis2 dial"
    dotCh = 1
  end  
  if dotCh == 1
		px = 100
		py = 100   
		xp = -30
		yp = -60
	  n = "Dot"
    expE = "DotExp"
    if name.include? "DotSis2 dial"
  	  n = ["DotFL", "DotFL2"].sample
      expE = "DotFLExp"
		  xp = 190
		  yp = -120
    end  
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ######   MOUSE#1 - SOCKET    ######
  ##################################
  if name.include? "Socket dial"
		px = 100
		py = 100   
		xp = -35
		yp = 0
	  n = "Socket"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
     elsif name.include? "topless" 
	   n += "Top"
     elsif name.include? "Topless" 
	   n += "Top"     
	 end        
	 expE = "SocketExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "determined"
	 expS = "Det"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 1 #socket on throne
      xcr = xp + 50
      ycr = yp + 100
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end  
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ######   MOUSE#2 - CHIME    ######
  ##################################
  if name.include? "Chime dial"
		px = 100
		py = 100   
		xp = -25
		yp = 0
	  n = "Chime"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "ChimeExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 2 #chime on throne
      xcr = xp + 0
      ycr = yp + 85
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end    
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ######   MOUSE#3 - REELA    ######
  ##################################
  if name.include? "Reela dial"
		px = 100
		py = 100   
		xp = -20
		yp = 0
	  n = "Reela"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "ReelaExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 6 #reela on throne
      xcr = xp + 40
      ycr = yp + 20
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end      
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end            
  ##################################
  ######   MOUSE# - CHRISTINE  #####
  ##################################
  if name.include? "Christine dial"
		px = 100
		py = 100   
		xp = -10
		yp = 0
	  n = "Christine"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
     elsif name.include? "shoe"
	   n += "N2"     
	 end        
	 expE = "ChristineExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "rage2"
	 expS = "Rage2"   
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 3 #christine on throne
      xcr = xp + 20
      ycr = yp + 90
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end   
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[114].show("ChristineGlasses", 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end               
  ##################################
  ######   MOUSE#4 - SATA    ######
  ##################################
  if name.include? "Sata dial"
		px = 100
		py = 100   
		xp = -20
		yp = -10
	  n = "Sata"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "SataExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 4 #sata on throne
      xcr = xp + 30
      ycr = yp + 150
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end      
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ######   MOUSE#5 - PIN    ######
  ##################################
  if name.include? "Pin dial"
		px = 100
		py = 100   
		xp = -20
		yp = -10
	  n = "Pin"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
     elsif name.include? "topless" 
	   n += "Top"
     elsif name.include? "Topless" 
	   n += "Top"     
	 end         
	 expE = "PinExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 5 #pin on throne  
      xcr = xp + 50
      ycr = yp + 160
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end         
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ######   MOUSE#3 - HELAH    ######
  ##################################
  if name.include? "Helah dial"
		px = 100
		py = 100   
		xp = -30
		yp = 0
	  n = "Helah"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
     elsif name.include? "topless" 
	   n += "Top"
     elsif name.include? "Topless" 
	   n += "Top"     
	 end           
	 expE = "HelahExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 9 #helah on throne
      xcr = xp + 70
      ycr = yp + 40
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
    end           
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end             
  ##################################
  ######   MOUSE#10 - LOLA    ######
  ##################################
  if name.include? "Lola dial"
		px = 100
		py = 100   
		xp = -35
		yp = 0
	  n = "Lola"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "LolaExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 10 #lola on throne 
      xcr = xp + 10
      ycr = yp - 3
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end        
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ######   MOUSE#7 - Miss Borne  ######
  ##################################
  if name.include? "Miss Borne dial"
		px = 100
		py = 100   
		xp = -25
		yp = 0
	  n = "MissBorne"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "MissBorneExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 7 #missborne on throne
      xcr = xp + 20
      ycr = yp + 105
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end       
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end           
  ##################################
  ######   MOUSE#9 - Loretta  ######
  ##################################
  if name.include? "Loretta dial"
		px = 100
		py = 100   
		xp = -35
		yp = 0
	  n = "Loretta"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end        
	 expE = "LorettaExp"
	 expS = "Std"
	 if name.include? "sad2"
	 expS = "Sad2"    
	 elsif name.include? "sad"
	 expS = "Sad"   
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "scared"
	 expS = "Scared"
	 end
	 expE += expS
   if $game_switches[2635] == true && $game_variables[779] == 8 #loretta on throne 
      xcr = xp + 40
      ycr = yp + 80
      $game_map.screen.pictures[111].show("MouSisCrown", 0, xcr, ycr, px, py, 255, 0)
   end         
	  $game_map.screen.pictures[112].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[113].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end         
  ##################################
  ########   ROBYN    ############
  ##################################
  if name.include? "Robyn dial"
		px = 100
		py = 100   
		xp = -65
		yp = -55
	  n = "Robyn"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end     
    expE = "RobynExp"      
		expS = "Std"
		if name.include? "sad"
		expS = "Sad"  
		elsif name.include? "rage"
		expS = "Rage"  
		elsif name.include? "love"
		expS = "Love"  
		elsif name.include? "tch"
		expS = "Tch"  
		elsif name.include? "bed"    
		expS = "Bed"
    end
    expE += expS
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end 
  ##################################
  ########   CHICHA    ############
  ##################################
  if name.include? "Chicha dial"
		px = 100
		py = 100   
		xp = -80
		yp = -20
	 n = "Chicha"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end   
	 expE = "ChichaExp"  
   expS = ""   
    if name.include? "sad"
		expS = "sad"  
		elsif name.include? "rage"
		expS = "rage"  
		elsif name.include? "love"
		expS = "love"  
		elsif name.include? "scoff"
		expS = "scoff"  
		elsif name.include? "ara"    
		expS = "ara"
    end
    expE += expS  
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(expE, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end 
  #####################
  ##### CRUSADER ######
  #####################
  if name.include? "CrusaderP dial"
		pos = 0
		px = 100
		py = 100   
		xp = 50
		yp = 80 
		expE = "CrusExp"
    expS = "Std"
		if name.include? "unimpressed"
		  expS = "Sad"
		elsif name.include? "rage"
		  expS = "Rage"
		elsif name.include? "impressed"
		  expS = "Love"
		elsif name.include? "shock"
		  expS = "Shock"
		elsif name.include? "ecstasy"
		  expS = "Ecstasy"
		end   
	   n = "CrusaderP"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
    exp = expE + expS
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end    
  #####################
  ##### AMELIE ######
  #####################  
  if name.include? "Amelie Dial"
		pos = 0
		px = 100
		py = 100     
		xp = 0
		yp = 75    
	 n = "Amelie" 
	 expE = "AmelieExp"
	 expS = "Std"
	 if name.include? "sad"
	 expS = "Sad"    
	 elsif name.include? "rage"
	 expS = "Rage"
	 elsif name.include? "love"
	 expS = "Love"
	 elsif name.include? "disgust"
	 expS = "Disgust"
	 end
	 expE += expS
	 if nkdCheat == 1
     n += "N"
    elsif name.include? "naked"
	   n += "N"
	 end   
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)
	$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)   
	return
end      
  #####################
  ##### LICHLING #####
  #####################
  if name.include? "Lichling dial"
		pos = 0
		px = 100
		py = 100   
		xp = 40
		yp = 105
		n = "Lichling"
		if name.include? "rage"
		  n = "LichlingRage"
		elsif name.include? "spook"
		  n = "LichlingSpook"      
    	xp = 0
	  	yp = 0
    end  
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end    
  #####################
  ##### PAPABEARD #####
  #####################
  if name.include? "PapaBeard Dial"
		pos = 0
		px = 100
		py = 100   
		xp = -90
		yp = -30
		n = "PapaBeard"
		if $game_variables[1794] >= 3 #fall or winter
		  n += " fallen"
		end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
  end    
  #####################
  ###### PUNTIA ######
  #####################
  if name.include? "Puntia dial"
		pos = 0
		px = 100
		py = 100   
		xp = 20
		yp = 90        
		n = "Puntia"
	  if nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
	    n += "N"
	  end     
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end      
  #####################
  ###### PRUNA ######
  #####################
  if name.include? "Pruna dial"
		pos = 0
		px = 100
		py = 100   
		xp = -60
		yp = 0        
		exp = "PrunaExp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "evil"
		  expS = "Evil"
		end   
		exp += expS
		n = "Pruna"
	  if nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
	    n += "N"
	  end     
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end             
  #####################
  ###### ACEROLA ######
  #####################
  if name.include? "Acerola dial"
		pos = 0
		px = 100
		py = 100   
		xp = -115
		yp = -20        
		exp = "AcerolaExp"
		expS = "Std"
		if  name.include? "weary"
		  expS = "Std"
		elsif  name.include? "pout"
		  expS = "Rage"
		elsif  name.include? "relief"
		  expS = "Relief"
		end  
		exp += expS
		n = "Acerola"
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end               
  ################
  ##### GEMA #####
  ################
  if name.include? "Gema dial"
		pos = 0
		px = 100
		py = 100   
		xp = -105
		yp = -30        
		exp = "GemaExp"
		expS = "Std"
		if  name.include? "Std"
		  expS = "Std"
		elsif  name.include? "sad"
		  expS = "Sad"
		elsif  name.include? "rage"
		  expS = "Rage"
		end  
		exp += expS
		n = "Gema"
		if $game_variables[1794] >= 3 #fall or winter
		  n += " fallen"
		end        
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end             
  #####################
  ##### JARDIN ######
  #####################
  if name.include? "Jardin Dial"
		pos = 0
		px = 100
		py = 100   
		xp = -25
		yp = 10
		exp = "JardinExp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "smug"
		  expS = "Smug"
		elsif  name.include? "love"
		  expS = "Love"
		end  
	   exp += expS
	   n = "Jardin"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
  end    
  #####################
  ##### TITANIA ######
  #####################
  if name.include? "Titania dial"
		pos = 0
		px = 100
		py = 100   
		xp = -50
    if $game_self_switches[[353,31,"A"]] == true && $game_self_switches[[353,31,"B"]] == false #titania ani
      xp = -115
    end  
		yp = -70  
		exp = "TitaniaExp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		end  
	   exp += expS
	   n = "Titania"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end      
  #####################
  ##### SHROUDS ######
  #####################
  if name.include? "Shroud dial"
    if name.include? "Shroud dial 2"
      n = "ShrLyanna"
    else
      n = "ShrMalia"
    end  
		pos = 0
		px = 100
		py = 100   
		xp = -30
		yp = 0  
    cost = n + "Dre"
		exp = n + "Exp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "Pleased"
		  expS = "Pleased"
		end  
	   exp += expS
	 if name.include? "naked"
     cost = ""
     elsif name.include? "Naked"
     cost = ""
     elsif nkdCheat == 1  
     cost = ""
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[113].show(cost, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end      
  #####################
  ##### SONNET ######
  #####################
  if name.include? "Sonnet Dial"
		pos = 0
		px = 100
		py = 100   
		xp = 50
		yp = 135  
		exp = "SonnetExp"
		expS = "Std"
		if  name.include? "embarass"
		  expS = "Emb"
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "scared"
		  expS = "Sca"
		elsif  name.include? "serious"
		  expS = "Srs"
		end  
	   exp += expS
	   n = "Sonnet"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end    
  #####################
  ##### MIMIC ######
  #####################
  if name.include? "Mimic Princess dial"
		pos = 0
		px = 100
		py = 100   
		xp = 10
		yp = 165
		exp = "MimicPExp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"
		elsif  name.include? "mad"
		  expS = "Rage"
		elsif  name.include? "allure"
		  expS = "Love"
		elsif  name.include? "hungry"
		  expS = "Hungry"
		end  
	  exp += expS       
	  n = "MimicP"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end     
  #####################
  ##### SPHINX ######
  #####################
  if name.include? "Sphinx Princess"
		pos = 0
		px = 100
		py = 100   
		xp = 0
		yp = 135
		exp = "SphinxPExp"
		expS = "Std"
		if  name.include? "sad2"
		  expS = "Sad2"
		elsif  name.include? "sad"
		  expS = "Sad"          
		elsif  name.include? "mad"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "smug"
		  expS = "Smug"      
		elsif  name.include? "pout"
		  expS = "Pout"
		elsif  name.include? "lust"
		  expS = "Lust"
		end  
	  exp += expS       
	  n = "SphinxP"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end       
  #####################
  ##### CRYSTAL ######
  #####################
  if name.include? "Crystal Princess"
		pos = 0
		px = 100
		py = 100   
		xp = -80
		yp = -100
		exp = "CrystalPExp"
		expS = "Std"
		if  name.include? "sad2"
		  expS = "Sad2"
		elsif  name.include? "sad"
		  expS = "Sad"          
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "sleep"
		  expS = "Sleep"
		end  
	  exp += expS       
	  n = "CrystalP"
	  if name.include? "crownless"
		n += "Crown"   
	  end  
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end 
  #####################
  ##### MER SIS 1 ######
  #####################
  if name.include? "Mermaid Sis1"
		pos = 0
		px = 100
		py = 100   
		xp = -40
		yp = 20
		exp = "MerSis1Exp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"   
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"          
		elsif  name.include? "wary"
		  expS = "Wary"
		elsif  name.include? "mock"
		  expS = "Mock"
		end  
	  exp += expS       
	  n = "MerSis1"    
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)             
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end          
  #####################
  ##### MER SIS 2 ######
  #####################
  if name.include? "Mermaid Sis2"
		pos = 0
		px = 100
		py = 100   
		xp = -20
		yp = 50
		exp = "MerSis2Exp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"   
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"          
		elsif  name.include? "love2"
		  expS = "Love2"                   
		elsif  name.include? "wary"
		  expS = "Wary"
		elsif  name.include? "mock"
		  expS = "Mock"
		end  
	  exp += expS       
	  n = "MerSis2"    
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)             
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end       
  #####################
  ##### MER SIS 3 ######
  #####################
  if name.include? "Mermaid Slave"
		pos = 0
		px = 100
		py = 100   
		xp = -70
		yp = 85
		exp = "MerSis3Exp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"   
		elsif  name.include? "cry"
		  expS = "Cry"          
		elsif  name.include? "lust"
		  expS = "Love"
		elsif  name.include? "grateful"
		  expS = "Glad"
		end  
	  exp += expS       
	  n = "MerSis3"    
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
	  unless name.include? "SlaveF"  
		$game_map.screen.pictures[113].show("MerSis3Chains", pos, xp, yp, px, py, 255, 0)
	  end                
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end       
  #####################
  ###### CALYPSO ######
  #####################
  if name.include? "Calypso dial"
		pos = 0
		px = 100
		py = 100   
		xp = -25
		yp = 15
		exp = "CalypsoExp"
		expS = "Std"
		if name.include? "sad"
		  expS = "Sad"        
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "blush"
		  expS = "Blush"          
		end  
	  exp += expS       
	  n = "CalypsoBod"     
	  if name.include? "naked"
		n += "N"
	elsif name.include? "Naked"
		n += "N"
	elsif nkdCheat == 1  
	   n += "N"
	  end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
  end           
  #####################
  ###### OBSERVER #######
  #####################
  obsCH = 0
  if name.include? "Observer dial"
    obsCH = 1
  elsif name.include? "Observer2 dial"
    obsCH = 1
  end  
  if obsCH == 1
		pos = 0
		px = 100
		py = 100   
		xp = 0
		yp = 0
	  n = "OBSERVER"   
    acc = ""
    if name.include? "Observer2"
  	  acc = "OBSERVERdot"
    end       
if acc == "OBSERVERdot"
    voiceAc = "VoiceMou"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end      
    voiceV = 90
    voiceP = 130 
  else
   voiceAc = "Observer" + ["1","2","3","4"].sample 
   voiceV = 100
   voiceP = 70 + [0,10,20].sample  
end  
  RPG::SE.new(voiceAc, voiceV, voiceP).play   
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(acc, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end        
  #####################
  ###### RIN #######
  #####################
  rinCH = 0
  if name.include? "Rin dial"
    rinCH = 1
  elsif name.include? "Rin2 dial"
    rinCH = 1
  end  
  if rinCH == 1
		pos = 0
		px = 100
		py = 100   
		xp = 20
		yp = 165
		exp = "RinExp"
		expS = "Std"
	  n = "RinBod"   
	  if name.include? "naked"
		n += "N"
	elsif name.include? "Naked"
		n += "N"
	elsif nkdCheat == 1  
	   n += "N"
	  end    
    if name.include? "Rin2 dial"
  	  n = ["RinBodFL", "RinBodFL2"].sample
      exp = "RinFLExp"
		  xp = 240
		  yp = 50
    end     
		if name.include? "mad"
		  expS = "Mad"    
		elsif name.include? "mad2"
		  expS = "Mad2"        
		elsif name.include? "sad"
		  expS = "Sad"      
		elsif name.include? "calm"
		  expS = "Calm"
		elsif name.include? "scared"
		  expS = "Scared"      
		end  
	  exp += expS       
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end            
  #####################
  ### GUILD CLERK ####
  #####################
  if name.include? "Guild Clerk"
		pos = 0
		px = 100
		py = 100   
		xp = 0
		yp = 0
		exp = "GuildExp"
		expS = "Std"
		if name.include? "sad"
		  expS = "Sad"        
		elsif name.include? "rage"
		  expS = "Rage"
		elsif name.include? "love"
		  expS = "Pleased"      
		elsif name.include? "pleased"
		  expS = "Pleased"
		elsif name.include? "srs"
		  expS = "Srs"
		elsif name.include? "smug"
		  expS = "Smug"      
		elsif name.include? "heat"
		  expS = "Heat"          
		end  
	  exp += expS       
	  n = "GuildBod"   
	  if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
		n += "N"
	  elsif name.include? "SS"  
		n += "SS"
	  end  
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end         
  #####################
  ##### HAMMER P ######
  #####################
  if name.include? "HammerP dial"
		pos = 0
		px = 100
		py = 100   
		xp = -88
		yp = -8
		exp = "HammerPExp"
		expS = "Std"
		if  name.include? "sad2"
		  expS = "Sad2"   
		elsif  name.include? "sad"
		  expS = "Sad"          
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "smug"
		  expS = "Smug"
		elsif  name.include? "shark"
		  expS = "Shark"      
		end  
	  exp += expS       
	  n = "HammerP"
	  if name.include? "hidden"  
		n += "hidden"
		exp = ""
	  elsif name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end               
  #####################
  ##### GAZER ######
  #####################
  if name.include? "Gazer Princess dial"
		pos = 0
		px = 100
		py = 100   
		xp = 0
		yp = 60
		exp = "GazerPExp"
		expS = "Std"
		if  name.include? "sad2"
		  expS = "Sad2"   
		elsif  name.include? "sad"
		  expS = "Sad"          
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "smug"
		  expS = "Smug"
		end  
	  exp += expS       
	  n = "GazerP"
	  if name.include? "Hidden"  
		n += "hidden"
		exp = ""
	  elsif name.include? "naked"
    n += "N"
     elsif name.include? "Naked"
    n += "N"
     elsif nkdCheat == 1  
	  n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end           
  #####################
  ##### PIRATE ######
  #####################
  if name.include? "PirateP dial"
		pos = 0
		px = 100
		py = 100   
		xp = 0
		yp = 10
		exp = "PiratePExp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"   
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "HAR"
		  expS = "Har"
		end  
	  exp += expS       
	  n = "PirateP"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end          
  #####################
  ##### KHEERA ######
  #####################
  if name.include? "Kheera dial"
		pos = 0
		px = 100
		py = 100   
		xp = 56
		yp = 134
		exp = "KheeraExp"
		expS = "Std"
		if  name.include? "sad"
		  expS = "Sad"   
		elsif  name.include? "rage"
		  expS = "Rage"
		elsif  name.include? "love"
		  expS = "Love"
		elsif  name.include? "scared"
		  expS = "Scared"
		end  
	  exp += expS       
	  n = "Kheera"
   if name.include? "Kheera dial2"
      n = "KheeraPimp"
   end  
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
  end     
  #####################
  ####### MOSS #######
  #####################
  if name.include? "Moss Princess dial"
		pos = 0
		px = 100
		py = 100   
		xp = 50
		yp = 110  
    n = "MossP"
    crown = "Moss"
    if name.include? "Lump"
      n += "Lump"
      crown += "Lump"
      xp = 50
		  yp = 350 
    end  
    crown = ""
    if name.include? "dialC"
      crown += "Crown"
    end     
		if name.include? "crying"
		  n += "Sad"
		elsif name.include? "silent"
		  n += "Silent"
		elsif name.include? "embarassed"
		  n += "Embarass"
		elsif name.include? "asleep"
		  n += "Asleep"
    else
      n += "Std"
		end 
		$game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[111].show(crown, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
  end    
  #####################
  ####### ZEGRE #######
  #####################
  if name.include? "Zegre dial"
		pos = 0
		px = 100
		py = 100   
		xp = 10
		yp = 65  
		exp = "ZegreExp"
		if name.include? "sad"
		  exp += "Sad"
		elsif name.include? "rage"
		  exp += "Rage"
		elsif name.include? "love"
		  exp += "Love"
		elsif name.include? "heat"
		  exp += "Heat"
		elsif name.include? "roar"
		  exp += "Roar"      
    else
      exp += "Std"
		end    
	   n = "Zegre"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
  end      
  #####################
  ##### EDLRITCH ######
  #####################
  if name.include? "Eldritch Princess"
		pos = 0
		px = 100
		py = 100   
		xp = -20
		yp = 5  
		exp = "EldritchExp"
		if name.include? "sad"
		  exp += "Sad"
		elsif name.include? "rage"
		  exp += "Rage"
		elsif name.include? "love"
		  exp += "Love"
		elsif name.include? "grin"
		  exp += "Grin"
    else
      exp += "Std"
		end    
	   n = "EldritchP"
	 if name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
  end    
  #####################
  ###### ChainP ######
  #####################
  if name.include? "ChainP dial"
		pos = 0
		px = 100
		py = 100   
		xp = -20
		yp = 0 
    #voice Base
    voiceAc = ""
    voiceV = 90
    voiceP = 100       
		exp = "ChainPExp"
		if name.include? "sad"
      voiceV -= 10
      voiceP -= 15      
		  exp += "Sad"
		elsif name.include? "rage"
      voiceV += 15
      voiceP += 20          
		  exp += "Rage"
		elsif name.include? "love"
		  exp += "Love"
      voiceV += 10
      voiceP -= 10         
		elsif name.include? "mock"
		  exp += "Mock"
      voiceV += 10
      voiceP -= 10   
    elsif name.include? "gasp"
      voiceV -= 10
      voiceP -= 15      
		  exp += "Gasp"  
    else
      exp += "Std"
		end    
	  n = "ChainP"	 
	 if name.include? "hidden"
	   n += "h"
	  elsif name.include? "naked"
     n += "N"
     elsif name.include? "Naked"
     n += "N"
     elsif nkdCheat == 1  
	   n += "N"
	 end   
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true || $game_variables[7330] == 2
	     RPG::SE.new("Chain", voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
		return
	  end      
  ##################################
  ########   PRINCESS    ###########
  ##################################  
  #--------------------------------#
  ##################################
  ##########   KOBOLD  #############
  ################################## 
  if name.include? "Kobold Princess Dial"
	pPort = "Kobold"
  elsif name.include? "KobMenu"
	pPort = "Kobold"
  end
  if pPort == "Kobold"
		pRace = 1
		pVar = 4001
		px = 100
		py = 100   
		xp = -149
		yp = 63
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70             
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		end       
  if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[579] == true || $game_switches[2411] == true
  pos = 1
	else
  pos = 0
  end      
	  priExp = ""
	  exp = ""
	  bodyB = "KoboldPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "KoboldPHead"
	  expBase = "KoboldPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 2	  
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	$game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad2"
	  $game_variables[4000][2] = 1
	  exp = "Sad2"    
	elsif name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"    
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "heat"
	  $game_variables[4000][2] = 4
	  exp = "Heat" 
	elsif name.include? "det"
	  $game_variables[4000][2] = 5
	  exp = "Det" 
	end       
	if name == "KobMenu"
	  $game_variables[4000][2] = 10
	  exp = "Std"
	elsif name == "KobMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Std"
	end   
    #voice Base
    voiceAc = "VoiceKob"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end      
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 4
      voiceV += 10
      voiceP -= 10      
    end  
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[2356] == true #dra form
		$game_variables[4000][5] = 1
	  elsif $game_switches[4120] == true #kobold dog
		$game_variables[4000][5] = 2
		bodyS = "Dog"      
		expS = bodyS
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] <= 1 #allowed with drakebold form
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
	  end  
	  if $game_switches[2225] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	   if name.include? "Naked"
		  nkd = 1
		 elsif name.include? "naked"
			 nkd = 1     
		 end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[203]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[63]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
      needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[178]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[127]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[102]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[325]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[400]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[426]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[455]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"     
  elsif $game_actors[@ac].equips[5] == $data_armors[640]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Net"   
  elsif $game_actors[@ac].equips[5] == $data_armors[72]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "2"        
  elsif $game_actors[@ac].equips[5] == $data_armors[227]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Rogue"
  elsif $game_actors[@ac].equips[5] == $data_armors[424]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Tear"          
  elsif $game_actors[@ac].equips[5] == $data_armors[505] || $game_actors[@ac].equips[5] == $data_armors[506]
		  then
		  $game_variables[4000][6] = 21
		  bodyS = "Coatl"
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[557]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"                     
  elsif $game_actors[@ac].equips[5] == $data_armors[592]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "Zegre"    
      needHelm = 1
		end 
		end
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
  if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
 end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
    $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if $game_switches[2356] == true #drake
	  $game_map.screen.pictures[111].show("KoboldPaccWings", pos, xp, yp, px, py, 255, 0)
	end  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end
  end  
  return 
  end  #toRND
  end
  ##################################
  ############   DOG  #############
  ################################## 
  if name.include? "Dog Princess Dial"
	pPort = "Dog"
  elsif name.include? "DogMenu"
	pPort = "Dog"
  end
  if pPort == "Dog"
		pRace = 12
		pVar = 4012
		px = 100
		py = 100   
		xp = -134
		yp = 52
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70             
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		end       
  if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[579] == true || $game_switches[2411] == true
  pos = 1
	else
  pos = 0
  end      
	  priExp = ""
	  exp = ""
	  bodyB = "DogPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "DogPHead"
	  expBase = "DogPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 16
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	$game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "mad"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "yan"
	  $game_variables[4000][2] = 4
	  exp = "Yan" 
	end       
	if name == "DogMenu"
	  $game_variables[4000][2] = 10
	  exp = "Yan"
	elsif name == "DogMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Yan"
	end 
    #voice Base
    voiceAc = "VoiceDog"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10   
    elsif $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP += 25       
    end    
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
	  elsif $game_switches[2338] == true #djinn form
		$game_variables[4000][5] = 1
		bodyS = "Shitzu"   
		expS = "none"
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
	  end  
	  if $game_switches[2236] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1     
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[214]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[150]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[189]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[138]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[113]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[336]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[411]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
		  expS = "none"
  elsif $game_actors[@ac].equips[5] == $data_armors[437]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[466]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"   
  elsif $game_actors[@ac].equips[5] == $data_armors[486]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Wor"     
		  needHelm = 1         
  elsif $game_actors[@ac].equips[5] == $data_armors[194]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Momi"        
  elsif $game_actors[@ac].equips[5] == $data_armors[353]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Amat"
  elsif $game_actors[@ac].equips[5] == $data_armors[356]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Red" 
  elsif $game_actors[@ac].equips[5] == $data_armors[663]
		  then
		  $game_variables[4000][6] = 21
		  bodyS = "Squirt"     
      needHelm = 1     
  elsif $game_actors[@ac].equips[5] == $data_armors[617]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"          
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
$game_variables[4012][56] = 0
if goInPRND == 0
	  if $game_actors[@ac].equips[4] == $data_armors[241] #CUFFS
		$game_variables[4012][56] = 1 
		cuffs = ""         
		cuffM = "Std"
	  if bodyS.include? "Shitzu"
		cuffM = "Shitzu"
	  elsif bodyS.include? "Succ"
		cuffM = "Succ"                 
	  elsif bodyS.include? "Thicc"
		cuffM = "Thicc"     
	  end              
		cuffs = "DogPHeadCuffs" + cuffM
	  $game_map.screen.pictures[120].show(cuffs, pos, xp, yp, px, py, 255, 0)  
	  end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  return 
  end  #toRND
  end
  ##################################
  ############   MOTH  #############
  ################################## 
  if name.include? "Moth Princess Dial"
	pPort = "Moth"
  elsif name.include? "MothMenu"
	pPort = "Moth"
  end
  if pPort == "Moth"
		pRace = 10
		pVar = 4010
		px = 100
		py = 100   
		xp = -169
		yp = -52
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "MothPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "MothPHead"
	  expBase = "MothPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 21
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]  
	$game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "mad2"
	  $game_variables[4000][2] = 2
	  exp = "Rage2"
	elsif name.include? "mad"
	  $game_variables[4000][2] = 2
	  exp = "Rage"    
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "glad"
	  $game_variables[4000][2] = 4
	  exp = "Glad" 
	end       
	if name == "MothMenu"
	  $game_variables[4000][2] = 10
	  exp = "Glad"
	elsif name == "MothMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Glad"
	end    
    #voice Base
    voiceAc = "VoiceMot"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10         
    end  
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[2460] == true #butterfly form
		$game_variables[4000][5] = 1
		bodyS = "But" 
	  elsif $game_switches[4118] == true #fairy form
		$game_variables[4000][5] = 2
		bodyS = "Fairy"   
		if pos == 0    
		needPos = 1
		end  
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
	  end  
	  if $game_switches[2234] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
    end  
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1     
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" && $game_switches[789] == false  
      #no alt form / costumes allowed / route end
  if $game_actors[@ac].equips[5] == $data_armors[212]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[148]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[187]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
  elsif $game_actors[@ac].equips[5] == $data_armors[136]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[111]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[334]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[409]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
  elsif $game_actors[@ac].equips[5] == $data_armors[435]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[464]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"   
  elsif $game_actors[@ac].equips[5] == $data_armors[641]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Net"         
  elsif $game_actors[@ac].equips[5] == $data_armors[121]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Vest"         
  elsif $game_actors[@ac].equips[5] == $data_armors[573]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Death"           
  elsif $game_actors[@ac].equips[5] == $data_armors[620]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"          
		end                  
	  end 
	  body = bodyB + bodyS
    if name.include? "Xidden"
      body = "MothPbodHidden"
      expS = "Xidden"
    end
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
  	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	  $game_switches[4001] = true
	  name = "RND"
	 end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   if name.include? "hidden"
	 $game_map.screen.pictures[113].show("MothPbodHidden", pos, xp, yp, px, py, 255, 0)
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	 else
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	  if needPos == 1 
		  if bodyS.include? "Fairy"
		   yp += (0.5 * px)  
		  end
		 end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
   xexp = xp
   yexp = yp
    if bodyS.include? "Fairy"
		   yexp += (1.4 * px)  
	  end
	  $game_map.screen.pictures[117].show(priExp, pos, xexp, yexp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end  
   end
  if $game_switches[579] == true && $game_switches[1622] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end  #hidden
  end
  ##################################
  ############   FINHEAD  #############
  ################################## 
  if name.include? "FinheadP dial"
	pPort = "Finhead"
  elsif name.include? "FinheadMenu"
	pPort = "Finhead"
  end
  if pPort == "Finhead"
		pRace = 17
		pVar = 4017
		px = 100
		py = 100   
		xp = -137
		yp = 64
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "FinheadPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "FinheadPHead"
	  expBase = "FinheadPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 46
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "smug"
	  $game_variables[4000][2] = 4
	  exp = "Smug"
  elsif name.include? "glad"
	  $game_variables[4000][2] = 5
	  exp = "Glad"      
	end       
	if name == "FinheadMenu"
	  $game_variables[4000][2] = 10
	  exp = "Smug"
	elsif name == "FinheadMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Smug"
	end  
    #voice Base
    voiceAc = "VoiceFin"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 5
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end   
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[4593] == true #bird form
		$game_variables[4000][5] = 1
		bodyS = "Bir"   
		expS = bodyS
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
	  end  
	  if $game_switches[4052] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked" 
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1     
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[219]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[307]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[309]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[568]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "War2"
		  needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[308]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[306]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[341]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[416]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
  elsif $game_actors[@ac].equips[5] == $data_armors[442]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[471]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20" 
  elsif $game_actors[@ac].equips[5] == $data_armors[651]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Shell"     
  elsif $game_actors[@ac].equips[5] == $data_armors[684]
		  then
		  $game_variables[4000][6] = 21
		  bodyS = "Kono"    
      needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[629]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"       
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#   
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[4057] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ############   MERMAID  ############
  ################################## 
  if name.include? "MermaidP dial"
	pPort = "Mermaid"
  elsif name.include? "MermaidMenu"
	pPort = "Mermaid"
  end
  if pPort == "Mermaid"
		pRace = 18
		pVar = 4018
		px = 100
		py = 100   
		xp = -330
		yp = -160
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "MermaidPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "MermaidPHead"
	  expBase = "MermaidPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 48
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "mock"
	  $game_variables[4000][2] = 4
	  exp = "Mock"      
	elsif name.include? "wary"
	  $game_variables[4000][2] = 5
	  exp = "Wary"               
	end       
	if name == "MermaidMenu"
	  $game_variables[4000][2] = 10
	  exp = "Wary"
	elsif name == "MermaidMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Wary"
	end  
    #voice Base
    voiceAc = "VoiceMer"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 5
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end     
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS        
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[4595] == true #scylla form
		$game_variables[4000][5] = 1
		bodyS = "Scylla"   
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc" 
	  end  
	  if $game_switches[4232] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[220]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[360]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[361]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"     
		  needHelm = 1   
  elsif $game_actors[@ac].equips[5] == $data_armors[362]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
		  needHelm = 1   
  elsif $game_actors[@ac].equips[5] == $data_armors[359]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[342]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[370]
		  then
		  $game_variables[4000][6] = 9
		  bodyS = "Selkie"  
		  needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[417]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"    
		  needHelm = 1         
  elsif $game_actors[@ac].equips[5] == $data_armors[443]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"        
  elsif $game_actors[@ac].equips[5] == $data_armors[472]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"
		  needHelm = 1  
  elsif $game_actors[@ac].equips[5] == $data_armors[652]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Shell"    
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#    
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	  if bodyS.include? "Scylla"
		if pos == 0
		xp -= (0.4*px)
		yp += (1.2*px)
		end
	  end       
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	 if needHelm == 1
	  helmx = xp
	  helmy = yp
	  if bodyS == "H20"
		helmx = xp + (0.2*px)
		helmy = yp - (1.9*px)
	  end  
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, helmx, helmy, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, helmx, helmy, px, py, 255, 0) 
	 end      
	 xexp = xp
	 yexp = yp
	 if bodyS.include? "Scylla"
		xexp = xp + (0.45*px)
		yexp = yp - (1.15*px)
	  end  
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xexp, yexp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
 end
  if $game_switches[579] == true && $game_switches[4273] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
end
  ##################################
  ##########  SHADOW P  #############
  ################################## 
if name.include? "ShadowP dial"
	pPort = "Shadow"
  elsif name.include? "ShaMenu"
	pPort = "Shadow"
end
if pPort == "Shadow"
	pRace = 22
	pVar = 4031
	px = 100
	py = 100   
	xp = -410
	yp = -75
	pos = 0   
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 70
		py = 70         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 240
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 105
		yp = 320
		px = 70
		py = 70   
		pos = 1
	  end  
	  priExp = ""
	  exp = ""
	  bodyB = "ShadowPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "ShadowPHead"
	  expBase = "ShadowPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 57
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = 31
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
		$game_variables[4000][2] = 1
		exp = "Sad"
	  elsif name.include? "rage"
		$game_variables[4000][2] = 2
		exp = "Rage"
	  elsif name.include? "love"
		$game_variables[4000][2] = 3
		exp = "Love"
	  elsif name.include? "grin"
		$game_variables[4000][2] = 4
		exp = "Grin"       
	  elsif name.include? "glad"
		$game_variables[4000][2] = 0
		exp = "Glad"    
	  elsif name.include? "smirk"
		$game_variables[4000][2] = 0
		exp = "Glad"        
	  elsif name.include? "eye"
		$game_variables[4000][2] = 7
		exp = "Eye"    
	  end           
	  if name == "ShaMenu"
		$game_variables[4000][2] = 10
		exp = "Std"
	  elsif name == "ShaMenuH"
		$game_variables[4000][2] = 11
		exp = "Std"
    end         
    #voice Base
    voiceAc = "VoiceSha"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 5 
      voiceV += 10
      voiceP -= 10     
    elsif $game_variables[4000][2] == 7
      voiceV = 30
      voiceP -= 50       
    end     
	#succ check
	@sch = 22
	@succ = $game_variables[6401][@sch] rescue -1
	@prince = $game_variables[6406][@sch] rescue -1
	#succ check
  @shadMaps = [125,531,532,533,535]
  if @shadMaps.include?$game_map.map_id
    bodyS = "Sha"    
    expS = bodyS
  elsif $game_switches[579] == true || $game_switches[2840] == true
    bodyS = "Sha" 
    expS = bodyS
	elsif $game_switches[3959] == true || @prince == 2 #pri form
	  bodyS = "Prince"
    expS = bodyS
	elsif @succ == 2 
	  $game_variables[4000][5] = 5
	  bodyS = "Succ"
    expS = bodyS
	elsif $game_variables[6202][22] >= @thiccLim && $game_variables[4000][5] == 0
	  $game_variables[4000][5] = 3
	  bodyS = "Thicc"     
	end  
	if $game_switches[2813] == true && bodyS != "Thicc" && bodyS != "Prince"
	  $game_variables[4000][4] = 1
	  bodyS += "Pre"
	end  
   ### SHAD ###   
  @nkd = 0
  if name.include? "naked"
   @nkd = 1  
  elsif name.include? "Naked" 
   @nkd = 1 
 end   
 #########
  if !bodyS.include?"Sha"
	if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || @nkd == 1 || nkdCheat == 1
	  $game_variables[4000][3] = 1
	  bodyS += "Naked"
	end  
  end
	if bodyS == "" #no alt form / costumes allowed
if $game_actors[@ac].equips[5] == $data_armors[224]
		then
		$game_variables[4000][6] = 5
		bodyS = "Bunny"
    needHelm = 1
elsif $game_actors[@ac].equips[5] == $data_armors[762]
		then
		$game_variables[4000][6] = 2
		bodyS = "Maid"
elsif $game_actors[@ac].equips[5] == $data_armors[764]
		then
		$game_variables[4000][6] = 4
		bodyS = "War"
    needHelm = 1
elsif $game_actors[@ac].equips[5] == $data_armors[763]
		then
		$game_variables[4000][6] = 3
		bodyS = "Pri"
elsif $game_actors[@ac].equips[5] == $data_armors[761]
		then
		$game_variables[4000][6] = 1
		bodyS = "SS"
    needHelm = 1
elsif $game_actors[@ac].equips[5] == $data_armors[347]
		then
		$game_variables[4000][6] = 6
		bodyS = "Court"
elsif $game_actors[@ac].equips[5] == $data_armors[765]
		then
		$game_variables[4000][6] = 13
		bodyS = "H20"        
		needHelm = 1 
    expS = bodyS
elsif $game_actors[@ac].equips[5] == $data_armors[766]
		then
		$game_variables[4000][6] = 15
		bodyS = "C20"       
elsif $game_actors[@ac].equips[5] == $data_armors[767]
		then
		$game_variables[4000][6] = 16
		bodyS = "F20"       
elsif $game_actors[@ac].equips[5] == $data_armors[635]
		then
		$game_variables[4000][6] = 22
		bodyS = "Bar"           
	end  
  end
	body = bodyB + bodyS   
#--------------------------------#
if pRace != 0 && pVar != 0
 if $game_variables[4000][1] == 31 && $game_variables[pVar][0] != 0 
  if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
   $game_switches[4001] = true
   name = "RND"
  end
 end
end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#    
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == 31 && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   if name.include? "hidden"
	 $game_map.screen.pictures[113].show("ShadowPbodHidden", pos, xp, yp, px, py, 255, 0)
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
  unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
  end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	 else  
 goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	 # if bodyS.include? "Succ"
	 # if pos == 0
	 # xp += (0.2*px)
	 # yp -= (1.4*px)
   # end
	 # end       
	 $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)   
   if needHelm == 1
	 helm = helmBase + bodyS
	 helmB = helmBase + bodyS + "B" 
	 $game_map.screen.pictures[119].show(helm, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
   end      
	priExp = expBase + expS + exp 
	$game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
 if inMenu == 0
  if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
 end  
end
  if $game_switches[579] == true && $game_switches[3138] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
end  #toRND
end  #hidden
end
  ##################################
  ############  TOY    #############
  ################################## 
  if name.include? "ToyP dial"
	pPort = "Toy"
  elsif name.include? "ToyMenu"
	pPort = "Toy"
end
if pPort == "Toy"
	pRace = 23
	pVar = 4032
	px = 100
	py = 100   
	xp = -340
	yp = -45
	pos = 0
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 70
		py = 70         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 240
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
		px = 70
		py = 70   
		pos = 1
	  end  
	  priExp = ""
	  exp = ""
	  bodyB = "ToyPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "ToyPHead"
	  expBase = "ToyPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 59
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = 32
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
		$game_variables[4000][2] = 1
		exp = "Sad"
	  elsif name.include? "rage"
		$game_variables[4000][2] = 2
		exp = "Rage"
	  elsif name.include? "love"
		$game_variables[4000][2] = 3
		exp = "Love"
	  elsif name.include? "spooky"
		$game_variables[4000][2] = 4
		exp = "Spooky"               
	  end           
	  if name == "ToyMenu"
		$game_variables[4000][2] = 10
		exp = "Std"
	  elsif name == "ToyMenuH"
		$game_variables[4000][2] = 11
		exp = "Std"
    end         
    #voice Base
    voiceAc = "VoiceToy"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
   voiceV = 90
   voiceP = 100    
	#succ check
	@sch = 23
	@succ = $game_variables[6401][@sch] rescue -1
	@prince = $game_variables[6406][@sch] rescue -1
	#succ check
	if $game_switches[3959] == true || @prince == 2 #pri form
	  #bodyS = "Prince"
    #expS = bodyS
	elsif @succ == 2 
	  $game_variables[4000][5] = 5
	  bodyS = "Succ"
	elsif $game_switches[1719] == true #Human ToyP
	  $game_variables[4000][5] = 2
	  bodyS = "Human"      
	  expS = bodyS        
	elsif $game_variables[6202][23] >= @thiccLim && $game_variables[4000][5] == 0
	  $game_variables[4000][5] = 3
	  bodyS = "Thicc"     
	end  
	if $game_switches[1708] == true && bodyS != "Thicc" && bodyS != "Prince"
	  $game_variables[4000][4] = 1
	  bodyS += "Pre"
	end  
  #########
  @nkd = 0
  if name.include? "naked"
   @nkd = 1  
  elsif name.include? "Naked" 
   @nkd = 1 
 end  
 #########
	if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || @nkd == 1 || nkdCheat == 1
	  $game_variables[4000][3] = 1
	  bodyS += "Naked"
	end  
	if bodyS == "SUSPENDCOSTUMES" #no alt form / costumes allowed
if $game_actors[@ac].equips[5] == $data_armors[223]
		then
		$game_variables[4000][6] = 5
		bodyS = "Bunny"
elsif $game_actors[@ac].equips[5] == $data_armors[582]
		then
		$game_variables[4000][6] = 2
		bodyS = "Maid"
elsif $game_actors[@ac].equips[5] == $data_armors[584]
		then
		$game_variables[4000][6] = 4
		bodyS = "War"
elsif $game_actors[@ac].equips[5] == $data_armors[597]
		then
		$game_variables[4000][6] = 23
		bodyS = "War2"
    expS = bodyS
elsif $game_actors[@ac].equips[5] == $data_armors[583]
		then
		$game_variables[4000][6] = 3
		bodyS = "Pri"
elsif $game_actors[@ac].equips[5] == $data_armors[581]
		then
		$game_variables[4000][6] = 1
		bodyS = "SS"
elsif $game_actors[@ac].equips[5] == $data_armors[345]
		then
		$game_variables[4000][6] = 6
		bodyS = "Court"
elsif $game_actors[@ac].equips[5] == $data_armors[585]
		then
		$game_variables[4000][6] = 13
		bodyS = "H20"        
		needHelm = 1 
elsif $game_actors[@ac].equips[5] == $data_armors[586]
		then
		$game_variables[4000][6] = 15
		bodyS = "C20"       
elsif $game_actors[@ac].equips[5] == $data_armors[587]
		then
		$game_variables[4000][6] = 16
		bodyS = "F20"   
elsif $game_actors[@ac].equips[5] == $data_armors[661]
		then
		$game_variables[4000][6] = 18
		bodyS = "Saur"               
elsif $game_actors[@ac].equips[5] == $data_armors[631]
	  then
	  $game_variables[4000][6] = 22
	  bodyS = "Bar"     
		end          
	end  
	body = bodyB + bodyS   
#--------------------------------#
if pRace != 0 && pVar != 0
 if $game_variables[4000][1] == 30 && $game_variables[pVar][0] != 0 
  if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
   $game_switches[4001] = true
   name = "RND"
  end
 end
end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#    
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == 30 && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   if name.include? "hidden"
	 $game_map.screen.pictures[113].show("ToyPbodHidden", pos, xp, yp, px, py, 255, 0)
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
  unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
  end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	 else  
 goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	 # if bodyS.include? "Succ"
	 # if pos == 0
	 # xp += (0.2*px)
	 # yp -= (1.4*px)
   # end
	 # end       
	 $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)   
   if needHelm == 1
	 helm = helmBase + bodyS
	 helmB = helmBase + bodyS + "B" 
	 $game_map.screen.pictures[119].show(helm, pos, helmx, helmy, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(helmB, pos, helmx, helmy, px, py, 255, 0) 
   end      
	priExp = expBase + expS + exp 
	$game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
 if inMenu == 0
  if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
 end  
end
  if $game_switches[579] == true && $game_switches[3138] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
end  #toRND
end  #hidden
end
  ##################################
  ##########  PLANT    #############
  ################################## 
  if name.include? "PlantP dial"
	pPort = "Plant"
  elsif name.include? "PlaMenu"
	pPort = "Plant"
end
if pPort == "Plant"
	pRace = 21
	pVar = 4030
	px = 100
	py = 100   
	xp = -340
	yp = -45
	pos = 0
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 70
		py = 70         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 240
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
		px = 70
		py = 70   
		pos = 1
	  end  
	  priExp = ""
	  exp = ""
	  bodyB = "PlantPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "PlantPHead"
	  expBase = "PlantPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 56
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = 30
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
		$game_variables[4000][2] = 1
		exp = "Sad"
	  elsif name.include? "rage"
		$game_variables[4000][2] = 2
		exp = "Rage"
	  elsif name.include? "love"
		$game_variables[4000][2] = 3
		exp = "Love"
	  elsif name.include? "scared"
		$game_variables[4000][2] = 4
		exp = "Scared"       
	  elsif name.include? "glad"
		$game_variables[4000][2] = 0
		exp = "Glad"         
	  end           
	  if name == "PlaMenu"
		$game_variables[4000][2] = 10
		exp = "Std"
	  elsif name == "PlaMenuH"
		$game_variables[4000][2] = 11
		exp = "Std"
    end         
    #voice Base
    voiceAc = "VoicePla"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
   voiceV = 90
   voiceP = 100    
	#succ check
	@sch = 21
	@succ = $game_variables[6401][@sch] rescue -1
	@prince = $game_variables[6406][@sch] rescue -1
	#succ check
	if $game_switches[3959] == true || @prince == 2 #pri form
	  #bodyS = "Prince"
    #expS = bodyS
	elsif @succ == 2 
	  $game_variables[4000][5] = 5
	  bodyS = "Succ"
	elsif $game_switches[3207] == true #Thorny PlantP
	  $game_variables[4000][5] = 2
	  bodyS = "Thorn"      
	  #expS = bodyS        
	elsif $game_variables[6202][21] >= @thiccLim && $game_variables[4000][5] == 0
	  $game_variables[4000][5] = 3
	  bodyS = "Thicc"     
	end  
	if $game_switches[3133] == true && bodyS != "Thicc" && bodyS != "Prince"
	  $game_variables[4000][4] = 1
	  bodyS += "Pre"
	end  
  #########
  @nkd = 0
  if name.include? "naked"
   @nkd = 1  
  elsif name.include? "Naked" 
   @nkd = 1 
 end  
 #########
	if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || @nkd == 1 || nkdCheat == 1
	  $game_variables[4000][3] = 1
	  bodyS += "Naked"
	end  
	if bodyS == "" #no alt form / costumes allowed
if $game_actors[@ac].equips[5] == $data_armors[223]
		then
		$game_variables[4000][6] = 5
		bodyS = "Bunny"
elsif $game_actors[@ac].equips[5] == $data_armors[582]
		then
		$game_variables[4000][6] = 2
		bodyS = "Maid"
elsif $game_actors[@ac].equips[5] == $data_armors[584]
		then
		$game_variables[4000][6] = 4
		bodyS = "War"
elsif $game_actors[@ac].equips[5] == $data_armors[597]
		then
		$game_variables[4000][6] = 23
		bodyS = "War2"
    expS = bodyS
elsif $game_actors[@ac].equips[5] == $data_armors[583]
		then
		$game_variables[4000][6] = 3
		bodyS = "Pri"
elsif $game_actors[@ac].equips[5] == $data_armors[581]
		then
		$game_variables[4000][6] = 1
		bodyS = "SS"
elsif $game_actors[@ac].equips[5] == $data_armors[345]
		then
		$game_variables[4000][6] = 6
		bodyS = "Court"
elsif $game_actors[@ac].equips[5] == $data_armors[585]
		then
		$game_variables[4000][6] = 13
		bodyS = "H20"        
		needHelm = 1 
elsif $game_actors[@ac].equips[5] == $data_armors[586]
		then
		$game_variables[4000][6] = 15
		bodyS = "C20"       
elsif $game_actors[@ac].equips[5] == $data_armors[587]
		then
		$game_variables[4000][6] = 16
		bodyS = "F20"   
elsif $game_actors[@ac].equips[5] == $data_armors[661]
		then
		$game_variables[4000][6] = 18
		bodyS = "Saur"               
elsif $game_actors[@ac].equips[5] == $data_armors[631]
	  then
	  $game_variables[4000][6] = 22
	  bodyS = "Bar"     
		end          
	end  
	body = bodyB + bodyS   
#--------------------------------#
if pRace != 0 && pVar != 0
 if $game_variables[4000][1] == 30 && $game_variables[pVar][0] != 0 
  if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
   $game_switches[4001] = true
   name = "RND"
  end
 end
end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#    
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == 30 && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   if name.include? "hidden"
	 $game_map.screen.pictures[113].show("PlantPbodHidden", pos, xp, yp, px, py, 255, 0)
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
  unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
  end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	 else  
 goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	 # if bodyS.include? "Succ"
	 # if pos == 0
	 # xp += (0.2*px)
	 # yp -= (1.4*px)
   # end
	 # end       
	 $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)   
   if needHelm == 1
	 helm = helmBase + bodyS
	 helmB = helmBase + bodyS + "B" 
	 $game_map.screen.pictures[119].show(helm, pos, helmx, helmy, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(helmB, pos, helmx, helmy, px, py, 255, 0) 
   end      
	priExp = expBase + expS + exp 
	$game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
 if inMenu == 0
  if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
 end  
end
  if $game_switches[579] == true && $game_switches[3138] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
end  #toRND
end  #hidden
end
  ##################################
  ##########   ONI    #############
  ################################## 
  if name.include? "OniP dial"
	pPort = "Oni"
  elsif name.include? "OniMenu"
	pPort = "Oni"
end
if pPort == "Oni"
	pRace = 20
	pVar = 4020
	px = 100
	py = 100   
	xp = -380
	yp = -150
	pos = 0
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 70
		py = 70         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 250
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
		px = 70
		py = 70   
		pos = 1
	  end  
	  priExp = ""
	  exp = ""
	  bodyB = "OniPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "OniPHead"
	  expBase = "OniPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 54
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
		$game_variables[4000][2] = 1
		exp = "Sad"
	  elsif name.include? "rage"
		$game_variables[4000][2] = 2
		exp = "Rage"
	  elsif name.include? "love"
		$game_variables[4000][2] = 3
		exp = "Love"
	  elsif name.include? "roar"
		$game_variables[4000][2] = 4
		exp = "Roar"                 
	  elsif name.include? "grin"
		$game_variables[4000][2] = 5
		exp = "Grin" 
	  end           
	  if name == "OniMenu"
		$game_variables[4000][2] = 10
		exp = "Rage"
	  elsif name == "OniMenuH"
		$game_variables[4000][2] = 11
		exp = "Rage"
  end            
    #voice Base
    voiceAc = "VoiceOni"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 5 
      voiceV += 10
      voiceP -= 10     
    end     
	#succ check
	@sch = $game_variables[4000][1] 
	@succ = $game_variables[6401][@sch] rescue -1
	@prince = $game_variables[6406][@sch] rescue -1
	#succ check
	if $game_switches[3959] == true || @prince == 2 #pri form
	  bodyS = "Prince"
	elsif @succ == 2 
	  $game_variables[4000][5] = 5
	  bodyS = "Succ"
	  expS = bodyS
	elsif $game_switches[4613] == true #Raijin OniP
	  $game_variables[4000][5] = 2
	  bodyS = "Ten"      
	  expS = bodyS        
	elsif $game_variables[6202][20] >= @thiccLim && $game_variables[4000][5] == 0
	  $game_variables[4000][5] = 3
	  bodyS = "Thicc"     
	end  
	if $game_switches[4687] == true && bodyS != "Thicc" && bodyS != "Prince"
	  $game_variables[4000][4] = 1
	  bodyS += "Pre"
	end  
  #########
  @nkd = 0
  if name.include? "naked"
   @nkd = 1  
  elsif name.include? "Naked" 
   @nkd = 1 
 end  
	if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || @nkd == 1 || nkdCheat == 1
	  $game_variables[4000][3] = 1
	  bodyS += "Naked"
	elsif name.include? "topless"
    if bodyS == "" || bodyS == "Pre"
    bodyS += "Topless"
    $game_variables[4000][3] = 1
    end
  end
  #########
	if bodyS == "" #no alt form / costumes allowed
if $game_actors[@ac].equips[5] == $data_armors[222]
		then
		$game_variables[4000][6] = 5
		bodyS = "Bunny"
elsif $game_actors[@ac].equips[5] == $data_armors[517]
		then
		$game_variables[4000][6] = 2
		bodyS = "Maid"
elsif $game_actors[@ac].equips[5] == $data_armors[519]
		then
		$game_variables[4000][6] = 4
		bodyS = "War"
		expS = "none" 
elsif $game_actors[@ac].equips[5] == $data_armors[519]
		then
		$game_variables[4000][6] = 23
		bodyS = "War2"
    needHelm = 1
elsif $game_actors[@ac].equips[5] == $data_armors[518]
		then
		$game_variables[4000][6] = 3
		bodyS = "Pri"
elsif $game_actors[@ac].equips[5] == $data_armors[516]
		then
		$game_variables[4000][6] = 1
		bodyS = "SS"
elsif $game_actors[@ac].equips[5] == $data_armors[344]
		then
		$game_variables[4000][6] = 6
		bodyS = "Court"
elsif $game_actors[@ac].equips[5] == $data_armors[520]
		then
		$game_variables[4000][6] = 13
		bodyS = "H20"        
		needHelm = 1 
elsif $game_actors[@ac].equips[5] == $data_armors[521]
		then
		$game_variables[4000][6] = 15
		bodyS = "C20"       
elsif $game_actors[@ac].equips[5] == $data_armors[522]
		then
		$game_variables[4000][6] = 16
		bodyS = "F20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[647]
		  then
		  $game_variables[4000][6] = 21      
	 if $game_variables[4000][5] == 3
		  bodyS = "ThiccFloat"             
		else
		  bodyS = "Float"            
		end       
elsif $game_actors[@ac].equips[5] == $data_armors[625]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"     
		end                     
	end 
	body = bodyB + bodyS
#--------------------------------#
if pRace != 0 && pVar != 0
 if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
  if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
   $game_switches[4001] = true
   name = "RND"
  end
 end
end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#    
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
 goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	  if bodyS.include? "Succ"
		if pos == 0
		xp += (0.2*px)
		yp -= (1.4*px)
		end
	  end       
	 $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)   
   if needHelm == 1
	 helm = helmBase + bodyS
	 helmB = helmBase + bodyS + "B" 
	 $game_map.screen.pictures[119].show(helm, pos, helmx, helmy, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(helmB, pos, helmx, helmy, px, py, 255, 0) 
   end      
	priExp = expBase + expS + exp 
	$game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
 if inMenu == 0
  if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
 end  
end
  if $game_switches[579] == true && $game_switches[4692] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
end  #toRND
end
  ##################################
  ##########   BIRD    #############
  ################################## 
  if name.include? "BirdP dial"
	  pPort = "Bird"
	elsif name.include? "BirdMenu"
	  pPort = "Bird"
  end
  if pPort == "Bird"
	  pRace = 19
	  pVar = 4019
	  px = 100
	  py = 100   
	  xp = -145
	  yp = -60
	  pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end  
		priExp = ""
		exp = ""
		bodyB = "BirdPbod"
		bodyS = ""
		dre = ""
		dreB = ""
		helmBase = "BirdPHead"
		expBase = "BirdPexp"
		needHelm = 0
		expS = ""
		@ac = 53
		$game_variables[4000][0] = 1
		$game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
		$game_variables[4000][2] = 0 #std exp
	  exp = "Std"
	  if name.include? "sad"
		  $game_variables[4000][2] = 1
		  exp = "Sad"
		elsif name.include? "rage"
		  $game_variables[4000][2] = 2
		  exp = "Rage"
		elsif name.include? "love"
		  $game_variables[4000][2] = 3
		  exp = "Love"
		elsif name.include? "tch"
		  $game_variables[4000][2] = 4
		  exp = "Tch"      
		elsif name.include? "bed"
		  $game_variables[4000][2] = 5
		  exp = "Bed"               
		end       
		if name == "BirdMenu"
		  $game_variables[4000][2] = 10
		  exp = "Std"
		elsif name == "BirdMenuH"
		  $game_variables[4000][2] = 11
		  exp = "Std"
		end            
    #voice Base
    voiceAc = "VoiceBir"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 5 
      voiceV += 10
      voiceP -= 10     
    end         
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[4592] == true #finhead birdP
		$game_variables[4000][5] = 2
		bodyS = "Fin"      
		expS = bodyS        
	  elsif $game_variables[6202][19] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
	  end  
	  if $game_switches[4386] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[221]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[388]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[390]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
  elsif $game_actors[@ac].equips[5] == $data_armors[389]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
		  needHelm = 1 
  elsif $game_actors[@ac].equips[5] == $data_armors[387]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[343]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[391]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"
		  expS = "none"  
  elsif $game_actors[@ac].equips[5] == $data_armors[392]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[473]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[644]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Goth"        
  elsif $game_actors[@ac].equips[5] == $data_armors[626]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"     
		end              
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
   unless name.include?"noeyeG"   
	 if expS != "none" && $game_actors[@ac].equips[4] == $data_armors[488] #glasses and can show exp
		  $game_map.screen.pictures[118].show("BirdPGlasses", pos, xp, yp, px, py, 255, 0)
    end      
   end 
	 if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[119].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
 end
  if $game_switches[579] == true && $game_switches[4391] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ###########   GHOST  ############
  ################################## 
  if name.include? "Ghost Princess dial"
	pPort = "Ghost"
  elsif name.include? "GhostMenu"
	pPort = "Ghost"
  end
  if pPort == "Ghost"
		pRace = 8
		pVar = 4008
		px = 100
		py = 100   
		xp = -156
		yp = -37
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "GhostPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "GhostPHead"
	  expBase = "GhostPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 12
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "scary"
	  $game_variables[4000][2] = 4
	  exp = "Scary" 
	elsif name.include? "silent"
	  $game_variables[4000][2] = 5
	  exp = "Silent"          
	end       
	if name == "GhostMenu"
	  $game_variables[4000][2] = 10
	  exp = "Sad"
	elsif name == "GhostMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Sad"
	end  
    #voice Base
    voiceAc = "VoiceGho"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10      
    elsif $game_variables[4000][2] == 5
      voiceV = 0          
    end         
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[2454] == true #human form
		$game_variables[4000][5] = 1
		bodyS = "Human" 
	  elsif $game_switches[3050] == true #yokai form
		$game_variables[4000][5] = 2
		bodyS = "Jap"   
		expS = bodyS
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		if bodyS == "Human" 
		  bodyS = "HumanThicc"  
		else
		  bodyS = "Thicc"     
		end
	  end  
	  if $game_switches[2232] == true && bodyS != "Thicc" && bodyS != "Prince" && bodyS != "HumanThicc"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1     
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
    end  
    if name.include? "Hum" #human form
		$game_variables[4000][5] = 1
		bodyS = "Human"   
    expS = ""
    end
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[210]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[146]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[185]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"        
  elsif $game_actors[@ac].equips[5] == $data_armors[134]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[109]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[332]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
		  needHelm = 1    
  elsif $game_actors[@ac].equips[5] == $data_armors[407]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
  elsif $game_actors[@ac].equips[5] == $data_armors[433]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"     
		  needHelm = 1  
  elsif $game_actors[@ac].equips[5] == $data_armors[462]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[155]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Hex"    
  elsif $game_actors[@ac].equips[5] == $data_armors[484]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Paper"       
		  needHelm = 1    
  elsif $game_actors[@ac].equips[5] == $data_armors[628]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"       
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
 end
  if $game_switches[579] == true && $game_switches[457] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ##########   HUMAN  ##############
  ################################## 
  if name.include? "Human Princess dial"
	pPort = "Human"
  elsif name.include? "HumMenu"
	pPort = "Human"
  end
  if pPort == "Human"
		pRace = 2
		pVar = 4002
		px = 100
		py = 100   
		xp = -140
		yp = 16
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "HumanPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "HumanPHead"
	  expBase = "HumanPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 5
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	if name == "HumMenu"
	  $game_variables[4000][2] = 10
	  exp = "Std"
	elsif name == "HumMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Std"
	end  
	$game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "tied"
	  $game_variables[4000][2] = 4
	  exp = "Tied" 
	elsif name.include? "determined"
	  $game_variables[4000][2] = 0
	  exp = "Det"     
	end       
    #voice Base
    voiceAc = "VoiceHum"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 4
      voiceV += 10
      voiceP -= 10      
    end   
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
	  elsif $game_switches[4116] == true #porgy form
		$game_variables[4000][5] = 1
		bodyS = "Porgy"   
		expS = bodyS
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
		expS = bodyS
	  end  
	  if $game_switches[2226] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
   end  
	  if name.include? "naked"
	   nkd = 1
	  end    
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[204]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[140]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[179]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
  elsif $game_actors[@ac].equips[5] == $data_armors[128]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[103]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[326]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[229]
		  then
		  $game_variables[4000][6] = 9
		  bodyS = "Nun"   	
		  needHelm = 1	
  elsif $game_actors[@ac].equips[5] == $data_armors[401]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
  elsif $game_actors[@ac].equips[5] == $data_armors[427]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[456]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"     
  elsif $game_actors[@ac].equips[5] == $data_armors[62]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Sol"        
  elsif $game_actors[@ac].equips[5] == $data_armors[124]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Filia"
  elsif $game_actors[@ac].equips[5] == $data_armors[514]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Tree"      
		  needHelm = 1	
  elsif $game_actors[@ac].equips[5] == $data_armors[682]
		  then
		  $game_variables[4000][6] = 21
		  bodyS = "Kono"       
  elsif $game_actors[@ac].equips[5] == $data_armors[558]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"                    
		end 
		end
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
 #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------#  
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end
  end  
  if $game_switches[579] == true && $game_switches[45] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
     end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return 
  end  #toRND
  end
  ##################################
  ##########   DESERT  #############
  ################################## 
  if name.include? "Desert Princess dial"
	pPort = "Desert"
  elsif name.include? "DesertMenu"
	pPort = "Desert"
  end
  if pPort == "Desert"
		pRace = 7
		pVar = 4007
		px = 100
		py = 100   
		xp = -183
		yp = 18
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end     
	  priExp = ""
	  exp = ""
	  bodyB = "DesertPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "DesertPHead"
	  expBase = "DesertPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 4
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	if name == "DesertMenu"
	  $game_variables[4000][2] = 10
	  exp = "Std"
	elsif name == "DesertMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Std"
	end  
	$game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "embarass"
	  $game_variables[4000][2] = 4
	  exp = "Embarass" 
	end       
    #voice Base
    voiceAc = "VoiceDes"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 4
      voiceV += 10
      voiceP -= 10      
    end       
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif $game_switches[4121] == true #djinn form
		$game_variables[4000][5] = 1
		bodyS = "Djinn"   
		needPos = 1  
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
	  end  
	  if $game_switches[2231] == true && bodyS != "Thicc" && bodyS != "Prince" && bodyS != "Djinn"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
	   nkd = 1
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[209]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[145]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[184]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
  elsif $game_actors[@ac].equips[5] == $data_armors[133]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[108]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[331]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[406]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[432]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[461]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"     
  elsif $game_actors[@ac].equips[5] == $data_armors[156]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Pain"        
  elsif $game_actors[@ac].equips[5] == $data_armors[510]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Glass"
  elsif $game_actors[@ac].equips[5] == $data_armors[662]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Char"      
      needHelm = 1
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------#  
  if name.include? "shadow"
	  $game_map.screen.pictures[113].show("DesertPbodShade", pos, xp, yp, px, py, 255, 0)  
	  priExp = expBase + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 155, 0) 
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)    
  elsif name.include? "fading"
	  $game_map.screen.pictures[113].show("DesertPbodFading", pos, xp, yp, px, py, 255, 0)  
	  priExp = expBase + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
  else
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
    yexp = yp
	  if needPos == 1 
	   if bodyS.include? "Djinn"
	  	yp -= (0.5 * px)  
	   end
	 end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
	   if $game_switches[4121] == false && bodyS != "Court" && bodyS != "Pain"
		  desH = "DesertP"
		  desT = "DesertP"  
			if bodyS.include? "Prince"
			  desH += "Prince"
			  desT += "Prince"
			end  
			desH += "Horns"
			desT += "Tail"
			$game_map.screen.pictures[118].show(desH, pos, xp, yp, px, py, 255, 0)
			$game_map.screen.pictures[111].show(desT, pos, xp, yp, px, py, 255, 0)                
		  end  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[119].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yexp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
 end
  if $game_switches[579] == true && $game_switches[321] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end  #hidden
  end
  ##################################
  ###########   GOBLIN  ############
  ################################## 
  if name.include? "GoblinP dial"
	pPort = "Goblin"
  elsif name.include? "GoblinMenu"
	pPort = "Goblin"
  end
  if pPort == "Goblin"
		pRace = 9
		pVar = 4009
		px = 100
		py = 100   
		xp = -74
		yp = 120
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "GoblinPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "GoblinPHead"
	  expBase = "GoblinPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 14
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "aroused"
	  $game_variables[4000][2] = 3
	  exp = "Love"      
	elsif name.include? "shock"
	  $game_variables[4000][2] = 4
	  exp = "Shocked" 
	elsif name.include? "worried"
	  $game_variables[4000][2] = 4
	  exp = "Jealous"          
	elsif name.include? "jealous"
	  $game_variables[4000][2] = 4
	  exp = "Jealous"                  
	end       
	if name == "GoblinMenu"
	  $game_variables[4000][2] = 10
	  exp = "Std"
	elsif name == "GoblinMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Std"
	end  
    #voice Base
    voiceAc = "VoiceGob"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10         
    end       
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_actors[@ac].state?(28) == true #gremlin
		$game_variables[4000][5] = 1
		bodyS = "Gremlin" 
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc" 
		expS = bodyS
	  end  
	  if $game_switches[2233] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1     
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[211]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
		  needHelm = 1  
  elsif $game_actors[@ac].equips[5] == $data_armors[147]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[186]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"        
  elsif $game_actors[@ac].equips[5] == $data_armors[135]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[110]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[333]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[408]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
		  needHelm = 1  
  elsif $game_actors[@ac].equips[5] == $data_armors[434]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"             
  elsif $game_actors[@ac].equips[5] == $data_armors[463]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"              
  elsif $game_actors[@ac].equips[5] == $data_armors[643]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Goth"      
  elsif $game_actors[@ac].equips[5] == $data_armors[649]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "SS2"     
  elsif $game_actors[@ac].equips[5] == $data_armors[734]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Santa"         
  elsif $game_actors[@ac].equips[5] == $data_armors[646]
		  then
		  $game_variables[4000][6] = 21      
	 if $game_variables[4000][5] == 3
		  bodyS = "ThiccFloat"             
		else
		  bodyS = "Float"            
		end      
  elsif $game_actors[@ac].equips[5] == $data_armors[559]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"                   
		end 
		end
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[938] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ###########   INSECT  ############
  ################################## 
  if name.include? "Insect Princess dial"
	pPort = "Insect"
  elsif name.include? "InsectMenu"
	pPort = "Insect"
  end
  if pPort == "Insect"
		pRace = 5
		pVar = 4005
		px = 100
		py = 100   
		xp = -149
		yp = 39
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "InsectPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "InsectPHead"
	  expBase = "InsectPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 8
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "heat"
	  $game_variables[4000][2] = 4
	  exp = "Heat"      
	elsif name.include? "smug"
	  $game_variables[4000][2] = 3
	  exp = "Smug"      
	end             
	if name == "InsectMenu"
	  $game_variables[4000][2] = 10
	  exp = "Rage"
	elsif name == "InsectMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Rage"
	end  
    #voice Base
    voiceAc = "VoiceIns"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 4
      voiceV += 10
      voiceP -= 10      
    end     
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_actors[@ac].state?(29) == true #hornet
		$game_variables[4000][5] = 1
		bodyS = "Hornet" 
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc" 
	  end  
	  if $game_switches[2229] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1     
		elsif name.include? "estrus"
		  nkd = 1             
		  elsif $game_switches[1650] == true 
			nkd = 1             
	  end  
	  if nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[207]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[143]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[182]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"        
  elsif $game_actors[@ac].equips[5] == $data_armors[131]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[106]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[329]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
		  needPos = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[404]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"          
  elsif $game_actors[@ac].equips[5] == $data_armors[430]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"             
  elsif $game_actors[@ac].equips[5] == $data_armors[459]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"          
  elsif $game_actors[@ac].equips[5] == $data_armors[354]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Magi"
  elsif $game_actors[@ac].equips[5] == $data_armors[511]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Kamen"       
		  needHelm = 1         
  elsif $game_actors[@ac].equips[5] == $data_armors[513]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Mandra"   
  elsif $game_actors[@ac].equips[5] == $data_armors[619]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"          
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	xexp = xp
	yexp = yp 
	if needPos == 1 
	  if bodyS.include? "Court"
		  if pos == 0
		  xp += (1.05 * px)
		  yp -= (0.21 * px)
		  end
		  #expressions 
		  xexp = xp
		  yexp = yp
		  xexp -= (0.2 * px)
		  yexp -= (0.7 * px) 
	  end
	end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xexp, yexp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[94] == true #status + death
	   @p = 111
	   while @p <= 121
       if $game_map.screen.pictures[@p]
		   $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
       end
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ############   CAT  #############
  ################################## 
  if name.include? "Cat Princess Dial"
	pPort = "Cat"
  elsif name.include? "CatMenu"
	pPort = "Cat"
  end
  if pPort == "Cat"
		pRace = 11
		pVar = 4011
		px = 100
		py = 100   
		xp = -129
		yp = 32
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "CatPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "CatPHead"
	  expBase = "CatPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 23
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "catty"
	  $game_variables[4000][2] = 4
	  exp = "Catty" 
  elsif name.include? "bitter"
	  $game_variables[4000][2] = 5
	  exp = "Bitter"   
  elsif name.include? "moon"
	  $game_variables[4000][2] = 9
	  exp = "Moon"         
	end       
	if name == "CatMenu"
	  $game_variables[4000][2] = 10
	  exp = "Catty"
	elsif name == "CatMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Catty"
	end  
    #voice Base
    voiceAc = "VoiceCat"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4 || $game_variables[4000][2] == 5
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10   
    elsif $game_variables[4000][2] == 9
      voiceAc = "VoiceGho"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end           
      voiceV -= 10
      voiceP += 20        
    end  
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
		needPos = 1
	  elsif $game_switches[2340] == true #mata form
		$game_variables[4000][5] = 1
		bodyS = "Mata" 
	  elsif $game_switches[4115] == true #fish form
		$game_variables[4000][5] = 2
		bodyS = "Fish"    
		expS = bodyS  
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"     
	  end  
	  if $game_switches[2235] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1     
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[213]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[149]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[188]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[137]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[112]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[335]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[410]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
  elsif $game_actors[@ac].equips[5] == $data_armors[436]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[465]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[485]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Ankh" 
		  needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[123]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Yarn"    
  elsif $game_actors[@ac].equips[5] == $data_armors[125]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Feli"    
  elsif $game_actors[@ac].equips[5] == $data_armors[225]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Ian" 
  elsif $game_actors[@ac].equips[5] == $data_armors[579]
		  then
		  $game_variables[4000][6] = 21
		  bodyS = "Ronin"    
      needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[616]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"    
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	  if needPos == 1 && pos == 0
	  if bodyS.include? "Succ"
		  xp += (0.5 * px)
		  yp -= (0.3 * px)  
	   end
	  end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[1993] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ##########   SLIME  ##############
  ################################## 
  if name.include? "Slime Princess dial"
	pPort = "Slime"
  elsif name.include? "SlimeMenu"
	pPort = "Slime"
  end
  if pPort == "Slime"
		pRace = 3
		pVar = 4003
		px = 100
		py = 100   
		xp = -202
		yp = -55
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70             
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		end       
  if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[579] == true || $game_switches[2411] == true
  pos = 1
	else
  pos = 0
  end      
	  priExp = ""
	  exp = ""
	  bodyB = "SlimePbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "SlimePHead"
		expBase = "SlimePexp"
	  needHelm = 0
	  expS = ""
		 needPos = 0
	  @ac = 7
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	$game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love2"
	  $game_variables[4000][2] = 3
	  exp = "Love2"        
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"    
	elsif name.include? "pout"
	  $game_variables[4000][2] = 4
	  exp = "Pout" 
	  elsif name.include? "glad"
	  $game_variables[4000][2] = 5
	  exp = "Glad" 	
	  elsif name.include? "contempt"
	  $game_variables[4000][2] = 0
	  exp = "Contempt" 	      
	end       
	if name == "SlimeMenu"
	  $game_variables[4000][2] = 10
	  exp = "Glad"
	elsif name == "SlimeMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Glad"
	end    
    #voice Base
    voiceAc = "VoiceSli"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10      
    end   
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
	  elsif $game_switches[2445] == true #Ooz form
		$game_variables[4000][5] = 1
		bodyS = "Ooz"   
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc"    
	  end  
	  if $game_switches[2227] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
    end    
	   nkd = 0
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[205]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
		  needPos = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[141]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[180]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"
		  needPos = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[129] #prisoner -> needs cost
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
		  needPos = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[104]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[327]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"	
  elsif $game_actors[@ac].equips[5] == $data_armors[402]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"  
  elsif $game_actors[@ac].equips[5] == $data_armors[428]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
  elsif $game_actors[@ac].equips[5] == $data_armors[457]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"     
  elsif $game_actors[@ac].equips[5] == $data_armors[490]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Acid"   
  elsif $game_actors[@ac].equips[5] == $data_armors[310]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Cream"        
  elsif $game_actors[@ac].equips[5] == $data_armors[122]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Suu"
  elsif $game_actors[@ac].equips[5] == $data_armors[650]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Shell"    
      needPos = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[683]
		  then
		  $game_variables[4000][6] = 21
		  bodyS = "Kono"     
  elsif $game_actors[@ac].equips[5] == $data_armors[633]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"
		end                  
	  end 
	  body = bodyB + bodyS
  ###################################  
	  if $game_map.map_id == 456 #reset form in ending
	   $game_variables[4000] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	  end 
  ###################################	
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	xexp = xp
	yexp = yp
	   if name.include? "spicy"
		 bodyS = "Spice"
		 needPos = 0
	   end  
  if needPos == 1 
  #whole body pos  
   if bodyS == "Shell"
    xp -= (0.28 * px)  
    yp -= (0.05 * px)  
    xexp += (1.22 * px)
    yexp += (1.35 * px)   
    #xexp -= (0.80 * px)
    #yexp -= (0.90 * py)        
   elsif bodyS == "Bunny"
    yp -= (0.3 * px)  
   else  
    yp += (0.55 * px)
 end
  #expressions
   if bodyS == "War"
   yexp += (2 * py)
   elsif bodyS == "Pri"
   xexp += (0.20 * px)
   yexp += (2.20 * py)
   end 
  end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 priExp = expBase + expS + exp
	  $game_map.screen.pictures[117].show(priExp, pos, xexp, yexp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end
  end  
  if $game_switches[579] == true && $game_switches[19] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return  
  end  #toRND
  end
  ##################################
  ###########   GOLEM  ############
  ################################## 
  if name.include? "Golem Princess dial"
	pPort = "Golem"
  elsif name.include? "Golem Princess Dial"
	  pPort = "Golem"  
  elsif name.include? "GolemMenu"
	pPort = "Golem"
  end
  if pPort == "Golem"
		pRace = 4
		pVar = 4004
		px = 100
		py = 100   
		xp = -200
		yp = -100
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "GolemPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "GolemPHead"
	  expBase = "GolemPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 6
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "curious"
	  $game_variables[4000][2] = 4
	  exp = "Curious"  
	elsif name.include? "Drided"
	  $game_variables[4000][2] = 5
	  expS = "none"         
	end       
	if name == "GolemMenu"
	  $game_variables[4000][2] = 10
	  exp = "Curious"
	elsif name == "GolemMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Curious"
	end  
    #voice Base
    voiceAc = "VoiceGol"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 95
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 || $game_variables[4000][2] == 4
      voiceV += 10
      voiceP -= 10      
    elsif $game_variables[4000][2] == 5
      voiceV -= 10
      voiceP += 15
    end   
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[2450] == true #Rock
		$game_variables[4000][5] = 1
		bodyS = "Rock" 
	  elsif $game_switches[2452] == true #Human
		$game_variables[4000][5] = 2
		bodyS = "Human"   
		expS = bodyS   
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		if bodyS == "Human"  
		  bodyS = "HumanThicc" 
		else
		  bodyS = "Thicc" 
		end      
	  end  
	  if $game_switches[2228] == true && bodyS != "Thicc" && bodyS != "Prince" && bodyS != "HumanThicc"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1    
	  elsif name.include? "Dial2"
		  nkd = 1           
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[206]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[142]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[181]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"        
  elsif $game_actors[@ac].equips[5] == $data_armors[130]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[105]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
		  expS = "none"
  elsif $game_actors[@ac].equips[5] == $data_armors[328]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[403]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"          
		  expS = "none"
  elsif $game_actors[@ac].equips[5] == $data_armors[429]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"             
  elsif $game_actors[@ac].equips[5] == $data_armors[458]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"                                               
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[55] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return  
  end  #toRND
  end
  ##################################
  ##########   SKELETON  ##########
  ################################## 
  if name.include? "Skeleton pri dial"
	pPort = "Skeleton"
  elsif name.include? "SkeletonMenu"
	pPort = "Skeleton"
  end
  if pPort == "Skeleton"
		pRace = 6
		pVar = 4006
		px = 100
		py = 100   
		xp = -207
		yp = -55
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "SkeletonPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "SkeletonPHead"
	  expBase = "SkeletonPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 9
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "spooky"
	  $game_variables[4000][2] = 4
	  exp = "Spooky"   
	elsif name.include? "det"
	  $game_variables[4000][2] = 4
	  exp = "Det"     
	end       
	if name == "SkeletonMenu"
	  $game_variables[4000][2] = 10
	  exp = "Love"
	elsif name == "SkeletonMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Love"
	end  
    #voice Base
    voiceAc = "VoiceSke"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 4
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[2395] == true #Hum
		$game_variables[4000][5] = 1  
		bodyS = "Human"   
		expS = bodyS   
	  elsif $game_switches[2393] == true #Merc
		  $game_variables[4000][5] = 2  
		  bodyS = "Merc"        
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		if bodyS == "Human"  
		  bodyS = "HumanThicc" 
		else
		  bodyS = "Thicc" 
		end      
	  end  
	  if $game_switches[2230] == true && bodyS != "Thicc" && bodyS != "Prince" && bodyS != "HumanThicc"
		if bodyS == "Merc"
		  bodyS = ""
		end  
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		if bodyS == "Merc"
		  bodyS = ""
		end  
		if bodyS == "Thicc" #fake THICC
		  bodyS = "Naked"
		  else
		  bodyS += "Naked"
		end
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[208]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"       
  elsif $game_actors[@ac].equips[5] == $data_armors[144]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[183]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"     
  elsif $game_actors[@ac].equips[5] == $data_armors[569]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "War2"     
      needHelm = 1 
  elsif $game_actors[@ac].equips[5] == $data_armors[132]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[107]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[330]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[405]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"   
		  needHelm = 1               
  elsif $game_actors[@ac].equips[5] == $data_armors[431]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"         
		  expS = "none"  
  elsif $game_actors[@ac].equips[5] == $data_armors[460]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"  
		  needHelm = 1        
  elsif $game_actors[@ac].equips[5] == $data_armors[285]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Wedding"     
  elsif $game_actors[@ac].equips[5] == $data_armors[624]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"        
		end                  
  end 
   if $game_map.map_id == 24 #wed event
		  $game_variables[4000][6] = 17
		  bodyS = "Wedding2"    
      needHelm = 0
   end   
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if bodyS == "" || bodyS == "Pre"
	   $game_map.screen.pictures[118].show("SkeletonPHeadVeil", pos, xp, yp, px, py, 255, 0)
	elsif needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	 xexp = xp
	 yexp = yp
	 if bodyS == "Pri"
	  xexp += (1 * px)
	  yexp += (2.7 * px) 
	 end  
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xexp, yexp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[146] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ############   MOUSE  ############
  ################################## 
  if name.include? "Mouse Princess dial"
	pPort = "Mouse"
  elsif name.include? "MouseMenu"
	pPort = "Mouse"
  end
  # TO THRONE SIS
  if name == "MouseMenu"
  if $game_switches[579] == true && $game_switches[2635] == true #check if Sister Placed
  @i = $game_variables[779]
  @dial = ["","Socket","Chime","Christine","Sata","Pin","Reela","MissBorne","Loretta",
  "Helah","Lola"]
  n = @dial[@i]
  exp = n + "ExpStd"
  @crownX = [0,50,0,20,30,50,40,20,40,70,10]
  @crownY = [0,100,85,90,150,160,20,105,80,40,-3]
  xd = @crownX[@i] / 2
  yd = @crownY[@i] / 2 
  xc = 150 + xd
  yc = 240 + yd
  $game_map.screen.pictures[119].show("MouSisCrown",1, xc, yc, 50, 50, 255, 0)
  $game_map.screen.pictures[120].show(n,1, 150, 240, 50, 50, 255, 0)    
  $game_map.screen.pictures[121].show(exp,1, 150, 240, 50, 50, 255, 0)
  $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0)  
  return
  end
  end  
  # TO STD MOUSE STUFF
  if pPort == "Mouse"
		pRace = 13
		pVar = 4013
		px = 100
		py = 100   
		xp = -240
		yp = -30
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "MousePbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "MousePHead"
	  expBase = "MousePexp"
	  needHelm = 0
	  expS = ""
	  @ac = 26
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad2"
	  $game_variables[4000][2] = 1
	  exp = "Sad2"
	elsif name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"    
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "scared"
	  $game_variables[4000][2] = 4
	  exp = "Scared"       
	elsif name.include? "determined"
	  $game_variables[4000][2] = 2
	  exp = "Determined"         
	end       
	if name == "MouseMenu"
	  $game_variables[4000][2] = 10
	  exp = "Scared"
	elsif name == "MouseMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Scared"
	end  
    #voice Base
    voiceAc = "VoiceMou"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end    
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[4117] == true #Rob
		$game_variables[4000][5] = 1  
		bodyS = "Robot"   
		expS = bodyS   
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc" 
	  end  
	  if $game_switches[2237] == true && bodyS != "Thicc" && bodyS != "Prince" && bodyS != "Robo"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		if bodyS != "Robot"
		bodyS += "Naked"
		end
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[215]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
		  needHelm = 1   
  elsif $game_actors[@ac].equips[5] == $data_armors[151]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[190]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"     
		  needPos = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[154]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
		  needHelm = 1   
  elsif $game_actors[@ac].equips[5] == $data_armors[153]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[337]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[412]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"              
  elsif $game_actors[@ac].equips[5] == $data_armors[438]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"         
		  needPos = 1          
  elsif $game_actors[@ac].equips[5] == $data_armors[467]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"               
  elsif $game_actors[@ac].equips[5] == $data_armors[279]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Majo"   
  elsif $game_actors[@ac].equips[5] == $data_armors[322]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Lab"                 
  elsif $game_actors[@ac].equips[5] == $data_armors[618]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"          
  elsif $game_actors[@ac].equips[5] == $data_armors[745]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "Muri-00"         
      needHelm = 1  
      needPos = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[746]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "Muri-01"   
      needHelm = 1  
      needPos = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[747]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "Muri-02"         
      needHelm = 1  
      needPos = 1
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0 
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   if name.include? "hidden"
	 $game_map.screen.pictures[113].show("MousePbodHidden", pos, xp, yp, px, py, 255, 0)
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
  unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
  end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	 else
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	 xexp = xp
	 yexp = yp
	if needPos == 1 
    ######
    if bodyS.include?"Muri"
	   if pos == 1
      xp += (0.05 * px)  
		  yp -= (0.05 * px)  
      xexp = xp
   	  yexp = yp
      xexp -= (0.1 * px)
		  yexp -= (0.1 * px)       
    else
      xp = 0
		  yp = -10
      xexp = xp
   	  yexp = yp
      xexp -= (0.1 * px)
		  yexp -= (0.1 * px) 
    end           
   else
    ######     
	   if pos == 1
		  yexp -= (0.5 * px)          
	   else
		  yp -= (0.5 * px)  
		  yexp -= (1 * px) 
    end   
    ######    
    end
    ######
	 end     
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	 if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
     if bodyS.include?"Muri"
	   helm = "MouSuitX6Visor"
	   helmB = helmBase + bodyS + "B"       
     end       
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xexp, yexp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[2760] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end  #hidden
  end
  ##################################
  ###########   HARVEST  ###########
  ################################## 
  if name.include? "HarvestP dial"
	pPort = "Harvest"
  elsif name.include? "HarvestMenu"
	pPort = "Harvest"
  end
  if pPort == "Harvest"
		pRace = 15
		pVar = 4015
		px = 100
		py = 100   
		xp = -172
		yp = -5
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "HarvestPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "HarvestPHead"
	  expBase = "HarvestPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 32
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp      
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "embarassed"
	  $game_variables[4000][2] = 4
	  exp = "Embarass"     
	elsif name.include? "shock"
	  $game_variables[4000][2] = 5
	  exp = "Shock"                     
	elsif name.include? "scared"
	  $game_variables[4000][2] = 5
	  exp = "Shock"                     
	end       
	if name == "HarvestMenu"
	  $game_variables[4000][2] = 10
	  exp = "Embarass"
	elsif name == "HarvestMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Embarass"
	end   
    #voice Base
    voiceAc = "VoiceHar"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4 || $game_variables[4000][2] == 5
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end        
    if $game_switches[3323] == true && $game_variables[4000][5] == 0 #female STD 
		 voiceP += 10  
	  end     
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
	  elsif $game_switches[4119] == true #Wolf
		$game_variables[4000][5] = 1  
		bodyS = "Wolf"   
		expS = bodyS   
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0 && $game_switches[3323] == true
		$game_variables[4000][5] = 3
		bodyS = "Thicc" 
	  end  
	  if $game_switches[3314] == true && bodyS != "Succ" && bodyS != "Thicc" && bodyS != "Prince" && $game_switches[3323] == true
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end   
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
	   if $game_switches[3323] == true && $game_variables[4000][5] == 0 #female STD 
		  bodyS = "Fem"
	    end           
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
		if $game_actors[@ac].equips[5] == $data_armors[217]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[233]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[235]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"   
		  expS = "none"
  elsif $game_actors[@ac].equips[5] == $data_armors[567]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "War2"   
      needHelm = 1	
  elsif $game_actors[@ac].equips[5] == $data_armors[232]
		  then
		  $game_variables[4000][6] = 3
	    if $game_switches[3323] == true && $game_variables[4000][5] == 0 #female STD 
		    bodyS = "Fem"
	    end             
		  bodyS += "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[234]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"    
  elsif $game_actors[@ac].equips[5] == $data_armors[339]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"    
  elsif $game_actors[@ac].equips[5] == $data_armors[414]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"     
		  expS = "none"
  elsif $game_actors[@ac].equips[5] == $data_armors[440]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"      
		  needHelm = 1     
  elsif $game_actors[@ac].equips[5] == $data_armors[469]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"   
  elsif $game_actors[@ac].equips[5] == $data_armors[228]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Geru"   
  elsif $game_actors[@ac].equips[5] == $data_armors[514]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Tree"      
		  needHelm = 1	          
  elsif $game_actors[@ac].equips[5] == $data_armors[627]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"     
		end                  
  end 
	if name.include? "hiddenSS"
	  bodyS = "HiddenSS"
    expS = "none"
  elsif name.include? "hidden"
    bodyS = "Hidden"
    expS = "none"
	end     
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	 if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[3279] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return  
  end  #toRND
  end
  ##################################
  ############   RABBIT  ###########
  ################################## 
  if name.include? "RabbitP dial"
	pPort = "Rabbit"
  elsif name.include? "RabbitMenu"
	pPort = "Rabbit"
  end
  if pPort == "Rabbit"
		pRace = 14
		pVar = 4014
		px = 100
		py = 100   
		xp = -175
		yp = -74
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "RabbitPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "RabbitPHead"
	  expBase = "RabbitPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 30
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "ara"
	  $game_variables[4000][2] = 3
	  exp = "Ara"
	elsif name.include? "scared"
	  $game_variables[4000][2] = 4
	  exp = "Scared"                   
	end       
	if name == "RabbitMenu"
	  $game_variables[4000][2] = 10
	  exp = "Ara"
	elsif name == "RabbitMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Ara"
	end  
    #voice Base
    voiceAc = "VoiceRab"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end      
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[3014] == true #moon
		$game_variables[4000][5] = 1  
		bodyS = "Moon"   
		expS = bodyS   
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc" 
	  end  
	  if $game_switches[2921] == true && bodyS != "Thicc" && bodyS != "Prince"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[216]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"
  elsif $game_actors[@ac].equips[5] == $data_armors[167]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
  elsif $game_actors[@ac].equips[5] == $data_armors[191]
		  then
		  $game_variables[4000][6] = 4
		  bodyS = "War"   
  elsif $game_actors[@ac].equips[5] == $data_armors[570]
		  then
		  $game_variables[4000][6] = 23
		  bodyS = "War2"       
  elsif $game_actors[@ac].equips[5] == $data_armors[169]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[168]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"    
		  needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[338]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"    
		  needHelm = 1   
  elsif $game_actors[@ac].equips[5] == $data_armors[367]
		  then
		  $game_variables[4000][6] = 11
		  bodyS = "Nurse"  
  elsif $game_actors[@ac].equips[5] == $data_armors[413]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"     
		  needHelm = 1         
  elsif $game_actors[@ac].equips[5] == $data_armors[439]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"        
  elsif $game_actors[@ac].equips[5] == $data_armors[468]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"   
  elsif $game_actors[@ac].equips[5] == $data_armors[226]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Spandex"   
  elsif $game_actors[@ac].equips[5] == $data_armors[315]
		  then
		  $game_variables[4000][6] = 19
		  bodyS = "Abyss"         
  elsif $game_actors[@ac].equips[5] == $data_armors[316]
		  then
		  $game_variables[4000][6] = 20
		  bodyS = "Hearts"  
  elsif $game_actors[@ac].equips[5] == $data_armors[556]
		  then
		  $game_variables[4000][6] = 21
	 if $game_variables[4000][5] == 3
		  bodyS = "ThiccFloat"             
		else
		  bodyS = "Float"            
		end  
  elsif $game_actors[@ac].equips[5] == $data_armors[623]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"     
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	#if needPos == 1 
	#  if bodyS.include? "SS"
	#   yp += (0.14 * px)  
	#  end
	# end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	 if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  if $game_switches[579] == true && $game_switches[2886] == true #status + death
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end  
     $game_map.screen.pictures[122].show("DeadBanner", 0, 0, 0, 100, 100, 255, 0) 
  end
  return   
  end  #toRND
  end
  ##################################
  ############   WYVERN  ###########
  ################################## 
  if name.include? "WyvernP dial"
	pPort = "Wyvern"
  elsif name.include? "WyvernMenu"
	pPort = "Wyvern"
  end
  if pPort == "Wyvern"
		pRace = 16
		pVar = 4016
		px = 100
		py = 100   
		xp = -300
		yp = -115
		if $game_switches[3896] == true #human
		xp = -240
		yp = -50        
		end  
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "WyvernPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "WyvernPHead"
	  expBase = "WyvernPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 41
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
    @thiccLim = @wei[pRace]
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad2"
	  $game_variables[4000][2] = 1
	  exp = "Sad2"
	elsif name.include? "sad"
		$game_variables[4000][2] = 1
		exp = "Sad"    
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "scared"
	  $game_variables[4000][2] = 4
	  exp = "Scared"                   
	elsif name.include? "embarass"
	  $game_variables[4000][2] = 3
	  exp = "Embarass"                   
	end             
	if name == "WyvernMenu"
	  $game_variables[4000][2] = 10
	  exp = "Rage"
	elsif name == "WyvernMenuH"
	  $game_variables[4000][2] = 11
	  exp = "Rage"
	end  
    #voice Base
    voiceAc = "VoiceWyv"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end           
	  #succ check
	  @sch = $game_variables[4000][1] 
	  @succ = $game_variables[6401][@sch] rescue -1
	  @prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  if $game_switches[3959] == true || @prince == 2 #pri form
		bodyS = "Prince"
		expS = bodyS
	  elsif @succ == 2 
		$game_variables[4000][5] = 5
		bodyS = "Succ"
		expS = bodyS
	  elsif $game_switches[3896] == true #human
		$game_variables[4000][5] = 1
		bodyS = "Human"   
		expS = bodyS   
    #if $game_actors[@ac].equips[5] == $data_armors[634]
		#  $game_variables[4000][6] = 22
		#  bodyS = "HumanBar"               
		#end                 
	  elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
		$game_variables[4000][5] = 3
		bodyS = "Thicc" 
	  end  
	  if $game_switches[3512] == true && bodyS != "Thicc" && bodyS != "Prince" && bodyS != "Human"
		$game_variables[4000][4] = 1
		bodyS += "Pre"
	  end
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if $game_actors[@ac].equips[5] == $data_armors[248]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"
  elsif $game_actors[@ac].equips[5] == $data_armors[251]
		  then
		  $game_variables[4000][6] = 30
		  bodyS = "Pierce" 
  elsif $game_actors[@ac].equips[5] == $data_armors[246]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"      
  elsif $game_actors[@ac].equips[5] == $data_armors[247]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
      needHelm = 1
  elsif $game_actors[@ac].equips[5] == $data_armors[218]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"           
  elsif $game_actors[@ac].equips[5] == $data_armors[229]
		  then
		  $game_variables[4000][6] = 9
		  bodyS = "Nun"        
		  needHelm = 1     
  elsif $game_actors[@ac].equips[5] == $data_armors[415]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"         
  elsif $game_actors[@ac].equips[5] == $data_armors[441]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"        
		  needHelm = 1     
  elsif $game_actors[@ac].equips[5] == $data_armors[470]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"
		  needHelm = 1   
  elsif $game_actors[@ac].equips[5] == $data_armors[487]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Rein"    
  elsif $game_actors[@ac].equips[5] == $data_armors[634]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"               
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
   goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	if needPos == 1 && pos == 0
	  if bodyS.include? "Human"
		  xp += (0.66 * px) 
		  yp += (0.6 * px) 
	  elsif bodyS.include? "Succ"
		yp += (0.82 * px) 
	 end
	end
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	 if needHelm == 1
	   helm = helmBase + bodyS
	   helmB = helmBase + bodyS + "B" 
	   $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	 end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
   if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
   end  
   end
  return 
  end  #toRND
  end
	##################################
  ##########   DRAGON 1  ###########
  ################################## 
  if name.include? "Dragon pri dial"
	pPort = "Dragon1"
  elsif name.include? "DP1Menu"
	pPort = "Dragon1"
  end
  if pPort == "Dragon1"
		pRace = 16
		pVar = 4026
		px = 100
		py = 100   
		xp = -192
		yp = -112
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "Dragon1Pbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "Dragon1PHead"
	  expBase = "Dragon1Pexp"
	  needHelm = 0
	  expS = ""
	  @ac = 18
	  #@thiccLim = @merWM
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "pensive"
	  $game_variables[4000][2] = 4
	  exp = "Pensive"                   
	end       
	if name == "DP1Menu"
	  $game_variables[4000][2] = 10
	  exp = "Rage"
	elsif name == "DP1MenuH"
	  $game_variables[4000][2] = 11
	  exp = "Rage"
	end  
    #voice Base
    voiceAc = "VoiceWyv"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 95
    voiceP = 95  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end            
	  #succ check
	  @sch = $game_variables[4000][1] 
	  #@succ = $game_variables[6401][@sch] rescue -1
	  #@prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  #if $game_switches[3959] == true || @prince == 2 #pri form
	  #  bodyS = "Prince"
	  #  expS = bodyS
	  #elsif @succ == 2 
	  #  $game_variables[4000][5] = 5
	  #  bodyS = "Succ"
	  #  expS = bodyS
	  #elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
	  #  $game_variables[4000][5] = 3
	  #  bodyS = "Thicc" 
	  #end  
	  #if $game_switches[4232] == true && bodyS != "Thicc" && bodyS != "Prince"
	  #  $game_variables[4000][4] = 1
	  #  bodyS += "Pre"
	  #end0
	  top = 0
	  if name.include? "Topless"
		top = 1
	   elsif name.include? "topless"
		top = 1     
	   end       
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end         
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if top == 1
		  then
		  $game_variables[4000][3] = 1
		  bodyS = "Topless"
  elsif $game_actors[@ac].equips[5] == $data_armors[115]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[247]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
      needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[248]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"      
  elsif $game_actors[@ac].equips[5] == $data_armors[218]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"         
  elsif $game_actors[@ac].equips[5] == $data_armors[340]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[229]
		  then
		  $game_variables[4000][6] = 9
		  bodyS = "Nun"  
		  needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[415]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"        
  elsif $game_actors[@ac].equips[5] == $data_armors[441]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
		  needHelm = 1       
  elsif $game_actors[@ac].equips[5] == $data_armors[470]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"
		  needHelm = 1 
  elsif $game_actors[@ac].equips[5] == $data_armors[487]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Rein"
		  needHelm = 1              
  elsif $game_actors[@ac].equips[5] == $data_armors[192]
		  then
		  $game_variables[4000][6] = 18
		  bodyS = "Gold"                                                                               
  elsif $game_actors[@ac].equips[5] == $data_armors[246]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS0"    
  elsif $game_actors[@ac].equips[5] == $data_armors[634]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"         
		end                
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
 #   if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	 @dra = 10
 #   end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
  goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	  helm = helmBase + bodyS
	  helmB = helmBase + bodyS + "B" 
	  $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end  
   end
  return 
  end  #toRND
  end
  ##################################
  ##########   DRAGON 2  ###########
  ################################## 
  if name.include? "Dragon pri II dial"
	pPort = "Dragon2"
  elsif name.include? "DP2Menu"
	pPort = "Dragon2"
  end
  if pPort == "Dragon2"
		pRace = 16
		pVar = 4027
		px = 100
		py = 100   
		xp = -190
		yp = -78
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "Dragon2Pbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "Dragon2PHead"
	  expBase = "Dragon2Pexp"
	  needHelm = 0
	  expS = ""
	  @ac = 11
	  #@thiccLim = @merWM
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "love2"
		$game_variables[4000][2] = 3
		exp = "Love"                 
	elsif name.include? "glad"
		$game_variables[4000][2] = 0
		exp = "Glad"                   
	  end            
	if name == "DP2Menu"
	  $game_variables[4000][2] = 10
	  exp = "Glad"
	elsif name == "DP2MenuH"
	  $game_variables[4000][2] = 11
	  exp = "Glad"
	end  
    #voice Base
    voiceAc = "VoiceWyv"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 90  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end           
	  #succ check
	  @sch = $game_variables[4000][1] 
	  #@succ = $game_variables[6401][@sch] rescue -1
	  #@prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  #if $game_switches[3959] == true || @prince == 2 #pri form
	  #  bodyS = "Prince"
	  #  expS = bodyS
	  #elsif @succ == 2 
	  #  $game_variables[4000][5] = 5
	  #  bodyS = "Succ"
	  #  expS = bodyS
	  #elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
	  #  $game_variables[4000][5] = 3
	  #  bodyS = "Thicc" 
	  #end  
	  #if $game_switches[4232] == true && bodyS != "Thicc" && bodyS != "Prince"
	  #  $game_variables[4000][4] = 1
	  #  bodyS += "Pre"
	  #end0
	  top = 0
	  if name.include? "Topless"
		top = 1
	   elsif name.include? "topless"
		top = 1     
	   end       
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end         
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if top == 1
		  then
		  $game_variables[4000][3] = 1
		  bodyS = "Topless"
  elsif $game_actors[@ac].equips[5] == $data_armors[116]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[218]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"         
  elsif $game_actors[@ac].equips[5] == $data_armors[247]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
      needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[248]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"            
  elsif $game_actors[@ac].equips[5] == $data_armors[340]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[229]
		  then
		  $game_variables[4000][6] = 9
		  bodyS = "Nun"  
		  needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[415]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"        
  elsif $game_actors[@ac].equips[5] == $data_armors[441]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
		  needHelm = 1       
  elsif $game_actors[@ac].equips[5] == $data_armors[470]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"
		  needHelm = 1 
  elsif $game_actors[@ac].equips[5] == $data_armors[487]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Rein"
		  needHelm = 1                                                                                  
  elsif $game_actors[@ac].equips[5] == $data_armors[246]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS0"        
  elsif $game_actors[@ac].equips[5] == $data_armors[634]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"        
		end             
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
 #   if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	 @dra = 11
 #   end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
  goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	  helm = helmBase + bodyS
	  helmB = helmBase + bodyS + "B" 
	  $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end  
   end
  return 
  end  #toRND
end
  ##################################
  ##########   DRAGON 3  ###########
  ################################## 
  if name.include? "Dragon pri III dial"
	pPort = "Dragon3"
  elsif name.include? "DP3Menu"
	pPort = "Dragon3"
  end
  if pPort == "Dragon3"
		pRace = 16
		pVar = 4028
		px = 100
		py = 100   
		xp = -147
		yp = -103
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "Dragon3Pbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "Dragon3PHead"
	  expBase = "Dragon3Pexp"
	  needHelm = 0
	  expS = ""
	  @ac = 24
	  #@thiccLim = @merWM
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "horny"
		$game_variables[4000][2] = 3
		exp = "Horny"                 
	elsif name.include? "groan"
		$game_variables[4000][2] = 1
		exp = "ZZZ"   
	elsif name.include? "dozing"
		$game_variables[4000][2] = 1
		exp = "Dozing"                           
	  end            
	if name == "DP3Menu"
	  $game_variables[4000][2] = 10
	  exp = "Dozing"
	elsif name == "DP3MenuH"
	  $game_variables[4000][2] = 11
	  exp = "Dozing"
	end  
    #voice Base
    voiceAc = "VoiceWyv"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 85  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end           
	  #succ check
	  @sch = $game_variables[4000][1] 
	  #@succ = $game_variables[6401][@sch] rescue -1
	  #@prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  #if $game_switches[3959] == true || @prince == 2 #pri form
	  #  bodyS = "Prince"
	  #  expS = bodyS
	  #elsif @succ == 2 
	  #  $game_variables[4000][5] = 5
	  #  bodyS = "Succ"
	  #  expS = bodyS
	  #elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
	  #  $game_variables[4000][5] = 3
	  #  bodyS = "Thicc" 
	  #end  
	  #if $game_switches[4232] == true && bodyS != "Thicc" && bodyS != "Prince"
	  #  $game_variables[4000][4] = 1
	  #  bodyS += "Pre"
	  #end0
	  top = 0
	  if name.include? "Topless"
		top = 1
	   elsif name.include? "topless"
		top = 1     
	   end       
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end         
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if top == 1
		  then
		  $game_variables[4000][3] = 1
		  bodyS = "Topless"
  elsif $game_actors[@ac].equips[5] == $data_armors[117]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[218]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"         
  elsif $game_actors[@ac].equips[5] == $data_armors[247]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
      needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[248]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"            
  elsif $game_actors[@ac].equips[5] == $data_armors[340]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[229]
		  then
		  $game_variables[4000][6] = 9
		  bodyS = "Nun"  
		  needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[415]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"        
  elsif $game_actors[@ac].equips[5] == $data_armors[441]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
		  needHelm = 1       
  elsif $game_actors[@ac].equips[5] == $data_armors[470]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"
		  needHelm = 1 
  elsif $game_actors[@ac].equips[5] == $data_armors[487]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Rein"
		  needHelm = 1                                                                                  
  elsif $game_actors[@ac].equips[5] == $data_armors[246]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS0"      
  elsif $game_actors[@ac].equips[5] == $data_armors[634]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"        
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
 #   if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	 @dra = 12
 #   end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
  goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	  helm = helmBase + bodyS
	  helmB = helmBase + bodyS + "B" 
	  $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end  
   end
  return 
  end  #toRND
end
  ##################################
  ##########   DRAGON 4  ###########
  ################################## 
  if name.include? "Dragon pri IV dial"
	pPort = "Dragon4"
  elsif name.include? "DP4Menu"
	pPort = "Dragon4"
  end
  if pPort == "Dragon4"
		pRace = 16
		pVar = 4029
		px = 100
		py = 100   
		xp = -254
		yp = -84
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "Dragon4Pbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "Dragon4PHead"
	  expBase = "Dragon4Pexp"
	  needHelm = 0
	  expS = ""
	  @ac = 55
	  #@thiccLim = @merWM
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "hungry"
		$game_variables[4000][2] = 4
		exp = "Hungry"                 
	elsif name.include? "spite"
		$game_variables[4000][2] = 2
		exp = "Spite"                           
	  end            
	if name == "DP4Menu"
	  $game_variables[4000][2] = 10
	  exp = "Spite"
	elsif name == "DP4MenuH"
	  $game_variables[4000][2] = 11
	  exp = "Spite"
	end  
    #voice Base
    voiceAc = "VoiceWyv"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 90  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end           
	  #succ check
	  @sch = $game_variables[4000][1] 
	  #@succ = $game_variables[6401][@sch] rescue -1
	  #@prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  #if $game_switches[3959] == true || @prince == 2 #pri form
	  #  bodyS = "Prince"
	  #  expS = bodyS
	  #elsif @succ == 2 
	  #  $game_variables[4000][5] = 5
	  #  bodyS = "Succ"
	  #  expS = bodyS
	  #elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
	  #  $game_variables[4000][5] = 3
	  #  bodyS = "Thicc" 
	  #end  
	  #if $game_switches[4232] == true && bodyS != "Thicc" && bodyS != "Prince"
	  #  $game_variables[4000][4] = 1
	  #  bodyS += "Pre"
	  #end0
	  top = 0
	  if name.include? "Topless"
		top = 1
	   elsif name.include? "topless"
		top = 1     
	   end       
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end         
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if top == 1
		  then
		  $game_variables[4000][3] = 1
		  bodyS = "Topless"
 #  elsif $game_actors[@ac].equips[5] == $data_armors[117]
 #         then
 #         $game_variables[4000][6] = 1
 #         bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[340]
		  then
		  $game_variables[4000][6] = 6
		  bodyS = "Court"
  elsif $game_actors[@ac].equips[5] == $data_armors[247]
		  then
		  $game_variables[4000][6] = 2
		  bodyS = "Maid"
      needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[248]
		  then
		  $game_variables[4000][6] = 3
		  bodyS = "Pri"      
  elsif $game_actors[@ac].equips[5] == $data_armors[218]
		  then
		  $game_variables[4000][6] = 5
		  bodyS = "Bunny"         
  elsif $game_actors[@ac].equips[5] == $data_armors[229]
		  then
		  $game_variables[4000][6] = 9
		  bodyS = "Nun"  
		  needHelm = 1      
  elsif $game_actors[@ac].equips[5] == $data_armors[415]
		  then
		  $game_variables[4000][6] = 13
		  bodyS = "H20"        
  elsif $game_actors[@ac].equips[5] == $data_armors[441]
		  then
		  $game_variables[4000][6] = 15
		  bodyS = "C20"       
		  needHelm = 1       
  elsif $game_actors[@ac].equips[5] == $data_armors[470]
		  then
		  $game_variables[4000][6] = 16
		  bodyS = "F20"
		  needHelm = 1 
  elsif $game_actors[@ac].equips[5] == $data_armors[487]
		  then
		  $game_variables[4000][6] = 17
		  bodyS = "Rein"
		  needHelm = 1                                                                                  
  elsif $game_actors[@ac].equips[5] == $data_armors[246]
		  then
		  $game_variables[4000][6] = 1
		  bodyS = "SS0"            
  elsif $game_actors[@ac].equips[5] == $data_armors[634]
		  then
		  $game_variables[4000][6] = 22
		  bodyS = "Bar"        
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
 #   if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	 @dra = 13
 #   end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
  goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	  helm = helmBase + bodyS
	  helmB = helmBase + bodyS + "B" 
	  $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end  
   end
  return 
  end  #toRND
end
  ##################################
  ##########   DRAGON 4  ###########
  ################################## 
  if name.include? "Dragon pri V dial"
	pPort = "Dragon5"
  elsif name.include? "DP5Menu"
	pPort = "Dragon5"
  end
  if pPort == "Dragon5"
		pRace = 16
		pVar = 4035
		px = 100
		py = 100   
		xp = -290
		yp = -90
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "Dragon5Pbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "Dragon5PHead"
	  expBase = "Dragon5Pexp"
	  needHelm = 0
	  expS = ""
	  @ac = 55
	  #@thiccLim = @merWM
	  $game_variables[4000][0] = 1
	  $game_variables[4000][1] = pRace
	  $game_variables[4000][2] = 0 #std exp
	exp = "Std"
	if name.include? "sad"
	  $game_variables[4000][2] = 1
	  exp = "Sad"
	elsif name.include? "rage"
	  $game_variables[4000][2] = 2
	  exp = "Rage"
	elsif name.include? "love"
	  $game_variables[4000][2] = 3
	  exp = "Love"
	elsif name.include? "munch"
		$game_variables[4000][2] = 4
		exp = "Munch"                                          
	  end            
	if name == "DP5Menu"
	  $game_variables[4000][2] = 10
	  exp = "Munch"
	elsif name == "DP5MenuH"
	  $game_variables[4000][2] = 11
	  exp = "Munch"
	end  
    #voice Base
    voiceAc = "VoiceWyv"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 90
    voiceP = 90  
    #pitch/volume changes
    if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 4
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3 
      voiceV += 10
      voiceP -= 10     
    end           
	  #succ check
	  @sch = $game_variables[4000][1] 
	  #@succ = $game_variables[6401][@sch] rescue -1
	  #@prince = $game_variables[6406][@sch] rescue -1
	  #succ check
	  #if $game_switches[3959] == true || @prince == 2 #pri form
	  #  bodyS = "Prince"
	  #  expS = bodyS
	  #elsif @succ == 2 
	  #  $game_variables[4000][5] = 5
	  #  bodyS = "Succ"
	  #  expS = bodyS
	  #elsif $game_variables[6202][pRace] >= @thiccLim && $game_variables[4000][5] == 0
	  #  $game_variables[4000][5] = 3
	  #  bodyS = "Thicc" 
	  #end  
	  #if $game_switches[4232] == true && bodyS != "Thicc" && bodyS != "Prince"
	  #  $game_variables[4000][4] = 1
	  #  bodyS += "Pre"
	  #end0
	  top = 0
	  if name.include? "Topless"
		top = 1
	   elsif name.include? "topless"
		top = 1     
	   end       
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end         
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		$game_variables[4000][3] = 1
		bodyS += "Naked"
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if top == 1
		  then
		  $game_variables[4000][3] = 1
		  bodyS = "Topless"
   elsif $game_actors[@ac].equips[5] == $data_armors[770]
          then
          $game_variables[4000][6] = 1
          bodyS = "SS"
  #elsif $game_actors[@ac].equips[5] == $data_armors[340]
	#	  then
	#	  $game_variables[4000][6] = 6
	#	  bodyS = "Court"
  #elsif $game_actors[@ac].equips[5] == $data_armors[247]
	#	  then
	#	  $game_variables[4000][6] = 2
	#	  bodyS = "Maid"
  #    needHelm = 1      
  #elsif $game_actors[@ac].equips[5] == $data_armors[248]
	#	  then
	#	  $game_variables[4000][6] = 3
	#	  bodyS = "Pri"      
  #elsif $game_actors[@ac].equips[5] == $data_armors[218]
	#	  then
	#	  $game_variables[4000][6] = 5
	#	  bodyS = "Bunny"         
  #elsif $game_actors[@ac].equips[5] == $data_armors[229]
	#	  then
	#	  $game_variables[4000][6] = 9
	#	  bodyS = "Nun"  
	#	  needHelm = 1      
  #elsif $game_actors[@ac].equips[5] == $data_armors[415]
	#	  then
	#	  $game_variables[4000][6] = 13
	#	  bodyS = "H20"        
  #elsif $game_actors[@ac].equips[5] == $data_armors[441]
	#	  then
	#	  $game_variables[4000][6] = 15
	#	  bodyS = "C20"       
	#	  needHelm = 1       
  #elsif $game_actors[@ac].equips[5] == $data_armors[470]
	#	  then
	#	  $game_variables[4000][6] = 16
	#	  bodyS = "F20"
	#	  needHelm = 1 
  #elsif $game_actors[@ac].equips[5] == $data_armors[487]
	#	  then
	#	  $game_variables[4000][6] = 17
	#	  bodyS = "Rein"
	#	  needHelm = 1                                                                                  
  #elsif $game_actors[@ac].equips[5] == $data_armors[246]
	#	  then
	#	  $game_variables[4000][6] = 1
	#	  bodyS = "SS0"                                                                               
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
   if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
 #   if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	 $game_switches[4001] = true
	 name = "RND"
	 @dra = 14
 #   end
   end
  end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
  goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	if needHelm == 1
	  helm = helmBase + bodyS
	  helmB = helmBase + bodyS + "B" 
	  $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(helmB, pos, xp, yp, px, py, 255, 0) 
	end      
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end  
   end
  return 
  end  #toRND
end
  ##################################
  ##########   DRAGON Q  ###########
  ################################## 
  if name.include? "DQ dial"
	pPort = "DQ"
  elsif name.include? "DQh dial"
	pPort = "DQ"
  end
  if pPort == "DQ"
		px = 100
		py = 100   
  		xp = -15
			yp = -20
		if name.include? "DQh"
			xp = -235
			yp = -175
		elsif $game_switches[2083] == true
			xp = -235
			yp = -175
		end    
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "DragonQbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "DragonQHead"
	  expBase = "DragonQexp"
	  needHelm = 0
    expS = ""
    if $game_switches[2083] == true
      expS = "Human"
      bodyB += "Human"
    elsif name.include? "DQh"
      expS = "Human"
      bodyB += "Human"
    end  	  
    #voice Base
    voiceAc = "VoiceMer"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end         
    voiceV = 95
    voiceP = 80  
    #pitch/volume changes
	exp = "Std"
	if name.include? "sad"
	  exp = "Sad"
      voiceV -= 10
      voiceP -= 15    
	elsif name.include? "rage"
	  exp = "Rage"
      voiceV += 15
      voiceP += 20 
	elsif name.include? "rage2"
	  exp = "Rage2"
      voiceV += 15
      voiceP += 20     
	elsif name.include? "pleased"
		exp = "Pleased"       
      voiceV += 10
      voiceP -= 10       
	elsif name.include? "cruel"
		exp = "Cruel"      
      voiceV += 15
      voiceP += 20     
	  end            
	if name == "DQhFull"
	  exp = "Cruel"
	elsif name == "DQFull"
	  exp = "Cruel"
	end  
	  top = 0
	  if name.include? "Topless"
		top = 1
	   elsif name.include? "topless"
		top = 1     
	   end       
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end         
	  if nkd == 1 || nkdCheat == 1
		bodyS += "N" #no nkd body
	  end  
	  if bodyS == "" #no alt form / costumes allowed
  if top == 1
		  then
		  bodyS = "Topless"                                                                                
		end                  
	  end 
	  body = bodyB + bodyS
  #--------------------------------#
	  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    
	 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	end  
   end
  return 
end
  ##################################
  ############   LAMIA  ############
  ################################## 
  if name.include? "Lamia Princess dial"
	pPort = "Lamia"
  end
  if pPort == "Lamia"
		pRace = 22
		pVar = 4022
		px = 100
		py = 100   
		xp = -155
		yp = -65
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  bodyB = "LamiaPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmBase = "LamiaPHead"
	  expBase = "LamiaPexp"
	  needHelm = 0
	  expS = ""
	exp = "Std"
	if name.include? "sad"
	  exp = "Sad"
	elsif name.include? "mad"
	  exp = "Rage"
	elsif name.include? "rage"
	  exp = "Rage"    
	elsif name.include? "love2"
	  exp = "Love2"
	elsif name.include? "love"
		exp = "Love"                 
	  end             
	   nkd = 0
	  if name.include? "Naked"
	   nkd = 1
	  elsif name.include? "naked"
		  nkd = 1        
	  end         
	  if nkd == 1 || nkdCheat == 1
		bodyS += "Naked"
	  end
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
	if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	 if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	  $game_switches[4001] = true
	  name = "RND"
	 end
	end
   end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
		$game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	  if needHelm == 1
		helm = helmBase + bodyS
		helmB = helmBase + bodyS + "B" 
		$game_map.screen.pictures[119].show(helm, pos, helmx, helmy, px, py, 255, 0)
		$game_map.screen.pictures[112].show(helmB, pos, helmx, helmy, px, py, 255, 0) 
	  end      
	   priExp = expBase + expS + exp 
	   $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
	if inMenu == 0
	 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	end  
	end
   return 
   end  #toRND
   end
  ##################################
  ##########   FAIRY    ############
  ##################################
  if name.include? "Fairy Princess"
	  @ac = 47
	  px = 100
	  py = 100  
	  pos = 0  
   if $game_actors[@ac].equips[5] == $data_armors[380] #DIY Wyvern
	n = "DIY Wyvern"
		  xp = -245
		  yp = 0          
		  $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
  elsif $game_actors[@ac].equips[5] == $data_armors[383] #DIY Shark
	n = "DIY Shark"
		  xp = -245
		  yp = 0    
		  $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
  elsif $game_actors[@ac].equips[5] == $data_armors[572] #DIY Larva
	n = "DIY Larva"
		  xp = -245
		  yp = 0    
		  $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	  else 
	  xp = -75
	  yp = 90  
	  n = "FairyP"
	  expB = "FairyPExp"
	  expS = "Std"
	 if name.include? "sad"
	  expS = "Sad"
	 elsif name.include? "rage"  
	  expS = "Rage"
	 elsif name.include? "love"  
	  expS = "Love"
	 elsif name.include? "ahegao"
	  expS = "Ahegao"
	end  
	  if name.include? "naked"
		n += "N"
	  else  
	  if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkdCheat == 1
		n += "N"
	  elsif $game_actors[@ac].equips[5] == $data_armors[357]
		n += "p" 
	  elsif $game_actors[@ac].equips[5] == $data_armors[421]
		n += "H20" 
	  elsif $game_actors[@ac].equips[5] == $data_armors[447]
		n += "C20"  
	  elsif $game_actors[@ac].equips[5] == $data_armors[476]
		n += "F20"      
	  elsif $game_actors[@ac].equips[5] == $data_armors[630]
		n += "Bar"      
	  elsif $game_actors[@ac].equips[5] == $data_armors[645]
		n += "Goth"          
	  end 
	end  
		exp = expB + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
	  if !name.include? "Stockless"
		$game_map.screen.pictures[113].show("FaiPBrace", pos, xp, yp, px, py, 255, 0)
	  end      
	  end
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
   end     
  ##################################
  ###########   FROG   ###########
  ################################## 
  if name.include? "FrogP dial"
	pPort = "Frog"
  end
  if pPort == "Frog"
		px = 100
		py = 100   
		xp = -25
		yp = 125
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end        
	  priExp = ""
	  exp = ""
	  bodyB = "FrogPbod"
	  bodyS = ""
	  dre = ""
	  dreB = ""
	  helmB = "FrogPHead"
    helmS = ""
	  expBase = "FrogPexp"
	  needHelm = 0
	  expS = ""
	  @ac = 51
	exp = "Std"
	if name.include? "sad"
	  exp = "Sad"
	elsif name.include? "sad2"
	  exp = "Sad"
	elsif name.include? "rage"
	  exp = "Rage"
	elsif name.include? "love"
		exp = "Love"                 
	elsif name.include? "pleased"
		exp = "Pleased" 
	elsif name.include? "poker"
		exp = "Poker"                                   
	end            
	if name.include? "hidden"
	  bodyS = "Hidden"
	end  
	   nkd = 0
	 if name.include? "Naked"
	   nkd = 1
	 elsif name.include? "naked"
		  nkd = 1        
	 end  
	if $game_actors[@ac].equips[5] == nil || $game_actors[@ac].equips[5] == $data_armors[275] || nkd == 1 || nkdCheat == 1
		bodyS += "Naked"
	end     
	if bodyS == "" #no alt form / costumes allowed
	  if $game_actors[@ac].equips[5] == $data_armors[193] || $game_switches[2995] == true
		then
		bodyS = "Keroic"  
  elsif $game_actors[@ac].equips[5] == $data_armors[714]
    bodyS = "SS"
  elsif $game_actors[@ac].equips[5] == $data_armors[715]
    bodyS = "H20"   
    helmS += "H20"    
  elsif $game_actors[@ac].equips[5] == $data_armors[716]
    bodyS = "C20"
    expBase += "C20"
  elsif $game_actors[@ac].equips[5] == $data_armors[717]
    bodyS = "F20"
  end  
 end
  helm = helmB + helmS
	body = bodyB + bodyS
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
    name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
  goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
	  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	  priExp = expBase + expS + exp 
	  $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0)
    $game_map.screen.pictures[118].show(helm, pos, xp, yp, px, py, 255, 0)
  if inMenu == 0
	if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
	 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	end  
   end
   return 
  end  #toRND
end
  ##################################
  ########   RabClerks    ############
  ##################################
  if name.include? "Rabbit Clerks dial"
		px = 100
		py = 100   
		xp = 160
		yp = 10  
		n = "RabClerkFM"
	  if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"        
	  end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
		exp = "RabClerkFMExp"  
	  if name.include? "sad"
		exp += "Sad"   
	  elsif name.include? "rage"
		exp += "Rage"   
	  elsif name.include? "love"
		exp += "Love"  
	  elsif name.include? "ara"
		exp += "Ara"     
	  else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end
  ##################################
  ########   RabClerks    ############
  ##################################
  if name.include? "Rabbit ClerkF dial"
		px = 100
		py = 100   
		xp = 160
		yp = 10  
		n = "RabClerkF"
	  if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"        
	  end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
		exp = "RabClerkFExp"  
	  if name.include? "sad"
		exp += "Sad"   
	  elsif name.include? "rage"
		exp += "Rage"   
	  elsif name.include? "love"
		exp += "Love"  
	  elsif name.include? "ara"
		exp += "Ara"     
	  else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ########   RabClerks    ############
  ##################################
  if name.include? "Rabbit ClerkM dial"
		px = 100
		py = 100   
		xp = 160
		yp = 10  
		n = "RabClerkM"
	  if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"        
	  end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
		exp = "RabClerkMExp"  
	  if name.include? "sad"
		exp += "Sad"   
	  elsif name.include? "rage"
		exp += "Rage"   
	  elsif name.include? "love"
		exp += "Love"  
	  elsif name.include? "ara"
		exp += "Ara"     
	  else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ########   Basilissa    ############
  ##################################
  if name.include? "Basilissa dial"
		px = 100
		py = 100   
		xp = 10
		yp = 70  
		n = "Basilissa"
	  if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
     n += "N"        
	  end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
		exp = "BasilissaExp"  
	  if name.include? "rage"
		exp += "Rage"   
	  elsif name.include? "embarass"
		exp += "Embarass"   
	  elsif name.include? "hohoho"
		exp += "Hohoho"  
	  else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end
  ##################################
  ########   Dusk    ############
  ##################################
  dusk = 0
  if name.include? "Dusk Princess nDial"
	dusk = 1
  end  
  if name.include? "Dusk Princess Dial" || dusk == 1
		px = 100
		py = 100   
		xp = -25
		yp = 42  
		n = "DuskP"
    #voice Base
      voiceAc = "voiceDusk"
      if $game_variables[7330] == 2
        voiceAc += "susp"
      end          
      voiceV = 90
      voiceP = 100  
    #pitch/volume changes    
		if name.include? "hidden"
		  n += "h"
		elsif nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
		  n += "N"        
		end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	 exp = "DuskPExp"  
	  if name.include? "rage"
	  	exp += "Rage"   
      voiceV += 15
      voiceP += 20       
	  else
		exp += "Std"  
	  end
	  unless name.include? "hidden"
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
    end
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true
     voiceAc += (rand(4)+1).to_s
     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #         
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end
  ##############################
  ######   WENDIGO    ########
  ##############################
  wendigo = 0
  if name.include? "WendigoP dialAAA"
	wendigo = 1
  end    
  if wendigo == 1
		px = 100
		py = 100   
		n = "WendigoP"
	  if name.include? "HUM"
		xp = -25
		yp = 42  
		n += "Hum"
	  else
		xp = -25
		yp = 42  
	  end         
		if name.include? "hidden"
		  n += "h"
		elsif nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
		  n += "N"        
		end  
		if name.include? "HUM X"
		  n = "WendigoPHumX"
		end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	 exp = "WendigoPExp" 
	 expS = "Std"  
	  if name.include? "defeat" 
		expS = "Defeat"   
	  elsif name.include? "rage" 
		expS = "Rage"  
	  elsif name.include? "hungry" 
		expS = "Hungry" 
	  elsif name.include? "tamed" 
		expS = "Tamed" 
	  elsif name.include? "calm"  
		expS = "Std" 
	  elsif name.include? "desperate"  
		expS = "Desperate" 
	   elsif name.include? "determined"  
		expS = "Determined" 
	   elsif name.include? "love"  
		expS = "Love"      
	   elsif name.include? "scared"  
		expS = "Scared"          
	  end
	  unless name.include? "HUM X"
		exp += expS
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  end
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end
  ##############################
  ######   SCARECROW    ########
  ##############################
  if name.include? "ScarecrowP dial"
	pPort = "Scarecrow"
  elsif name.include? "ScarecrowMenu"
	pPort = "Scarecrow"
  end
  if pPort == "Scarecrow"
		px = 100
		py = 100   
		xp = 0
		yp = 45  
		n = "ScarecrowP"
		exp = "ScarecrowPExp" 
		pos = 0
    ###########
    voiceAc = "VoiceSca"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end             
    voiceV = 90 
    voiceP = 110  
    ###########
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 70
		  py = 70        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 50
		  py = 50        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 50
		  py = 50   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 70
		  py = 70   
		  pos = 1
		end             
		if name.include? "trasp"
		  n += "h"
		elsif nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
		  n += "N2"        
		elsif name.include? "X1"  
		  n += "X1"
		  exp += "X1" 
		end  
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)      
		if name.include? "sad"
		exp += "Sad"  
      voiceV -= 10
      voiceP -= 15    
		elsif name.include? "evil"
		exp += "Evil"   
      voiceV += 15
      voiceP += 20        
		elsif name.include? "love"
		exp += "Love"  
      voiceV += 10
      voiceP -= 10         
		elsif name.include? "scary"
		exp += "Scary"     
      voiceV += 15
      voiceP += 20        
		elsif name.include? "sack"
		exp += "Sack"  
      voiceV -= 10
      voiceP -= 15        
		else
		exp += "Std"   
	  end
	  unless name.include? "trasp"
	  $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
	end    
   if inMenu == 0  
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true
     voiceAc += (rand(4)+1).to_s
     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #       
	 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
   end 
	  return
	end    
  ##################################
  ########   DEAR    ############
  ##################################
  if name.include? "Dear dial"
		px = 100
		py = 100   
		xp = 0
		yp = 0
		n = "Dear"
    exp = "DearExp"  
    if nkdCheat == 1
     n += "N"
     elsif name.include? "naked"
      n += "N"
    elsif fest != "" #RT festival
      if fest == "Chill"
      n += "C20"
      end      
    elsif $game_switches[4333] == true #chillbite
      n += "C20"
    end      
		if name.include? "sad"
		exp += "Sad"  
		elsif name.include? "rage"
		exp += "Rage"   
		elsif name.include? "glad"
		exp += "Glad"  
		elsif name.include? "scoff"
		exp += "Scoff"          
		else
		exp += "Std"  
    end
  	$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end   
  ##################################
  ########   PUMPKING    ###########
  ##################################  
  if name.include? "Pumpking dial"
		px = 100
		py = 100   
		xp = -70
		yp = 0
		n = "PumpKing"
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  exp = "PumpKingExp"  
		if name.include? "grin"
		exp += "Grin"  
		else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ########   BUMPKIN    ############
  ##################################  
  if name.include? "Bumpkin dial"
		px = 100
		py = 100   
		xp = -20
		yp = 35
		n = "BumpKin"
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  exp = "BumpKinExp"  
		if name.include? "cheer"
		exp += "Cheer"  
		elsif name.include? "rage"
		exp += "Rage"   
		elsif name.include? "scary"
		exp += "Scary"  
		else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ########   FARMER    ############
  ##################################  
  if name.include? "Farmer dial"
		px = 100
		py = 100   
		xp = 0
		yp = 0
		n = "Farmer"
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	 exp = "FarmerExp"  
		if name.include? "sad"
		exp += "Sad"  
		elsif name.include? "rage"
		exp += "Rage"   
		elsif name.include? "love"
		exp += "Love"  
		else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end       
  ##################################
  ########   SCARECROW    ############
  ##################################  
  if name.include? "Scarecrow dial"
	unless name.include? "pretty"
		px = 100
		py = 100   
		xp = 10
		yp = 90
		n = "Scarecrow"
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  exp = "ScarecrowExp"  
		if name.include? "scary"
		exp += "Scared" 
		elsif name.include? "scared"
		exp += "Scared"       
		elsif name.include? "cheer"
		exp += "Cheer"   
		elsif name.include? "rage"
		exp += "Rage"  
		else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	  end
	end        
  ##################################
  ########   GANASSA    ############
  ##################################  
  if name.include? "Ganassa dial"
		px = 100
		py = 100   
		xp = -95
		yp = -30
		n = "Ganassa"
	  exp = "GanassaExp"  
		if name.include? "scared"
		exp += "Scared"  
		elsif name.include? "cheer"
		exp += "Cheer"   
		elsif name.include? "rage"
		exp += "Rage"  
		else
		exp += "Std"  
    end
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end     
  ##################################
  ########   DOMINUN    ############
  ##################################
  if name.include? "Dominun dial"
		px = 100
		py = 100   
		xp = 50
		yp = 115
		n = "Dominun"
		if nkdCheat == 1
      n += "N"
     elsif name.include? "naked" 
		  n += "N"  
		end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	 exp = "DominunExp"  
		if name.include? "excited"
		exp += "Excited"  
		elsif name.include? "stern"
		exp += "Stern"   
		elsif name.include? "reprimand"
		exp += "Reprimand"  
		else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ########   KNIGHT    ###########
  ##################################  
  knightPort = 0
  if name.include? "PlayerKnight"
    knightPort = 1
  end  
  if name.include? "BanditP"
   knightPort = 0
  elsif name.include? "KnightP"
   knightPort = 0
  end 
  if knightPort == 1
		px = 100
		py = 100   
		xp = 50
		yp = 115
    pos = 0
    if $game_switches[3529] == true
		px = 50
		py = 50   
		xp = 240
		yp = 250     
    pos = 1
  end  
    petX = xp
    petY = yp  
    backX = xp
    backY = yp
    costX = xp
    costY = yp    
    backK = ""
    knight = ""
    costK = ""
    petK = ""
    extra = "PlayerExtra"
    bod = "PlayerPort"
    backName = "PlayerBack"
    costName = "PlayerCost"
    traitK = 0  
   if $game_actors[1].equips[5] == $data_armors[253]
     backK = "Wings"
   end
   if $game_actors[1].equips[4] == $data_armors[363]
     petK = "HBanner"
   elsif $game_actors[1].equips[4] == $data_armors[673]
     petK = "IBanner"     
   elsif $game_actors[1].equips[4] == $data_armors[368] || $game_actors[1].equips[4] == $data_armors[394]
     petK = "Dur"
     petX = 243
     petY = 286          
   elsif $game_actors[1].equips[4] == $data_armors[369] || $game_actors[1].equips[4] == $data_armors[395]
     petK = "OldNick"
     petX = 289
     petY = 255      
     xp -= (0.2 * px)
   elsif $game_actors[1].equips[4] == $data_armors[379] || $game_actors[1].equips[4] == $data_armors[396]
     petK = "KeatonG"
     petX = 302
     petY = 230     
     xp -= (0.2 * px)
   elsif $game_actors[1].equips[4] == $data_armors[382] || $game_actors[1].equips[4] == $data_armors[397]
     petK = "Gazzetta"
     petX = 294
     petY = 174    
     xp -= (0.2 * px)
   elsif $game_actors[1].equips[4] == $data_armors[393] || $game_actors[1].equips[4] == $data_armors[398]
     petK = "DrusyRot"     
     petX = 290
     petY = 188  
     xp -= (0.2 * px)
   elsif $game_actors[1].equips.include?$data_armors[832]
     petK = "TsukichiAcc" 
     petX = 280
     petY = 168  
     xp -= (0.2 * px)     
   end     
   if $game_actors[1].equips[5] == $data_armors[252]
     costK = "Fish"
   elsif $game_actors[1].equips[5] == $data_armors[254]
     costK = "Gas"
   elsif $game_actors[1].equips[5] == $data_armors[230]
     costK = "Pump"
   elsif $game_actors[1].equips[5] == $data_armors[229]
     costK = "Nun"
   elsif $game_actors[1].equips[5] == $data_armors[260]
     costK = "Gob"
   end  
   traitK = $game_variables[628]   
   if $game_switches[783] == true #classic K
     traitK = 1
   elsif traitK == 2 || traitK == 102 || traitK == 1002 #BattleReady
     knight = "Battle"
     costX -= (0.2 * px)
     if costK == "Nun"
     costY -= (0.2 * px)
     end          
   elsif traitK == 3 || traitK == 103 || traitK == 1003 #Stud
     backName += "Flip"
     costName += "Flip"
     knight = "Stud"
     backX += (0.25 * px)     
     if costK == "Gas"
     costX -= (0.2 * px)      
     elsif costK == "Fish"
     costX += (0.2 * px)  
     elsif costK == "Pump"
     knight = "Stud2" 
     elsif costK == "Nun"
     costK = "NunStud" 
     end        
   elsif traitK == 4 || traitK == 104 || traitK == 1004 #Pacifista
     knight = "Pacifista"
     costY -= (0.4 * px)    
     if costK == "Fish"
     costY -= (0.4 * px)
     elsif costK == "Nun"
     knight = "Pacifista2" 
     costK = ""
     end            
   elsif traitK == 5 || traitK == 105 || traitK == 1005 #Monster
     knight = "Monster"
     if costK == "Pump"
     knight = "Monster2" 
     costK = "PumpMonster"
     end
   elsif traitK == 6 || traitK == 106 || traitK == 1006 #Beast
     knight = "Beast"
     if costK == "Gas"
     costX += (0.1 * px) 
     costY -= (0.4 * px) 
     elsif costK == "Gob"
     costY -= (0.5 * px)         
     elsif costK == "Fish"
     costX -= (0.1 * px) 
     costY -= (0.4 * px) 
     elsif costK == "Pump"
     knight = "Beast2" 
     costX += (0.1 * px) 
     costY -= (0.5 * px) 
     elsif costK == "Nun"
     knight = "Beast2" 
     costY -= (0.6 * px)  
     end   
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
     if costK == "Gas"
     costY -= (0.1 * px)  
     elsif costK == "Fish"
     costY -= (0.5 * px)  
     elsif costK == "Pump"
     costK = "PumpTesto"
     elsif costK == "Nun"
     knight = "Testo3" 
     costK = "NunTesto"
   end         
   elsif traitK == 12 || traitK == 112 || traitK == 1012 #Counsellor
     knight = "Counsellor"
     if costK == "Gas"
     costX += (0.1 * px) 
     elsif costK == "Gob"
     costY += (0.1 * px)
     elsif costK == "Fish"
     costX += (0.2 * px) 
     costY -= (0.2 * px) 
     elsif costK == "Pump"
     costX -= (0.1 * px)   
     costY += (0.05 * px) 
     elsif costK == "Nun"
     costY -= (0.35 * px)  
   end              
   elsif traitK == 13 || traitK == 113 || traitK == 1013 #SoulMaster
     knight = "Soul"
     if costK == "Fish"
     costX -= (0.1 * px)
     costY -= (0.55 * px)
     elsif costK == "Nun"
     costY -= (0.5 * px)
     elsif costK == "Pump"
     costY -= (0.2 * px)     
   end
   elsif traitK == 14 || traitK == 114 || traitK == 1014 #Necromancer
     knight = "Necro"
     if costK == "Fish"
     costX += (0.1 * px) 
     elsif costK == "Pump"
     costY += (0.1 * px)
     elsif costK == "Nun"
     costY -= (0.1 * px)
     end
   elsif traitK == 15 || traitK == 115 || traitK == 1015 #Slaver
     knight = "Slaver"
     if costK == "Gas"
     costY += (0.1 * px) 
     elsif costK == "Gob"
     costY += (0.1 * px)
     elsif costK == "Fish"
     costY -= (0.2 * px) 
     elsif costK == "Pump"
     costY += (0.15 * px) 
     elsif costK == "Nun"
     costY -= (0.1 * px)  
   end       
   elsif traitK == 16 || traitK == 116 || traitK == 1016 #Goddess
     knight = "Goddess"   
     if costK == "Gas"
     costY += (0.1 * px) 
     elsif costK == "Gob"
     costY -= (0.1 * px)
     elsif costK == "Fish"
     costX += (0.2 * px) 
     costY -= (0.2 * px) 
     elsif costK == "Pump"
     costY += (0.05 * px) 
     elsif costK == "Nun"
     costK = "NunGoddess"
   end        
   elsif traitK == 17 || traitK == 117 || traitK == 1017 #Chef
     knight = "Chef"
     yp -= (0.3 * px)
     if costK == "Gas"
     extra = ""
     elsif costK == "Gob"
     extra = ""
     elsif costK == "Fish"
     extra = ""
     costX -= (1.4 * px) 
     costY -= (0.1 * px) 
     elsif costK == "Pump"
     costX -= (0.2 * px)   
     elsif costK == "Nun"
     costY -= (0.1 * px)  
   end          
   elsif traitK == 18 || traitK == 118 || traitK == 1018 #Peasant
     knight = "Peasant"
     if costK == "Gas"
     costX -= (0.05 * px) 
     elsif costK == "Gob"
     costX -= (0.1 * px) 
     costY += (0.05 * px)
     elsif costK == "Fish"
     costY -= (0.1 * px) 
     elsif costK == "Pump"
     costX -= (0.05 * px)   
     costY += (0.05 * px) 
     elsif costK == "Nun"
     knight = "Peasant2" 
     costK = "NunPeasant"
   end         
   elsif traitK == 19 || traitK == 119 || traitK == 1019 #Houndmaster
     knight = "Hound"
     if costK == "Gas"
     costY += (0.1 * px)
     elsif costK == "Gob"
     costY += (0.1 * px)
     elsif costK == "Fish"
     costX += (0.2 * px)
     costY += (0.3 * px) 
     elsif costK == "Pump"
     costY += (0.1 * px) 
     elsif costK == "Nun"
     costX += (0.05 * px)
     costY -= (0.2 * px) 
   end              
   elsif traitK == 20 || traitK == 120 || traitK == 1020 #Guild
     knight = "Guild" 
     extra = "Guild" 
     if costK == "Gas"
     costK = "GasGuild"
     elsif costK == "Gob"
     costY += (0.1 * px)
     elsif costK == "Fish"
     extra = "" 
     costX += (0.1 * px)
     costY += (0.1 * px) 
     elsif costK == "Pump"
     knight = "Guild2" 
     costY += (0.1 * px) 
     elsif costK == "Nun"
     costK = "NunGuild"
   end          
   elsif traitK == 21 || traitK == 121 || traitK == 1021 #Snitch
     knight = "Snitch" 
     if costK == "Gas"
     costY += (0.1 * px)
     elsif costK == "Fish"
     costY -= (0.2 * px) 
     elsif costK == "Pump"     
     costK = "PumpSnitch"
     knight = "Snitch2" 
     elsif costK == "Nun"
     costK = "Snitch2"
     costY -= (0.2 * px)      
   end            
   elsif traitK == 22 || traitK == 122 || traitK == 1022 #Incubus
     knight = "Incubus"
     yp -= (0.4 * px)
   elsif traitK == 23 || traitK == 123 || traitK == 1023 #Banker
     knight = "Banker"       
     if costK == "Gas"
     costX += (0.05 * px)
     costY += (0.2 * px)
     elsif costK == "Gob"
     costX += (0.05 * px)
     costY += (0.2 * px)
     elsif costK == "Fish"
     costY -= (0.3 * px) 
     elsif costK == "Pump"
     costY += (0.3 * px) 
     knight = "Banker2" 
     elsif costK == "Nun"
     knight = "Banker3" 
     costK = ""
   end          
   elsif traitK == 24 || traitK == 124 || traitK == 1024 #Mason
     knight = "Mason"     
     if costK == "Fish"
     costY -= (0.1 * px)
     elsif costK == "Gob"
     costY -= (0.12 * px)   
     elsif costK == "Pump"
     knight = "Mason2" 
     costY += (0.3 * px)        
     elsif costK == "Nun"
     costY -= (0.15 * px)   
     end          
   elsif traitK == 25 || traitK == 125 || traitK == 1025 #Insurgent
     knight = "Insurgent"  
     if costK == "Fish"
     costX += (0.3 * px)
     costY -= (0.2 * px)
     elsif costK == "Pump"
     costY -= (1 * px)        
     elsif costK == "Nun"
     knight = "Insurgent2" 
     costK = "" 
     end       
   elsif traitK == 26 || traitK == 126 || traitK == 1026 #Brawler
     knight = "Brawler"
   elsif traitK == 27 || traitK == 127 || traitK == 1027 #Zealot
     knight = "Zealot"      
     if costK == "Gas"
     costX += (0.2 * px)
     elsif costK == "Gob"
     costX += (0.2 * px)
     costY -= (0.4 * px)   
     elsif costK == "Fish"
     costX += (0.3 * px)
     costY -= (0.2 * px)      
     elsif costK == "Pump"
     knight = "Zealot2" 
     costX -= (0.15 * px)
     costY += (0.05 * px)        
     elsif costK == "Nun"
     knight = "Zealot3" 
     costK = ""
   end     
   elsif traitK == 28 || traitK == 128 || traitK == 1028 #MonsterEater
     knight = "MonsterEater"   
     if costK == "Pump"
     costY += (0.1 * px) 
   end
   elsif traitK == 29 || traitK == 129 || traitK == 1029 #Dice
     knight = "Dice"   
     if costK == "Pump"
     costY += (0.2 * px)
     elsif costK == "Nun"
     knight = "Dice2" 
     costK = ""
     costY -= (0.3 * px)
   end   
   elsif traitK == 30 || traitK == 130 || traitK == 1030 #DreamK
     knight = "Dream"   
     if costK == "Gas"
     costY -= (0.2 * px)  
     elsif costK == "Gob"
     costY -= (0.2 * px)   
     elsif costK == "Fish"
     costX += (0.1 * px)      
     costY -= (0.5 * px)      
     elsif costK == "Pump"
     costX -= (0.2 * px)      
     costY -= (0.3 * px)       
     elsif costK == "Nun"
     costX += (0.1 * px)      
     costY -= (0.7 * px)   
     end
   elsif traitK == 31 || traitK == 131 || traitK == 1031 #RabiK
     knight = "Rabi"
     if costK == "Gas"
     costY += (0.1 * px)  
     elsif costK == "Gob"
     costY += (0.1 * px)   
     elsif costK == "Fish"
     costX += (0.2 * px)      
     elsif costK == "Pump"
     costX += (0.1 * px)      
     costY += (0.2 * px)       
     elsif costK == "Nun"
     costX += (0.15 * px)      
     costY -= (0.05 * px)   
     end     
   elsif traitK == 32 || traitK == 132 || traitK == 1032 #MagiK
     knight = "Magi"
     if costK == "Gas"
      costK = "MagiGas"   
     elsif costK == "Gob"
      costK = "MagiGob"
     elsif costK == "Fish"
      costK = "MagiFish"      
     elsif costK == "Pump"
      costK = "MagiPump"     
     elsif costK == "Nun"
      knight = "Magi2"
      costK = "MagiNun" 
     else
      costK = "Magi" 
    end        
   elsif traitK == 33 || traitK == 133 || traitK == 1033 #Clockwork
     knight = "Clockwork"   
     if costK == "Gas"
     costY += (0.3 * px)  
     elsif costK == "Gob"
     costX -= (0.18 * px) 
     costY += (0.18 * px)   
     elsif costK == "Fish"
     costY += (0.1 * px)      
     elsif costK == "Pump"
     costX -= (0.1 * px) 
     costY += (0.25 * px)         
     elsif costK == "Nun"
     costX -= (0.1 * px)      
     end          
   end           
   bod += knight
   backName += backK
   costName += costK
   extra += knight
   if $game_switches[3775] == true #Skeleton Ending
     bod = "PlayerPortSkeleton"
     $game_map.screen.pictures[111].show(bod, pos, xp, yp, px, py, 255, 0)
     return
   end      
   ### SHAD ###
   @shadMaps = [125,531,532,533,535]
   if @shadMaps.include?$game_map.map_id
     bod = "PlayerPortShadow"
     $game_map.screen.pictures[111].show(bod, pos, xp, yp, px, py, 255, 0)
     return
   end   
   ### SHAD ###   
    if $game_actors[1].equips[5] == $data_armors[380] 
  	 bod = "DIY Wyvern"
     backName = ""
     costName = ""
     extra = ""
	   px = 50
		 py = 50   
	   xp = 240
	   yp = 250     
     pos = 1  
    elsif $game_actors[1].equips[5] == $data_armors[383]
	   bod = "DIY Shark"
     backName = ""
     costName = ""
     extra = ""
	   px = 50
		 py = 50   
	   xp = 240
	   yp = 250     
     pos = 1   
    elsif $game_actors[1].equips[5] == $data_armors[572]
  	 bod = "DIY Larva"   
     backName = ""
     costName = ""
     extra = ""
	   px = 50
		 py = 50   
	   xp = 240
	   yp = 250     
     pos = 1     
   end   
   $game_map.screen.pictures[111].show(petK, pos, petX, petY, px, py, 255, 0)
   $game_map.screen.pictures[112].show(backName, pos, backX, backY, px, py, 255, 0)
   $game_map.screen.pictures[113].show(bod, pos, xp, yp, px, py, 255, 0)
   $game_map.screen.pictures[114].show(costName, pos, costX, costY, px, py, 255, 0)
   $game_map.screen.pictures[115].show(extra, pos, xp, yp, px, py, 255, 0)
   return
   end
  ##################################
  ########   KNIGHT P    ###########
  ##################################
  if name.include? "BanditP dial"
   pPort = "BanditKnight" 
   ban = 1
  elsif name.include? "Knight Princess dial"
   pPort = "BanditKnight"
   ban = 0
   end  
   ##################### 
   if pPort == "BanditKnight"
		px = 100
		py = 100   
		xp = 10
		yp = 28
	  #####################  
	  if ban == 0
		n = "KnightP"
	  else
		n = "BanditP"
	  end
	  #####################
		if nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
		  n += "N"  
		end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	   exp = "KnightPExp"  
		if name.include? "sad"
		exp += "Sad"  
		elsif name.include? "rage"
		exp += "Rage"  
		elsif name.include? "love"
		exp += "Love"  
		elsif name.include? "fluster"
		exp += "Fluster"  
		else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end      
  ##################################
  ########   ARCANE    ############
  ##################################
   if name.include? "Arcane Princess dial"
		px = 100
		py = 100   
		xp = 0
		yp = 14
		n = "ArcaneP"		
	  exp = "ArcanePExp"  
		if name.include? "glad"
		exp += "Glad"  
		elsif name.include? "rage"
		n = "ArcanePRage"  
		exp = ""
		elsif name.include? "lick"
		exp += "Lick"  
		elsif name.include? "stare"
		exp += "Stare"  
		else
		exp += "Std"  
    end
    $game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end        
  ##################################
  ########   BATTY    ############
  ##################################
  if name.include? "Batty dial"
		px = 100
		py = 100   
		xp = 40
		yp = 140
		n = "Batty"
		if nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
		  n += "N"  
		end  
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	 exp = "BattyExp"  
		if name.include? "sad"
		exp += "Sad"  
		elsif name.include? "rage"
		exp += "Rage"   
		elsif name.include? "love"
		exp += "Love"  
		elsif name.include? "shock"
		exp += "Shock"  
		else
		exp += "Std"  
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end    
  ##################################
  ########   FAUN    ############
  ##################################
  if name.include? "Faun Princess Dial"
		px = 100
		py = 100   
		xp = 35
		yp = 105  
		body = "FaunP"
		if name.include? "hidden"
		  body += "h"
		elsif name.include? "naked"  
		  body += "N2"        
		elsif $game_actors[43].equips[5] == nil || $game_actors[43].equips[5] == $data_armors[275] || nkdCheat == 1
		  body += "N"
		elsif $game_actors[43].equips[5] == $data_armors[271]
		  body += "Bar"      
		end  
		$game_map.screen.pictures[111].show(body, 0, xp, yp, px, py, 255, 0)
	 exp = "FaunPExp"  
		if name.include? "sad" || "Sad"
		exp += "Sad"  
		elsif name.include? "rage" || "Rage"
		exp += "Rage"   
		elsif name.include? "love" || "Love"
		exp += "Love"  
		elsif name.include? "drunk" || "Drunk"
		exp += "Drunk"  
	  end
	  unless name.include? "hidden"
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  end
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end
  ##################################
  ########   FAUN BRO   ############
  ##################################
  if name.include? "FaunBro dial"
		px = 100
		py = 100   
		xp = 35
		yp = 55  
		n = "FaunBro"
		if nkdCheat == 1
      n += "N"
     elsif name.include? "naked"
		  n += "N"  
		end    
		$game_map.screen.pictures[111].show(n, 0, xp, yp, px, py, 255, 0)
	  exp = "FaunBroExp"
		if name.include? "sad"
		exp += "Sad"
		elsif name.include? "rage"
		exp += "Rage"
		elsif name.include? "love"
		exp += "Love"
		elsif name.include? "drunk"
		exp += "Drunk"
    else
    exp += "Std"
	  end
	  $game_map.screen.pictures[112].show(exp, 0, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)      
	  return
	end  
  ##################################
  ###########   DRIDER   ###########
  ################################## 
  if name.include? "Drider Princess Dial"
	pPort = "Drider"
	if name.include? "static"
	pPort = "NoDrider"
	end  
  end
  if pPort == "Drider"
		pRace = 21
		pVar = 4021
		px = 100
		py = 100   
		xp = -165
		yp = 0
		pos = 0
		if $game_switches[2411] == true    
		  xp = 365
		  yp = 345       
		  px = 60
		  py = 60        
		  pos = 1     
		elsif $game_switches[579] == true
		  xp = 158
		  yp = 250
		  px = 40
		  py = 40        
		  pos = 1
		elsif $game_switches[3529] == true #port center / LVLUp
		  xp = 242 
		  yp = 245
		  px = 40
		  py = 40   
		  pos = 1
		elsif $game_switches[3416] == true #Diary
		  xp = 150 
		  yp = 300
		  px = 60
		  py = 60   
		  pos = 1
		end         
	  priExp = ""
	  exp = ""
	  dre = ""
	  dreB = ""
	  helmBase = "DriderPHead"
	  expBase = "DriderPexp"
	  needHelm = 0
	  expS = ""
	exp = "Std"
	if name.include? "sad2"
	  exp = "Sad2"
	elsif name.include? "sad"
	  exp = "Sad"
	elsif name.include? "rage"
	  exp = "Rage"
	elsif name.include? "love"
		exp = "Love"                 
	elsif name.include? "hungry"
		exp = "Hungry"                         
	end            
  ##############
	   bodyB = "DriderP" 
     bodyS = ""
	 if name.include? "naked"
	   bodyS = "Naked"
	 elsif $game_actors[31].equips[5] == nil || $game_actors[31].equips[5] == $data_armors[275] || nkdCheat == 1
	   bodyS = "Naked"
	  elsif $game_actors[31].equips[5] == $data_armors[418]
		  bodyS = "H20"
	  elsif $game_actors[31].equips[5] == $data_armors[444]
		  bodyS = "C20"
	  elsif $game_actors[31].equips[5] == $data_armors[454]
		  bodyS = "X1"
	  elsif $game_actors[31].equips[5] == $data_armors[474]
		  bodyS = "F20"
    elsif $game_actors[31].equips[5] == $data_armors[621]
		  bodyS = "Bar"
    elsif $game_actors[31].equips[5] == $data_armors[642]
		  bodyS = "Net"         
	  end  
  ##############
	if name == "DriderMenu"
	  exp = "Hungry"
	elsif name == "DriderMenuH"
	  exp = "Hungry"
	end    
	if name.include? "hidden"
	  bodyS = "Hidden"
	end  
	  #if bodyS == "" #no alt form / costumes allowed
	  #    
	  #end 
	  body = bodyB + bodyS
  #--------------------------------#
  if pRace != 0 && pVar != 0
	if $game_variables[4000][1] == pRace && $game_variables[pVar][0] != 0 
	 if $game_variables[4000][5] == 0 || $game_variables[4000][5] == 3
	  $game_switches[4001] = true
	  name = "RND"
	 end
	end
   end
  #--------# DIY ARMORS #----------#
   if $game_actors[@ac].equips[5] == $data_armors[380] 
	 name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383]
	 name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572]
	 name = "DIYl"   
  end
   #--------------------------------#
 if name.include?"DIY"
	if pos == 0
           xp = -260
           yp = 0
        end
if name == "DIY"
		$game_map.screen.pictures[121].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYs"
        $game_map.screen.pictures[121].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
	 elsif name == "DIYl"
        $game_map.screen.pictures[121].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	  end  
	return
 end	
  #--------------------------------#  
  @sch = @heirSW[pRace]
  @vch = @heirVAR[pRace]
  if $game_variables[@vch][0] == pRace && @sch != 0
  if $game_switches[579] == true && $game_switches[@sch] == true #check if Heir Placed
   name = "ThroneHeir" + pPort
    @prog = @heirVAR[pRace]
   $game_map.screen.pictures[122].show("HeirBanner", 0, 160, 190, 100, 100, 255, 0) 
  end
  end
  #--------------------------------# 
goInPRND = 1
if name != "RND" && name != "DIY" && name != "DIYs" && name != "DIYl"
goInPRND = 0
end
if name.include?"ThroneHeir" #toRND
goInPRND = 1
end
if goInPRND == 0
		$game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)  
	  if needHelm == 1
		helm = helmBase + bodyS
		helmB = helmBase + bodyS + "B" 
		$game_map.screen.pictures[119].show(helm, pos, helmx, helmy, px, py, 255, 0)
		$game_map.screen.pictures[112].show(helmB, pos, helmx, helmy, px, py, 255, 0) 
	  end      
	   priExp = expBase + expS + exp 
	   $game_map.screen.pictures[117].show(priExp, pos, xp, yp, px, py, 255, 0) 
	if inMenu == 0
	 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
	  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	end  
	end
   return 
   end  #toRND
   end
  #####################
  ##### EDLRITCH ######
  #####################
  if name.include? "Holstaur Princess dial"
		pos = 0
		px = 100
		py = 100   
		xp = 30
		yp = -41          
		ere = 0
		exp = "HolPexp"
		if name.include? "sad"  
		  exp += "Sad"
		elsif name.include? "mad"  
		  exp += "Rage"
		elsif name.include? "horny"  
		  exp += "Love"
		  ere = 1
		elsif name.include? "milk"  
		  exp += "Milk"
		  ere = 1
		else  
		  exp += "Std"
		end           
	   n = "HolstaurP"    
	 if name.include? "naked"
	   n += "N"
	 elsif $game_actors[25].equips[5] == nil || $game_actors[25].equips[5] == $data_armors[275] || nkdCheat == 1
	   n += "N"
	  elsif $game_actors[25].equips[5] == $data_armors[114]
		  n += "SS"
	  elsif $game_actors[25].equips[5] == $data_armors[498]
		  n += "Pri"
		  $game_map.screen.pictures[113].show("HolPMaskPri", pos, xp, yp, px, py, 255, 0)
		  ere = 0
	  elsif $game_actors[25].equips[5] == $data_armors[499]
		  n += "H20"        
		  $game_map.screen.pictures[113].show("HolPMaskH20", pos, xp, yp, px, py, 255, 0)
		  ere = 0
    elsif $game_actors[25].equips[5] == $data_armors[622]
		  n += "Bar"    
	  end
	 if ere == 1
	   n += "x" 
	 end  
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return
	  end  
  ### SOLDIERS ###
  if name == "Old King dial"
	$game_variables[1918] = 1837
	$game_variables[2051] = 2   
	if $game_variables[4087][0] != 0    
	name = "RNDnpc"
	end  
  end  
  if name.include? "DQamb dial"
	$game_variables[1918] = 1178 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "pleased"
	  $game_variables[2051] = 4   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[3278][0] != 0
	name = "RNDnpc"
	end
  end  
  if name.include? "Drider FireWitch dial"
	$game_variables[1918] = 1836 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "prey"
	  $game_variables[2051] = 4   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4086][0] != 0
	name = "RNDnpc"
	end
  end 
  # HOURLY DIAL #
  if name.include? "Hourly dial" #&& $game_variables[4085][0] != 0
	name = "RNDnpc"
	$game_variables[1918] = 1835
	if name.include? "naked"
	  $game_variables[4085][17] = 2
	  else
	  $game_variables[4085][17] = 1
	end 
	$game_variables[2051] = 0   
	if name.include? "glad"
	  $game_variables[2051] = 0
	elsif name.include? "disappoint"
	  $game_variables[2051] = 1
	elsif name.include? "rage"  
	  $game_variables[2051] = 2
	elsif name.include? "scared"    
	  $game_variables[2051] = 4
	end  
  end  
  #^^^  HOURLY DIAL  ^^^#
  if name == "Goblin Elite"
	$game_variables[1918] = 1839
	$game_variables[2051] = 0   
	if $game_variables[4089][0] != 0
	name = "RNDnpc"
	end  
  end 
  if name.include? "Goblin Musk"
	$game_variables[1918] = 1834 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "prey"
	  $game_variables[2051] = 4   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4084][0] != 0
	name = "RNDnpc"
  $game_variables[4084][11] = 3
  end
  end 
  if name.include? "Goblin Auc"
	$game_variables[1918] = 938 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "prey"
	  $game_variables[2051] = 4   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[3188][0] != 0
	name = "RNDnpc"
	end
  end 
  #KNOCKER
  if name.include? "Knocker dial"
	$game_variables[1918] = 1811 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4061][0] != 0
	name = "RNDnpc"
	end
  end  
  ### JELL ###
  marm = 0
  marmOK = 0
  if name.include? "Jell dial"
	marmOK = 1
  elsif name.include? "Marmalad dial"
	marmOK = 1
  end  
  if marmOK == 1
	$game_variables[1918] = 1813 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4063][0] != 0
	name = "RNDnpc"
	marm = 1
	end
  end 
  ### HORNET ###
  if name.include? "Hornet dial"
	$game_variables[1918] = 1815 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "lust"
	  $game_variables[2051] = 4   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4065][0] != 0
	name = "RNDnpc"
	end
end  
  ### G HORNET ###
  if name.include? "GHornet dial"
	$game_variables[1918] = 1840 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "lust"
	  $game_variables[2051] = 4   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4090][0] != 0
	name = "RNDnpc"
	end
  end  
  ### BONEHEAD ###
  boneOK = 0
  if name.include? "Bonehead dial"
	boneOK = 1
  elsif name.include? "BoneheadE dial"
	boneOK = 1
  end
  if boneOK == 1
	$game_variables[1918] = 1816 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4066][0] != 0
	name = "RNDnpc"
	end
end  
  ### DESERT GUARD ###
  if name.include? "DesGuard dial"
	$game_variables[1918] = 1843
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4093][0] != 0
	name = "RNDnpc"
	end
end  
  ### INCUBI ###
  if name.include? "Incubus dial"
	$game_variables[1918] = 1817 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4067][0] != 0
	name = "RNDnpc"
	end
end
  ### BANSHEE ###
  if name.include? "Banshee dial"
	$game_variables[1918] = 1818 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "scary"
	  $game_variables[2051] = 4       
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4068][0] != 0
	name = "RNDnpc"
	end
end  
  ### GREMLIN ###
  if name.include? "Gremlin dial"
	$game_variables[1918] = 1819 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4069][0] != 0
	name = "RNDnpc"
	end
end  
  ### MOTH GUARD ###
  if name.include? "Moth Guard dial"
	$game_variables[1918] = 1820
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "mad"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "glad"
	  $game_variables[2051] = 4   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4070][0] != 0
	name = "RNDnpc"
	end
end  
  ### SIDHE ###
  if name.include? "CatSidhe dial"
	$game_variables[1918] = 1821 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4071][0] != 0
	name = "RNDnpc"
	end
  end  
  if name.include? "Jackalope dial"
	$game_variables[1918] = 1824
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4074][0] != 0
	name = "RNDnpc"
	end
end  
  ### KNIGHT ###
  if name.include? "Knight dial"
	$game_variables[1918] = 1812 
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4062][0] != 0
	name = "RNDnpc"
	end
end  
  ### MER RAIDER ###
  if name.include? "Mermaid Raider dial"
	$game_variables[1918] = 1828
  if name.include? "sad"
	  $game_variables[2051] = 1 
  elsif name.include? "rage"
	  $game_variables[2051] = 2
  elsif name.include? "love"
	  $game_variables[2051] = 3   
  elsif name.include? "mock"
	  $game_variables[2051] = 4   
  elsif name.include? "wary"
	  $game_variables[2051] = 5  
	else 
	  $game_variables[2051] = 0    
	end  
	if $game_variables[4078][0] != 0
	name = "RNDnpc"
	end
  end   
  ### SOLDIERS ### - END - 
  if $game_variables[4000][0] == 1 #Princess port
	if @dra == 10
	  @ac = 18
	elsif @dra == 11
	  @ac = 11    
	elsif @dra == 12
	  @ac = 24
	elsif @dra == 13
	  @ac = 55
	elsif @dra == 14
	  @ac = 58        
	end   
  if @ac != nil
  if $game_actors[@ac].equips[5] == $data_armors[380] #DIY Wyvern
	name = "DIY"
  elsif $game_actors[@ac].equips[5] == $data_armors[383] #DIY Shark
	name = "DIYs"
  elsif $game_actors[@ac].equips[5] == $data_armors[572] #DIY Larva
	name = "DIYl"
  end 
  end
  end
  #-------------------------------------------------------#
  if $game_variables[4000][3] == 1
	  $game_switches[4002] = true  
  elsif $game_variables[4000][6] == 2 #maid
	$game_switches[4003] = true
  elsif $game_variables[4000][6] == 1 #swimsuit
	$game_switches[4004] = true
  elsif $game_variables[4000][6] == 3 #prisoner
	$game_switches[4005] = true
  elsif $game_variables[4000][6] == 4 #battlesuits
	$game_switches[4006] = true
  elsif $game_variables[4000][6] == 5 #bunny
	$game_switches[4007] = true
  elsif $game_variables[4000][6] == 6 #courtesan
	$game_switches[4008] = true
  elsif $game_variables[4000][6] == 10 #queen slave
	$game_switches[4010] = true    
  elsif $game_variables[4000][6] == 11 #nurse
	$game_switches[4011] = true  
  elsif $game_variables[4000][6] == 13 #halloween 2020
	$game_switches[4013] = true
  elsif $game_variables[4000][6] == 15 #chillbite 2020
	$game_switches[4015] = true
  elsif $game_variables[4000][6] == 16 #bloomgaze 2020
	$game_switches[4016] = true
  elsif $game_variables[4000][6] == 18 #x1
	$game_switches[4018] = true
  elsif $game_variables[4000][6] == 19 #x2
	$game_switches[4019] = true
  elsif $game_variables[4000][6] == 20 #x3
	$game_switches[4020] = true    
  elsif $game_variables[4000][6] == 21 #x4
	$game_switches[4021] = true
  elsif $game_variables[4000][6] == 22 #x5
	$game_switches[4022] = true    
  elsif $game_variables[4000][6] == 23 #x6 / colosseum
	$game_switches[4023] = true      
  elsif $game_variables[4000][6] == 24 #altCostume (Wyv SS)
	$game_switches[4024] = true       
  elsif $game_variables[4000][6] == 25 #---
	$game_switches[4025] = true   
  elsif $game_variables[4000][6] == 26 #---
	$game_switches[4026] = true   
  elsif $game_variables[4000][6] == 27 #---
	$game_switches[4027] = true   
  elsif $game_variables[4000][6] == 28 #---
	$game_switches[4028] = true   
  elsif $game_variables[4000][6] == 29 #---
	$game_switches[4029] = true   
  elsif $game_variables[4000][6] == 30 #Wyv Pierce
	$game_switches[4030] = true     
  end    
  #-------------------------------------------------------#
  if name != "RND"
   $game_variables[4000] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  end 
  #-----------------------------------------------------------#
  goInRnd = 0
  if name == "S&D" || name == "RND" || name == "RNDnpc" || name == "DIY" || name == "DIYs" || name == "DIYl"
	  goInRnd = 1
  elsif name.include?"ThroneHeir"
    goInRnd = 1
  end
  if goInRnd == 1
	cost = ""
	bod = ""
	base = ""
	basedre = ""
	col = ""
	col1 = ""
	col2 = ""
	sk = ""
	hcol = ""
	hsty = ""
	hair = ""
	hairb = ""
	dress = ""
	c1 = ""
	c2 = ""
	h = ""
	hs = ""
	basew = ""
	basee = ""
	ear = "" 
	w = ""
	colHo = ""
	tailS = ""
	expF = ""
	expS = ""    
	horn = ""
	hornS = ""
	head = ""
	hairS = ""    
		  px = 100
		  py = 100  
	if $game_variables[4000][0] == 1
		  px = 100
		  py = 100
	  if $game_variables[4000][2] == 10
		if $game_variables[4000][1] == 16 #dragons
		  px = 40
		  py = 40
		else
		  px = 50
		  py = 50
		  end
	  end    
	  if $game_variables[4000][2] == 11
		  px = 70
		  py = 70
		end
		@asd = $game_variables[4000][1]
		@prog = 4000
		@prog += @asd
		@prog += @dra
    if @dra == 14
      @prog = 4035
    end  
		  else     
	px = 100
	py = 100
  checkProgRND = 1
  ### SHOW HEIR ###  
  if name.include?"ThroneHeir"
	  checkProgRND = 0
  end	
  ### SHOW HEIR ###
	if checkProgRND == 1
	  name = "RND"    
	  @prog = 2250 + $game_variables[1918] #staple NPCs
	if $game_switches[2412] == true #RND World NPC#
	  @prog = 2100 + $game_variables[2097] 
	elsif $game_switches[2443] == true
	  @prog = $game_variables[2165] #Benched Progeny#    
	elsif $game_switches[2466] == true || $game_switches[3534] == true || $game_switches[3215] == true
	  @prog = 2250 + $game_variables[1918] #babby prev#    
	elsif $game_switches[2730] == true || $game_switches[3451] == true || $game_switches[3340] == true || $game_switches[3038] == true
	  @prog = $game_variables[2868] #Prog change#     
	elsif $game_switches[2628] == true || $game_switches[579] == true #Heir Talk# 
	  @prog = $game_variables[2769] 
	elsif $game_switches[2562] == true #Kob Noble#   
	  @prog = 2243    
	elsif $game_switches[2411] == true #Random ProgenySim#  
	  @prog = 2249 + $game_variables[2067] 
	elsif $game_switches[2421] == true #Random Kobold# 
	  @prog = 2120 + $game_variables[2161] 
	else
	  @prog = 2250 + $game_variables[1918] 
  end  
	end
end
  @ski = $game_variables[@prog][60] rescue ""
  #pos
  @bon = 0
  if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true
  pos = 1
	else
  pos = 0
  end
  #####
  if $game_switches[3215] == true #centerhead
      pos = 1
		  pxHead = 100
		  pyHead = 100 
      @race = $game_variables[@prog][0]
      xStr = [0,0,410,365,0,0,350,400,310,390,340,380,400,380,395,410,0,0,410,410,375,260,435,0,0,0,0,0,0,0,390,370,370]
      yStr = [0,0,415,465,0,0,470,400,385,320,450,390,390,350,375,415,0,0,450,520,550,460,400,0,0,0,0,0,0,0,490,470,470]
		  xpHead = xStr[@race]
		  ypHead = yStr[@race]
      if $game_variables[@prog][0] == 18 && $game_variables[@prog][3] == 4 #big mer
		  xpHead = 485
		  ypHead = 600
      end
  end  
  if $game_variables[@prog][17] == 12 || name == "DIY" || $game_variables[@prog][17] == 14 || name == "DIYs" || $game_variables[@prog][17] == 24 || name == "DIYl" #DIY Wyvern
		  xp = -245
		  yp = 0        
		if $game_switches[2359] == true || $game_switches[2466] == true
		  px = 80
		  py = 80   
		  xp = 50
		  yp = 0
		  end
		if $game_switches[2411] == true
		  px = 50
		  py = 50        
		  xp = 365
		  yp = 345
		end
	  if $game_switches[579] == true
		  px = 50
		  py = 50        
		  xp = -15
		  yp = 90       
	  end 
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 45
		  py = 45       
	  end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
	if $game_variables[@prog][17] == 12 || name == "DIY"    
	$game_map.screen.pictures[112].show("DIY Wyvern", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][17] == 14 || name == "DIYs"
	$game_map.screen.pictures[112].show("DIY Shark", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][17] == 24 || name == "DIYl"
	$game_map.screen.pictures[112].show("DIY Larva", pos, xp, yp, px, py, 255, 0)
	end
	  if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
   else ##### to ending
  #####################
  ##### MIMIC ######
  #####################    
  if $game_variables[@prog][0] == "mimic"
		xp = 10
		yp = 165  
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 210
		  yp = 5
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
	   if $game_variables[@prog][19] == 2
		  xp += 15
		  yp += 25        
	   end             
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 80
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end          
	 n = "MimicP"   
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	elsif $game_variables[@prog][17] == 4
	   n += "s"     
	elsif $game_variables[@prog][17] == 13    
	   n += "H20"
	elsif $game_variables[@prog][17] == 15     
	   n += "C20"      
	elsif $game_variables[@prog][17] == 16     
	   n += "F20"
	 end
	 exp = "MimicPExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Hungry"
	 end
	 exp += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end       
  #####################
  ##### WENDIGO ######
  ##################### 
  if $game_variables[@prog][0] == "wendigo"
	 if $game_switches[4450] == true
		xp = -70
		yp = 0      
	   else
		xp = 50
		yp = 55  
	 end   
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 210
		  yp = 5
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345          
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 80
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end            
	 if $game_switches[3416] == true || $game_switches[2359] == true || $game_switches[2411] == true || $game_switches[2466] == true || $game_switches[579] == true || $game_switches[3451] == true   
	 if $game_switches[4450] == true
	   if $game_variables[@prog][17] == 16
	   $game_map.screen.pictures[111].show("WendigoF20", pos, xp, yp, px, py, 255, 0)     
	   elsif $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   $game_map.screen.pictures[111].show("WendigoN", pos, xp, yp, px, py, 255, 0)
	   else
	   $game_map.screen.pictures[111].show("Wendigo", pos, xp, yp, px, py, 255, 0)
	  end     
	 else
	   if $game_variables[@prog][17] == 16
	   $game_map.screen.pictures[111].show("WendigoHUMF20", pos, xp, yp, px, py, 255, 0)     
	   elsif $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   $game_map.screen.pictures[111].show("WendigoHUMN", pos, xp, yp, px, py, 255, 0)
	   else
	   $game_map.screen.pictures[111].show("WendigoHUM", pos, xp, yp, px, py, 255, 0)
	  end    
	end  
	#### WENDIGO MENU ####
	   if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end     
	 return
	 #### END WENDIGO MENU ####
   else
		xp = 0
		yp = 0
	##########
	@a = "WendigoP dial"
	@b = ""
	@c = ""
	@d = ""
	  ###COST
	 if $game_switches[4450] == true  
	@b = ""
  else
	@b = " HUM"
  end
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   @c = " naked"
	  else
	   @c = ""
	 end    
	###EXP
	if $game_switches[4450] == true
	 if $game_variables[2051] == 0    
	  @d = ""
	 elsif $game_variables[2051] == 1   
	  @d = " defeat" 
	 elsif $game_variables[2051] == 2   
	  @d = " rage" 
	 elsif $game_variables[2051] == 3    
	  @d = " tamed" 
	 elsif $game_variables[2051] == 4      
	  @d = " hungry"
	end      
	else
	 if $game_variables[2051] == 0    
	  @d = " calm"
	 elsif $game_variables[2051] == 1   
	  @d = " desperate" 
	 elsif $game_variables[2051] == 2   
	  @d = " determinate" 
	 elsif $game_variables[2051] == 3    
	  @d = " love" 
	 elsif $game_variables[2051] == 4      
	  @d = " scared"
	end    
	end  
	#####
	wendiname = @a + @b + @c + @d
	$game_map.screen.pictures[111].show(wendiname, pos, xp, yp, px, py, 255, 0)
  $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	return
	  end
	end
  #####################
  ##### SCARECROW #####
  #####################    
  if $game_variables[@prog][0] == "scarecrow"
		xp = 0
		yp = 45 
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 210
		  yp = 5
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
	   if $game_variables[@prog][19] == 2
		  xp += 15
		  yp += 25        
	   end             
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 80
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end          
	 n = "ScarecrowP"
    ###########
    voiceAc = "VoiceSca"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end             
    voiceV = 90 
    voiceP = 110  
    ###########
	 exp = "ScarecrowPExp"
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 13    
	   n += "X1"
     exp += "X1"
	 end   
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
      voiceV -= 10
      voiceP -= 15       
	 elsif $game_variables[2051] == 2
	 expS = "Evil"
      voiceV += 15
      voiceP += 20       
	 elsif $game_variables[2051] == 3
	 expS = "Love"
      voiceV += 10
      voiceP -= 10      
	 elsif $game_variables[2051] == 4
	 expS = "Scary"
      voiceV += 15
      voiceP += 20     
	 elsif $game_variables[2051] == 5
	 expS = "Sack"    
      voiceV -= 10
      voiceP -= 15      
	 end
	 exp += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true
     voiceAc += (rand(4)+1).to_s
     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #                
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end      
  #####################
  ##### AMELIE ######
  #####################   
  if $game_variables[@prog][0] == "amelie"
		xp = 0
		yp = 75  
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 215
		  yp = 45
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end            
	 n = "Amelie" 
	if $game_variables[@prog][17] == 13  
	   n += "H20"
	   $game_map.screen.pictures[113].show("AmelieH20Mask", pos, xp, yp, px, py, 255, 0)
	elsif $game_variables[@prog][17] == 18     
	   n += "X1"
	elsif $game_variables[@prog][17] == 19  
	   n += "Scanty"     
	elsif $game_variables[@prog][17] == 21 
	   n += "X4"          
	   $game_map.screen.pictures[113].show("AmelieX4Mask", pos, xp, yp, px, py, 255, 0)
	elsif $game_variables[@prog][17] == 22 
	   n += "Bar"          
	   $game_map.screen.pictures[113].show("AmelieBarMask", pos, xp, yp, px, py, 255, 0)     
	elsif $game_variables[@prog][17] == 23 
	   n += "Zegre"          
	   $game_map.screen.pictures[113].show("AmelieZegreMask", pos, xp, yp, px, py, 255, 0)          
	elsif $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   n += "N"
	 end
	 expE = "AmelieExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Disgust"
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 if $game_variables[@prog][17] != 18  
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)
	 end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end 
  ######################
  ####### TASBOT #######
  ##################### #   
  if $game_variables[@prog][0] == "bot"
     tas = $game_variables[776]
     bot = $game_variables[778]
     if $game_map.map_id == 64 || $game_map.map_id ==170
      tas[bot] = "Gattai"
     end
     if tas[bot] == "Gattai"       
	     xp = -30
	     yp = 0
     else
	     xp = -15
	     yp = 140
     end  
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 320    
      if tas[bot] == "Gattai"
        yp += 30
      end       
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
      if tas[bot] == "Gattai"
        yp += 15
      end       
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
      if tas[bot] == "Gattai"
        yp += 30
      end  
		end   
    ###########
    voiceAc = "VoiceGol"
    voiceV = 80 
    voiceP = 120
    ###########       
	 n = "TASBOT"   
   n += tas[bot]
   expE = "TASBOTGattaiExp"
   #######################
   @ac = $game_variables[330]
   if @ac == 0
   @ac = 35
   end
   if tas[bot] == "Gattai" && $game_actors[@ac].state?(217) == true #camp + depleted
      n += "Down" 
      expE += "Down"
      voiceV = 50 
      voiceP = 20 
      yp += 0.60 * px
   end
   #######################
   expS = "Std"
   if tas[bot] == "Gattai"
	 if $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"   
   elsif $game_variables[@prog][17] == 13      
	     n += "H20"     
	 elsif $game_variables[@prog][17] == 15      
	     n += "C20"        
	 elsif $game_variables[@prog][17] == 2 || nkdCheat == 1      
	   n += "N"     
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
      voiceV -= 10
      voiceP -= 15    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
      voiceV += 15
      voiceP += 20      
 	 elsif $game_variables[2051] == 3
    expS = "Love"
      voiceV += 10
      voiceP -= 10      
	 elsif $game_variables[2051] == 4
    expS = "Curious"
      voiceV += 15
      voiceP += 20      
    end   
  else
    #lil bots too
    if $game_variables[@prog][17] == 13      
	     n += "H20"     
	  elsif $game_variables[@prog][17] == 15      
	     n += "C20"   
    end
 end 
   expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0) 
   if tas[bot] == "Gattai"
   $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
   end
	   if inMenu == 0       
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
	  # VOICE SCRIPT #
   	unless $game_switches[4600] == true || $game_variables[7330] == 2
       voiceAc += (rand(4)+1).to_s
	     RPG::SE.new(voiceAc, voiceV, voiceP).play
   	end  
	  # VOICE SCRIPT #          
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end  
  #####################
  #### VENDRA ####
  #####################    
  if $game_variables[@prog][0] == "lovesnek"
	   xp = 0
	   yp = 0
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 340    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end     
	 n = "Vendra"   
   expE = "VendraExp"
   acc = ""
    #voice Base
    voiceAc = "VoiceKob"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end     
    voiceV = 100
    voiceP = 100    
    #voice Base - End   
   cost = ""
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N" 
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
     acc = "VendraAccs"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
     acc = "VendraAccb"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
    voiceV -= 10
    voiceP -= 15    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
    voiceV += 15
    voiceP += 20        
 	 elsif $game_variables[2051] == 3
    expS = "Love"
    voiceV += 10
    voiceP -= 10         
 	 elsif $game_variables[2051] == 4
    expS = "Heat"
    voiceV -= 10
    voiceP -= 15            
  end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
   $game_map.screen.pictures[114].show(acc, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #       
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end         
  #####################
  #### TSUKICHI ####
  #####################    
  if $game_variables[@prog][0] == "lilbug"
	   xp = 0
	   yp = 120
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 340    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end   
		if $game_switches[3451] == true  #level up with brooch on
     if $game_actors[1].equips.include?$data_armors[832]
       n = "Tsukichibrb"   
       $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
       return
     end  
		end    
	 n = "Tsukichi"   
   expE = "TsukichiExp"
    #voice Base
    voiceAc = "VoiceIns"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end     
    voiceV = 100
    voiceP = 100    
    #voice Base - End   
   cost = ""
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N" 
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
     cost = "TsukichiBattlesuit"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
    voiceV -= 10
    voiceP -= 15    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
    voiceV += 15
    voiceP += 20        
 	 elsif $game_variables[2051] == 3
    expS = "Love"
    voiceV += 10
    voiceP -= 10         
 	 elsif $game_variables[2051] == 4
    expS = "Sad2"
    voiceV -= 10
    voiceP -= 15 
	 elsif $game_variables[2051] == 5
    expS = "Love2"
    voiceV += 15
    voiceP += 20            
  end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
   $game_map.screen.pictures[114].show(cost, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #       
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end        
  #####################
  #### OSCAR ####
  #####################    
  if $game_variables[@prog][0] == "keteer"
	   xp = -10
	   yp = 30
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 340    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end   
	 n = "Oscar"   
   expE = "OscarExp"
    #voice Base
    voiceAc = "VoiceMou"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end     
    voiceV = 100
    voiceP = 100    
    #voice Base - End   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N" 
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
    voiceV -= 10
    voiceP -= 15    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
    voiceV += 15
    voiceP += 20        
 	 elsif $game_variables[2051] == 3
    expS = "Love"
    voiceV += 10
    voiceP -= 10         
 	 elsif $game_variables[2051] == 4
    expS = "Scared"
    voiceV += 10
    voiceP -= 10 
  end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #       
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end       
  #####################
  #### BABY ORCA ####
  #####################    
  if $game_variables[@prog][0] == "orca"
	   xp = -140
	   yp = 10
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 60
		  py = 60
		  xp = 365
		  yp = 340    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 40
		  py = 40
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 40
		  py = 40
		end   
	 n = "Orca"   
   expE = "OrcaExp"
    #voice Base
    voiceAc = "VoiceMer"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end     
    voiceV = 100
    voiceP = 100    
    #voice Base - End   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N" 
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
    voiceV -= 10
    voiceP -= 15    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
    voiceV += 15
    voiceP += 20        
 	 elsif $game_variables[2051] == 3
    expS = "Love"
    voiceV += 10
    voiceP -= 10         
 	 elsif $game_variables[2051] == 4
    expS = "Lust"
    voiceV += 10
    voiceP -= 10 
 	 elsif $game_variables[2051] == 5
    expS = "Roar"
    voiceV += 20
    voiceP += 15 
  end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #       
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end      
  #####################
  #### IMPS 31 ####
  #####################    
  if $game_variables[@prog][0] == "imps31"
	   xp = -30
	   yp = -10
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 350    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 262
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 330
		  px = 50
		  py = 50
		end   
	 n = "Imps31"   
   expE = "Imps31Exp"
    #voice Base
    voiceAc = "VoiceSha"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end     
    voiceV = 100
    voiceP = 100    
    #voice Base - End   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N" 
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
    voiceV -= 10
    voiceP -= 15    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
    voiceV += 15
    voiceP += 20        
 	 elsif $game_variables[2051] == 3
    expS = "Love"
    voiceV += 10
    voiceP -= 10         
 	 elsif $game_variables[2051] == 4
    expS = "Tch"
    voiceV += 10
    voiceP -= 10 
 	 elsif $game_variables[2051] == 5
    expS = "Love2"
    voiceV += 20
    voiceP += 15 
  end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #       
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end       
  #####################
  #### DEE KNIGHT ####
  #####################    
  if $game_variables[@prog][0] == "femk"
	   xp = -140
	   yp = 10
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 320    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end   
	 n = "FemK"   
   expE = "FemKExp"
    #voice Base
    voiceAc = "VoiceDee"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end     
    voiceV = 100
    voiceP = 100    
    #voice Base - End   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N" 
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
    voiceV -= 10
    voiceP -= 15    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
    voiceV += 15
    voiceP += 20        
 	 elsif $game_variables[2051] == 3
    expS = "Love"
    voiceV += 10
    voiceP -= 10         
	 elsif $game_variables[2051] == 4
    expS = ""
  end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
	   # VOICE SCRIPT #
	   voiceAc += (rand(4)+1).to_s
    	unless $game_switches[4600] == true
	      RPG::SE.new(voiceAc, voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #       
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end     
  #####################
  ####### ANUBIS #######
  #####################    
  if $game_variables[@prog][0] == "anubis"
	   xp = -15
	   yp = -40
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 320    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end   
	 n = "AnubisP"   
   expE = "AnubisPExp"
    #voice Base
    voiceAc = "VoiceDog"
    voiceV = 90
    voiceP = 100    
    #voice Base - End   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N" 
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
 	 elsif $game_variables[2051] == 3
    expS = "Love"
	 elsif $game_variables[2051] == 4
    expS = "Awoo"
   end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end    
  #####################
  ####### SHROOM #######
  #####################    
  if $game_variables[@prog][0] == "shroom"
	   xp = 20
	   yp = -10
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 320    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end   
	 n = "ShroomP"   
   expE = "ShroomPExp"
	 if nkdCheat == 1
	   n += ""   
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
 	 elsif $game_variables[2051] == 3
    expS = "Love"
	 elsif $game_variables[2051] == 4
    expS = "Uncertain"
   end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end       
  #########################
  ####### Broodmother #######
  #########################
  if $game_variables[@prog][0] == "mama"
	   xp = -75
	   yp = -70
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 320    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end   
	 n = "Broodmother"   
   expE = "BroodmotherExp"
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"       
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"     
     expE += "C20"
     yp -= 0.5*px 
	 end  
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
 	 elsif $game_variables[2051] == 3
    expS = "Love"
	 elsif $game_variables[2051] == 4
    expS = "Fluster"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end       
  #####################
  ####### PRINCESS #######
  #####################    
  if $game_variables[@prog][0] == "nightmare"
	   xp = -50
	   yp = -80
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 320    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 50
		  py = 50
		end   
	 n = "MarePrincess"   
   expE = "MarePrincessExp"
   head = "MarePrincessHeadd"
	 if nkdCheat == 1
	   n += ""   
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"    
     head += "H20" 
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"     
     expE += "C20"  
	 end   
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
 	 elsif $game_variables[2051] == 3
    expS = "Love"
	 elsif $game_variables[2051] == 4
    expS = "Pray"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
   $game_map.screen.pictures[114].show(head, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end      
  #####################
  ####### KARIDDI #######
  #####################    
  if $game_variables[@prog][0] == "kraken"
	   xp = -130
	   yp = -35
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true    
		  px = 40
		  py = 40
		  xp = 385
		  yp = 360    
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 40
		  py = 40 
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 40
		  py = 40 
		end   
	 n = "Kariddi"   
   expE = "KariddiExp"
	 if nkdCheat == 1
	   n += ""   
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"    
     expE = "KariddiExpH20"
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"         
	 end    
	 if $game_variables[2051] == 0
    expS = "Std"
	 elsif $game_variables[2051] == 1
	  expS = "Sad"    
	 elsif $game_variables[2051] == 2
    expS = "Rage"
 	 elsif $game_variables[2051] == 3
    expS = "Love"
	 elsif $game_variables[2051] == 4
    expS = "Scared"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end     
  #####################
  ####### HARRIET #######
  #####################    
  if $game_variables[@prog][0] == "jester"
	   xp = -30
	   yp = 5 
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70  
		  xp = 385
		  yp = 350       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 251 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Harriet"   
   expE = "HarrietExp"
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"    
     expE = "HarrietExpH20"     
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"         
	 end   
	 if $game_variables[2051] == 0
     @r = rand(2)
    if @r < 1
       expS = "Std"
    else
       expS = "Std2"
    end  
	 elsif $game_variables[2051] == 1
	 expS = "Shock"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Smug"
	 elsif $game_variables[2051] == 4
	 expS = "Glad"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end    
  #####################
  ####### BOREA #######
  #####################    
  if $game_variables[@prog][0] == "yukionna"
	   xp = 0
	   yp = 0   
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70  
		  xp = 385
		  yp = 350       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 251 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Borea"   
   expE = "BoreaExp"
   head = "BoreaHeadd"
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
     expE = ""
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"  
     head += "H20"
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"         
	 end  
	 if $game_variables[2051] == 0
     @r = rand(2)
    if @r < 1
       expS = "Std"
    else
       expS = "Std2"
    end  
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Weird"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
    $game_map.screen.pictures[114].show(head, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end    
  #####################
  ##### PRUSZKA ######
  #####################    
  if $game_variables[@prog][0] == "zmeu"
     if $game_switches[497] == true
	   xp = -115
	   yp = -60
   else
	   xp = -90
	   yp = 10     
     end
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 60
		  py = 60  
		  xp = 385
		  yp = 350       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 251 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 60
		  py = 60   
		end        
	 n = "Pruszka"   
   expE = "PruszkaExp"
   if $game_switches[497] == true
	    n += "Dra"
      expE += "Dra"
   end
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13     
	   n += "H20" 
     expE += "H20"
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"         
	 end  
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Evil"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end    
  #####################
  ##### CAROLINA ######
  #####################    
  if $game_variables[@prog][0] == "ox"
	   xp = 10
	   yp = -35
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 60
		  py = 60     
		  xp = 385
		  yp = 350       
		end     
		if $game_switches[579] == true
		  px = 40
		  py = 40
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 251 #port center without ADV menu check
		  yp = 245
		  px = 40
		  py = 40   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 60
		  py = 60   
		end        
	 n = "OxP"   
   helm = ""
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
     helm = "OxPHelm"  
	 elsif $game_variables[@prog][17] == 13     
	   n += "H20"     
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"         
	 end  
	 expE = "OxPExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
   helm += "Rage"   
	 elsif $game_variables[2051] == 3
	 expS = "Love"
   helm += "Love"   
	 elsif $game_variables[2051] == 4
	 expS = "Star"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0) 
   $game_map.screen.pictures[114].show(helm, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
       if $game_variables[2051] == 3 || $game_variables[2051] == 2 #RAGE/LOVE SE
       RPG::SE.new("Sand", 80, 150).play  
       end
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end   
  #####################
  ##### VICTORIA ######
  #####################    
  if $game_variables[@prog][0] == "goat"
	   xp = -10
	   yp = 100
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Victoria"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"         
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"         
	 end  
	 expE = "VictoriaExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Bleat"
	 elsif $game_variables[2051] == 5
	 expS = "GOAT"
	 end
	 expE += expS
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end  
  #####################
  ###### CANDY #######
  #####################    
  if $game_variables[@prog][0] == "candy"
	   xp = 0
	   yp = 135
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "CandyP"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"     
	 elsif $game_variables[@prog][17] == 15      
	   n += "C20"     
	 end  
	 expE = "CandyPExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Smirk"
	 end
	 if $game_variables[@prog][30] == 124
	   wep = "CandyPWepZooka"
   else
     wep = "CandyPWepCane"
	 end  
	 expE += expS
   $game_map.screen.pictures[111].show(wep, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end 
  #####################
  ###### SPRITZ #######
  #####################    
  if $game_variables[@prog][0] == "sprite"
	   xp = 10
	   yp = 170
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 base = "SpritzBod"   
	 expE = "SpritzExp"   
	 bod = ""
	 n = ""
	 if $game_variables[@prog][17] == 3
	   bod = "Maid"
	 elsif $game_variables[@prog][17] == 4
	   bod = "SS"
	 elsif $game_variables[@prog][17] == 6       
	   bod = "Battle"
	 elsif $game_variables[@prog][17] == 13      
	   bod = "H20"
	 elsif $game_variables[@prog][17] == 15
	   bod = "C20"    
     expE += "C20" 
	 end     
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Vision"
	 end
	 if bod == ""
	   base += expS
	 end  
   if $game_variables[@prog][17] == 13      
	   expS = ""
	 end    
	 expE += expS
	 n = base + bod
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end            
  #####################
  ###### VASHTI #######
  #####################    
  if $game_variables[@prog][0] == "scorpio"
	   xp = -100
	   yp = -40
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Vashti"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"       
	 end   
	 expE = "VashtiExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Deject"
	 end
	 if $game_variables[@prog][17] != 2 && $game_variables[@prog][17] != 3 && $game_variables[@prog][17] != 4 && $game_variables[@prog][17] != 13
	   expS += "Cover"
	 end  
   if $game_variables[@prog][17] == 13  
     expS = ""
   end  
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end                
  #####################
  ##### MARIE ######
  #####################    
  if $game_variables[@prog][0] == "futadog"
		xp = -15
		yp = 90
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Marie"   
	 show = 1
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	   show = 0
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	   show = 0
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	   show = 0
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
	   show = 0
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"  
     show = 0
	 end   
	 expE = "MarieExp"
	 expS = "Std"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Smile"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Lust"
	 if show == 1
	  expS = "LustN"
	 end  
   end     
   if $game_variables[@prog][17] == 13      
	   expS = ""
	 end   
	  $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)             
	 expE += expS
	  $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)
	 if $game_variables[@prog][56] == 2 && $game_variables[@prog][17] != 15
	  $game_map.screen.pictures[113].show("MarieNunHood", pos, xp, yp, px, py, 255, 0)
	 end       
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end              
  #####################
  ##### WUCHAN ######
  #####################    
  if $game_variables[@prog][0] == "monkey"
		xp = -25
		yp = 55
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Wuchan"
   head = ""
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
     head = "WuchanHeadH20"
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"         
	 end   
	 expE = "WuchanExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Eek"
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
   $game_map.screen.pictures[113].show(head, pos, xp, yp, px, py, 255, 0) 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end             
  #####################
  ##### SALIZZIE ######
  #####################    
  if $game_variables[@prog][0] == "sala"
		xp = -165
		yp = -55
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Salizzie"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"         
	 end   
	 expE = "SalizzieExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Ditto"
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end              
  #####################
  ##### GAITA ######
  #####################    
  if $game_variables[@prog][0] == "dullanyan"
		xp = 25
		yp = 50
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Gaita"   
   expE = "GaitaExp"
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"     
     expE += "C20"  
	 end    
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end           
  #####################
  ##### BLOO ######
  #####################    
  if $game_variables[@prog][0] == "squid"
		xp = 10
		yp = 115
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Bloo"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"         
	 end   
	 expE = "BlooExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Det"
	 elsif $game_variables[2051] == 5
	 expS = "Squid"
 end
   if $game_variables[@prog][17] == 13      
	   expS = ""
	 end     
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end        
  #####################
  ##### YAKO ######
  #####################    
  if $game_variables[@prog][0] == "kitsune"
		xp = 0
		yp = 10
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 365
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Yako"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"         
	 end   
	 expE = "YakoExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Mask"
   end
   if $game_variables[@prog][17] == 13      
	   expS = ""
	 end    
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end      
  #####################
  ##### IDOL ######
  #####################    
  if $game_variables[@prog][0] == "idol"
		xp = -25
		yp = 25
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 385
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 241 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "Fina"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	 elsif $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"         
	 end 
	 if $game_map.map_id == 170
	   n = "Finah"
	   gla = "FinaGlasses"
	   $game_map.screen.pictures[113].show(gla, pos, xp, yp, px, py, 255, 0)
	 end  
	 expE = "FinaExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Sing"
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)   
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end    
  #####################
  ##### 404B ######
  #####################    
  if $game_variables[@prog][0] == "dummy"
		xp = -60
		yp = 0
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 385
		  yp = 345       
		end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 253 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end        
	 n = "404B"   
	 if $game_variables[@prog][17] == 3
	   n += "m"
	 elsif $game_variables[@prog][17] == 4
	   n += "s"
	 elsif $game_variables[@prog][17] == 6       
	   n += "b"
	 elsif $game_variables[@prog][17] == 13      
	   n += "H20"           
     if pos == 0
		  xp = 10
		  yp = 290
    end  
	 elsif $game_variables[@prog][17] == 15
	   n += "C20"        
	 end       
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end  
  #####################
  ##### SPIKA ######
  #####################    
  if $game_variables[@prog][0] == "spika"
		xp = 0
		yp = 0  
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 230
		  yp = 70
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345  
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end           
    #voice Base
    voiceAc = "Sha"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end      
   voiceV = 90
   voiceP = 100  
	 n = "SpikaP"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   n += "N"
	 end
	 expE = "SpikaPExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
      voiceV -= 10
      voiceP -= 15   
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
      voiceV += 15
      voiceP += 20     
	 elsif $game_variables[2051] == 3
	 expS = "Love"
      voiceV += 10
      voiceP -= 10     
	 elsif $game_variables[2051] == 4
	 expS = "Shock"
      voiceV += 10
      voiceP -= 10    
	 elsif $game_variables[2051] == 5
	 expS = "Sad2"    
      voiceV -= 10
      voiceP -= 15         
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)
 	if inMenu == 0
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
    unless $game_switches[4600] == true
     RPG::SE.new(voiceAc, voiceV, voiceP).play
    end  
   # VOICE SCRIPT #  
     if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
     end
	  end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end     
  #####################
  ##### CHAIN ######
  #####################    
  if $game_variables[@prog][0] == "chain"
		xp = -20
		yp = 0  
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 230
		  yp = 70
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345  
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end           
    #voice Base
    voiceAc = "Chain"
    if $game_variables[7330] == 2
      voiceAc += "susp"
    end      
   voiceV = 90
   voiceP = 100  
	 n = "ChainP"   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   n += "N"
	 end
	 expE = "ChainPExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
      voiceV -= 10
      voiceP -= 15   
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
      voiceV += 15
      voiceP += 20     
	 elsif $game_variables[2051] == 3
	 expS = "Love"
      voiceV += 10
      voiceP -= 10     
	 elsif $game_variables[2051] == 4
	 expS = "Mock"
      voiceV += 10
      voiceP -= 10    
	 elsif $game_variables[2051] == 5
	 expS = "Gasp"    
      voiceV -= 10
      voiceP -= 15         
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)
 	if inMenu == 0
	   # VOICE SCRIPT #
    	unless $game_switches[4600] == true
	      RPG::SE.new("Chain", voiceV, voiceP).play
    	end  
	   # VOICE SCRIPT #
     if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
     end
	  end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
 end    
  #####################
  ##### EDLRITCH ######
  #####################    
  if $game_variables[@prog][0] == "eldritch"
		xp = -20
		yp = 5  
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 230
		  yp = 70
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345  
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end           
	 n = "EldritchP"  
	 expE = "EldritchExp"   
	 yexp = yp
	if $game_variables[@prog][17] == 13  
	   n = "EldritchPH20"
	   if pos == 1
	   yp -= 0.5 * px
	 else
	   yp -= 1 * px
	   end
	   #yexp = yp + (1*px)
	elsif $game_variables[@prog][17] == 4    
	   n += "s"
	elsif $game_variables[@prog][17] == 9    
	   n += "H20B"    
     expE += "susp"
	elsif $game_variables[@prog][17] == 15    
	   n += "C20"
	elsif $game_variables[@prog][17] == 16    
	   n += "F20"   
     expE += "susp"
	elsif $game_variables[@prog][17] == 22    
	   n += "Bar"
	elsif $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   n += "N"
	 end
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Grin"
	 end
	 expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yexp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end  
  #####################
  ####### MOSS #######
  ##################### 
  if $game_variables[@prog][0] == "moss"
		xp = 50
		yp = 110 
   if $game_variables[2051] >= 10
    xp = 50
		yp = 350  
   end         
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 230
		  yp = 70
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 15
		  yp += 25        
  end             
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end         
	 n = "MossP"   
	 if $game_variables[2051] >= 10
	 n += "Lump"   
   end
	if $game_variables[@prog][17] == 13 && $game_variables[2051] < 10
	   n = "MossPH20"
   else     
   ### LUMP FORM ###  
   if $game_variables[2051] >= 10
	   $game_variables[2051] -= 10
   end     
   ### LUMP FORM ###
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Silent"
	 elsif $game_variables[2051] == 3
	 expS = "Embarass"
	 elsif $game_variables[2051] == 4
	 expS = "Asleep"
   end 
   n += expS
   end
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end       
  #####################
  ###### DOKURO ######
  ##################### 
  if $game_variables[@prog][0] == "dokuro"
		xp = 40
		yp = 145  
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 180
		  yp = 0
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 15
		  yp += 25        
  end             
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end            
	 if $game_switches[3416] == true || $game_switches[2359] == true || $game_switches[2411] == true || $game_switches[2466] == true || $game_switches[579] == true || $game_switches[3451] == true   
	 if $game_variables[@prog][17] == 2 || nkdCheat == 1    
	   $game_map.screen.pictures[111].show("DokuroN", pos, xp, yp, px, py, 255, 0)
	   else
	   $game_map.screen.pictures[111].show("Dokuro", pos, xp, yp, px, py, 255, 0)
	 end
   else
		xp = 0
		yp = 0  
	  if $game_variables[2051] == 0    
		if $game_variables[@prog][17] == 2 || nkdCheat == 1
		   $game_map.screen.pictures[111].show("Dokuro dial naked", pos, xp, yp, px, py, 255, 0)
		  else        
		   $game_map.screen.pictures[111].show("Dokuro dial", pos, xp, yp, px, py, 255, 0)
		end
		end
	  if $game_variables[2051] == 1   
		if $game_variables[@prog][17] == 2 || nkdCheat == 1
		   $game_map.screen.pictures[111].show("Dokuro dial naked sad", pos, xp, yp, px, py, 255, 0)
		  else        
		   $game_map.screen.pictures[111].show("Dokuro dial sad", pos, xp, yp, px, py, 255, 0)
		end
		end
	  if $game_variables[2051] == 2   
		if $game_variables[@prog][17] == 2 || nkdCheat == 1
		   $game_map.screen.pictures[111].show("Dokuro dial naked rage", pos, xp, yp, px, py, 255, 0)
		  else        
		   $game_map.screen.pictures[111].show("Dokuro dial rage", pos, xp, yp, px, py, 255, 0)
		end
		end
	  if $game_variables[2051] == 3    
		if $game_variables[@prog][17] == 2 || nkdCheat == 1
		   $game_map.screen.pictures[111].show("Dokuro dial naked sad", pos, xp, yp, px, py, 255, 0)
		  else        
		   $game_map.screen.pictures[111].show("Dokuro dial sad", pos, xp, yp, px, py, 255, 0)
		end
		end
	  if $game_variables[2051] == 4      
		if $game_variables[@prog][17] == 2 || nkdCheat == 1
		   $game_map.screen.pictures[111].show("Dokuro dial naked sad", pos, xp, yp, px, py, 255, 0)
		  else        
		   $game_map.screen.pictures[111].show("Dokuro dial sad", pos, xp, yp, px, py, 255, 0)
		end
		end
	  end
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end        
	  return
	end 
  #####################
  ##### CRYSTAL ######
  #####################    
  if $game_variables[@prog][0] == "crystal"
		xp = -80
		yp = -100
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 230
		  yp = 70
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 390
		  yp = 300
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end           
	 n = "CrystalP"   
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	   n += "N"
	elsif $game_variables[@prog][17] == 13    
	   n += "H20"
	elsif $game_variables[@prog][17] == 15     
	   n += "C20"      
	elsif $game_variables[@prog][17] == 16     
	   n += "F20"
	 end
	 exp = "CrystalPExp"
	 if $game_variables[2051] == 0
	 expS = "Std"
	 elsif $game_variables[2051] == 1
	 expS = "Sad"    
	 elsif $game_variables[2051] == 2
	 expS = "Rage"
	 elsif $game_variables[2051] == 3
	 expS = "Love"
	 elsif $game_variables[2051] == 4
	 expS = "Sleep"
	 end
	 exp += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end       
	 return
   end  
  #####################
  ##### CRUSADER ######
  #####################  
  if $game_variables[@prog][0] == "crusader"
		xp = 50
		yp = 80
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 300
		  yp = 50
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 15
		  yp += 25        
  end             
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 130
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
		expE = "CrusExp"
		ybod = yp
		if $game_variables[@prog][17] == 18     
		   n = "CrusaderPX1"
		   expE += "X1"
		elsif $game_variables[@prog][17] == 21   
		   n = "CrusaderPX4"           
		elsif $game_variables[@prog][17] == 13     
		   n = "CrusaderPH20"   
		if pos == 1
		  ybod -= (0.4 * px)
		else
		  ybod -= (0.8 * px)
		end  
		elsif $game_variables[@prog][17] == 2 || nkdCheat == 1    
		   n = "CrusaderPN"
		else
		   n = "CrusaderP"
	 end    
	 if $game_variables[@prog][17] == 18  
	   if $game_variables[2051] == 0 || $game_variables[2051] == 1
		expS = "Std" 
	  elsif $game_variables[2051] == 2 || $game_variables[2051] == 4
		expS = "Rage"      
	  elsif $game_variables[2051] == 3 || $game_variables[2051] == 5
		expS = "Love"
	  end  
	   else
	  if $game_variables[2051] == 0 
		expS = "Std"
	  elsif $game_variables[2051] == 1
		expS = "Sad"
	  elsif $game_variables[2051] == 2
		expS = "Rage"      
	  elsif $game_variables[2051] == 3
		expS = "Love"
	  elsif $game_variables[2051] == 4
		expS = "Ecstasy"
	  elsif $game_variables[2051] == 5
		expS = "Shock"      
	  end  
	  end
	  expE += expS
	 $game_map.screen.pictures[111].show(n, pos, xp, ybod, px, py, 255, 0)
	 $game_map.screen.pictures[112].show(expE, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end         
	   return  
	 end  
  #########################################     
  ######    STRING FIX      ######    
	#########################################  
  @baby = $game_variables[@prog]
  @raceStr = @baby[0]
  @acRace = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,30,31]
  if @acRace.include? @raceStr
	@maxIn = 7749 + @raceStr
  if $game_variables[@maxIn] != 0
	@maxStr = $game_variables[@maxIn]
	@strL = @maxStr.length
	@strCh = 3 #skips CE#,race,gender
  while @strCh < @strL    
  if @maxStr != 0 && @baby[@strCh] > @maxStr[@strCh]
	@ce = @maxStr[0]    
	$game_variables[7749] = @prog
	$game_switches[3755] = true
	if @ce != 0
	  $game_temp.reserve_common_event(@ce)
	end
  $game_switches[3755] = false
  end  
  @strCh += 1
  end 
  end
  end
  #########################################  
  ######    STRING FIX      ###### 
  #########################################  
  if $game_variables[@prog][0] == 99
	if $game_switches[3529] == true
		  xp = 223 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		  else
		  xp = 240
		  yp = -20 
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 240
		  yp = 10
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
		end
	  end
  @eggR = $game_variables[@prog][20]   
  @eggS = [1,5,10,16,17,18,19,21,22]
  @noEggS = [2,3,4,6,7,8,9,11,12,13,14,15,20,23]
  if @eggR == 24
  $game_map.screen.pictures[111].show("EggCry", pos, xp, yp, px, py, 255, 0) 
  elsif @noEggS.include? @eggR
  $game_map.screen.pictures[111].show("CatEgg", pos, xp, yp, px, py, 255, 0) 
  elsif @eggR == 1
	if $game_variables[@prog][4] == 0 #GREEN KOBOLD
	 $game_map.screen.pictures[111].show("EggKobG", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 1 #BLUE KOBOLD
	 $game_map.screen.pictures[111].show("EggKobB", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 2 #RED KOBOLD
	 $game_map.screen.pictures[111].show("EggKobR", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 3 #YELLOW KOBOLD
	 $game_map.screen.pictures[111].show("EggKobY", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 4 #PURPLE KOBOLD
	 $game_map.screen.pictures[111].show("EggKobP", pos, xp, yp, px, py, 255, 0) 
   end 
  elsif @eggR == 5
	if $game_variables[@prog][4] == 0 #BEE INSECT
	 $game_map.screen.pictures[111].show("EggInsZ", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 1 #GREEN INSECT
	 $game_map.screen.pictures[111].show("EggInsG", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 2 #PURPLE INSECT
	 $game_map.screen.pictures[111].show("EggInsP", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 3 #RED INSECT
	 $game_map.screen.pictures[111].show("EggInsR", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 4 #BLACK INSECT
	 $game_map.screen.pictures[111].show("EggInsB", pos, xp, yp, px, py, 255, 0) 
   end 
  elsif @eggR == 10
	if $game_variables[@prog][5] == 0 #PINK FUR MOTH
	 $game_map.screen.pictures[111].show("EggMotP", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 1 #YELLOW FUR MOTH
	 $game_map.screen.pictures[111].show("EggMotY", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 2 #WHITE FUR MOTH
	 $game_map.screen.pictures[111].show("EggMotW", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 3 #BLACK FUR MOTH
	 $game_map.screen.pictures[111].show("EggMotB", pos, xp, yp, px, py, 255, 0) 
   end 
  elsif @eggR == 16
	if $game_variables[@prog][4] == 0 #YELLOW DRAGON
	 $game_map.screen.pictures[111].show("EggDraY", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 1 #RED DRAGON
	 $game_map.screen.pictures[111].show("EggDraR", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 2 #BLUE DRAGON
	 $game_map.screen.pictures[111].show("EggDraB", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 3 #GREEN DRAGON
	 $game_map.screen.pictures[111].show("EggDraG", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 4 #BLACK DRAGON
	 $game_map.screen.pictures[111].show("EggDraK", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 5 #WHITE DRAGON
	 $game_map.screen.pictures[111].show("EggDraW", pos, xp, yp, px, py, 255, 0) 
   end   
  elsif @eggR == 17
	if $game_variables[@prog][5] == 0 #BLUE FINS FINHEAD
	 $game_map.screen.pictures[111].show("EggFinB", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 1 #RED FINS FINHEAD
	 $game_map.screen.pictures[111].show("EggFinR", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 2 #GREEN FINS FINHEAD
	 $game_map.screen.pictures[111].show("EggFinG", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 3 #WHITE FINS FINHEAD
	 $game_map.screen.pictures[111].show("EggFinW", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 4 #YELLOW FINS FINHEAD
	 $game_map.screen.pictures[111].show("EggFinY", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 5 #PURPLE FINS FINHEAD
	 $game_map.screen.pictures[111].show("EggFinP", pos, xp, yp, px, py, 255, 0) 
   end   
 elsif @eggR == 18  
  if $game_variables[@prog][5] == 0 #GREY FIN
	$game_map.screen.pictures[111].show("EggMerGy", pos, xp, yp, px, py, 255, 0)  
  elsif $game_variables[@prog][5] == 1 #GREEN FIN
	$game_map.screen.pictures[111].show("EggMerG", pos, xp, yp, px, py, 255, 0)  
  elsif $game_variables[@prog][5] == 2 #BLUE FIN
	$game_map.screen.pictures[111].show("EggMerB", pos, xp, yp, px, py, 255, 0)  
  elsif $game_variables[@prog][5] == 3 #PINK FIN
	$game_map.screen.pictures[111].show("EggMerP", pos, xp, yp, px, py, 255, 0)   
  end 
elsif @eggR == 19  
	if $game_variables[@prog][4] == 0 
	 $game_map.screen.pictures[111].show("EggBirB", pos, xp, yp, px, py, 255, 0)   
   elsif $game_variables[@prog][4] == 1 || $game_variables[@prog][4] == 5 
	 $game_map.screen.pictures[111].show("EggBirBk", pos, xp, yp, px, py, 255, 0)  
  elsif $game_variables[@prog][4] == 2 
	 $game_map.screen.pictures[111].show("EggBirBr", pos, xp, yp, px, py, 255, 0)  
  elsif $game_variables[@prog][4] == 3 
	 $game_map.screen.pictures[111].show("EggBirP", pos, xp, yp, px, py, 255, 0)  
  elsif $game_variables[@prog][4] == 4 
	 $game_map.screen.pictures[111].show("EggBirR", pos, xp, yp, px, py, 255, 0)  
  elsif $game_variables[@prog][4] == 6
	 $game_map.screen.pictures[111].show("EggBirY", pos, xp, yp, px, py, 255, 0)    
 end     
  @ski = $game_variables[@prog][60] rescue ""
  if @ski == "Immortal" 
 	 $game_map.screen.pictures[111].show("EggAsha", pos, xp, yp, px, py, 255, 0)    
  end        
  elsif @eggR == 21
	if $game_variables[@prog][4] == 0 #PURPLE DRIDER
	 $game_map.screen.pictures[111].show("EggDriP", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 1 #VIOLET DRIDER
	 $game_map.screen.pictures[111].show("EggDriV", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 2 #WHITE DRIDER
	 $game_map.screen.pictures[111].show("EggDriW", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 3 #GREEN DRIDER
	 $game_map.screen.pictures[111].show("EggDriG", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][4] == 4 #BLACK DRIDER
	 $game_map.screen.pictures[111].show("EggDriB", pos, xp, yp, px, py, 255, 0) 
   end
 elsif @eggR == 22
	if $game_variables[@prog][5] == 0 #RED LAMIA
	 $game_map.screen.pictures[111].show("EggLamR", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 1 #GREY LAMIA
	 $game_map.screen.pictures[111].show("EggLamGr", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 2 #GREEN LAMIA
	 $game_map.screen.pictures[111].show("EggLamG", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 3 #PURPLE LAMIA
	 $game_map.screen.pictures[111].show("EggLamP", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][5] == 4 #WHITE LAMIA
	 $game_map.screen.pictures[111].show("EggLamW", pos, xp, yp, px, py, 255, 0) 
   end 
  end  
	if inMenu == 0
	  if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   unless $game_switches[4600] == true
     RPG::SE.new("VoiceEgg", 80, 100).play
   end  
   # VOICE SCRIPT #    
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	  end
	end    
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end      
	return
  end
  ########################################
  ############ KOBOLDS ###################
  ########################################
  if $game_variables[@prog][0] == 1
		#FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#
	if $game_variables[4000][0] == 1 
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	   elsif $game_variables[4000][2] == 1 || $game_variables[4000][2] == 6
		  #sad        
		$game_variables[2051] = 1   
	   elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 5
		  #rage        
		$game_variables[2051] = 2   
	   elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	   elsif $game_variables[4000][2] == 4
		  #heat
		$game_variables[2051] = 4    
	  end  
	end    
		xp = 30
		yp = 136  
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 230
		  yp = 70
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 15
		  yp += 25        
  end             
		end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 100
		  yp = 170
		end
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		 if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end                   
  cost = ""
  bod = ""
  col = ""
  basedre = "KobDre"
  base = "KobBod"      
  baseTa = "KobTa"
  tailS = ""
  headS = ""
  hornS = ""
  colHo = ""
  exp = ""
  expE = ""
  expS = ""
  #vvv# SPECIAL NPC #vvv#
  if $game_variables[@prog][20] == "zalfos"
	if inMenu == 0
	  xp = -20
	  yp = 10
	end  
  if $game_switches[2359] == true || $game_switches[2466] == true
	  pos = 1
    xp = 400
	  yp = 250
	end
	n = "Zalfos"
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	  n += "N"
	end  
	if $game_variables[2051] == 0 
    expS = "Std"
	   elsif $game_variables[2051] == 1 
    expS = "Sad"
	   elsif $game_variables[2051] == 2 
    expS = "Rage"
	   elsif $game_variables[2051] == 3 
    expS = "Love"
	   elsif $game_variables[2051] == 4 
    expS = "Heat"
  end   
	exp = "ZalfosExp" + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
if $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= -30
	@c2= 65
	@c3= 45
	@c4= 20  
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end   
  #^^^# SPECIAL NPC #^^^#  
  if $game_variables[@prog][19] == 2
   if inMenu == 0
		xp = -149
		yp = 63
  end    
  bod = "KoboldPbodShade"
  exp = "KoboldPExp"
	if $game_variables[2051] == 0 
    exp += "Std"
	   elsif $game_variables[2051] == 1 
    exp += "Sad"
	   elsif $game_variables[2051] == 2 
    exp += "Rage"
	   elsif $game_variables[2051] == 3 
    exp += "Love"
	   elsif $game_variables[2051] == 4 
    exp += "Heat"
  end  
  $game_map.screen.pictures[111].show(bod, pos, xp, yp, px, py, 255, 0)
  $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)
  if inMenu == 0 
	$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	return 
	end
else  
  # EXPRESSIONS #
     if $game_switches[4001] == true || $game_variables[@prog][17] == 1
       expS = "d"
     end  
	   if $game_variables[2051] == 0
		  expE = "Std"
	   elsif $game_variables[2051] == 1 
		  expE = "Sad"
	   elsif $game_variables[2051] == 2 
		  expE = "Rage"
	   elsif $game_variables[2051] == 3 
		  expE = "Love"
	   elsif $game_variables[2051] == 4 
		  expE = "Heat"
	   elsif $game_variables[2051] == 5
		  expE = "Det"
		end    
    #voice Base    
      voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceP += 5
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20
    expE = "Yan"
   elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
  exp = "KobExp" + expE + expS
  if @ski == "Spooky" 
    exp = "KobExpSpoop"
  end  
  $game_map.screen.pictures[118].show(exp, pos, xp, yp, px, py, 255, 0)
  #^^^ EXPRESSIONS ^^^#
  if @prog == 4061 #knockers
	cost = "x1"
	 x2 = xp
	 y2 = yp
	  if $game_switches[3529] == true || $game_switches[3416] == true # pic center or diary
	   if $game_variables[@prog][3] == 0 #T
	   dy = 0.88 * py
		y2 -= dy      
	   elsif $game_variables[@prog][3] == 1 #C
	   dy = 0.88 * py
		y2 -= dy 
	   elsif $game_variables[@prog][3] == 2 #s
	   dy = 0.9 * py
		y2 -= dy       
	  end 
	else
	   if $game_variables[@prog][3] == 0 #T
	   dx = 0.7 * px
	   dy = 1.8 * py
	   x2 -= dx
		y2 -= dy      
	   elsif $game_variables[@prog][3] == 1 #C
	   dx = 0.7 * px
	   dy = 1.8 * py
	   x2 -= dx
		y2 -= dy 
	   elsif $game_variables[@prog][3] == 2 #s
	   dx = 0.7 * px
	   dy = 1.8 * py
	   x2 -= dx
		y2 -= dy     
	  end        
	end   
	$game_map.screen.pictures[120].show("KobHelmCrest", pos, x2, y2, px, py, 255, 0)
  else 
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
  if $game_switches[4001] == true || $game_variables[@prog][17] == 1
	 cost = "d"
	   dx = 0.20 * px  
	   x2 = xp - dx
	   y2 = yp 
	 $game_map.screen.pictures[120].show("KobCrown", pos, x2, y2, px, py, 255, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3
	 cost = "m"
	 $game_map.screen.pictures[120].show("KobMaidBonnet", pos, xp, yp, px, py, 255, 0) 
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
	 $game_map.screen.pictures[120].show("KobTribalMarks", pos, xp, yp, px, py, 255, 0) 
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 $game_map.screen.pictures[111].show("KobBunEars", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"   
  elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17
	 cost = "x0"   
  elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18
	 cost = "x1"
  elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19
	 cost = "x2"
  elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20
	 cost = "x3"      
  elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21
	 cost = "x4"
	 x2 = xp
	 y2 = yp
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
	   dx = 0
	   dy = 0.18 * py
	 else
	   dx = 1.24 * px
	   dy = 0.37 * py
	 end
	 x2 -= dx
	 y2 -= dy 
	 $game_map.screen.pictures[120].show("KobX4Mask", pos, x2, y2, px, py, 255, 0)
	 $game_map.screen.pictures[111].show("KobX4Maskb", pos, x2, y2, px, py, 255, 0)
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22
	 cost = "x5"      
  elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #zegre
	 cost = "x6" 
	 x2 = xp
	 y2 = yp
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
	   dx = 0
	   dy = 0.18 * py
	 else
	   dx = 1.24 * px
	   dy = 0.37 * py
	 end
	 x2 -= dx
	 y2 -= dy 
	 $game_map.screen.pictures[120].show("KobX6Mask", pos, x2, y2, px, py, 255, 0)   
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13
	 cost = "h20"
	 x2 = xp
	 y2 = yp
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
	   dx = 0
	   dy = 0.18 * py
	 else
	   dx = 1.24 * px
	   dy = 0.37 * py
	 end
	 x2 -= dx
	 y2 -= dy 
	 $game_map.screen.pictures[120].show("KobH20Mask", pos, x2, y2, px, py, 255, 0)    
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15
	 cost = "c20"
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16
	 cost = "f20"
	 x2 = xp
	 y2 = yp
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
	   dx = 0
	   dy = 0.18 * py
	 else
	   dx = 1.24 * px
	   dy = 0.37 * py
	 end
	 x2 -= dx
	 y2 -= dy 
	 $game_map.screen.pictures[120].show("KobF20Mask", pos, x2, y2, px, py, 255, 0)   
   end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
  end
  end
  if $game_variables[@prog][1] == 1
	cost = ""
  end
   if $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   end  
  end
	if $game_variables[@prog][3] == 0
		  bod = "TF"        
  elsif $game_variables[@prog][3] == 1
		  bod = "CF"
  elsif $game_variables[@prog][3] == 2
		  bod = "SF"
  elsif $game_variables[@prog][3] == 3
		  bod = "TM"
  elsif $game_variables[@prog][3] == 4
		  bod = "SM"
	end
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
		 bod = "Chu"
	end 
  ### COLOR       
	   if $game_variables[@prog][4] == 0
		  col = "G"
		  colHo = "GB"
		elsif $game_variables[@prog][4] == 1
		  col = "B"
		  colHo = "GB"
		elsif $game_variables[@prog][4] == 2
		  col = "R"
		  colHo = "R"
		elsif $game_variables[@prog][4] == 3  
		  col = "Y"
		  colHo = "R"
		elsif $game_variables[@prog][4] == 4  
		  col = "P"
		  colHo = "P"        
		end
  ### TAIL      
		 if $game_variables[@prog][6] == 0
		  tailS = "S"
		elsif $game_variables[@prog][6] == 1
		  tailS = "L"
		elsif $game_variables[@prog][6] == 2
		  tailS = "F"
		elsif $game_variables[@prog][6] == 3
		  tailS = "A"
		end          
  tail = "KobTa" + tailS + col
  $game_map.screen.pictures[112].show(tail, pos, xp, yp, px, py, 255, 0)
  ### HEAD 
		  if $game_variables[@prog][7] == 0
		  headS = "Std"
		elsif $game_variables[@prog][7] == 1
		  headS= "Long"
		  elsif $game_variables[@prog][7] == 2
		  headS = "Fri"
		  elsif $game_variables[@prog][7] == 3
		  headS = "Cha"
		  elsif $game_variables[@prog][7] == 4
		  headS = "Arm"
		  end
  head = "KobH" + headS + col
  $game_map.screen.pictures[116].show(head, pos, xp, yp, px, py, 255, 0)   
  ### WINGS 
	 if $game_variables[@prog][11] == 1
	   wings = "KobW" + col
		  $game_map.screen.pictures[113].show(wings, pos, xp, yp, px, py, 255, 0)
	  end   
  ### HORNS      
		if $game_variables[@prog][5] == 0
		  hornS = "Lit"
		  elsif $game_variables[@prog][5] == 1
		  hornS = "Chip"
		  elsif $game_variables[@prog][5] == 3
		  hornS = "Big"
		  if $game_variables[@prog][4] <= 1 #blue/green kobold
		  $game_map.screen.pictures[115].show("KobHOBackGB", pos, xp, yp, px, py, 255, 0)
		  else
		  $game_map.screen.pictures[115].show("KobHOBackR", pos, xp, yp, px, py, 255, 0)
		  end
		end    
	   if $game_variables[@prog][5] == 2
	   horns = "KobHOGold"  
		 else
	   horns = "KobHO" + hornS + colHo
	 end
	$game_map.screen.pictures[119].show(horns, pos, xp, yp, px, py, 255, 0)
  ## BODY
		body = base + bod + col + cost
   if cost == "b"
	 x2 = xp
	 y2 = yp
	  if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
	   if $game_variables[@prog][3] == 0 #T
	   dy = 0.88 * py
		y2 -= dy      
	   elsif $game_variables[@prog][3] == 1 #C
	   dy = 0.88 * py
		y2 -= dy 
	   elsif $game_variables[@prog][3] == 2 #s
	   dy = 0.9 * py
		y2 -= dy       
	  end 
	else
	   if $game_variables[@prog][3] == 0 #T
	   dx = 0.7 * px
	   dy = 1.8 * py
	   x2 -= dx
		y2 -= dy      
	   elsif $game_variables[@prog][3] == 1 #C
	   dx = 0.7 * px
	   dy = 1.8 * py
	   x2 -= dx
		y2 -= dy 
	   elsif $game_variables[@prog][3] == 2 #s
	   dx = 0.7 * px
	   dy = 1.8 * py
	   x2 -= dx
		y2 -= dy     
	  end        
	end
	 $game_map.screen.pictures[120].show("KobHelmCrest", pos, x2, y2, px, py, 255, 0)  
	$game_map.screen.pictures[114].show(body, pos, x2, y2, px, py, 255, 0)
  else
		dress =  basedre + bod + cost
	 xdre = xp
	 ydre = yp
	 ### h20 Costume
	 if cost == "h20"
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
	   dx = 0
	   dy = 0.18 * py
	 else
	   dx = 1.24 * px
	   dy = 0.37 * py
	 end
	 xdre -= dx
	 ydre -= dy     
	 end  
	 ### h20 Costume
	  $game_map.screen.pictures[117].show(dress, pos, xdre, ydre, px, py, 255, 0)    
  if cost != ""
	if $game_variables[@prog][1] == 0 && $game_variables[@prog][3] <= 2
	cost = "n"
  else
	cost = ""
	end
  end            
  body = base + bod + col + cost
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	end 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #    			
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	   end        
	 end 
  #### TONES ####   
	#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= -30
	@c2= 65
	@c3= 45
	@c4= 20  
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end
  #--------------------
	if $game_variables[@prog][0] == 2
	#FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#        
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #tied
		$game_variables[2051] = 4    
	  end  
  end             
		  xp = 37
		  yp = 82  
  if $game_variables[@prog][19] == 2
		  xp -= 15
		  yp -= 0  
    end          
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 223
		  yp = 70
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70      
		  xp = 375
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp -= 15
		  yp += 0
  end          
  end
		if $game_switches[579] == true
		  px = 50
		  py = 50            
		  xp = 95
		  yp = 145
		end         
		if $game_switches[3529] == true
		  if $game_switches[3451] == true
		  if $game_variables[@prog][19] == 2
			pos = 1
		  end  
		  end
		  xp = 243 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end
  cost = ""
  bod = ""
  col = ""
  col2 = ""
  hcol = ""
  expic = ""
  expR = ""
  expT = ""
  expE = ""
  basedre = "HumDre"
  base = "HumBod"      
  if $game_variables[@prog][19] == 2
   if inMenu == 0
    pos = 0
		xp = -140
		yp = 16
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("HumanPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Tied"
	 end        
	expr = "HumanPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)    
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
  else      
  #expT  
  if $game_switches[4013] == true || $game_variables[@prog][17] == 13 #GreenExp
	expic = 119
  if $game_variables[@prog][13] == 2     
	  expT = "H20Fox"
	else
	  expT = "H20" 
  end 
  else
	expic = 116  
  if $game_variables[@prog][13] == 0     
	  expT = ""  
  elsif $game_variables[@prog][13] == 1    
	  expT = "Brow"  
  elsif $game_variables[@prog][13] == 2     
	  expT = "Fox"
	end 
  end
  #expE  
  if $game_variables[2051] == 0 
		  expE = "Std"
  elsif $game_variables[2051] == 1 
		  expE = "Sad"
  elsif $game_variables[2051] == 2 
		  expE = "Angry"
  elsif $game_variables[2051] == 3 
		  expE = "Love"
  elsif $game_variables[2051] == 4 
		  expE = "Tied"
		end              
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
   expR = "HumExp" + expT + expE
  if @ski == "Spooky" 
    expR = "HumExpSpoop"
  end  
   $game_map.screen.pictures[expic].show(expR, pos, xp, yp, px, py, 255, 0)
  #Accessory 
		  if $game_variables[@prog][6] == 2
		  $game_map.screen.pictures[118].show("HumAccGla", pos, xp, yp, px, py, 255, 0)
		  end
		  if $game_variables[@prog][6] == 1
		  $game_map.screen.pictures[118].show("HumAccBGla", pos, xp, yp, px, py, 255, 0)
		  end
		  if $game_variables[@prog][6] == 3
		  $game_map.screen.pictures[118].show("HumAccMon", pos, xp, yp, px, py, 255, 0)
		end    
  #iif $game_variables[@prog][1] == 0
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1
	 cost = "d"
	 $game_map.screen.pictures[111].show("HumCrown", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[120].show("HumMaidBonnet", pos, xp, yp, px, py, 255, 0) 
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4
	 cost = "s"
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"     
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 $game_map.screen.pictures[111].show("HumBunEars", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
  elsif $game_switches[4009] == true || $game_variables[@prog][17] == 9 #nun
	 cost = "c"
	 $game_map.screen.pictures[120].show("HumNunHood", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
  elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #bark
	 cost = "x3"     
	 $game_map.screen.pictures[120].show("HumX3Mask", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22
	 cost = "x5"            
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"       
	 $game_map.screen.pictures[116].show("HumH20Mask", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"   
  if pos == 1 # pic center or diary   
	 xc20 = xp - (0.4 * px)
   else
	 xc20 = xp - (0.4 * px)
  end    
	 $game_map.screen.pictures[120].show("HumC20Mask", pos, xc20, yp, px, py, 255, 0)
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"       
	 $game_map.screen.pictures[120].show("HumF20Mask", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #prcrown 
	 cost = "x1"
	 $game_map.screen.pictures[111].show("HumHX1back", pos, xp, yp, px, py, 255, 0)   
	 $game_map.screen.pictures[120].show("HumHX1front", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 #filia 
	 unless $game_variables[@prog][28] == 1
	 cost = "x2"
	 end
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true   
	 x3p = xp
   else
	 dx = 1 * px 
	 x3p = xp - dx
	 end
	 $game_map.screen.pictures[111].show("HumHX2back", pos, x3p, yp, px, py, 255, 0)
	 if $game_variables[@prog][4] == 0
	 $game_map.screen.pictures[114].show("HumHSX2", pos, x3p, yp, px, py, 255, 0)  
	elsif $game_variables[@prog][4] == 1
	 $game_map.screen.pictures[114].show("HumHPX2", pos, x3p, yp, px, py, 255, 0)
	elsif $game_variables[@prog][4] == 2  
	 $game_map.screen.pictures[114].show("HumHTX2", pos, x3p, yp, px, py, 255, 0)
   end 
  elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21 #kono
   cost = "x4"
	 $game_map.screen.pictures[111].show("HumHX4", pos, x3p, yp, px, py, 255, 0)   
  end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
   end  
  end
  if $game_variables[@prog][1] == 1 && nkdCheat == 0
	  cost = ""
  end  
		if $game_variables[@prog][3] == 0
		  bod = "CF"        
		  elsif $game_variables[@prog][3] == 1
		  bod = "SF"
		  elsif $game_variables[@prog][3] == 2
		  bod = "TF"
		  elsif $game_variables[@prog][3] == 3
		  bod = "SM"
		  elsif $game_variables[@prog][3] == 4
		  bod = "TM"
		end
		if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
		 bod = "Chu"
	   end        
  #HAIR revert      
	if $game_variables[@prog][26] >= 16
	  $game_variables[@prog][26] = 0
	end        
  #HAIR     
   if $game_variables[@prog][26] == 0 #no cust hs     
  if $game_variables[@prog][7] == 0
  hairS = "Cur"
  elsif $game_variables[@prog][7] == 1
  hairS = "Dri"
  elsif $game_variables[@prog][7] == 2
  hairS = "Him"
  elsif $game_variables[@prog][7] == 3
  hairS = "Med"
  elsif $game_variables[@prog][7] == 4
  hairS = "Tom"
  end
  else #cust HS
	if $game_variables[@prog][26] == 1
   hairS = "Pig"   
	 elsif $game_variables[@prog][26] == 2
   hairS = "Bun"   
	 elsif $game_variables[@prog][26] == 3
   hairS = "Bow"  
	 elsif $game_variables[@prog][26] == 4
   hairS = "Ali"  
	 elsif $game_variables[@prog][26] == 5
   hairS = "Flo"  
	 elsif $game_variables[@prog][26] == 6
   hairS = "Spi"  
	 elsif $game_variables[@prog][26] == 7
   hairS = "Sid"  
	 elsif $game_variables[@prog][26] == 8
   hairS = "Lba"  
	 elsif $game_variables[@prog][26] == 9
   hairS = "Eye"  
	 elsif $game_variables[@prog][26] == 10
   hairS = "Bra"  
	 elsif $game_variables[@prog][26] == 11
   hairS = "Cha"  
	 elsif $game_variables[@prog][26] == 12
   hairS = "Vcu"  
	 elsif $game_variables[@prog][26] == 13
   hairS = "Pro"  
	 elsif $game_variables[@prog][26] == 14
   hairS = "Poi"  
	 elsif $game_variables[@prog][26] == 15
   hairS = "Tw2"   
  end     
  end
  if $game_variables[@prog][4] == 0 #STANDARD SKIN HUMAN   
  col = "S"
  col2 = "Std"
  elsif $game_variables[@prog][4] == 1 #PALE SKIN HUMAN   
  col = "P"
  col2 = "Pal"
  elsif $game_variables[@prog][4] == 2 #TAN SKIN HUMAN   
  col = "T"
  col2 = "Tan"
  end   
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col  
	 if $game_variables[@prog][5] == 0  
	  hcol = "W"
	 elsif $game_variables[@prog][5] == 1 
	  hcol = "R"
	 elsif $game_variables[@prog][5] == 2 
	  hcol = "B"
	 elsif $game_variables[@prog][5] == 3 
	  hcol = "Br"
	 elsif $game_variables[@prog][5] == 4 
	  hcol = "Bl"
	 end
	  else
		if $game_variables[@prog][27] == 1
		  hcol = "W"
elsif $game_variables[@prog][27] == 2
		  hcol = "R"
elsif $game_variables[@prog][27] == 3
		  hcol = "B"
elsif $game_variables[@prog][27] == 4
		  hcol = "Br"
elsif $game_variables[@prog][27] == 5
		  hcol = "Bl"
elsif $game_variables[@prog][27] == 6
		  hcol = "Spe"
		end           
	  end           
	  ### ACCESSORY
		  if $game_variables[@prog][11] == 1
		  $game_map.screen.pictures[115].show("HumAccChe", pos, xp, yp, px, py, 255, 0)
		  end
		  if $game_variables[@prog][11] == 2
		  $game_map.screen.pictures[115].show("HumAccFre", pos, xp, yp, px, py, 255, 0)
		  end
		xd = xp
		if $game_variables[@prog][3] == 0 #curvy courtesan / H20
		  if cost == "q" || cost == "c20" || cost == "x4"
			   xd -= 0.48 * px
		  end
		end      
	  dress =  basedre + bod + cost 
	  $game_map.screen.pictures[113].show(dress, pos, xd, yp, px, py, 255, 0)
  if cost != ""
	cost = "n"
  end                
  #BEARD
	  if $game_variables[@prog][12] == 1 && $game_variables[@prog][1] == 0
		beard = "HumBeard" + col
		$game_map.screen.pictures[117].show(beard, pos, xp, yp, px, py, 255, 0)
	  end
  #HAIR    
	hair = "HumH" + hairS + col2 + hcol
	  unless $game_switches[4019] == true || $game_variables[@prog][17] == 19 #filia 
	  $game_map.screen.pictures[114].show(hair, pos, xp, yp, px, py, 255, 0)
	  end
  #BODY    
		body = base + bod + col + cost
	  $game_map.screen.pictures[112].show(body, pos, xp, yp, px, py, 255, 0)
	  end
	   if inMenu == 0
		if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #       
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end      
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= -30
	@c2= 45
	@c3= -30
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
	  end
  #--------------------
	   if $game_variables[@prog][0] == 15
   #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#         
	px = 100
	py = 100       
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #tied
		$game_variables[2051] = 4    
	  end  
  end             
		  xp = 37
		  yp = 82  
  if $game_variables[@prog][19] == 2
		  xp -= 15
		  yp -= 0  
    end          
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 223
		  yp = 70
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70       
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp -= 20
		  yp += 5  
  end          
  end
		if $game_switches[579] == true
		  px = 50
		  py = 50            
		  xp = 95
		  yp = 145
		end      
	if $game_switches[3529] == true
		  if $game_switches[3451] == true
		  if $game_variables[@prog][19] == 2
			pos = 1
		  end  
		  end    
		  xp = 243 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end     
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end                
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -172
		yp = -5
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("HarvestPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Embarass"
	elsif $game_variables[2051] == 5 
	  expS = "Shock"
	 end           
	expr = "HarvestPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0) 
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
		else      
  #####
  #EXP#
  ##### 
  expR = ""
  expT = ""
  expE = ""
  cost = ""
  bod = ""
  col = ""
  col2 = ""
  hcol = ""
  basedre = "HarDre"
  base = "HumBod"
  if $game_variables[@prog][13] == 0     
	  expT = ""  
  elsif $game_variables[@prog][13] == 1    
	  expT = "Brow"  
  elsif $game_variables[@prog][13] == 2     
	  expT = "Fox"
	end 
  #expE  
  if $game_variables[2051] == 0 
		  expE = "Std"
  elsif $game_variables[2051] == 1 
		  expE = "Sad"
  elsif $game_variables[2051] == 2 
		  expE = "Angry"
  elsif $game_variables[2051] == 3 
		  expE = "Love"
  elsif $game_variables[2051] == 4 
		  expE = "Tied"
  end              
   expR = "HumExp" + expT + expE
   if @ski == "Spooky" 
     expR = "HarExpSpoop"  
  end
   $game_map.screen.pictures[116].show(expR, pos, xp, yp, px, py, 255, 0)
  ### ACCESSORIES
	if $game_variables[@prog][6] == 2
		  $game_map.screen.pictures[118].show("HumAccGla", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][6] == 1
		  $game_map.screen.pictures[118].show("HumAccBGla", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][6] == 3
		  $game_map.screen.pictures[118].show("HumAccMon", pos, xp, yp, px, py, 255, 0)
	end    
  #iif @prog == 4015  || $game_variables[@prog][1] == 1  
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1
	 cost = "d"
	 $game_map.screen.pictures[111].show("HumCrown", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 #maid
	 cost = "m" 
	 $game_map.screen.pictures[119].show("HarMaidBonnet", pos, xp, yp, px, py, 255, 0)  
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 #ss
	 cost = "s"  
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 #prison
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 #battle
	 cost = "b"
	 $game_map.screen.pictures[119].show("HarPumpkin", pos, xp, yp, px, py, 255, 0)     
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 #bunny
	 cost = "u"
  if pos == 1 # pic center or diary   
	 yd = 0.4 * py
   else
	 yd = 0.4 * py
  end   
	 ybun = yp - yd
	 $game_map.screen.pictures[119].show("HarBunnyEars", pos, xp, ybun, px, py, 255, 0)  
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #gerudo 
	 cost = "x1"  
	 $game_map.screen.pictures[119].show("HumHmX1", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #bark
	 cost = "x3"     
	 $game_map.screen.pictures[119].show("HumX3Mask", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22
	 cost = "x5"       
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[119].show("HarH20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
  if pos == 1 # pic center or diary   
	 xc20 = xp - (0.6 * px)
	 yc20 = yp - (0.3 * px)
   else
	 xc20 = xp - (0.6 * px)
	 yc20 = yp - (0.3 * px)
  end      
	 $game_map.screen.pictures[119].show("HarC20Mask", pos, xc20, yc20, px, py, 255, 0)
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"       
	 $game_map.screen.pictures[119].show("HarF20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #colosseum
	 cost = "b2"       
	 $game_map.screen.pictures[119].show("Harb2Mask", pos, xp, yp, px, py, 255, 0)
  end  
  if $game_variables[@prog][1] == 0 #else #females
	if $game_variables[@prog][28] == 1 #chub
	  cost = "Chu"
   else
	  cost = ""
    end    
  end 
  end
		if $game_variables[@prog][3] == 0
		  bod = "CF"        
		  elsif $game_variables[@prog][3] == 1
		  bod = "SF"
		  elsif $game_variables[@prog][3] == 2
		  bod = "TF"
		  elsif $game_variables[@prog][3] == 3
		  bod = "SM"
		  elsif $game_variables[@prog][3] == 4
		  bod = "TM"
		end
		if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
		 bod = "Chu"
	   end    
  #HAIR revert      
	if $game_variables[@prog][26] >= 16
	  $game_variables[@prog][26] = 0
	end        
  #HAIR     
  if $game_variables[@prog][26] == 0 #no cust HS     
  if $game_variables[@prog][7] == 0
  hairS = "Cur"
  elsif $game_variables[@prog][7] == 1
  hairS = "Dri"
  elsif $game_variables[@prog][7] == 2
  hairS = "Him"
  elsif $game_variables[@prog][7] == 3
  hairS = "Pon"
  elsif $game_variables[@prog][7] == 4
  hairS = "Twi"
  end
  else #cust HS
	if $game_variables[@prog][26] == 1
   hairS = "Pig"   
	 elsif $game_variables[@prog][26] == 2
   hairS = "Bun"   
	 elsif $game_variables[@prog][26] == 3
   hairS = "Bow"  
	 elsif $game_variables[@prog][26] == 4
   hairS = "Ali"  
	 elsif $game_variables[@prog][26] == 5
   hairS = "Flo"  
	 elsif $game_variables[@prog][26] == 6
   hairS = "Spi"  
	 elsif $game_variables[@prog][26] == 7
   hairS = "Sid"  
	 elsif $game_variables[@prog][26] == 8
   hairS = "Lba"  
	 elsif $game_variables[@prog][26] == 9
   hairS = "Eye"  
	 elsif $game_variables[@prog][26] == 10
   hairS = "Bra"  
	 elsif $game_variables[@prog][26] == 11
   hairS = "Cha"  
	 elsif $game_variables[@prog][26] == 12
   hairS = "Vcu"  
	 elsif $game_variables[@prog][26] == 13
   hairS = "Pro"  
	 elsif $game_variables[@prog][26] == 14
   hairS = "Poi"  
	 elsif $game_variables[@prog][26] == 15
   hairS = "Tw2"   
  end        
  end
  if $game_variables[@prog][4] == 0 #STANDARD SKIN HUMAN   
  col = "S"
  col2 = "Std"
  elsif $game_variables[@prog][4] == 1 #PALE SKIN HUMAN   
  col = "P"
  col2 = "Pal"
  elsif $game_variables[@prog][4] == 2 #TAN SKIN HUMAN   
  col = "T"
  col2 = "Tan"
  end    
 # alt col?
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col    
  if $game_variables[@prog][5] == 0  
  hcol = "W"
  elsif $game_variables[@prog][5] == 1 
  hcol = "R"
  elsif $game_variables[@prog][5] == 2 
  hcol = "B"
  elsif $game_variables[@prog][5] == 3 
  hcol = "Br"
  elsif $game_variables[@prog][5] == 4 
  hcol = "Bl"
  end
	  else
		if $game_variables[@prog][27] == 1
		  hcol = "W"
		elsif $game_variables[@prog][27] == 2
		  hcol = "R"
		elsif $game_variables[@prog][27] == 3
		  hcol = "B"
		elsif $game_variables[@prog][27] == 4
		  hcol = "Br"
		elsif $game_variables[@prog][27] == 5
		  hcol = "Bl"
		elsif $game_variables[@prog][27] == 6
		  hcol = "Spe"
		end           
	  end        
	  ### Accessory
		  if $game_variables[@prog][11] == 1
		  $game_map.screen.pictures[115].show("HumAccChe", pos, xp, yp, px, py, 255, 0)
		  end
		  if $game_variables[@prog][11] == 2
		  $game_map.screen.pictures[115].show("HumAccFre", pos, xp, yp, px, py, 255, 0)
		  end
	  dress =  basedre + bod + cost 
	  $game_map.screen.pictures[113].show(dress, pos, xp, yp, px, py, 255, 0)
  if cost != ""
   if $game_variables[@prog][1] == 0 && @prog == 4015  #cust female harvest
	 cost = ""
	  else
	 cost = "n"
	 end
  end   
  #BEARD
	  if $game_variables[@prog][12] == 1 && $game_variables[@prog][1] == 0
		beard = "HumBeard" + col
		$game_map.screen.pictures[117].show(beard, pos, xp, yp, px, py, 255, 0)
	  end
  #HAIR    
	  if $game_switches[4013] == false && $game_variables[@prog][17] != 13 #hall 2020
		hair = "HumH" + hairS + col2 + hcol
	  $game_map.screen.pictures[114].show(hair, pos, xp, yp, px, py, 255, 0)
	  end
  #BODY    
		body = base + bod + col + cost
	  $game_map.screen.pictures[112].show(body, pos, xp, yp, px, py, 255, 0)
	end
	   if inMenu == 0        
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 55
	@c2= 15
	@c3= 5
	@c4= 10
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES #### 
	 return
	  end
  #--------------------
  if $game_variables[@prog][0] == 3
	#FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  elsif $game_variables[@prog][3] <= 2
	$game_variables[@prog][1] = 0
  end 
  #FIX#      
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #pout
		$game_variables[2051] = 4    
	  end  
	end    
		  xp = -10
		  yp = -29
  if $game_variables[@prog][19] == 2
		  xp -= 0
		  yp += 25  
    end          
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 198
		  yp = -29
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70      
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
  #        xp += 15
		  yp += 5        
  end  
		end       
	   if $game_variables[@prog][6] == 1
		 yp += 15
	   end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 70 
		  yp = 90
		end       
		  if $game_switches[3529] == true 
  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end   
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
   xh = xp
   yh = yp
   xpa = 0
   ypa = 0
   xha = 0
   yha = 0  
  expIgnore = 0 
  if $game_switches[4005] == true || $game_variables[@prog][17] == 5 #prison
    expIgnore = 1
	if pos == 1
	xpa = 0
   ypa = 0.3
   xha = -0.02
   yha = 1.87
	  else
   xpa = 0.05
   ypa = 1.55
   xha = 0.97
   yha = 2.47
	   end   
  end
  if $game_switches[4006] == true || $game_variables[@prog][17] == 6 #war  
    expIgnore = 1
	if pos == 1
   xpa = 0
   ypa = -0.3
   xha = 0
   yha = 1.5
	  else
   xpa = -0.45
   ypa = 0.75
   xha = 0.75
   yha = 2.40
	   end  
	 end    
   if $game_switches[4020] == true || $game_variables[@prog][17] == 20 #shell
     expIgnore = 1
	if pos == 1
   xpa = 0
   ypa = 0
   xha = 1.65
   yha = 1.2
	  else
   xpa = -2.3
   ypa = -0.15
   xha = 1.12
   yha = 1.45
	   end  
   end     
  if $game_variables[@prog][1] == 0 #fem only
  if $game_switches[4007] == true || $game_variables[@prog][17] == 7 #melo 
    expIgnore = 1
	if pos == 1
   xpa = 0
   ypa = 0
   xha = 0.15
   yha = 0.4
	  else
   xpa = 0
   ypa = -0.33
   xha = 0
   yha = 0.33
	   end  
  end      
  if $game_switches[4019] == true || $game_variables[@prog][17] == 19 #suu  
    expIgnore = 1
	if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
   xpa = 0
   ypa = 0
   xha = 0.1
   yha = 0.1
	  else
   xpa = -0.75
   ypa = 0.3
   xha = -0.4
   yha = 0.4
   end     
  end    
  end
  if $game_switches[4021] == true || $game_variables[@prog][17] == 21 #kono 
    expIgnore = 1
  end  
   xpa *= px
   ypa *= px
   xha *= px
   yha *= px  
   xp += xpa
   yp += ypa
   xh += xha
   yh += yha 
  bodh1 = "" 
  bodh2 = ""
  cost = ""
  costL = ""
  costH = ""
  bodyl = ""
  bodyh = ""
  legco = ""
  bod = ""
  col = ""
  bodh = ""
  bodl = ""
  cro = ""
  crown = ""
  accS = ""
  accSb = ""
  sliacc = ""
  baseh = "SliBodH"
  basel = "SliBodL" 
  haiS = ""
  hair = ""  
  exp = ""
  expE = ""
  expS = ""
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -202
		yp = -55
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("SlimePbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Pout"
	elsif $game_variables[2051] == 5 
	  expS = "Glad"
	 end           
	expr = "SlimePexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
		else        
  # EXPRESSIONS #
  if $game_variables[@prog][3] != 3  
     if $game_variables[@prog][7] == 0
       expS = "B"
     end  
     if expIgnore == 1
       expS = ""
     end  
	   if $game_variables[2051] == 0
		  expE = "Std"
	   elsif $game_variables[2051] == 1 
		  expE = "Sad"
	   elsif $game_variables[2051] == 2 
		  expE = "Rage"
	   elsif $game_variables[2051] == 3 
		  expE = "Love"
	   elsif $game_variables[2051] == 4 
		  expE = "Pout"
	   elsif $game_variables[2051] == 5
		  expE = "Glad"
		end    
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end          
  exp = "SliExp" + expE + expS
  if @ski == "Spooky" 
    exp = "SliExpSpoop"
  end  
  $game_map.screen.pictures[117].show(exp, pos, xh, yh, px, py, 255, 0)
  end
  #^^^ EXPRESSIONS ^^^#
	  cost = ""
  #### COLOUR ####
  if $game_variables[@prog][4] == 0 #GREEN SLIME
  col = "G"
  elsif $game_variables[@prog][4] == 1 #BLUE SLIME
  col = "B"
  elsif $game_variables[@prog][4] == 2 #RED SLIME
  col = "R"
  elsif $game_variables[@prog][4] == 3 #PURPLE SLIME
  col = "P"
  end
  #^^^^ COLOUR ^^^^#
  if $game_variables[@prog][3] != 3 #naked # && $game_variables[@prog][1] == 0 #fem and not dumb
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "" 
  end
  ##############################
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 costL = "d"  
	 $game_map.screen.pictures[118].show("SliCrown", pos, xp, yp, px, py, 255, 0)
  end
  ############################## 
   if $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[118].show("SliMaidBonnet", pos, xp, yp, px, py, 255, 0) 
  end
  ##############################
   if $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
  end
  ############################## 
   if $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "SliBodPri"
   bodyh = cost + col
   $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0) 
  end
  ##############################
   if $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "SliBodWar"
   bodyh = cost + col
   $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0)
   end
  ############################## 
   if $game_switches[4020] == true || $game_variables[@prog][17] == 20
	 cost = "SliBodShell"
   bodyh = cost + col
   $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0) 
   end  
  ##############################
	if $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   end
  ##############################
   if $game_variables[@prog][1] == 0 #females only
  ##############################   
   if $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 if $game_variables[@prog][28] == 1 #chub
	   bodh2 = "B"
	   else
		  if $game_variables[@prog][3] == 0
		  bodh2 = "N"        
		  elsif $game_variables[@prog][3] == 1
		  bodh2 = "B"
		  elsif $game_variables[@prog][3] == 2
		  bodh2 = "S"
		end   
		end
	 bodh1 = "SliBodMelo"
	 bodyh = bodh1 + bodh2 
	 $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0)
  end
  ############################## 
	if $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 if $game_variables[@prog][28] != 1 #not chub   
	  cost = "SliBodCou"    
	 xd = xp
	 yd = yp
	 if $game_variables[@prog][3] == 0
	   bodh2 = "N"        
		  elsif $game_variables[@prog][3] == 1
	   bodh2 = "B"
		if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
		   xdiff = 0.45 * px
		   xd -= xdiff
		 else
		   xdiff = 0.90 * px
		   xd -= xdiff
		end         
		  elsif $game_variables[@prog][3] == 2
	   bodh2 = "S"
	 end  
   bodyh = cost + bodh2 + col 
   $game_map.screen.pictures[113].show(bodyh, pos, xd, yd,  px, py, 255, 0)
  end
  end
  ##############################
   if $game_switches[4018] == true || $game_variables[@prog][17] == 18
	 if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   bodh2 = "B"
	   else
		  if $game_variables[@prog][3] == 0
		  bodh2 = "N"        
		  elsif $game_variables[@prog][3] == 1
		  bodh2 = "B"
		  elsif $game_variables[@prog][3] == 2
		  bodh2 = "S"
		end   
		end  
	 bodh1 = "SliBodDel"
	 bodyh = bodh1 + bodh2   
	 $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show("SliBodLDel", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[115].show("SliHDel", pos, xp, yp, px, py, 255, 0)
  end 
  ##############################
   if $game_switches[4019] == true || $game_variables[@prog][17] == 19
	 if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub
	   bodh2 = "B"
	   else
		  if $game_variables[@prog][3] == 0
		  bodh2 = "N"        
		  elsif $game_variables[@prog][3] == 1
		  bodh2 = "B"
		  elsif $game_variables[@prog][3] == 2
		  bodh2 = "S"
		end   
		end  
	 bodh1 = "SliBodSuu"
	 bodyh = bodh1 + bodh2   
	 $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0)
   end 
  ##############################
   if $game_switches[4021] == true || $game_variables[@prog][17] == 21
	 if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub
	   bodh2 = "B"
	   else
		  if $game_variables[@prog][3] == 0
		  bodh2 = "N"        
		  elsif $game_variables[@prog][3] == 1
		  bodh2 = "B"
		  elsif $game_variables[@prog][3] == 2
		  bodh2 = "S"
		end   
		end  
	 bodh1 = "SliBodx4"
	 bodyh = bodh1 + bodh2   
	 $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0)
   end 
   ############################## 
   if $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20" 
	 $game_map.screen.pictures[118].show("SliH20Mask", pos, xp, yp, px, py, 255, 0) 
   end 
   ############################## 
   if $game_switches[4025] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5" 
   end  
   ############################## 
   if $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20" 
	 costL = "c20" 
	 costH = "c20"
   end 
   ############################## 
   if $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20" 
	 costL = "f20"
	 costH = "f20"   
   end
  ##############################
   if $game_switches[4017] == true || $game_variables[@prog][17] == 17
	 if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   bodh2 = "B"
	   else
		  if $game_variables[@prog][3] == 0
		  bodh2 = "N"        
		  elsif $game_variables[@prog][3] == 1
		  bodh2 = "B"
		  elsif $game_variables[@prog][3] == 2
		  bodh2 = "S"
		end   
		end  
	 bodh1 = "SliBodx0"
	 bodyh = bodh1 + bodh2   
	 $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0)
   end 
  ##############################
   if @prog == 4003
	if cost == "SliBodWar"
	 cro = "SliCrownWar"
	 crown = cro + col  
	 $game_map.screen.pictures[118].show(crown, pos, xp, yp, px, py, 255, 0)
	end  
	if cost == "SliBodPri"
	 cro = "SliCrownPri"
   crown = cro + col 
   $game_map.screen.pictures[118].show(crown, pos, xp, yp, px, py, 255, 0)
	end   
	if bodh1 == "SliBodSuu"
	 $game_map.screen.pictures[118].show("SliCrownSuu", pos, xp, yp, px, py, 255, 0)
	end   
	if bodh1 == "SliBodMelo"
	 $game_map.screen.pictures[118].show("SliCrownMelo", pos, xp, yp, px, py, 255, 0)
	end   
  end 
  ##############################
  end # F only
  end # Q body
   if $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 if $game_variables[@prog][6] == 1
	 costL = "h20"
	 end
   end 
  ##############################
  if bodh1 != "SliBodx0" && cost != "SliBodWar" && cost != "SliBodShell" &&  cost != "SliBodPri" && bodh1 != "SliBodSuu" && bodh1 != "SliBodMelo" && bodh1 != "SliBodDel" && bodh1 != "SliBodx4"
   if $game_variables[@prog][1] == 1
	 cost = ""
  end     
	if $game_variables[@prog][3] == 0
		  bodh = "NF"        
  elsif $game_variables[@prog][3] == 1
		  bodh = "B"
  elsif $game_variables[@prog][3] == 2
		  bodh = "SF"
  elsif $game_variables[@prog][3] == 3
		  bodh = "Q"
  elsif $game_variables[@prog][3] == 4
		  bodh = "SM"
	end       
  if $game_switches[4001] == true || $game_variables[@prog][17] == 1 #regalia
		  bodl = ""
      costL = "d"
  else
		  if $game_variables[@prog][6] == 0
		  bodl = "G"
		  elsif $game_variables[@prog][6] == 1
		  bodl = "L"
		  elsif $game_variables[@prog][6] == 2
		  bodl = "T"
		end
	  end
	 if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub
	   if $game_variables[@prog][3] != 3
	   bodh = "Chu"  
	   bodl = ""
	   end
	 end       
  ##############################
  end # costume bodies
  ##############################   
  if $game_variables[@prog][3] != 3 && marm == 0 && bodh1 != "SliBodx0" && cost != "SliBodWar" &&  cost != "SliBodPri" && bodh1 != "SliBodSuu" && bodh1 != "SliBodMelo" && bodh1 != "SliBodDel" && cost != "SliBodShell" && bodh1 != "SliBodx4" #No SliQ
  ############################# 
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end        
  #HAIR     
   if $game_variables[@prog][26] == 0 #no cust hs     
  if $game_variables[@prog][7] == 0
	 haiS = "Bob"
  elsif $game_variables[@prog][7] == 1
	 haiS = "Cur"
  elsif $game_variables[@prog][7] == 2
	 haiS = "Dri"
  elsif $game_variables[@prog][7] == 3
	 haiS = "Sid"
  elsif $game_variables[@prog][7] == 4
	 haiS = "Ten"
   end    
  else #cust HS
	if $game_variables[@prog][26] == 1
   haiS = "Bow"   
	 elsif $game_variables[@prog][26] == 2
   haiS = "Goo"   
	 elsif $game_variables[@prog][26] == 3
   haiS = "Pon"  
	 elsif $game_variables[@prog][26] == 4
   haiS = "Pon2"  
	 elsif $game_variables[@prog][26] == 5
   haiS = "Pun"  
	 elsif $game_variables[@prog][26] == 6
   haiS = "Ten2"  
  end     
  end   
  if costH == "f20"
	hair = "SliH" + col + "F20"
  elsif costH == "c20"
	hair = "SliH" + haiS + col + "C20"
	else
	hair = "SliH" + haiS + col
  end
  $game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0)
  #### ACC ####
  if $game_variables[@prog][5] == 0
  if $game_switches[4001] != true && $game_variables[@prog][17] != 1   
	 accS = "Co"
  end   
  elsif $game_variables[@prog][5] == 1
	accS = "Fl"
  elsif $game_variables[@prog][5] == 2
	accS = "HF"
	accSb = "SliAccHB" + col
	$game_map.screen.pictures[114].show(accSb, pos, xp, yp, px, py, 255, 0)
  end  
  if accS != ""
  sliacc = "SliAcc" + accS + col
  $game_map.screen.pictures[116].show(sliacc, pos, xp, yp, px, py, 255, 0)
  end
  ##############################
  end # Q body
  ##############################
  #### BODIES ####
	if bodh1 != "SliBodx0" && cost != "SliBodCou" && cost != "SliBodWar" && cost != "SliBodPri" && bodh1 != "SliBodSuu" && bodh1 != "SliBodDel" && bodh1 != "SliBodMelo" && cost != "SliBodShell" && bodh1 != "SliBodx4"  #courtesan upper body
	 if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   cost = ""
	 end 
	 if cost == "c20" || cost == "f20"
	   cost = ""
	 end  
		bodyh = baseh + bodh + col + cost      
	  $game_map.screen.pictures[113].show(bodyh, pos, xp, yp, px, py, 255, 0)
	end
	if costL == "f20"
	  bodl = ""    
	elsif costL == "c20"
	  legco = "SliDreL" + bodl + "c20"
	  $game_map.screen.pictures[118].show(legco, pos, xp, yp, px, py, 255, 0)
	  costL = ""
	end  
		bodyl = basel + bodl + col + costL
	  $game_map.screen.pictures[112].show(bodyl, pos, xp, yp, px, py, 255, 0)  
  ##################################  
  end # ShadeP
  ##################################
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end     
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= -30
	@c2= 45
	@c3= 65
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
  ##################################   
  end # Slime
  ##################################
  #--------------------
  if $game_variables[@prog][0] == 4
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif$game_variables[4000][2] == 4
		  #curious
		$game_variables[2051] = 4    
	  elsif $game_variables[4000][2] == 5
		  #drided
		$game_variables[2051] = 5    
	  end 
	end    
		  xp = -85
		  yp = -11 
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 131
		  yp = -37
		end        
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 385
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 5
		  yp += 10      
  end         
  end     
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 23
		  yp = 93
		end  
		  if $game_switches[3529] == true 
		  xp = 253 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  arm = ""
  leg = ""
  armx = ""
  col = ""
  legs = ""
  armor = ""
  arms = ""
  hbs = ""
  body = ""
  expr = ""
  expT = ""
  expE = ""
  base = "Gol"      
  #vvv# SPECIAL NPC #vvv#
  if $game_variables[@prog][20] == "feather"
	if inMenu == 0
	  xp = -70
	  yp = -20
	end  
  if $game_switches[2359] == true || $game_switches[2466] == true
	  pos = 1
    xp = 345
	  yp = 275
	end
	n = "Feather"
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	  n += "N"
	end  
	if $game_variables[2051] == 0 
    expS = "Std"
	   elsif $game_variables[2051] == 1 
    expS = "Sad"
	   elsif $game_variables[2051] == 2 
    expS = "Rage"
	   elsif $game_variables[2051] == 3 
    expS = "Love"
	   elsif $game_variables[2051] == 4 
    expS = "Con"
	   elsif $game_variables[2051] == 5
    expS = "Sleep"    
  end   
	exp = "FeatherExp" + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
if $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 65
	@c2= -30
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end   
  #^^^# SPECIAL NPC #^^^#    
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -200
		yp = -100
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("GolemPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Curious"
  end            
	expr = "GolemPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)   
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end 
		else     
		  ##
   if $game_switches[4007] == true || $game_variables[@prog][17] == 7
  if $game_switches[3529] == false && $game_switches[3416] == false && $game_switches[2411] == false #NO daycare # pic center or diary
   # puts("AAAAA")
   yadd = yp 
   #yex = yp
	 yadd = -0.7 * py
   #yex += 0.7 * py
	 yp += yadd
   # puts("BBBBB")
   end          
   end   
	if $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   end 
		  yex = yp
		  if $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
		  yadd = -0.15 * py
		  yex = yp + yadd
		  end
  ### EXPRESSIONS ###
  if $game_variables[@prog][7] >= 4 || $game_variables[@prog][7] <= 1
  if $game_variables[@prog][7] >= 4
	expT = "Hum"
  elsif
	expT = "Rob"
  end  
  if $game_variables[2051] == 0 
		  expE = "Std"
  elsif $game_variables[2051] == 1 
		  expE = "Sad"
  elsif $game_variables[2051] == 2 
		  expE = "Rage"
  elsif $game_variables[2051] == 3 
		  expE = "Love"
  elsif $game_variables[2051] == 4 
		  expE = "Con"
  elsif $game_variables[2051] == 5
		  expE = "Dri"
	end    
end      
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
  expr = "GolExp" + expT + expE     
  if @ski == "Spooky" 
    expr = "GolExp" + expT + "Spoop"
  end  
############
 xex = xp
  if $game_switches[4007] == true || $game_variables[@prog][17] == 7
     if pos == 0
     yex = yp + (0.5 * py)
     xex = xp - (0.1 * py)
   elsif pos == 1
     yex = yp + (0.25 * py) 
     xex = xp - (0.05 * py)
     end
  end
############
  unless $game_switches[4004] == true || $game_variables[@prog][17] == 4 #no exp SS
   $game_map.screen.pictures[118].show(expr, pos, xex, yex, px, py, 255, 0)  
  end
		  if $game_variables[@prog][12] == 0
		  $game_map.screen.pictures[112].show("GolLegSil", pos, xp, yex, px, py, 255, 0)
  elsif $game_variables[@prog][11] == 1
		  $game_map.screen.pictures[112].show("GolAccKey", pos, xp, yex, px, py, 255, 0)
  elsif $game_variables[@prog][11] == 2
		  $game_map.screen.pictures[112].show("GolAccVal", pos, xp, yex, px, py, 255, 0)
		  end      
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 if @prog == 4004
	 $game_map.screen.pictures[111].show("GolCrown", pos, xp, yp, px, py, 255, 0)
	 end
	 end 
   if $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[119].show("GolMaidBonnet", pos, xp, yp, px, py, 255, 0)   
   end 
   if $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
  if $game_variables[@prog][4] == 0 #ORANGE GOLEM    
  col = "O"        
  elsif $game_variables[@prog][4] == 1 #BROWN GOLEM   
  col = "Br"   
  elsif $game_variables[@prog][4] == 2 #BLUE GOLEM    
  col = "Bl" 
  elsif $game_variables[@prog][4] == 3 #BLACK GOLEM    
  col = "B" 
  end      
	 if @prog == 4004
	 $game_map.screen.pictures[111].show("GolCrownSS", pos, xp, yp, px, py, 255, 0)   
	 end
   end 
   if $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
	 $game_map.screen.pictures[119].show("GolChain", pos, xp, yp, px, py, 255, 0)
   end 
   if $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
	 $game_map.screen.pictures[119].show("GolVisor", pos, xp, yp, px, py, 255, 0)
   end 
   if $game_switches[4007] == true || $game_variables[@prog][17] == 7
	 cost = "u"
	 if @prog == 4004
	 $game_map.screen.pictures[111].show("GolCrownU", pos, xp, yp, px, py, 255, 0)   
	 end      
   end  
	if $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
	 yadd = -0.3 * py
	 yq = yp + yadd
	 $game_map.screen.pictures[117].show("GolHq", pos, xp, yq, px, py, 255, 0)
  if $game_variables[@prog][4] == 0 #ORANGE GOLEM    
  col = "O"        
  elsif $game_variables[@prog][4] == 1 #BROWN GOLEM   
  col = "Br"   
  elsif $game_variables[@prog][4] == 2 #BLUE GOLEM    
  col = "Bl" 
  elsif $game_variables[@prog][4] == 3 #BLACK GOLEM    
  col = "B" 
  end   
   end   
	if $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   end 
   if $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20" 
	 if $game_variables[2051] == 5
	 $game_map.screen.pictures[119].show("GolH20MaskDrided", pos, xp, yp, px, py, 255, 0)  
	   else
	 $game_map.screen.pictures[119].show("GolH20Mask", pos, xp, yp, px, py, 255, 0)
	 end
   end  
   if $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20" 
	 $game_map.screen.pictures[117].show("GolHc20", pos, xp, yp, px, py, 255, 0)
  if $game_variables[@prog][4] == 0 #ORANGE GOLEM    
  col = "O"        
  elsif $game_variables[@prog][4] == 1 #BROWN GOLEM   
  col = "Br"   
  elsif $game_variables[@prog][4] == 2 #BLUE GOLEM    
  col = "Bl" 
  elsif $game_variables[@prog][4] == 3 #BLACK GOLEM    
  col = "B" 
  end     
  end   
   if $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20" 
		  if $game_variables[@prog][12] == 0 || $game_variables[@prog][12] == 1 || $game_variables[@prog][12] == 2
		   costleg = "Sil"
		  elsif $game_variables[@prog][12] == 3
		   costleg = "Mec"
		  elsif $game_variables[@prog][12] == 4
		   costleg = "Spi"
		  end        
	 goldre = "GolDre" + costleg + "f20"
	 $game_map.screen.pictures[120].show(goldre, pos, xp, yp, px, py, 255, 0)         
	 $game_map.screen.pictures[119].show("GolF20Mask", pos, xp, yp, px, py, 255, 0)  
   end  
	#if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 && $game_variables[@prog][3] != 2 #chub/no mec
	# cost = "Chu"
	#  if $game_variables[@prog][5] == 1 || $game_variables[@prog][5] == 0
	#	  armx = "ArmJ"
	#  else
	#	  armx = "ArmT"
  #  end 
  #arms = base + armx + col
	#$game_map.screen.pictures[116].show(arms, pos, xp, yp, px, py, 255, 0)     
	#end 
  end
  #end
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
		 if $game_variables[@prog][3] == 2
		  bod = "BodMec"
		  elsif $game_variables[@prog][3] == 0
		 bod = "BodSilCur"
		  elsif $game_variables[@prog][3] == 1
		 bod = "BodSilSle"
		  elsif $game_variables[@prog][3] == 3
		  bod = "BodSilBrk"
		end     
		if $game_variables[@prog][5] == 1 || $game_variables[@prog][5] == 0
		   arm = "BodArmJ"
		   armx = "ArmJ"
		  elsif $game_variables[@prog][5] == 2
		   arm = "BodArmT"
		   armx = "ArmT"
		 end     
		 if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 && $game_variables[@prog][3] != 2 #chub/no mec
		  bod = "BodSilChu"
		 end 
		  if $game_variables[@prog][12] == 0
		   leg = "LegSil"
		  elsif $game_variables[@prog][12] == 1
		   leg = "LegArmJ"
		  elsif $game_variables[@prog][12] == 2
		   leg = "LegArmT"
		  elsif $game_variables[@prog][12] == 3
		   leg = "LegMec"
		  elsif $game_variables[@prog][12] == 4
		   leg = "LegSpi"
		 end      
  if $game_variables[@prog][12] == 1 || $game_variables[@prog][12] == 2
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
  leg = "LegSil"
  end
  end
  if cost != "s" && cost != "u" && cost != "q" && cost != "c20"
  if $game_variables[@prog][4] == 0 #ORANGE GOLEM    
  col = "O"        
  elsif $game_variables[@prog][4] == 1 #BROWN GOLEM   
  col = "Br"   
  elsif $game_variables[@prog][4] == 2 #BLUE GOLEM    
  col = "Bl" 
  elsif $game_variables[@prog][4] == 3 #BLACK GOLEM    
  col = "B" 
  end   
		  if $game_variables[@prog][7] == 0
		  hbs = "TVJ"
		  elsif $game_variables[@prog][7] == 1
		  hbs = "TVT"
		  elsif $game_variables[@prog][7] == 2
		  hbs = "HelJ"
		  elsif $game_variables[@prog][7] == 3
		  hbs = "HelT"
		  end
	#head    
	if $game_variables[@prog][7] >= 0 && $game_variables[@prog][7] <= 3
	head = "GolH" + hbs + col    
	$game_map.screen.pictures[117].show(head, pos, xp, yp, px, py, 255, 0)  
	end
  end      
   if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1 #naked
	  if $game_variables[@prog][3] == 2
		  body = base + bod + col
	  else
		  body = base + bod
	  end  
  elsif cost == "s" #ss
		   if $game_variables[@prog][12] == 4
		   bod = "BodSpi"
		   cost = "s" 
		 else
		   bod = "Bod"
		   cost = "s"          
		 end    
		 body = base + bod + col + cost       
  elsif cost == "u" #bunny
		   if $game_variables[@prog][12] == 4
			 body = "GolBodSpiu"
		 else
		   body = "GolBodu"
		  end    
  elsif cost == "m" || cost == "h20" || cost == "c20" #maid / H20
   if $game_variables[@prog][3] == 2 && cost != "c20"
	 body = base + bod + col + cost
   else
	 body = base + bod + cost
   end   
	 else
   if $game_variables[@prog][3] == 2
	 body = base + bod + col
   else
	 body = base + bod
   end
  end
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	### LEGS ### 
  col1 = col
	if cost == "q"
	 legs = base + leg + col1    
	$game_map.screen.pictures[113].show(legs, pos, xp, yp, px, py, 255, 0)
   end 
  if $game_variables[@prog][12] == 1 || $game_variables[@prog][12] == 2
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	  col1 = ""
  end
  end
	if $game_variables[@prog][12] == 0 #silicon legs
	  col1 = ""
	end     
   if cost == "d" && $game_variables[@prog][12] != 0
	  legs = base + leg + col1 + cost   
	  else 
	  legs = base + leg + col1
	end   
	if cost == "u"
	  legs = "" #NO LEGS BUNNY
	else 
	if  cost == "s" && $game_variables[@prog][12] != 4
	  legs = "" #NO LEGS SS
	else
	$game_map.screen.pictures[113].show(legs, pos, xp, yp, px, py, 255, 0)
  end
  end
	### SPEC HEAD ### 
  if cost != "u" && cost != "s"
  if $game_variables[@prog][7] == 4
	  $game_map.screen.pictures[117].show("GolHDoll1", pos, xp, yex, px, py, 255, 0)
  elsif $game_variables[@prog][7] == 5
	  $game_map.screen.pictures[117].show("GolHDoll2", pos, xp, yex, px, py, 255, 0)
  end
  end  
	### ARMOR ### 
   if cost == "d"  #regalia
	  armor = base + arm + col + cost
	else
	  armor = base + arm + col    
	end
	if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	   armor = "" #NO ARMOR NAKED
	 elsif cost == "m" || cost == "u" || cost == "s" || cost == "h20" || bod == "BodSilChu" || cost == "c20"
	   armor = "" #NO ARMOR
	 else
	   $game_map.screen.pictures[115].show(armor, pos, xp, yp, px, py, 255, 0)
	end
	### ARMS ###
   if cost == "c20" #battle
	  armx = "Arm"
	  arms = base + armx + cost
   elsif cost == "b" #battle
	  armx = "Arm"
	  arms = base + armx + col + cost
   elsif cost == "d" #regalia
	  arms = base + armx + col + cost
   elsif cost == "q" || cost == "c20" #courtesan/h20
	  armx = "Arm"
	  arms = base + armx + col + cost
   else
	  arms = base + armx + col
   end
   if cost == "u"
	  arms = "" #NO ARMS BUNNY
   elsif cost == "s"
	  arms = "" #NO ARMS SS
	else
	$game_map.screen.pictures[116].show(arms, pos, xp, yp, px, py, 255, 0)
   end        
  end
	### PARTS ###    
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 65
	@c2= -30
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
	 end
  #--------------------
  if $game_variables[@prog][0] == 5
	#FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#      
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #heat
		$game_variables[2051] = 4    
	  end  
	end
		xp = 22
		yp = 113 
  if $game_variables[@prog][19] == 2
		  xp += 50
		  yp += 10      
    end       
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 223
		  yp = 90
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 20
		  yp += 35      
  end         
  end  
	if $game_switches[579] == true #status screen
		  px = 50
		  py = 50
		  xp = 85
		  yp = 180
		end  
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  bod0 = ""
  col = ""
  anS = ""
  anB = ""
  ant = ""
  antB = ""
  back = ""
  bakS = ""
  fan = ""
  fanS = ""
  fanB = ""
  exp = ""
  expT = ""
  expS = ""
  expr = ""
  basedre = "InsDre"
  base = "InsBod"   
   xh = xp
   yh = yp 
 	 xbk = xp
	 ybk = yp  
	 xpa = 0
	 ypa = 0
	 xha = 0
	 yha = 0   
	if $game_variables[@prog][1] == 0 && $game_variables[@prog][28] != 1 #female
	if $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true #daycare # pic center or diary
	 xpa = -0.3
	 ypa = -0.9
	 xha = 0
	 yha = 0
	  else
	 xpa = 0.7
	 ypa = -1.1
	 xha = -0.45
	 yha = -0.95
   end
   xpa *= px
   ypa *= px
   xha *= px
   yha *= px  
   xp += xpa
   yp += ypa
   xh += xha
   yh += yha      
  end
end
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -149
		yp = 39
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("InsectPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Heat"
	 end           
	expr = "InsectPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0) 
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end    
		else             
  #EXPRESSION
  if $game_variables[@prog][11] == 0 
	expS = ""
  elsif $game_variables[@prog][11] == 1   
	expS = "F"
  elsif $game_variables[@prog][11] == 2   
	expS = "C"
  end  
  expT = "Std"
	if $game_variables[2051] == 0 
		 expT = "Std"
  elsif $game_variables[2051] == 1 
		 expT = "Sad"
  elsif $game_variables[2051] == 2 
		 expT = "Rage"
  elsif $game_variables[2051] == 3 
		 expT = "Love"
  elsif $game_variables[2051] == 4 
		 expT = "Heat"
  end
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expT = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expT = "Yan"
  elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expT = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expT = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expT = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expT = "Nemu"
  end         
  exp = "InsExp" + expS + expT
  if @ski == "Spooky" 
    exp = "InsExpSpoop"
  end    
  $game_map.screen.pictures[119].show(exp, pos, xp, yp, px, py, 255, 0)
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[111].show("InsCrown", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"  
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	cost = "q"
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #magi
	 cost = "x1"
   elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #mandrake
	 cost = "x3"     
	 if $game_variables[@prog][1] == 1
	   $game_map.screen.pictures[118].show("InsX3Mask", pos, xp, yp, px, py, 255, 0) 
	 end  
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5" 
	 $game_map.screen.pictures[118].show("Insx5Mask", pos, xp, yp, px, py, 255, 0)    
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"      
		if $game_variables[@prog][3] == 0 
	 $game_map.screen.pictures[118].show("InsH20MaskAF", pos, xp, yp, px, py, 255, 0)      
	   elsif $game_variables[@prog][3] == 1
	 $game_map.screen.pictures[118].show("InsH20MaskB", pos, xp, yp, px, py, 255, 0)
	   elsif $game_variables[@prog][3] == 2
	 $game_map.screen.pictures[118].show("InsH20MaskS", pos, xp, yp, px, py, 255, 0)
	   else
	 $game_map.screen.pictures[118].show("InsH20Mask", pos, xp, yp, px, py, 255, 0)
   end   
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"
	 $game_map.screen.pictures[118].show("InsF20Mask", pos, xp, yp, px, py, 255, 0) 
  end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 cost = "Chu"   
   end
	end
  #end
  ### colour  
  if $game_variables[@prog][4] == 0
  col = "Bee" 
  elsif $game_variables[@prog][4] == 1 
  col = "Gre" 
  elsif $game_variables[@prog][4] == 2 
  col = "Pur" 
  elsif $game_variables[@prog][4] == 3 
  col = "Red" 
  elsif $game_variables[@prog][4] == 4
  col = "Bla" 
  end
  ### back
		if $game_variables[@prog][6] == 0
		  bakS = "InsBL"
		elsif $game_variables[@prog][6] == 1
		  bakS = "InsBB"
		elsif $game_variables[@prog][6] == 2
		  bakS = "InsBM"
		elsif $game_variables[@prog][6] == 3
		  bakS = "InsBS"   
		end 
	 back = bakS + col   
	 xbk = xp
	 ybk = yp
	 if $game_variables[@prog][3] == 2   
		xbk += 10
		ybk += 10
	  end   
	 $game_map.screen.pictures[112].show(back, pos, xbk, ybk, px, py, 255, 0)   
  ### fangs
		if $game_variables[@prog][7] == 1
	  fanS = "InsFHorn"
	  fan = fanS
	  $game_map.screen.pictures[116].show(fan, pos, xp, yp, px, py, 255, 0)
		elsif $game_variables[@prog][7] == 2
	  fanS = "InsF"
	  fan = fanS + col
	  fanB = fanS + col + "B"  
	  $game_map.screen.pictures[114].show(fanB, pos, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[116].show(fan, pos, xp, yp, px, py, 255, 0)
		end        
  ### antennae    
  if cost != "h20" && cost != "c20" #hall 2020
	  if $game_variables[@prog][5] == 0
		  anS = "InsAN"
	  elsif $game_variables[@prog][5] == 1
		  anS = "InsAT"
	  elsif $game_variables[@prog][5] == 2
		  anS = "InsAS" 
	  elsif $game_variables[@prog][5] == 3
		  anS = "InsAL"
		  anB = "InsAL"
	  antB = anB + col + "B"   
	  $game_map.screen.pictures[113].show(antB, pos, xp, yp, px, py, 255, 0)          
	  end  
	  ant = anS + col
	 $game_map.screen.pictures[117].show(ant, pos, xp, yp, px, py, 255, 0)    
   end  
  ### rest   
  if $game_variables[@prog][1] == 1 && cost != "c20"
	cost = ""
  end  
  ### bodies  
		if $game_variables[@prog][3] == 0 
		  bod = "AF"        
		  elsif $game_variables[@prog][3] == 1
		  bod = "B"
		  elsif $game_variables[@prog][3] == 2
		  bod = "S"
		  elsif $game_variables[@prog][3] == 3
		  bod = "AM"
		  elsif $game_variables[@prog][3] >= 4
		  bod = "Sc"
		end
		if cost == "Chu"
		  if $game_variables[@prog][3] == 1
		  bod = "BChu"
		else
		  bod = "Chu"
		end    
		end
   ### dress
   dress =  basedre + bod + cost 
   if cost == "q" #slaves and court coordinates
	 dress = "InsSlaves"
   end  
  if $game_variables[@prog][1] == 1 && cost == "c20"
	 dress = "InsDreAFc20"
  end   
	 $game_map.screen.pictures[120].show(dress, pos, xh, yh, px, py, 255, 0)
  if cost != "" && cost != "q" && cost != "Chu"
	cost = "n"
  end 
  if cost == "Chu" || $game_variables[@prog][1] == 1
	cost = ""
  end  
  body = base + bod + col + cost
	  $game_map.screen.pictures[115].show(body, pos, xp, yp, px, py, 255, 0)
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
		 end
	   end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 75
	@c2= -30
	@c3= 55
	@c4= 30
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####     
	   return
	 end
  #--------------------
  if $game_variables[@prog][0] == 6
	#FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  elsif $game_variables[@prog][3] <= 1
	$game_variables[@prog][1] = 0
  end 
  #FIX#        
   if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 6
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2 || $game_variables[4000][2] == 5
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #spooky
		$game_variables[2051] = 4    
	  end  
	end    
		xp = -94
		yp = -93
  if $game_variables[@prog][19] == 2
		  xp += 110
		  yp += 80      
  end             
		  if $game_variables[@prog][3] == 2
			xp = -88
			yp = -133
    end    
    if $game_switches[3215] == true #centerhead
      pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 121
		  yp = -87
		  if $game_variables[@prog][3] == 2
		  xp = 139
		  yp = -131
		  end  
		end
		if $game_switches[2411] == true 
		  px = 70
		  py = 70
		  xp = 365
		  yp = 340    
		  if $game_variables[@prog][3] == 2
		  yp -= 40
		  end          
  if $game_variables[@prog][19] == 2
		  xp += 20
		  yp += 10      
  end         
  end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 25
		  yp = 60
		  if $game_variables[@prog][3] == 2
		  xp = 40
		  yp = 45
		  end    
		end   
	  if $game_switches[3529] == true
      xp = 228 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  if $game_variables[@prog][7] == 10 #hydra head
    xp -= (0.50*px)
  end      
  cost = ""
  bod = ""
  col = ""
  col2 = ""
  horn = ""
  hornS = ""
  head = ""
  hairS = ""
  hcol = ""
  basedre = "SkeDre"
  base = "SkeBod"   
  exp = ""
  expS = ""
  expE = ""
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -207
		yp = -55
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("SkeletonPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Spooky"
	 end           
	expr = "SkeletonPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)     
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
		else 
  if $game_variables[@prog][1] == 0    
	  if $game_switches[4005] == true || $game_variables[@prog][17] == 5 #PRI HEAD PLACE
		if $game_variables[@prog][3] == 0
		  rat = 4.5 * py
		  yp += rat
		elsif $game_variables[@prog][3] == 1
		  rat = 1.5 * py  
		  xp += rat 
		  rat = 4.25 * py  
		  yp += rat
		end   
		end
   end 
  ###EXP###
  @expLess = [5,6,9,10,11]
  if $game_variables[@prog][7] == 2  
    expS = "M"
  elsif $game_variables[@prog][7] == 8
    expS = "L"
  elsif @expLess.include?$game_variables[@prog][7]
    expS = "hidd"
  end  
		if $game_variables[2051] == 0 
		 expE = "Std"
  elsif $game_variables[2051] == 1 
		 expE = "Sad"
  elsif $game_variables[2051] == 2 
		 expE = "Rage"
  elsif $game_variables[2051] == 3 
		 expE = "Boner"
  elsif $game_variables[2051] == 4 
		 expE = "Spooky"
   end    
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end             
  exp = "SkeExp" + expS + expE
  if @ski == "Spooky" 
    if $game_variables[@prog][7] == 2 
    exp = "SkeExpMSpoop"  
      else
    exp = "SkeExpSpoop"
    end
  end    
  $game_map.screen.pictures[117].show(exp, pos, xp, yp, px, py, 255, 0)
  ###EXP###  
  if @prog == 4087
  $game_map.screen.pictures[111].show("SkeCrownE", pos, -185, 75, px, py, 255, 0)
  end
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[118].show("SkeVeil", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[111].show("SkeCrown", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[118].show("SkeBunHead", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   unless $game_variables[@prog][7] == 10 #demon/hydra
	  $game_map.screen.pictures[111].show("SkeCourHead", pos, xp, yp, px, py, 255, 0)  
    end
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18
	 cost = "x1"
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[118].show("SkeMerHead", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19
	 cost = "x2"
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[118].show("SkeWedVeil", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[118].show("SkeH20Mask", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[118].show("SkeC20Mask", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[118].show("SkeF20Mask", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #colosseum
	 cost = "b2"       
   unless $game_variables[@prog][7] == 10 #demon/hydra
	 $game_map.screen.pictures[119].show("Skeb2Mask", pos, xp, yp, px, py, 255, 0)
   end
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"    
   unless $game_variables[@prog][7] == 10 #demon/hydra
   $game_map.screen.pictures[119].show("Skex5Mask", pos, xp, yp, px, py, 255, 0)   
   end
   end    
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 cost = "Chu"
   end     
  end
  #end
  #################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #################################
  if $game_variables[@prog][3] == 0
		  bod = "StdF"        
  elsif $game_variables[@prog][3] == 1
		  bod = "4F"
  elsif $game_variables[@prog][3] == 2
		  bod = "Gra"
		  if cost != "Chu"
			 cost = ""
		  end
  elsif $game_variables[@prog][3] == 3
		  bod = "StdM"
  elsif $game_variables[@prog][3] == 4
		  bod = "4M"
		end
  #### BONE COLOUR ####    
  if $game_variables[@prog][4] == 0 #WHITE SKELLY   
  col = "W"  
  elsif $game_variables[@prog][4] == 1 #GREY SKELLY   
  col = "Gr" 
  elsif $game_variables[@prog][4] == 2 #BLUE SKELLY   
  col = "B"  
  elsif $game_variables[@prog][4] == 3 #GREEN SKELLY   
  col = "G"  
  end
  #### HAIR COLOUR ####    
  if $game_variables[@prog][11] == 0 #BLACK HAIR
  col2 = "B"
  elsif $game_variables[@prog][11] == 1 #BLONDE HAIR
  col2 = "Bl"
  elsif $game_variables[@prog][11] == 2 #GREEN HAIR
  col2 = "G"
  elsif $game_variables[@prog][11] == 3 #PURPLE HAIR
  col2 = "P"
  end
  #### HEAD ####
  gotHair = 0
  noHead = 0
  if $game_switches[4015] == false && $game_variables[@prog][17] != 15 #chill 2020
   noHead = 1  
  end  
		if $game_variables[@prog][7] == 0
		  hairS = "Bus"
		  gotHair = 1
		elsif $game_variables[@prog][7] == 1
		  hairS = "Bald"
		elsif $game_variables[@prog][7] == 2
		  hairS = "Man"
		elsif $game_variables[@prog][7] == 3
		  hairS = "Moh"
		  gotHair = 1
		elsif $game_variables[@prog][7] == 4
		  hairS = "Dem"
		elsif $game_variables[@prog][7] == 5
		  hairS = "Hor"
		elsif $game_variables[@prog][7] == 6
		  hairS = "Cro"
		elsif $game_variables[@prog][7] == 7
		  hairS = "Pon"
		  gotHair = 1
		elsif $game_variables[@prog][7] == 8
		  hairS = "Lon"
		  gotHair = 1
		elsif $game_variables[@prog][7] == 9
		  hairS = "Lich"  
		elsif $game_variables[@prog][7] == 10
		  hairS = "Hydra"   
		elsif $game_variables[@prog][7] == 11
		  hairS = "Bomb"    
		end
	#HAIR
	if $game_variables[@prog][26] != 0
	  gotHair = 1 
	end  
	if $game_variables[@prog][26] == 1 #custom hair
	  hairS = "Sid"
	 elsif $game_variables[@prog][26] == 2 
	  hairS = "Bun"
	 elsif $game_variables[@prog][26] == 3 
	  hairS = "Twi"
	 elsif $game_variables[@prog][26] == 4 
	  hairS = "Fra"
	 elsif $game_variables[@prog][26] == 5 
	  hairS = "Pen"  
	 end   
  #HEAD
   nospeH = 0
   if $game_variables[@prog][27] == 5 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end    
  if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust hcol 
   hcol = col2 
  else
	if $game_variables[@prog][27] == 1 #BLACK
  hcol = "Bl"
  elsif $game_variables[@prog][27] == 2 #BLONDE
  hcol = "B"
  elsif $game_variables[@prog][27] == 3 #GREEN
  hcol = "G"
  elsif $game_variables[@prog][27] == 4 #PURPLE
  hcol = "P"
  elsif $game_variables[@prog][27] == 5 #Special
  hcol = "Spe"    
  end 
  end 
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end         
  if noHead == 1 #nohead
  #HAIR        
  if gotHair == 1       
	head = "SkeHBald" + col
	hair = "SkeH" + hairS + hcol
	$game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0)
  else  
   if $game_variables[@prog][7] == 11 #bomb head
		head = "SkeH" + hairS
   else
    head = "SkeH" + hairS + col
	 end  	
  end      
  xhead = xp
  yhead = yp
  if $game_variables[@prog][7] == 10 #hydra head
    xhead += (1.2*px)
  end  
  $game_map.screen.pictures[114].show(head, pos, xhead, yhead, px, py, 255, 0)
  end #nohead
  #### HORNS ####
  if $game_variables[@prog][7] != 4 && $game_variables[@prog][7] != 10 #demon/hydra skull
  if $game_variables[@prog][5] == 1
	hornS = "Lil"
   elsif $game_variables[@prog][5] == 2
	 hornS = "Cow"
   elsif $game_variables[@prog][5] == 3
	 hornS = "Sta"
  end
  horn = "SkeH" + hornS + col      
  $game_map.screen.pictures[116].show(horn, pos, xp, yp, px, py, 255, 0)
  end
  #################
  if $game_switches[4005] == true || $game_variables[@prog][17] == 5 #PRI HEAD RESTORE
	   if $game_variables[@prog][3] == 0
		  rat = 4.5 * py
		  yp -= rat
	   elsif $game_variables[@prog][3] == 1
		  rat = 1.5 * py  
		  xp -= rat 
		  rat = 4.25 * py  
		  yp -= rat
	   end   
	 end
   dress =  basedre + bod + cost 
	  $game_map.screen.pictures[113].show(dress, pos, xp, yp, px, py, 255, 0)
  if cost != ""
	cost = "n"
  end
  if $game_variables[@prog][3] == 2 #no grv "n"
	cost = ""
  end  
	   body = base + bod + col + cost
	  $game_map.screen.pictures[112].show(body, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	   end      
	 end
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 45
	@c2= 45
	@c3= 45
	@c4= 75
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end 
  #--------------------
  if $game_variables[@prog][0] == 7
	#FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#        
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #embarass
		$game_variables[2051] = 4    
	  end  
	end    
		xp = 11
		yp = 74
  unless $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc            
	if $game_switches[4018] == true || $game_variables[@prog][17] == 18 #QOP
		if $game_variables[@prog][3] == 0
		  xp -= 30
		elsif $game_variables[@prog][3] == 1
		  xp -= 50      
		  yp -= 1
		elsif $game_variables[@prog][3] == 2
		  xp -= 41      
		  yp -= 4
		end   
	  end          
   end   
  if $game_variables[@prog][19] == 2
		  xp += 70
		  yp += 30      
  end        
		if $game_variables[@prog][3] == 2
		  yp -= 28
		end  
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 224
		  yp = 10
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 5
		  yp += 5
  end           
  end 
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 80
		  yp = 135
		end  
		  if $game_switches[3529] == true
      xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  col1 = ""
  col2 = ""
  hair = ""
  hairS = ""
  hairB = ""
  hcol = ""
  basedre = "DesDre"
  base = "DesBod"      
  exp = ""
  expS = ""
  #vvv# SPECIAL NPC #vvv#
  if $game_variables[@prog][20] == "onyx" 
	if inMenu == 0
	  xp = -90
	  yp = -5
	end  
	if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 400
		  yp = 284
      pos = 1
	end  
	n = "Onyxxx"
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	  n += "N"
	end  
  if $game_variables[2051] == 0 
	  expS = "Std"
  elsif $game_variables[2051] == 1 
	  expS = "Sad"
  elsif $game_variables[2051] == 2 
	  expS = "Rage"
  elsif $game_variables[2051] == 3 
	  expS = "Love"
  elsif $game_variables[2051] == 4 
	  expS = "Embarass"
  end       
	exp = "OnyxxxExp" + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
if $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 55
	@c2= 0
	@c3= 0
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
	 end    
  #^^^# SPECIAL NPC #^^^#   
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -183
		yp = 18
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("DesertPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Embarass"
	 end           
	expr = "DesertPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0) 
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end    
		else 
		  xex = xp        
		  if $game_variables[@prog][1] == 0 
		   if $game_switches[4018] == true || $game_variables[@prog][17] == 18
		  xadd = 0.35 * px   
		  xex = xp + xadd
		end
   end
   expS = "Std" 
	  if $game_variables[2051] == 0 
		  expS = "Std" 
    elsif $game_variables[2051] == 1 
		  expS = "Sad" 
    elsif $game_variables[2051] == 2 
		  expS = "Rage"
    elsif $game_variables[2051] == 3 
		  expS = "Love"
    elsif $game_variables[2051] == 4 
		  expS = "Emb" 
		end
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expS = "Tsun"
 elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20
    expS = "Yan"
  elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expS = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expS = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expS = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expS = "Nemu"
  end         
  exp = "DesExp" + expS
  if @ski == "Spooky" 
     exp = "DesExpSpoop"  
  end      
  $game_map.screen.pictures[119].show(exp, pos, xex, yp, px, py, 255, 0)
  # if $game_variables[@prog][1] == 0 
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 if @prog == 4007
	 $game_map.screen.pictures[111].show("DesCrown", pos, xp, yp, px, py, 255, 0)
	 end   
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"  
	 yd = 0.15 * py
	 ybun = yp - yd
	 $game_map.screen.pictures[120].show("DesBunnyEars", pos, xp, ybun, px, py, 255, 0)   
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   end 
   ##########################
   if $game_variables[@prog][1] == 0 #fem only
   if $game_switches[4018] == true || $game_variables[@prog][17] == 18 
	 cost = "x1"
		 if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 3
		  bod = "Stdx1"        
		  elsif $game_variables[@prog][3] == 1
		  bod = "Flatx1"
		  elsif $game_variables[@prog][3] == 2
		  bod = "Succx1"
		end
		body = base + bod
		$game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)    
	  end     
	end
   ##########################  
	if $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
	$game_map.screen.pictures[120].show("DesHatq", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[120].show("DesH20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[120].show("DesC20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[120].show("DesF20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 #glass
	 cost = "x2"    
	 $game_map.screen.pictures[120].show("DesX2Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #char
	 cost = "x3"    
	 $game_map.screen.pictures[120].show("DesX3Mask", pos, xp, yp, px, py, 255, 0)   
  end     
  if $game_variables[@prog][3] != 3 #not for satyrs 
   if $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[120].show("DesMaidBonnet", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
   end     
  end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 cost = "Chu"
   end    
  end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
  #end
   if cost != "x1"
		  if $game_variables[@prog][6] == 1
		  $game_map.screen.pictures[112].show("DesTSuc", pos, xp, yp, px, py, 255, 0)
		  end      
		  if $game_variables[@prog][11] == 1
		  $game_map.screen.pictures[118].show("DesHoLil", pos, xp, yp, px, py, 255, 0)
		  elsif $game_variables[@prog][11] == 2
		  $game_map.screen.pictures[118].show("DesHoGoa", pos, xp, yp, px, py, 255, 0)
		  elsif $game_variables[@prog][11] == 3
		  $game_map.screen.pictures[118].show("DesHoDem", pos, xp, yp, px, py, 255, 0)
		end    
		if $game_variables[@prog][3] == 0
		  bod = "Std"        
		  elsif $game_variables[@prog][3] == 1
		  bod = "Flat"
		  elsif $game_variables[@prog][3] == 2
		  bod = "Succ"
		  elsif $game_variables[@prog][3] == 3
		  bod = "SatF"
		  elsif $game_variables[@prog][3] == 4
		  bod = "SatM"
		end     
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 if $game_variables[@prog][3] <= 2
	  bod = "Chu"
	 else
	  bod = "ChuSat" 
	 end
   end        
	  if $game_switches[4006] == false && $game_variables[@prog][17] != 6       
		 if $game_variables[@prog][12] == 1
		  $game_map.screen.pictures[115].show("DesAccP", pos, xp, yp, px, py, 255, 0)
		 elsif $game_variables[@prog][12] == 2
		  $game_map.screen.pictures[115].show("DesAccTcut", pos, xp, yp, px, py, 255, 0)
		 end   
	   end         
  #HAIR revert      
	if $game_variables[@prog][26] >= 9
	  $game_variables[@prog][26] = 0
	end        
  #HAIR     
  # Hairstyles 
	if $game_variables[@prog][26] == 0 
  if $game_variables[@prog][7] == 0 
		  hairS = "Sho"
  elsif $game_variables[@prog][7] == 1
		  hairS = "Pon"
  elsif $game_variables[@prog][7] == 2
		  hairS = "Twi"
  elsif $game_variables[@prog][7] == 3
		  hairS = "Bra"
  elsif $game_variables[@prog][7] == 4
		  hairS = "Him"
		end          
   else
	if $game_variables[@prog][26] == 1
	   hairS = "Afr"
  elsif $game_variables[@prog][26] == 2
	   hairS = "Bob"   
  elsif $game_variables[@prog][26] == 3
	   hairS = "Bra2"   
  elsif $game_variables[@prog][26] == 4
	   hairS = "Bra3"   
  elsif $game_variables[@prog][26] == 5
	   hairS = "Clo"   
  elsif $game_variables[@prog][26] == 6
	   hairS = "Lon"   
  elsif $game_variables[@prog][26] == 7
	   hairS = "Pon2"   
  elsif $game_variables[@prog][26] == 8
	   hairS = "Wil"   
	 end 
   end          
  # Haircol / fur col
  if $game_variables[@prog][5] == 0  #BROWN HAIR
  col2 = "Bro"     
  elsif $game_variables[@prog][5] == 1  #BLACK HAIR
  col2 = "Bla"       
  elsif $game_variables[@prog][5] == 2  #WHITE HAIR
  col2 = "Whi"   
  elsif $game_variables[@prog][5] == 3  #PURPLE HAIR
  col2 = "Pur"    
  elsif $game_variables[@prog][5] == 4  #GREEN HAIR
  col2 = "Gre"  
  end
  # alt col?
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col     
	hcol = col2
  else
	if $game_variables[@prog][27] == 1  #BROWN HAIR
  hcol = "Bro"     
  elsif $game_variables[@prog][27] == 2  #BLACK HAIR
  hcol = "Bla"       
  elsif $game_variables[@prog][27] == 3  #WHITE HAIR
  hcol = "Whi"   
  elsif $game_variables[@prog][27] == 4  #PURPLE HAIR
  hcol = "Pur"    
  elsif $game_variables[@prog][27] == 5  #GREEN HAIR
  hcol = "Gre"  
  elsif $game_variables[@prog][27] == 6  #SPECIAL HAIR
  hcol = "Spe"  
  end
  end
  #skin colour
  if $game_variables[@prog][4] == 0  #AMAZON DESERT        
  col1 = "Ama"
  elsif $game_variables[@prog][4] == 1  #BEDOUIN DESERT        
  col1 = "Bed"       
  elsif $game_variables[@prog][4] == 2  #PALE DESERT        
  col1 = "Pal"       
  elsif $game_variables[@prog][4] == 3  #PURPLE DESERT        
  col1 = "Pur"   
  end        
  #head
  if $game_variables[@prog][5] == 5  #Blonde HAIR, NPC only 
	 $game_map.screen.pictures[117].show("DesHShoBlo", pos, xp, yp, px, py, 255, 0)
	 else      
	 hair = "DesH" + hairS + hcol
	 $game_map.screen.pictures[117].show(hair, pos, xp, yp, px, py, 255, 0)
	 if hairS == "Wil"
	   hairB = hair + "b"
	   $game_map.screen.pictures[113].show(hairB, pos, xp, yp, px, py, 255, 0)
	 end  
  end   
   if $game_variables[@prog][6] == 2
	  tail = "DesTGoa" + col2
	 $game_map.screen.pictures[112].show(tail, pos, xp, yp, px, py, 255, 0)
   end    
   dress =  basedre + bod + cost 
	  $game_map.screen.pictures[116].show(dress, pos, xp, yp, px, py, 255, 0)
  if cost != ""
	cost = "n"
  end             
  if $game_variables[@prog][3] >= 3
   body = base + bod + col1 + col2 + cost
   else
   body = base + bod + col1 + cost
  end
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	end
	end #end != x1
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
		 end
	   end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 65
	@c2= 45
	@c3= -30
	@c4= 20  
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####     
	   return
	 end    
  #--------------------
  if $game_variables[@prog][0] == 8
   #FIX#
  if $game_variables[@prog][3] >= 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#   
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #scary
		$game_variables[2051] = 4    
	  end  
	   if $game_variables[4000][2] == 5
		  #silent
		$game_variables[2051] = 5    
	  end      
	end    
		xp = -158
		yp = 88
  if $game_variables[@prog][19] == 2
		  xp += 120
		  yp += 20      
  end          
		  if $game_variables[@prog][3] == 3
			xp = -134
			yp = 106
    end    
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 57
		  yp = 24
		  if $game_variables[@prog][3] == 3
		  xp = 81
		  yp = 42
		  end  
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70
		  xp = 300
		  yp = 345
		  if $game_variables[@prog][19] == 2
		  xp += 125
		  yp += 30     
		  end             
		end 
	   if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = -5
		  yp = 140
		  if $game_variables[@prog][3] == 3
		  xp = 15
		  yp = 175
		  end  
		end  
		  if $game_switches[3529] == true
  xp = 208 #port center without ADV menu check
		  yp = 257
		  px = 50
		  py = 50   
		end   
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  col = ""
  leg = ""
  exp = ""
  expS = ""
  expF = ""
  col1 = ""
  head = ""
  hairS = ""
  basedre = "GhoDre"
  base = "GhoBod"   
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -156
		yp = -37
    px = 100
	  py = 100    
  end      
	if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
	xadd = -1 * px
	yadd = -0.8 * py
	  else
	xadd = 0.3 * px
	yadd = -1 * py
	   end    
	xp += xadd
	yp += yadd 
	$game_map.screen.pictures[111].show("GhostPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Scary"
	elsif $game_variables[2051] == 5
	  expS = "Silent"    
	 end           
	expr = "GhostPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)     
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
		else         
  ### EXP ###        
  if $game_variables[@prog][6] == 0
	expS = ""
  elsif  $game_variables[@prog][6] == 1
	expS = "H"
  elsif  $game_variables[@prog][6] == 2
	expS = "T"
  elsif  $game_variables[@prog][6] == 3
	expS = "E"
  end  
   if $game_variables[2051] == 0 
	  expF = "Std"
	elsif $game_variables[2051] == 1 
	  expF = "Sad"    
		elsif $game_variables[2051] == 2 
	  expF = "Rage"        
		elsif $game_variables[2051] == 3 
	  expF = "Love"        
		elsif $game_variables[2051] == 4 
	  expF = "Sca"        
		elsif $game_variables[2051] == 5
	  expF = "Sil"        
  end 
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expF = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20
    expF = "Yan"    
  elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expF = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expF = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expF = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expF = "Nemu"
  end             
	exp = "GhoExp" + expS + expF
  if @ski == "Spooky" 
     exp = "GhoExpSpoop"  
  end      
  $game_map.screen.pictures[115].show(exp, pos, xp, yp, px, py, 255, 0)
  ####
		if $game_variables[@prog][11] == 1 
		  $game_map.screen.pictures[116].show("GhoFire", pos, xp, yp, px, py, 255, 0)
		end
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[111].show("GhoCrown", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"  
	 yd = 0.50 * py
	 ybun = yp - yd
	 $game_map.screen.pictures[119].show("GhoBunnyEars", pos, xp, ybun, px, py, 255, 0)   
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
	 $game_map.screen.pictures[119].show("GhoEyeCover", pos, xp, yp, px, py, 255, 0)      
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 #jiangshe
	 cost = "x2"
	 $game_map.screen.pictures[119].show("GhoX2Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #hex 
   if $game_variables[@prog][1] == 0 # fem only  
	 cost = "x1"
	 $game_map.screen.pictures[111].show("Ghox1back", pos, xp, yp, px, py, 255, 0)
   end  
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[119].show("GhoH20Mask", pos, xp, yp, px, py, 255, 0) 
	 if $game_variables[@prog][3] == 3
	 $game_map.screen.pictures[111].show("GhoH20WingsM", pos, xp, yp, px, py, 255, 0)  
	 else
	 $game_map.screen.pictures[111].show("GhoH20Wings", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 if $game_variables[@prog][3] == 3
	 $game_map.screen.pictures[116].show("GhoSnowL", pos, xp, yp, px, py, 255, 0)  
	 else
	 $game_map.screen.pictures[116].show("GhoSnowS", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[119].show("GhoF20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"    
	 $game_map.screen.pictures[119].show("GhoX5Mask", pos, xp, yp, px, py, 255, 0)
  end   
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	  cost = "Chu"   
   end    
  end
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "StdF"        
		  elsif $game_variables[@prog][3] == 1
		  bod = "BanF"
		  elsif $game_variables[@prog][3] == 2
		  bod = "Cur"
		  elsif $game_variables[@prog][3] == 3
		  bod = "Mega"
		  elsif $game_variables[@prog][3] == 4
		  bod = "StdM"        
		  elsif $game_variables[@prog][3] == 5
		  bod = "BanM"
		end      
		 if $game_variables[@prog][5] == 0
			 leg = "l"
		 else
			 leg = "f"
		   end
	   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   if $game_variables[@prog][3] == 3
		   bod = "ChuMega"
	   else
		   bod = "Chu"
	   end       
		 leg = ""
	   end       
  ### GHO COLOUR ###     
  if $game_variables[@prog][4] == 0 #BW GHOST     
  col = "B"   
  elsif $game_variables[@prog][4] == 1 #GREY GHOST       
  col = "G"
  elsif $game_variables[@prog][4] == 2 #PURPLE GHOST 
  col = "P"  
  elsif $game_variables[@prog][4] == 3 #PINK GHOST       
  col = "Pi"
  elsif $game_variables[@prog][4] == 4 #TRANSP GHOST       
  col = "T"
end
  ### HEAD ###
 # alt col?
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col      
	hcol = col
  else
	if $game_variables[@prog][27] == 1  #BW GHOST
  hcol = "B"     
  elsif $game_variables[@prog][27] == 2  #GREY GHOST
  hcol = "G"       
  elsif $game_variables[@prog][27] == 3  #PURPLE GHOST 
  hcol = "P"   
  elsif $game_variables[@prog][27] == 4  #PINK GHOST 
  hcol = "Pi"    
  elsif $game_variables[@prog][27] == 5  #TRANSP GHOST 
  hcol = "T"  
  elsif $game_variables[@prog][27] == 6 #SPECIAL HAIR
  hcol = "Spe"  
  end
end 
 # alt col END?
  if $game_switches[4018] == true || $game_variables[@prog][17] == 18 #hex
  head = "GhoH" + "x1" + hcol  
else
  # Hairstyles 
	if $game_variables[@prog][26] == 0 
  if $game_variables[@prog][7] == 0
	hairS = "BoB"
  elsif $game_variables[@prog][7] == 1
	hairS = "Lon"
  elsif $game_variables[@prog][7] == 2
	hairS = "Flo"
  elsif $game_variables[@prog][7] == 3
	hairS = "Fli"
  elsif $game_variables[@prog][7] == 4
	hairS = "Pon"
  elsif $game_variables[@prog][7] == 5
	hairS = "Vlo"
  end   
   else
	if $game_variables[@prog][26] == 1
	   hairS = "Bra"
  elsif $game_variables[@prog][26] == 2
	   hairS = "Bun"   
  elsif $game_variables[@prog][26] == 3
	   hairS = "DBa"   
  elsif $game_variables[@prog][26] == 4
	   hairS = "Dri"   
  elsif $game_variables[@prog][26] == 5
	   hairS = "Scr"   
	 end 
   end     
  head = "GhoH" + hairS + hcol
  end
  $game_map.screen.pictures[114].show(head, pos, xp, yp, px, py, 255, 0)
  ### DRESS ###
	  dress =  basedre + bod + cost 
	  $game_map.screen.pictures[113].show(dress, pos, xp, yp, px, py, 255, 0)
  if cost != ""
	cost = "n"
  end      
  if $game_variables[@prog][3] == 3
  body = base + bod + col + cost
  else
  body = base + bod + col + leg + cost
  end
	  $game_map.screen.pictures[112].show(body, pos, xp, yp, px, py, 255, 0)
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 95
	@c2= 25
	@c3= -35
	@c4= 30  
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
	 end
  #-------------------------------------   
  if $game_variables[@prog][0] == 9
	 #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#       
   if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #aroused
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #shocked/worried
		$game_variables[2051] = 4    
	  end  
	end    
	   if $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 4
		  xp = 34
		  yp = 125
		  else
		xp = 23
		yp = 99 
	  end
  if $game_variables[@prog][19] == 2
		  xp += 60
		  yp += 20      
    end       
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 253
		  yp = 90
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 0
		  yp += 25      
  end             
	  end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 90
		  yp = 175
		if $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 4        
		  yp += 20
		end  
	  end    
		if $game_switches[3529] == true
  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = "C"
  col = "G"
  col2 = "G"
  horn = ""
  hornS = ""
  ear = ""
  earS = "Gob"
  hair = ""
  hairS = "Lon"
  basedre = "GobDre"
  base = "GobBod"  
  expBase = "GobExp"
  expS = ""
  expE = "Std"
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -74
		yp = 120
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("GoblinPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Jealous"
	 end           
	expr = "GoblinPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0) 
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
	  else
	 #EXPRESSIONS#
  if $game_variables[@prog][12] == 0      
	expS = ""
  elsif $game_variables[@prog][12] == 1 
	  expS = "F"
  elsif $game_variables[@prog][12] == 2
	expS = "S"
  end  
  if $game_variables[2051] == 0 
	  expE = "Std"
  elsif $game_variables[2051] == 1 
	  expE = "Sad"
  elsif $game_variables[2051] == 2 
	  expE = "Rage"
  elsif $game_variables[2051] == 3 
	  expE = "Love"
  elsif $game_variables[2051] == 4 
	  expE = "Jeal"
  end
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
exp = expBase + expE + expS
  if @ski == "Spooky" 
     exp = "GobExpSpoop"  
  end     
$game_map.screen.pictures[118].show(exp, pos, xp, yp, px, py, 255, 0)
   #COSTUMES#
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1 
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[111].show("GobCrown", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[119].show("GobMaidBonnet", pos, xp, yp, px, py, 255, 0)    
	 elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
	 elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
	 elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
	 elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"  
	 $game_map.screen.pictures[119].show("GobCarrot", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
	 $game_map.screen.pictures[119].show("GobCourtGlasses", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
	 elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[119].show("GobH20Mask", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[119].show("GobC20Mask", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[119].show("GobF20Mask", pos, xp, yp, px, py, 255, 0)  
	 elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #x0 - Goth
	 cost = "x0"    
	 elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #x1 - AltSS
	 cost = "x1"           
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #x2 - AltC20
	 cost = "x2"           
   $game_map.screen.pictures[119].show("GobX2Mask", pos, xp, yp, px, py, 255, 0)  
   elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21 #floatie
	 cost = "x4"   
	 elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22
	 cost = "x5"       
	 end
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 if cost != "x4"
	   cost = "Chu"
	 end
   end 
  end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "C"        
		elsif $game_variables[@prog][3] == 1
		  bod = "S"
		elsif $game_variables[@prog][3] == 2
		  bod = "BugF"
		elsif $game_variables[@prog][3] == 3
		  bod = "T"
		elsif $game_variables[@prog][3] == 4
		  bod = "BugM"
		end
	   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   if $game_variables[@prog][3] == 2
       bod = "ChuBug"
	   else
       bod = "Chu"
	   end       
	   end         
		if $game_variables[@prog][11] == 3
		  $game_map.screen.pictures[111].show("GobMusk", pos, xp, yp, px, py, 255, 0)
		end         
	if $game_variables[@prog][7] >= 5       
			$game_variables[@prog][7] = rand(4)
		  end      
  ### Colour #1 #2        
  if $game_variables[@prog][4] == 0 #GREEN GOBLIN        
  col = "G"
  elsif $game_variables[@prog][4] == 1 #BROWN GOBLIN  
  col = "B"
  elsif $game_variables[@prog][4] == 2 #PURPLE GOBLIN
  col = "P"
  elsif $game_variables[@prog][4] == 3 #BLUE GOBLIN 
  col = "W"
end
#----------------------------------------#
if $game_variables[@prog][5] == 4 #HAIRFIX
  $game_variables[@prog][5] = 0
end  
#----------------------------------------#
  if $game_variables[@prog][5] == 0 #GREEN GOBLIN        
  col2 = "G"
  elsif $game_variables[@prog][5] == 1 #BROWN GOBLIN  
  col2 = "B"
  elsif $game_variables[@prog][5] == 2 #PURPLE GOBLIN
  col2 = "P"
  elsif $game_variables[@prog][5] == 3 #BLUE GOBLIN 
  col2 = "W"
  end
  # alt col?
	 nospeH = 0
   if $game_variables[@prog][27] == 5 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col    
	hcol = col2
  else
	if $game_variables[@prog][27] == 1  #GREEN HAIR
  hcol = "G"     
  elsif $game_variables[@prog][27] == 2  #BROWN HAIR
  hcol = "B"       
  elsif $game_variables[@prog][27] == 3  #PURPLE HAIR
  hcol = "P"   
  elsif $game_variables[@prog][27] == 4  #WHITE HAIR
  hcol = "W"    
  elsif $game_variables[@prog][27] == 5  #SPECIAL HAIR
  hcol = "Spe"  
  end
  end
  #HAIR revert      
	if $game_variables[@prog][26] >= 7
	  $game_variables[@prog][26] = 0
	end        
  ### HORNS  
  if $game_variables[@prog][11] == 1
	 horn = "GobHN" + col
	 $game_map.screen.pictures[117].show(horn, pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][11] == 2
	  $game_map.screen.pictures[117].show("GobHOni", pos, xp, yp, px, py, 255, 0)
	  $game_map.screen.pictures[114].show("GobHOniB", pos, xp, yp, px, py, 255, 0)
	end  
  ### HAIR
  # Hairstyles 
	if $game_variables[@prog][26] == 0 
  if $game_variables[@prog][7] == 0
	   hairS = "Lon"
  elsif $game_variables[@prog][7] == 1
	   hairS = "Bra"
  elsif $game_variables[@prog][7] == 2
	   hairS = "Twi"
  elsif $game_variables[@prog][7] == 3
	   hairS = "Bob"
  elsif $game_variables[@prog][7] == 4
	   hairS = "Bug"
		end        
   else
	if $game_variables[@prog][26] == 1
	   hairS = "Mov"
  elsif $game_variables[@prog][26] == 2
	   hairS = "Twi2"   
  elsif $game_variables[@prog][26] == 3
	   hairS = "Pon"   
  elsif $game_variables[@prog][26] == 4
	   hairS = "Spi"   
  elsif $game_variables[@prog][26] == 5
	   hairS = "Bow"   
  elsif $game_variables[@prog][26] == 6
	   hairS = "Bob2"   
	 end 
   end     
	hair = "GobH" + hairS + hcol
	$game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0)
  ### EARS
   if $game_variables[@prog][6] == 0 || $game_variables[@prog][6] == 1
		earS = "Gob"
  elsif $game_variables[@prog][6] == 2 || $game_variables[@prog][6] == 3
		earS = "Gre"
  elsif $game_variables[@prog][6] == 4 || $game_variables[@prog][6] == 5
		earS = "Elf"
  end    
	if $game_variables[@prog][6] == 0 || $game_variables[@prog][6] == 2 || $game_variables[@prog][6] == 4
	  ear = "GobE" + earS + col
	else
	  ear = "GobE" + earS + col + "P"   
	end  
  $game_map.screen.pictures[116].show(ear, pos, xp, yp, px, py, 255, 0)      
  ###################        
	  dress =  basedre + bod + cost 
	  $game_map.screen.pictures[113].show(dress, pos, xp, yp, px, py, 255, 0)
  if cost != ""
	cost = "n"
  end          
		  body = base + bod + col + cost
	  $game_map.screen.pictures[112].show(body, pos, xp, yp, px, py, 255, 0)
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 25
	@c2= 95
	@c3= 25
	@c4= 30
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
	 end
  #--------------------
  if $game_variables[@prog][0] == 10
   #FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  elsif $game_variables[@prog][3] <= 2
	$game_variables[@prog][1] = 0
  end 
  #FIX#      
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #glad
		$game_variables[2051] = 4    
	  end  
	end    
		  xp = -87
		  yp = -48
  if $game_variables[@prog][19] == 2
		  xp += 0
		  yp -= 25      
    end               
    if $game_switches[3215] == true #centerhead
      pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 121
		  yp = -50
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 20
		  yp -= 10      
  end                
  end
		if $game_switches[579] == true   
		  px = 50
		  py = 50
		  xp = 25
		  yp = 85
		  if $game_variables[@prog][3] == 3
		  xp += 5
		  end
		end
		  if $game_switches[3529] == true
  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  body = ""
  base = ""
  bod = ""
  col1 = ""
  col2 = "" #also hair col
  hsty = ""
  cost = ""    
  wings = ""
  winS = ""
  anten = ""
  anS = ""
  hcol = ""
  basedre = "MotDre"
  base = "MotBod"      
  exp = ""
  expS = ""
  expE = ""
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -169
		yp = -52
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("MothPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Glad"
	 end           
	expr = "MothPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0) 
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end   
  else      
  if $game_variables[@prog][3] == 3
		  if $game_variables[@prog][5] == 0
		  $game_map.screen.pictures[114].show("MotBodLarPin", pos, xp, yp, px, py, 255, 0)
	elsif $game_variables[@prog][5] == 1
		  $game_map.screen.pictures[114].show("MotBodLarYel", pos, xp, yp, px, py, 255, 0)
	elsif $game_variables[@prog][5] == 2
		  $game_map.screen.pictures[114].show("MotBodLarWhi", pos, xp, yp, px, py, 255, 0)
	elsif $game_variables[@prog][5] == 3
		  $game_map.screen.pictures[114].show("MotBodLarBla", pos, xp, yp, px, py, 255, 0)
		end
   if $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	  $game_map.screen.pictures[115].show("MotDreLarx5", pos, xp, yp, px, py, 255, 0)
   end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	   end  
		  else
  ### EXP ###
  if $game_variables[@prog][7] == 0 && $game_variables[@prog][26] == 0
    expS = "1"
  end    
   if $game_variables[2051] == 0 
		expE = "Std"
	elsif $game_variables[2051] == 1 
		expE = "Sad"
	elsif $game_variables[2051] == 2 
		expE = "Rage"
	elsif $game_variables[2051] == 3 
		expE = "Love"
	elsif $game_variables[2051] == 4 
		expE = "Joy"
	end
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
  exp = "MothExp" + expS + expE
  if @ski == "Spooky" 
     exp = "MothExpSpoop"  
  end   
  $game_map.screen.pictures[116].show(exp, pos, xp, yp, px, py, 255, 0)
  ### EXP ###
	  cost = ""
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
   else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[112].show("MotCrown", pos, xp, yp, px, py, 255, 0)
   elsif @prog == 7425 #momo ProgNPC
	 $game_map.screen.pictures[112].show("MotCrown", pos, xp, yp, px, py, 255, 0)
	 cost = "n"
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "xm"
	 $game_map.screen.pictures[118].show("MotMaidBonnet", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 $game_map.screen.pictures[118].show("MotBunHeadF", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[112].show("MotBunHeadB", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #net
	 cost = "x0"       
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 
	 cost = "x1"
   elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 
	 cost = "x2"   
   $game_map.screen.pictures[118].show("MotX2Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"    
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[118].show("MotH20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[118].show("MotF20Mask", pos, xp, yp, px, py, 255, 0)
  end    
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 unless $game_variables[@prog][3] == 3
	 cost = "Chu"
	 end
   end  
  end
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "Std"        
  elsif $game_variables[@prog][3] == 1
		  bod = "Plu"
  elsif $game_variables[@prog][3] == 2
		  bod = "Sic"
  elsif $game_variables[@prog][3] == 3
		  bod = "Lar"
  elsif $game_variables[@prog][3] == 4
		  bod = "StdM"
		end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 unless $game_variables[@prog][3] == 3
	 bod = "Chu"
	 end
   end        
  ### SKIN COLOUR ###
	if $game_variables[@prog][4] == 0 #PINK SKIN MOTH         
	   col1 = "Pin"
  elsif $game_variables[@prog][4] == 1 #YELLOW SKIN MOTH         
	   col1 = "Yel"
  elsif $game_variables[@prog][4] == 2 #WHITE SKIN MOTH         
	   col1 = "Whi"
  elsif $game_variables[@prog][4] == 3 #GREEN SKIN MOTH         
	   col1 = "Gre"
	 end    
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end        
  ### HAIRSTYLES ###   
	if $game_variables[@prog][26] == 0 # Hairdo
	if $game_variables[@prog][7] == 0 # HAIRSTYLES
	   hsty = "Sid"
  elsif $game_variables[@prog][7] == 1
	   hsty = "Lon"
  elsif $game_variables[@prog][7] == 2
	   hsty = "Wil"
  elsif $game_variables[@prog][7] == 3
	   hsty = "Bun"
	 end 
   else
	if $game_variables[@prog][26] == 1
	   hsty = "Ban"
  elsif $game_variables[@prog][26] == 2
	   hsty = "Dol"   
  elsif $game_variables[@prog][26] == 3
	   hsty = "Flo"   
  elsif $game_variables[@prog][26] == 4
	   hsty = "Pon"   
  elsif $game_variables[@prog][26] == 5
	   hsty = "Rib"   
	 end 
   end
  ### FUR COLOUR ### 
  if $game_variables[@prog][5] == 0 #PINK FUR MOTH
  col2 = "Pin"
  elsif $game_variables[@prog][5] == 1 #YELLOW FUR MOTH
  col2 = "Yel"
  elsif $game_variables[@prog][5] == 2 #WHITE FUR MOTH
  col2 = "Whi"
  elsif $game_variables[@prog][5] == 3 #BLACK FUR MOTH
  col2 = "Bla"
  end
  ### ANTENNAE ### 
  if $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
  anten = "MotAc20"
	else
  if $game_variables[@prog][6] == 0
	 anS = "Std"
  elsif $game_variables[@prog][6] == 1
	 anS = "Thi"
  elsif $game_variables[@prog][6] == 2
	 anS = "Wid"
   end
  anten = "MotA" + anS + col2
  end
  $game_map.screen.pictures[119].show(anten, pos, xp, yp, px, py, 255, 0)
  ### WINGS ### 
  if $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	wings = "MotWc20"
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	wings = "MotWRainbow"
  else
   if $game_variables[@prog][11] == 0
	 winS = "Std"
  elsif $game_variables[@prog][11] == 1
	 winS = "Flu"
  elsif $game_variables[@prog][11] == 2
	 winS = "Haw"
  elsif $game_variables[@prog][11] == 3
	 winS = "Lun"
  elsif $game_variables[@prog][11] == 4
	 winS = "Sea"
	end     
  wings = "MotW" + winS + col2  
  end  
	$game_map.screen.pictures[111].show(wings, pos, xp, yp, px, py, 255, 0)
  ### DRESS ###
		dress =  basedre + bod + cost 
	if @prog == 7425 && $game_variables[@prog][17] != 2 #momo ProgNPC
	 dress = "MotDreStdb"
   end  
	  $game_map.screen.pictures[117].show(dress, pos, xp, yp, px, py, 255, 0)
   nospeH = 0
   if $game_variables[@prog][27] == 5 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col  
		hcol = col2 # Hairdos
	  else
		if $game_variables[@prog][27] == 1
		  hcol = "Pin"
  elsif $game_variables[@prog][27] == 2
		  hcol = "Yel"
  elsif $game_variables[@prog][27] == 3
		  hcol = "Whi"
  elsif $game_variables[@prog][27] == 4
		  hcol = "Bla"
  elsif $game_variables[@prog][27] == 5
		  hcol = "Spe"
		end        
	  end      
		hair = "MotH" + hsty + hcol
	  $game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0) 
   if $game_variables[@prog][26] == 1 #bangs back hair
	  hairb = "MotH" + hsty + hcol + "b"
	  $game_map.screen.pictures[113].show(hairb, pos, xp, yp, px, py, 255, 0)
   end
  if cost != "" && $game_variables[@prog][1] == 0
	cost = "n"
  end 
  if bod == "Chu"
	body = base + bod + col1 + col2 + cost
	elsif $game_variables[@prog][3] == 2 && cost != ""
		body = base + bod + col1 + cost
	else  
	  body = base + bod + col1 + col2 + cost
	end
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	end
	end 
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end   
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 95
	@c2= 0
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
	 end     
  #--------------------
	if $game_variables[@prog][0] == 11
   #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#        
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1 || $game_variables[4000][2] == 6
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 5
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #heat
		$game_variables[2051] = 4 
	  elsif $game_variables[4000][2] == 5
		  #heat
		$game_variables[2051] = 5
	  elsif $game_variables[4000][2] == 9
		  #heat
		$game_variables[2051] = 9
	  end       
	end 
		  xp = 21
		  yp = 119        
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 228
		  yp = 70
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70        
		  xp = 365
		  yp = 345
		end 
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 90
		  yp = 165
		  if $game_variables[@prog][19] == 2
		  xp += 0
		  yp += 10      
  end       
  end   
	if $game_switches[3529] == true
  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  armV = ""      
  cost = ""
  bod = ""
  col = ""
  arm = ""
  pickle = ""
  bd = ""
  haS = ""
  catHair = ""
  catHairB = ""
  taS = ""
  catTa = ""
  hcol = ""
  base = "CatBod"  
  exp = ""
  expE = ""
  expS = ""
  #vvv# SPECIAL NPC #vvv#
  if $game_variables[@prog][20] == "sakari"
	if inMenu == 0
	  xp = 0
	  yp = 20
	end  
	n = "Sakari"
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	  n += "N"
	end  
  if $game_variables[2051] == 0 
	  expS = "Std"
  elsif $game_variables[2051] == 1 
	  expS = "Sad"
  elsif $game_variables[2051] == 2 
	  expS = "Rage"
  elsif $game_variables[2051] == 3 
	  expS = "Love"
  elsif $game_variables[2051] == 4 
	  expS = "Catty"
  elsif $game_variables[2051] == 5 
	  expS = "Bitter"
  elsif $game_variables[2051] == 9
	  expS = "Moon"
  end       
	exp = "SakariExp" + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  #### TONES ####
if $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 55
	@c2= 0
	@c3= 0
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end   
 ####### NEXT NPC #############
  if $game_variables[@prog][20] == "plasma"
	if inMenu == 0
	  xp = 25
	  yp = 110
	end  
	n = "Plasma"
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	  n += "N"
	end  
  if $game_variables[2051] == 0 
	  expS = "Std"
  elsif $game_variables[2051] == 1 
	  expS = "Sad"
  elsif $game_variables[2051] == 2 
	  expS = "Rage"
  elsif $game_variables[2051] == 3 
	  expS = "Love"
  elsif $game_variables[2051] == 4 
	  expS = "Catty"
  elsif $game_variables[2051] == 5 
	  expS = "Bitter"
  elsif $game_variables[2051] == 9
	  expS = "Moon"
  end       
	exp = "PlasmaExp" + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  #### TONES ####
if $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 55
	@c2= 0
	@c3= 0
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end 
  #^^^# SPECIAL NPC #^^^#
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -129
		yp = 32
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("CatPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Catty"
	elsif $game_variables[2051] == 5 
	  expS = "Bitter"
	elsif $game_variables[2051] == 9 
	  expS = "Moon"    
	 end           
	expr = "CatPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)         
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
		else
  if $game_variables[2051] == 0 
		 expE = "Std"
  elsif $game_variables[2051] == 1 
		 expE = "Sad"
  elsif $game_variables[2051] == 2 
		 expE = "Rage"
  elsif $game_variables[2051] == 3 
		 expE = "Horny"
  elsif $game_variables[2051] == 4 
		 expE = "Catty"
  elsif $game_variables[2051] == 5 
		 expE = "Bitter"
  elsif $game_variables[2051] == 9
		 expE = "Moon"
   end   
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end          
    exp = "CatExp" + expE
  if @ski == "Spooky" 
     exp = "CatExpSpoop"  
  end       
  $game_map.screen.pictures[117].show(exp, pos, xp, yp, px, py, 255, 0)
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
	 if @prog == 7419 #Patron NPC - "Nekomata"
	 $game_map.screen.pictures[119].show("CatMask", pos, xp, yp, px, py, 255, 0)
	 end
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 if $game_variables[@prog][5] == 0 #HUMAN ARMS
	   armV = "HU"
	 elsif $game_variables[@prog][5] == 1 #GLOVES ARMS     
	   armV = "GL"
	 elsif $game_variables[@prog][5] == 2 #FUR ARMS     
	   armV = "FU"
	 elsif $game_variables[@prog][5] == 3 #CLAW ARMS     
	   armV = "AR"
	 end 
	 $game_map.screen.pictures[111].show("CatCrown", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3  
	 cost = "m"
	 $game_map.screen.pictures[119].show("CatMaidBonnet", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
	 if @prog != 7404 #Patron NPC - Tsukimi
	 $game_map.screen.pictures[119].show("CatMask", pos, xp, yp, px, py, 255, 0)
	 end
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 $game_map.screen.pictures[119].show("CatBunEars", pos, xp, yp, px, py, 255, 0)      
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
  elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #ankh
	 cost = "x0"
	 armV = "HU"
	 $game_map.screen.pictures[119].show("CatX0Mask", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #yarn
	 cost = "x1"
  elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 #feli
	 cost = "x2"
  elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #ian
	 cost = "x3"
	 xh = xp + (0.2 * px)
	 yh = yp - (0.2 * py)  
	 $game_map.screen.pictures[119].show("CatIanHelm", pos, xh, yh, px, py, 255, 0)
  elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21 #ronyan
	 cost = "x4"
	 xh = xp + (0.1 * px)
	 yh = yp - (0.6 * py)    
   armV = "FU"
	 $game_map.screen.pictures[119].show("CatRoninHelm", pos, xh, yh, px, py, 255, 0)   
  elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5" 
   armV = "FU"
	 $game_map.screen.pictures[119].show("Catx5Mask", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	cost = "h20"    
   if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true   
	 ypik = yp - (0.6 * py)
   else
	 ypik = yp - (1.21 * py)
   end  
	if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 3
	   bd = "SF"        
	elsif $game_variables[@prog][3] == 1
	   bd = "CF"
	elsif $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 4
	   bd = "TF"
	end
	pickle = "CatDre" + bd + "h20"    
	$game_map.screen.pictures[119].show(pickle, pos, xp, ypik, px, py, 255, 0)       
  elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	cost = "c20"  
	armV = ""
	catHair = "CatH" + cost 
  $game_map.screen.pictures[115].show(catHair, pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	cost = "f20"  
	armV = "HU"
	$game_map.screen.pictures[119].show("CatF20Mask", pos, xp, yp, px, py, 255, 0)  
  end  
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
   end   
  end
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "SF"        
  elsif $game_variables[@prog][3] == 1
		  bod = "CF"
  elsif $game_variables[@prog][3] == 2
		  bod = "TF"
  elsif $game_variables[@prog][3] == 3
		  bod = "SM"
  elsif $game_variables[@prog][3] == 4
		  bod = "TM"
		end  
		if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
		 bod = "Chu"
		end           
  if $game_variables[@prog][5] == 0 #HUMAN ARMS
   arm = "HU"
  elsif $game_variables[@prog][5] == 1 #GLOVES ARMS     
   arm = "GL"
  elsif $game_variables[@prog][5] == 2 #FUR ARMS     
   arm = "FU"
  elsif $game_variables[@prog][5] == 3 #CLAW ARMS     
   arm = "AR"
  end 
  # Costumes with def arms
  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub
	arm = "AR"
	armV = "AR"
  elsif cost == "x3" || cost == "m" || cost == "b" || cost == "s" || cost == "u" || cost == "x1" || cost == "x2" || cost == "p"
	arm = "AR"
	armV = ""
  elsif cost == "q" || cost == "h20"
	arm = "HU"
	armV = ""
  elsif cost == "x0" || cost == "f20"
	arm = "HU"
	armV = "HU" 
  end  
  #CAT COLOR
  if $game_variables[@prog][4] == 0 #PINK CAT
  col = "P"
  elsif $game_variables[@prog][4] == 1 #BLACK CAT
  col = "B"
  elsif $game_variables[@prog][4] == 2 #YELLOW CAT
  col = "Y"
  elsif $game_variables[@prog][4] == 3 #WHITE CAT
  col = "W"
  end
  # alt col?
   nospeH = 0
   if $game_variables[@prog][27] == 5 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col      
	hcol = col
  else
	if $game_variables[@prog][27] == 1  #PINK HAIR
  hcol = "P"     
  elsif $game_variables[@prog][27] == 2  #BLACK HAIR
  hcol = "B"       
  elsif $game_variables[@prog][27] == 3  #YELLOW HAIR
  hcol = "Y"   
  elsif $game_variables[@prog][27] == 4  #WHITE HAIR
  hcol = "W"    
  elsif $game_variables[@prog][27] == 5  #SPECIAL HAIR
  hcol = "Spe"  
  end
  end
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end        
  #HAIR    
  # CAT HEAD
  if $game_switches[4015] == false && $game_variables[@prog][17] != 15 #no chill 2020
  if $game_variables[@prog][26] == 0     
	   if $game_variables[@prog][7] == 0
	   haS = "Bob"
  elsif $game_variables[@prog][7] == 1
	   haS = "Sid"
  elsif $game_variables[@prog][7] == 2
	   haS = "Spi"
  elsif $game_variables[@prog][7] == 3
	   haS = "Cur"
  elsif $game_variables[@prog][7] == 4
	   haS = "Him"
	 end
  else
	if $game_variables[@prog][26] == 1  #PINK HAIR
  haS = "Pon"     
  elsif $game_variables[@prog][26] == 2  #BLACK HAIR
  haS = "Spi2"       
  elsif $game_variables[@prog][26] == 3  #YELLOW HAIR
  haS = "Flu"   
  elsif $game_variables[@prog][26] == 4  #WHITE HAIR
  haS = "Egy"    
  elsif $game_variables[@prog][26] == 5  #SPECIAL HAIR
  haS = "Lic"  
  end
  end  
  catHair = "CatH" + haS + hcol 
  if haS == "Lic"  
	catHairB = catHair + "b"
	catHair += "f"
   $game_map.screen.pictures[115].show(catHair, pos, xp, yp, px, py, 255, 0)    
   $game_map.screen.pictures[112].show(catHairB, pos, xp, yp, px, py, 255, 0)    
  else  
  $game_map.screen.pictures[115].show(catHair, pos, xp, yp, px, py, 255, 0)    
  end
  end
  # CAT TAIL
  if cost != "b" && cost != "h20" && cost != "c20"
   if $game_variables[@prog][6] == 0
	  taS = "S"
  elsif $game_variables[@prog][6] == 1
	  taS = "D"
  elsif $game_variables[@prog][6] == 2
	  taS = "H"
	end  
	catTa = "CatTa" + taS + col
  $game_map.screen.pictures[113].show(catTa, pos, xp, yp, px, py, 255, 0)  
  end  
  ###
	if $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 5
	   $game_map.screen.pictures[116].show("CatET", pos, xp, yp, px, py, 255, 0)
	end
  ###      
	if cost != "h20"
	  dress = "CatDre" + armV + bod + cost    
	  $game_map.screen.pictures[118].show(dress, pos, xp, yp, px, py, 255, 0)
	end
	if cost != ""
	  cost = "n"
	end  
	  body = base + arm + bod + col + cost
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 55
	@c2= 0
	@c3= 0
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
	 end   
  #-------------------- 
  if $game_variables[@prog][0] == 12
   #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#    
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #mad        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #yan
		$game_variables[2051] = 4    
	  end  
	end  
		if $game_variables[@prog][3] == 2
		  xp = -16
		  yp = 110  
		else
		  xp = -10
		  yp = 92
		end  
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 208
		  yp = 60
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70      
		  xp = 375
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp += 20
		  yp += 15      
  end           
		end
		if $game_switches[579] == true   #status screen
		  xp = 70
		  yp = 110
		end 
		  if $game_switches[3529] == true
  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  col = ""
  exppic = ""
  hcol = ""
  basedre = "DogDre"
  base = "DogBod"    
  exp = ""
  expS = ""
  expE = ""
  #vvv# SPECIAL NPC #vvv#
  if $game_variables[@prog][20] == "seji"
	if inMenu == 0
	  xp = -30
	  yp = -60
	end  
  if $game_switches[2359] == true || $game_switches[2466] == true
	  pos = 1
    xp = 400
	  yp = 250
	end
	n = "Seji"
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	  n += "N"
	end  
	if $game_variables[2051] == 0 
    @rExp = rand(2)
    if @rExp < 1
      expS = "Std"
    else
      expS = "Std2"
    end  
	   elsif $game_variables[2051] == 1 
    expS = "Sad"
	   elsif $game_variables[2051] == 2 
    expS = "Rage"
	   elsif $game_variables[2051] == 3 
    expS = "Love"
	   elsif $game_variables[2051] == 4 
    expS = "Yan"
  end   
	exp = "SejiExp" + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
   #### TONES ####
if $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= -30
	@c2= 65
	@c3= 45
	@c4= 20  
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end     
 ######### NEXT NPC #############  
  if $game_variables[@prog][20] == "rouge"
	if inMenu == 0
	  xp = -10
	  yp = 75
	end  
  if $game_switches[2359] == true || $game_switches[2466] == true
	  pos = 1
    xp = 400
	  yp = 250
	end
	n = "Rouge"
	if $game_variables[@prog][17] == 2 || nkdCheat == 1
	  n += "N"
	end  
	if $game_variables[2051] == 0 
    expS = "Std"
	   elsif $game_variables[2051] == 1 
    expS = "Sad"
	   elsif $game_variables[2051] == 2 
    expS = "Rage"
	   elsif $game_variables[2051] == 3 
    expS = "Love"
	   elsif $game_variables[2051] == 4 
    expS = "Yan"
  end   
	exp = "RougeExp" + expS    
		$game_map.screen.pictures[111].show(n, pos, xp, yp, px, py, 255, 0)
		$game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0
	   if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
   #### TONES ####
if $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= -30
	@c2= 65
	@c3= 45
	@c4= 20  
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####   
	 return
 end      
  #^^^# SPECIAL NPC #^^^#   
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -134
		yp = 52
  end    
  bod = "DogPbodShade"
  exp = "DogPExp"  
	if $game_variables[2051] == 0 
    exp += "Std"
	   elsif $game_variables[2051] == 1 
    exp += "Sad"
	   elsif $game_variables[2051] == 2 
    exp += "Rage"
	   elsif $game_variables[2051] == 3 
    exp += "Love"
	   elsif $game_variables[2051] == 4 
    exp += "Yan"  
  end    
  $game_map.screen.pictures[111].show(bod, pos, xp, yp, px, py, 255, 0)
  $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)      
		  if inMenu == 0 
			$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
			return 
			end  
		else            
	 if $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 exppic = 119
   else
	 exppic = 118
  end        
   ###EXP###
  if $game_variables[@prog][12] == 0      
   expS = ""
	elsif $game_variables[@prog][12] == 1      
   expS = "W"
	elsif $game_variables[@prog][12] == 2     
   expS = "M"
  end    
	 if $game_variables[2051] == 0 
		  expE = "Std"
    elsif $game_variables[2051] == 1 
		  expE = "Sad"
    elsif $game_variables[2051] == 2 
		  expE = "Rage"
    elsif $game_variables[2051] == 3 
		  expE = "Love"
    elsif $game_variables[2051] == 4 
		  expE = "Yan"
    end  
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end             
      exp = "DogExp" + expE + expS
  if @ski == "Spooky" 
     exp = "DogExpSpoop"  
   end    
   $game_map.screen.pictures[exppic].show(exp, pos, xp, yp, px, py, 255, 0)
  ###EXP###
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1 
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1  
	 cost = "d"
	 $game_map.screen.pictures[111].show("DogCrown", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3  
	 cost = "m"
	 $game_map.screen.pictures[119].show("DogMaidBonnet", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
	 $game_map.screen.pictures[119].show("DogPriMask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"   
	 yd = 0.32 * py
	 ybun = yp - yd
	 if @prog != 7400 # Patron NPC - Polt
	 $game_map.screen.pictures[119].show("DogBunnyEars", pos, xp, ybun, px, py, 255, 0)   
	 end
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #wardog
	 cost = "x0"
	 $game_map.screen.pictures[119].show("DogX0Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #momiji
	 cost = "x1"
	 $game_map.screen.pictures[111].show("DogX1HB", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[119].show("DogX1HF", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 #amaterasu
	 xd = 0.2 * py
	 xmir = xp - xd   
	 $game_map.screen.pictures[111].show("DogMirror", pos, xmir, yp, px, py, 255, 0)
	 cost = "O"
   elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #red riding
	 $game_map.screen.pictures[111].show("DogHx2b", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[119].show("DogHx2", pos, xp, yp, px, py, 255, 0)
	 cost = "x2"
   elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21 #squirt
		if $game_variables[@prog][3] == 0
		  flS = "YF"        
		elsif $game_variables[@prog][3] == 1
		  flS = "FW"
		elsif $game_variables[@prog][3] == 2
		  flS = "FS"
		else
		  flS = "FS"
		end      
   flower = "DogX3Back" + flS
	 $game_map.screen.pictures[111].show(flower, pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[119].show("DogHx3", pos, xp, yp, px, py, 255, 0)
	 cost = "x3"   
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5" 
	 $game_map.screen.pictures[119].show("Dogx5Mask", pos, xp, yp, px, py, 255, 0) 
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 if $game_variables[@prog][4] == 0 || $game_variables[@prog][4] == 2 #ROTT DOG       
	  $game_map.screen.pictures[119].show("DogH20MaskB", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][4] == 1 #SHIZUNE DOG       
	  $game_map.screen.pictures[119].show("DogH20MaskS", pos, xp, yp, px, py, 255, 0)   
  elsif $game_variables[@prog][4] == 3 #WOLF DOG       
	  $game_map.screen.pictures[119].show("DogH20MaskW", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][4] == 4 #STANDARD YAN DOG       
	  $game_map.screen.pictures[119].show("DogH20MaskY", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 if $game_variables[@prog][1] == 1 || $game_variables[@prog][28] == 1 #male or chub -> flames only
	 $game_map.screen.pictures[111].show("DogFlameB", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[119].show("DogFlameF", pos, xp, yp, px, py, 255, 0)     
	 end  
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"  
		if $game_variables[@prog][3] == 0
		  flS = "YF"        
		elsif $game_variables[@prog][3] == 1
		  flS = "FW"
		elsif $game_variables[@prog][3] == 2
		  flS = "FS"
		else
		  flS = "FS"
		end   
	 flower = "DogF20Mask" + flS
	 $game_map.screen.pictures[118].show(flower, pos, xp, yp, px, py, 255, 0)     
  end     
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 cost = "Chu"
   end        
  end
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
  if $game_variables[@prog][3] >= 3 #safe
    bod = "MM"
  else
    bod = "YF" 
  end  
		if $game_variables[@prog][3] == 0
		  bod = "YF"        
		elsif $game_variables[@prog][3] == 1
		  bod = "FW"
		elsif $game_variables[@prog][3] == 2
		  bod = "FS"
		elsif $game_variables[@prog][3] == 3
		  bod = "MW"
		elsif $game_variables[@prog][3] == 4
		  bod = "MM"
		end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 if $game_variables[@prog][3] == 2
	 bod = "Chu2"  
	   else
	 bod = "Chu1"
	 end
   end          
  #BEAST CHOKER 
  if $game_variables[@prog][56] == 1
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	cuffs = "DogCuffsChu" 
	  else
	cuffs = "DogCuffs" + bod
	end
	$game_map.screen.pictures[120].show(cuffs, pos, xp, yp, px, py, 255, 0)
  end
  ###################
  if $game_variables[@prog][4] == 0 #ROTT DOG       
  col = "R"
  elsif $game_variables[@prog][4] == 1 #SHIZUNE DOG       
  col = "S"       
  elsif $game_variables[@prog][4] == 2 #BERNESE DOG       
  col = "B"
  elsif $game_variables[@prog][4] == 3 #WOLF DOG       
  col = "W"
  elsif $game_variables[@prog][4] == 4 #STANDARD YAN DOG       
  col = "Y"
  end
  ##################
  if bod != "Chu2" && bod != "Chu1"
  if cost == "O" || cost == "c20" #amaterasu/chill20
  col = cost  
  cost = ""
  end
  end
  ##################   
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col   #no cust hcol 
   hcol = col 
  else
	if $game_variables[@prog][27] == 1 #ROTT DOG       
	hcol = "R"
	elsif $game_variables[@prog][27] == 2 #SHIZUNE DOG       
	hcol = "S"       
	elsif $game_variables[@prog][27] == 3 #BERNESE DOG       
	hcol = "B"
	elsif $game_variables[@prog][27] == 4 #WOLF DOG       
	hcol = "W"
	elsif $game_variables[@prog][27] == 5 #STANDARD YAN DOG       
	hcol = "Y"
	elsif $game_variables[@prog][27] == 6 #STANDARD YAN DOG       
	hcol = "Spe"
	end
  end      
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end        
  #HAIR    
  ##################      
  if $game_variables[@prog][26] == 0 || cost == "O" || cost == "c20" #no cust hs  
	if $game_variables[@prog][7] == 0
	  headS = "F"
	elsif $game_variables[@prog][7] == 1
	  headS = "H"
	elsif $game_variables[@prog][7] == 2
	  headS = "W"
	elsif $game_variables[@prog][7] == 3
	  headS = "S"
	end
  else
	if $game_variables[@prog][26] == 1
	  headS = "Afr"
	elsif $game_variables[@prog][26] == 2
	  headS = "Ban"
	elsif $game_variables[@prog][26] == 3
	  headS = "Poo"
	elsif $game_variables[@prog][26] == 4
	  headS = "Rib"
	elsif $game_variables[@prog][26] == 5
	  headS = "Shi"
	end  
  end  
  hair = "DogH" + headS + hcol
  $game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0)
  #####################
		  if $game_variables[@prog][6] == 0
		  $game_map.screen.pictures[116].show("DogEDrop" + col, pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][6] == 1
		  $game_map.screen.pictures[116].show("DogEFold" + col, pos, xp, yp, px, py, 255, 0)
		  $game_map.screen.pictures[113].show("DogEFoldB" + col, pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][6] == 2
		  $game_map.screen.pictures[116].show("DogERose" + col, pos, xp, yp, px, py, 255, 0)
		  $game_map.screen.pictures[113].show("DogERoseB" + col, pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][6] == 3
		  $game_map.screen.pictures[116].show("DogEShort" + col, pos, xp, yp, px, py, 255, 0)
		  $game_map.screen.pictures[113].show("DogEShortB" + col, pos, xp, yp, px, py, 255, 0)
		end
  ##################      
		  if $game_variables[@prog][5] == 0
		  $game_map.screen.pictures[112].show("DogTF" + col, pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][5] == 1
		  $game_map.screen.pictures[112].show("DogTH" + col, pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][5] == 2
		  $game_map.screen.pictures[112].show("DogTS" + col, pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][5] >= 3
		  $game_map.screen.pictures[112].show("DogTW" + col, pos, xp, yp, px, py, 255, 0)
		end
  ##################      
	  dress =  basedre + bod + cost
	  $game_map.screen.pictures[117].show(dress, pos, xp, yp, px, py, 255, 0)
  if cost != ""
	cost = "n"
  end         
		 body = base + bod + col + cost
		 $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
		 end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end   
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 65
	@c2= 35
	@c3= 35
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end 
  #--------------------
  if $game_variables[@prog][0] == 13
  #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#      
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1 || $game_variables[4000][2] == 6
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2 || $game_variables[4000][2] == 5
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #scared
		$game_variables[2051] = 4    
	  end  
	end    
		xp = 36
		yp = 100
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 261
		  yp = 34
		end
		if $game_switches[2411] == true
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345
  if $game_variables[@prog][19] == 2
		  xp -= 10
		  yp -= 10      
  end           
  end
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 85
		  yp = 160   
		end        
	if $game_switches[3529] == true
  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end         
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  col = ""
  ears = ""
  earsB = ""
  eaS = ""
  hair = ""
  haS = ""
  hcol = ""
  hairB = ""
  basedre = "MouDre"
  base = "MouBod"   
   #iif $game_variables[@prog][1] == 0
  if $game_switches[4023] == true || $game_variables[@prog][17] == 23
	if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
      xp -= 0.15 * px
		  yp -= 0.60 * px
      xd = +0.30 * px
		  yd = +0.35 * px
		else
		  xp += 210
		  yp -= 10
		  xd = -2.46 * px
		  yd = -1.2 * px         
	  end    
		  xb = xp + xd
		  yb = yp + yd     
   end
   if $game_switches[4006] == true || $game_variables[@prog][17] == 6 || $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020 #head/exp place for battlesuit
	 yp -= 20
	if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
		  xd = +0.03 * px
		  yd = +0.575 * px
		else
		  xp += 14
		  yp -= 24
		  xd = -0.59 * px
		  yd = +0.43 * px        
	  end    
		  xb = xp + xd
		  yb = yp + yd 
	  unless $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
		  xd = 0 * px
		  yd = -0.085 * px 
		  xp += xd
		  yp += yd
	  end             
	 end  
   #end    
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -139
		yp = 88
  end    
  bod = "MousePbodShade"
  exp = "MousePExp"  
	if $game_variables[2051] == 0 
    exp += "Std"
	   elsif $game_variables[2051] == 1 
    exp += "Sad"
	   elsif $game_variables[2051] == 2 
    exp += "Rage"
	   elsif $game_variables[2051] == 3 
    exp += "Love"
	   elsif $game_variables[2051] == 4 
    exp += "Scared"  
  end    
  $game_map.screen.pictures[111].show(bod, pos, xp, yp, px, py, 255, 0)
  $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)    
		  if inMenu == 0 
			$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
			return 
			end        
		else                
  ###EXP###
    if $game_switches[4005] == true || $game_variables[@prog][17] == 5
      expS = "G"
    elsif $game_variables[@prog][13] == 0 
      expS = ""
    else
      expS = "T"
    end  
    expE = "Std"
  	if $game_variables[2051] == 0 
		  expE = "Std"
		elsif $game_variables[2051] == 1 
		  expE = "Sad"
		elsif $game_variables[2051] == 2 
		  expE = "Rage"
		elsif $game_variables[2051] == 3 
		  expE = "Love"
		elsif $game_variables[2051] == 4 
		  expE = "Sca"
		end
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end         
  exp = "MouExp" + expS + expE
  if @ski == "Spooky" 
     exp = "MouExpSpoop"  
  end
   $game_map.screen.pictures[117].show(exp, pos, xp, yp, px, py, 255, 0)
  ###EXP### 
  if $game_switches[4006] == false && $game_variables[@prog][17] != 6     
		  if $game_variables[@prog][5] == 0
		  $game_map.screen.pictures[111].show("MouTStd", pos, xp, yp, px, py, 255, 0)
		elsif $game_variables[@prog][5] == 1
		  $game_map.screen.pictures[111].show("MouTHea", pos, xp, yp, px, py, 255, 0)
		elsif $game_variables[@prog][5] == 2
		  $game_map.screen.pictures[111].show("MouTFur", pos, xp, yp, px, py, 255, 0)
		end
  end      
		  if $game_variables[@prog][12] == 1
		  $game_map.screen.pictures[120].show("MouAccGla", pos, xp, yp, px, py, 255, 0)
		elsif $game_variables[@prog][12] == 2
		  $game_map.screen.pictures[120].show("MouAccGog", pos, xp, yp, px, py, 255, 0)
		end    
  if $game_switches[4006] == false && $game_variables[@prog][17] != 6 && $game_switches[4015] == false && $game_variables[@prog][17] != 15
		  if $game_variables[@prog][12] == 3
		  $game_map.screen.pictures[120].show("MouAccArm", pos, xp, yp, px, py, 255, 0)
		end    
	  end
	  cost = ""
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 if $game_variables[@prog][7] == 1
	 $game_map.screen.pictures[119].show("MouAfroHat", pos, xp, yp, px, py, 255, 0)
  else
	 $game_map.screen.pictures[119].show("MouHat", pos, xp, yp, px, py, 255, 0)
   end
  end   
   if $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[119].show("MouseMaidBonnet", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
	 $game_map.screen.pictures[119].show("MouseGag", pos, xp, yp, px, py, 255, 0)  
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6
	 cost = "b"
   if $game_variables[@prog][4] == 0 #white
   body = "MouSuitW"
  elsif $game_variables[@prog][4] == 1 #grey
   body = "MouSuitG"
  elsif $game_variables[@prog][4] == 2 #brown
   body = "MouSuitBr"
  elsif $game_variables[@prog][4] == 3 #black
   body = "MouSuitB"
  elsif $game_variables[@prog][4] == 4 #pink
   body = "MouSuitP"
  end
   $game_map.screen.pictures[119].show(body, pos, xb, yb, px, py, 255, 0)
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 $game_map.screen.pictures[119].show("MouseBunEars", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #majorette
	 cost = "x1" 
	 $game_map.screen.pictures[119].show("MouHx1", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[116].show("MouEx1", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[114].show("MouEx1Back", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 #labcoat
	 cost = "x2" 
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"    
   $game_map.screen.pictures[119].show("MouHx5", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #masuka
	 cost = "x6" 
   $game_map.screen.pictures[111].show("MouSuitX6Back", pos, xb, yb, px, py, 255, 0)
   if $game_variables[@prog][35] == 745
     suit = "MouSuitX6-00"
   elsif $game_variables[@prog][35] == 746
     suit = "MouSuitX6-01"
   elsif $game_variables[@prog][35] == 747
     suit = "MouSuitX6-02"
   else
     suit = "MouSuitX6-P"
   end  
	 $game_map.screen.pictures[119].show(suit, pos, xb, yb, px, py, 255, 0)
	 $game_map.screen.pictures[120].show("MouSuitX6Visor", pos, xb, yb, px, py, 255, 0) 
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
   if $game_variables[@prog][7] == 1
	 $game_map.screen.pictures[119].show("MouH20AfroMask", pos, xp, yp, px, py, 255, 0)
	   else
	 $game_map.screen.pictures[119].show("MouH20Mask", pos, xp, yp, px, py, 255, 0)
   end
   #BROOM
	if $game_variables[@prog][3] == 0
		  $game_map.screen.pictures[112].show("MouH20BroomStdF", pos, xp, yp, px, py, 255, 0)        
	  elsif $game_variables[@prog][3] == 1
		  $game_map.screen.pictures[112].show("MouH20BroomHop", pos, xp, yp, px, py, 255, 0)        
	  elsif $game_variables[@prog][3] == 2
		  $game_map.screen.pictures[112].show("MouH20BroomWreF", pos, xp, yp, px, py, 255, 0)         
	  end   
	 elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
   if $game_variables[@prog][4] == 0 #white
   body = "MouSuitc20W"
  elsif $game_variables[@prog][4] == 1 #grey
   body = "MouSuitc20G"
  elsif $game_variables[@prog][4] == 2 #brown
   body = "MouSuitc20Br"
  elsif $game_variables[@prog][4] == 3 #black
   body = "MouSuitc20B"
  elsif $game_variables[@prog][4] == 4 #pink
   body = "MouSuitc20P"
  end
  $game_map.screen.pictures[119].show(body, pos, xb, yb, px, py, 255, 0)
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
		if $game_variables[@prog][3] == 0
		  bod = "StdF"        
		elsif $game_variables[@prog][3] == 1
		  bod = "Hop"
		elsif $game_variables[@prog][3] == 2
		  bod = "WreF"
		elsif $game_variables[@prog][3] >= 3
		  bod = "StdF"
		end   
  body = "MouF20Mask" + bod
  bodyB = "MouF20Mask" + bod + "b"
  $game_map.screen.pictures[112].show(bodyB, pos, xp, yp, px, py, 255, 0)
  $game_map.screen.pictures[119].show(body, pos, xp, yp, px, py, 255, 0)
  end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 unless cost == "b" || cost == "c20"
	 cost = "Chu"
	 end
   end   
   end  
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		 if $game_variables[@prog][3] >= 5 #crash save
			$game_variables[@prog][3] = 0
		 end     
	 if $game_variables[@prog][3] == 0
		  bod = "StdF"        
  elsif $game_variables[@prog][3] == 1
		  bod = "Hop"
  elsif $game_variables[@prog][3] == 2
		  bod = "WreF"
  elsif $game_variables[@prog][3] == 3
		  bod = "StdM"
  elsif $game_variables[@prog][3] == 4
		  bod = "WreM"
		end
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub
	 bod = "Chu"
   end
  #COLOR SKIN
   if $game_variables[@prog][4] == 0  #WHITE MOUSE
	col = "W" 
  elsif $game_variables[@prog][4] == 1
	col = "G" 
  elsif $game_variables[@prog][4] == 2
	col = "Br" 
  elsif $game_variables[@prog][4] == 3
	col = "B" 
  elsif $game_variables[@prog][4] == 4
	col = "P"
  end  
  #COLOR HAIR
   nospeH = 0
   if $game_variables[@prog][27] == 5 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col   #no cust hcol 
	 if $game_variables[@prog][11] == 0  #YELLOW HAIR
	   col2 = "Y"
	 elsif $game_variables[@prog][11] == 1  #GREY HAIR
	   col2 = "G"
	 elsif $game_variables[@prog][11] == 2  #BROWN HAIR
	   col2 = "Br"  
	 elsif $game_variables[@prog][11] == 3  #BLACK HAIR
	   col2 = "B"
	 end
  else
	 if $game_variables[@prog][27] == 1
		col2 = "Y"
  elsif $game_variables[@prog][27] == 2
		col2 = "G"
  elsif $game_variables[@prog][27] == 3
		col2 = "Br"
  elsif $game_variables[@prog][27] == 4
		col2 = "B"
  elsif $game_variables[@prog][27] == 5
		col2 = "Spe"      
	  end 
	end
   if col2 == "Spe" && $game_variables[@prog][26] == 0
	 if $game_variables[@prog][11] == 0  #YELLOW HAIR
	   col2 = "Y"
	 elsif $game_variables[@prog][11] == 1  #GREY HAIR
	   col2 = "G"
	 elsif $game_variables[@prog][11] == 2  #BROWN HAIR
	   col2 = "Br"  
	 elsif $game_variables[@prog][11] == 3  #BLACK HAIR
	   col2 = "B"
	 end   
	  end    
  #EARS
  if cost != "x1" #majo ears
		  if $game_variables[@prog][6] == 0
			eaS = "Rou"
  elsif $game_variables[@prog][6] == 1
			eaS = "Rer"
  elsif $game_variables[@prog][6] == 2
			eaS = "Sli"
  elsif $game_variables[@prog][6] == 3
			eaS = "Flo"
		end
	 ears = "MouE" + eaS + col
	 earsB = "MouE" + eaS + "Back" 
		  $game_map.screen.pictures[116].show(ears, pos, xp, yp, px, py, 255, 0)
		  $game_map.screen.pictures[114].show(earsB, pos, xp, yp, px, py, 255, 0)
		end        
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end        
  #HAIR
	if $game_variables[@prog][26] == 0 #no cust hs 
	 if $game_variables[@prog][7] == 0
		haS = "Std"
  elsif $game_variables[@prog][7] == 1
		haS = "Flu"
  elsif $game_variables[@prog][7] == 2
		haS = "Bra"
  elsif $game_variables[@prog][7] == 3
		haS = "Pon"
	  end 
	else
	 if $game_variables[@prog][26] == 1
		haS = "Bra2"
  elsif $game_variables[@prog][26] == 2
		haS = "Bun"
  elsif $game_variables[@prog][26] == 3
		haS = "Clo"
  elsif $game_variables[@prog][26] == 4
		haS = "Ras"
  elsif $game_variables[@prog][26] == 5
		haS = "Spi"      
	  end 
	  end
	 hair = "MouH" + haS + col2
	 $game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0)
  ###   
  if $game_variables[@prog][1] == 1
	body = base + bod + col
	$game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
	else
	if $game_switches[4006] == false && $game_variables[@prog][17] != 6 && $game_switches[4015] == false && $game_variables[@prog][17] != 15
	  dress =  basedre + bod + cost 
	  $game_map.screen.pictures[118].show(dress, pos, xp, yp, px, py, 255, 0)
		end 
	  body = base + bod + col + "n"
	  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)   
  end
  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end    
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 55
	@c2= 15
	@c3= 55
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end
  #--------------------
		if $game_variables[@prog][0] == 14
   #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#              
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #scared
		$game_variables[2051] = 4    
	  end  
	end       
		  xp = 10
		  yp = -50      
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 230
		  yp = -100
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70        
		  xp = 365
		  yp = 325
		end
  #      if $game_switches[579] == true
  #        px = 80
  #        py = 80
  #        xp = 50
  #        yp = -40
  #iif $game_variables[@prog][19] == 2
  #        xp += 35
  #        yp -= 10      
  #end           
  #end      
		if $game_switches[579] == true
		  px = 50
		  py = 50
		  xp = 90
		  yp = 75
		end  
		  if $game_switches[3529] == true
  xp = 238 #port center without ADV menu check
		  yp = 242
		  px = 50
		  py = 50   
		end   
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  col = ""
  colE = ""
  mask = ""
  expS = ""
  expr = ""
  expression = ""
  ears = ""
  eaS = ""
  efn = 111
  head = ""
  headB = ""
  heS = ""
  earC = ""
  hpn = 115
  hdn = 114
  basedre = "RabDre"
  base = "RabBod"   
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -175
		yp = -74
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("RabbitPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Ara"
	elsif $game_variables[2051] == 4 
	  expS = "Scared"
	 end        
	expr = "RabbitPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)     
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
  else          
   if $game_variables[@prog][7] == 0 && $game_variables[@prog][26] == 0
	  expS = "E"
	else
	  expS = ""
	end
  expr = "Std"
	if $game_variables[2051] == 0 
		  expr = "Std"
elsif $game_variables[2051] == 1 
		  expr = "Sad"
elsif $game_variables[2051] == 2 
		  expr = "Rage"
elsif $game_variables[2051] == 3 
		  expr = "Love"
elsif $game_variables[2051] == 4 
		  expr = "Scared"
		end
		    #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
	  expr = "Tsun"
   elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
		    expr = "Yan"
  elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expr = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expr = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expr = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expr = "Nemu"
  end        
expression = "RabExp" + expS + expr
  if @ski == "Spooky" 
     expression = "RabExpSpoop"  
  end
$game_map.screen.pictures[117].show(expression , pos, xp, yp, px, py, 255, 0)
#Accessory
		  if $game_variables[@prog][6] == 1
		  $game_map.screen.pictures[118].show("RabAccGla", pos, xp, yp, px, py, 255, 0)
		  end
		  if $game_variables[@prog][6] == 2
		  $game_map.screen.pictures[118].show("RabAccMon", pos, xp, yp, px, py, 255, 0)
		  end   
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[112].show("RabCrown", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[118].show("RabMaidBonnet", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
	 $game_map.screen.pictures[119].show("RabSnorkel", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 #$game_map.screen.pictures[118].show("RabBunEars", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
	 $game_map.screen.pictures[118].show("RabAccGlaq", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4011] == true || $game_variables[@prog][17] == 11 #nurse
	 cost = "+"
	 $game_map.screen.pictures[118].show("RabHat+", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"    
   $game_map.screen.pictures[118].show("RabHatx5", pos, xp, yp, px, py, 255, 0)  
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #spandex
	 cost = "x1" #spandex
   elsif $game_switches[4019] == true || $game_variables[@prog][17] == 19 #abyss
	 cost = "x2" #abyss
	 xhat = xp
	 yhat = yp
		  if $game_variables[@prog][7] == 0
		  #ponytail
	 xhat = xp - (0.25* px)
	 yhat = yp       
  elsif $game_variables[@prog][7] == 1
		  #braid
	 xhat = xp - (0.05* px)
	 yhat = yp + (0.05* py)
  elsif $game_variables[@prog][7] == 2
		  #punkish
	 xhat = xp - (0.07* px)
	 yhat = yp - (0.08* py)
  elsif $game_variables[@prog][7] == 3
		  #slick
	 xhat = xp - (0.17* px)
	 yhat = yp - (0.15* py)
  elsif $game_variables[@prog][7] == 4
		   #bob
	 xhat = xp
	 yhat = yp
  end
		 if $game_variables[@prog][7] != 5
		 $game_map.screen.pictures[119].show("RabHatx2", pos, xhat, yhat, px, py, 255, 0)
	  end
   elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #white
	 cost = "x3" #white
   elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21 #floatie
	 cost = "x4"
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 hpn = 114
	 hdn = 115
	 msk = ""
	  if $game_variables[@prog][7] == 0
	   msk = "Pon"
  elsif $game_variables[@prog][7] == 1
	   msk = "Bra"
  elsif $game_variables[@prog][7] == 4
	   msk = "Bob"
  elsif $game_variables[@prog][7] == 5
	   msk = "Lif"
	  end    
	 mask = "RabH20Mask" + msk
	 $game_map.screen.pictures[119].show("RabH20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20" 
	 earC = "c20"
	 $game_map.screen.pictures[119].show("RabC20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"   
	 earC = "f20"
   elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #colosseum
	 cost = "b2"         
	 $game_map.screen.pictures[119].show("RabHatb2", pos, xp, yp, px, py, 255, 0)
   end    
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 if cost != "x4"
	   cost = "Chu"
	 end
   end    
  end
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "FCur"        
  elsif $game_variables[@prog][3] == 1
		  bod = "FHai"
  elsif $game_variables[@prog][3] == 2
		  bod = "FSli"
  elsif $game_variables[@prog][3] == 3
		  bod = "MHai"
  elsif $game_variables[@prog][3] == 4
		  bod = "MSli"
		end
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub
	 bod = "Chu"
	end        
  #COLOR
  if $game_variables[@prog][4] == 0 #PURPLE RABBIT
  col = "P"
  elsif $game_variables[@prog][4] == 1 #GREEN
  col = "G"
  elsif $game_variables[@prog][4] == 2 #RED
  col = "R"
  elsif $game_variables[@prog][4] == 3 #BROWN
  col = "B"
  elsif $game_variables[@prog][4] == 4 #WHITE
  col = "W"  
  end  
  colE = col
  #EARS
  eax = xp
  if $game_variables[@prog][5] == 1 
	 eaS = "N"
	 efn = 111
  elsif $game_variables[@prog][5] == 0 && $game_variables[@prog][7] != 5
	 eaS = "N"     
	 efn = 111
  elsif $game_variables[@prog][5] == 2
	 eaS = "S"     
	 efn = 111
  elsif $game_variables[@prog][5] == 3
	 eaS = "F"   
	 efn = 116
   elsif $game_variables[@prog][5] == 4
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true# pic center or diary  
	 eax = xp
   else
	 eax = xp - (0.75 * px)
	 end
	 eaS = "L" 
	 efn = 116
   end        
  #EAR / COVERS
  if earC == "c20" || earC == "f20" 
	efn = 120
  if $game_variables[@prog][7] == 5
	eaS = "Lif"
  end  
	colE = earC
  end
  ears = "RabE" + eaS + colE
  $game_map.screen.pictures[efn].show(ears, pos, eax, yp, px, py, 255, 0)
  #EAR / COVERS - BACK
  if $game_variables[@prog][5] == 3 || $game_variables[@prog][5] == 4
  if earC == "c20" || earC == "f20" 
  colE = "c20"
  end
  earsB = "RabE" + eaS + colE + "back"
  $game_map.screen.pictures[111].show(earsB, pos, eax, yp, px, py, 255, 0)
  end
  #HEAD
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust hcol 
   hcol = col 
  else
	if $game_variables[@prog][27] == 1 #PURPLE RABBIT
  hcol = "P"
  elsif $game_variables[@prog][27] == 2 #GREEN
  hcol = "G"
  elsif $game_variables[@prog][27] == 3 #RED
  hcol = "R"
  elsif $game_variables[@prog][27] == 4 #BROWN
  hcol = "B"
  elsif $game_variables[@prog][27] == 5 #WHITE
  hcol = "W"  
  elsif $game_variables[@prog][27] == 6 #Special
  hcol = "Spe"  
  end 
  end 
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end        
  #HAIR
  if $game_variables[@prog][26] == 0 #no cust heS 
   if $game_variables[@prog][7] == 0
	 heS = "Pon"
  elsif $game_variables[@prog][7] == 1
	 heS = "Bra"
  elsif $game_variables[@prog][7] == 2
	 heS = "Pun"
  elsif $game_variables[@prog][7] == 3
	 heS = "Sli"
  elsif $game_variables[@prog][7] == 4
	 heS = "Bob"
  elsif $game_variables[@prog][7] == 5
	 heS = "Lif"
  end    
  else
	  if $game_variables[@prog][26] == 1 
  heS = "Puf"
  elsif $game_variables[@prog][26] == 2 
  heS = "Bel"
  elsif $game_variables[@prog][26] == 3 
  heS = "Flu"
  elsif $game_variables[@prog][26] == 4 
  heS = "Bun"
  elsif $game_variables[@prog][26] == 5 
  heS = "Hpo"  
  end 
  end  
  head = "RabH" + heS + hcol
  $game_map.screen.pictures[hpn].show(head, pos, xp, yp, px, py, 255, 0)
  if heS == "Flu"
   headB = "RabH" + heS + "b" + hcol
   $game_map.screen.pictures[112].show(headB, pos, xp, yp, px, py, 255, 0) 
  end  
  #DRESS   
   dress =  basedre + bod + cost 
   xdr = xp
   ydr = yp
   if pos == 0 && cost == "b2"
     xdr -= (1.85 * px)
   end   
   if cost == "h20" #hall 20
	 if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true# pic center or diary  
	   xdr -= (0.6 * px)
		else
	   xdr -= (1.21 * px)
	 end 
   end  
	  $game_map.screen.pictures[hdn].show(dress, pos, xdr, ydr, px, py, 255, 0)
  if cost != ""
	cost = "n"
  end              
	  body = base + bod + col + cost
	  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
	  if @prog == 4074
	  $game_map.screen.pictures[119].show("RabHorns", pos, xp, yp, px, py, 255, 0)
	  end
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end      
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 15
	@c2= 55
	@c3= 15
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end
  #--------------------
		if $game_variables[@prog][0] == 17 #finhead
   #FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#              
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #scared
		$game_variables[2051] = 4    
	  end  
	end       
		  if $game_variables[@prog][3] == 2
			 xp = -65
			 yp = 5 
		  else
			 xp = -85
			 yp = 70           
		  end  
		  px = 100
		  py = 100      
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 180
		  yp = -30      
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 335
		  yp = 370
		if $game_variables[@prog][19] == 2
		  xp += 25   
		  yp -= 10        
		 elsif $game_variables[@prog][3] == 2
		  yp -= 20
		 end      
		end
  #      if $game_switches[579] == true
  #        px = 80
  #        py = 80
  #        xp = 50
  #        yp = -40
  #iif $game_variables[@prog][19] == 2
  #        xp += 35
  #        yp -= 10      
  #end           
  #end      
		if $game_switches[579] == true #Status Screen
		  px = 50
		  py = 50
		  xp = 45
		  yp = 140
		end  
		  if $game_switches[3529] == true #LVL UP Menu
		  #defx 238
		  #defy 252
		  xp = 228 
		  yp = 252
		  if $game_variables[@prog][3] != 2
			 yp += 20 
		  end 
		  px = 50
		  py = 50   
		end   
		  if $game_switches[3416] == true #Diary
		  xp = 140
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  col = ""
  hs = ""
  base = "FinBod" 
  baseDre = "FinDre"
  col = "B"
  co2 = "B"
  hs = "Wha"
  bod = "FStd"      
  exp = ""
  expS = ""
  expE = ""
  expX = ""
  accB = ""
  if $game_variables[@prog][1] == 0 #FIN F
	sex = ""
  else
	sex = "m"
  end    
  if $game_variables[@prog][4] == 0 #FIN BLUE
	col1 = "B"
  elsif $game_variables[@prog][4] == 1 #FIN RED
	col1 = "R"  
  elsif $game_variables[@prog][4] == 2 #FIN GREEN
	col1 = "G"  
  elsif $game_variables[@prog][4] == 3 #FIN WHITE/PINK
	col1 = "W"  
  elsif $game_variables[@prog][4] == 4 #FIN TANNED
	col1 = "T"  
  end 
  if $game_variables[@prog][5] == 0 #FIN BLUE
	col2 = "B"
  elsif $game_variables[@prog][5] == 1 #FIN RED
	col2 = "R"  
  elsif $game_variables[@prog][5] == 2 #FIN GREEN
	col2 = "G"  
  elsif $game_variables[@prog][5] == 3 #FIN PINK
	col2 = "W"  
  elsif $game_variables[@prog][5] == 4 #FIN YELLOW
	col2 = "Y"  
  elsif $game_variables[@prog][5] == 5 #FIN PURPLE
	col2 = "P"  
  end 
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -137
		yp = 64
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("FinheadPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Smug"
	elsif $game_variables[2051] == 5 
	  expS = "Glad"
	 end           
	expr = "FinheadPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)      
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
		else 
  ###EXP###
  if $game_variables[@prog][1] == 0
    expX = ""
  else
    expX = "M"
  end    
  if $game_variables[@prog][11] == 0
    expS = "F"
  else
    expS = ""
  end  
	if $game_variables[2051] == 0 
		 expE = "Std"
		elsif $game_variables[2051] == 1 
		 expE = "Sad"
		elsif $game_variables[2051] == 2 
		 expE = "Rage"
		elsif $game_variables[2051] == 3 
     expE = "Love"
		elsif $game_variables[2051] == 4 
		 expE = "Smug"
		elsif $game_variables[2051] == 5 
		 expE = "Glad"
   end  
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end               
  exp = "FinExp" + expS + expE + expX
  if @ski == "Spooky" 
    exp = "FinExpSpoop"  
  end  
   $game_map.screen.pictures[118].show(exp, pos, xp, yp, px, py, 255, 0)
  ###EXP###
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n"    
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[111].show("FinCrown", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[119].show("FinHm", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"   
   $game_map.screen.pictures[119].show("FinHb", pos, xp, yp, px, py, 255, 0)
   accB = "FinTri"
   if $game_variables[@prog][3] == 0
		  accB = ""
      elsif $game_variables[@prog][3] == 1
		  accB += "FCur"
		  elsif $game_variables[@prog][3] == 2
		  accB += "FMod"
		  elsif $game_variables[@prog][3] == 3
		  accB += "FSwi"
		end	    
   $game_map.screen.pictures[111].show(accB, pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 $game_map.screen.pictures[119].show("FinHu", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
	 $game_map.screen.pictures[119].show("FinHq", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[119].show("FinH20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[119].show("FinC20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[119].show("FinF20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #shell
	 cost = "x3"       
   $game_map.screen.pictures[119].show("FinX3Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21 #kono
	 cost = "x4"       
   $game_map.screen.pictures[119].show("FinX4Mask", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"    
	 $game_map.screen.pictures[119].show("FinX5Mask", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #colosseum
	 cost = "b2"       
	 $game_map.screen.pictures[119].show("FinHb2", pos, xp, yp, px, py, 255, 0)
   accB = "FinTri2"
   if $game_variables[@prog][3] == 0
		  accB = ""
      elsif $game_variables[@prog][3] == 1
		  accB += "FCur"
		  elsif $game_variables[@prog][3] == 2
		  accB += "FMod"
		  elsif $game_variables[@prog][3] == 3
		  accB += "FSwi"
		end	    
   $game_map.screen.pictures[111].show(accB, pos, xp, yp, px, py, 255, 0)   
   end    
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
   end     
  end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "FStd"           
		  elsif $game_variables[@prog][3] == 1
		  bod = "FCur"
		  elsif $game_variables[@prog][3] == 2
		  bod = "FMod"
		  elsif $game_variables[@prog][3] == 3
		  bod = "FSwi"
		  elsif $game_variables[@prog][3] == 4
		  bod = "MSwi"
		end
	   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   if $game_variables[@prog][3] == 2
		   bod = "ChuMod"
	   else
		   bod = "Chu"
	   end       
	   end        
  if $game_variables[@prog][7] == 0
	hs = "Wha"
  end  
  if $game_variables[@prog][7] == 1
	hs = "Sha"
  end
  if $game_variables[@prog][7] == 2
	hs = "Lev"
  end
  if $game_variables[@prog][7] == 3
	hs = "Jel"
  end
  if $game_variables[@prog][7] == 4
	hs = "Oct"
  end
  # Finhead Head
   if $game_variables[@prog][7] == 3 #jellyhead
	hf = "FinH" + hs + col2
	$game_map.screen.pictures[117].show(hf, pos, xp, yp, px, py, 255, 0)
   else
	hb = "FinH" + hs + col2 + "b"
	$game_map.screen.pictures[112].show(hb, pos, xp, yp, px, py, 255, 0)
	hf = "FinH" + hs + col2
	$game_map.screen.pictures[117].show(hf, pos, xp, yp, px, py, 255, 0)
  end
  # Finhead Body
  body = base + bod +  col1
  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
  # Finhead Dress
  if cost != "n"   
  dre = baseDre + bod + cost
  $game_map.screen.pictures[114].show(dre, pos, xp, yp, px, py, 255, 0)
  end  
  # Finhead Fins
  fin = "FinFin" + bod + col2
  $game_map.screen.pictures[115].show(fin, pos, xp, yp, px, py, 255, 0)
  # Finhead Lamp
  if $game_variables[@prog][12] == 1   
  lamp = "FinLamp" + col2
  $game_map.screen.pictures[116].show(lamp, pos, xp, yp, px, py, 255, 0)
  end  
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 95
	@c2= 0
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end
  #--------------------
		if $game_variables[@prog][0] == 18 #mermaid
  #FIX#
  if $game_variables[@prog][3] == 5
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#             
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #scared
		$game_variables[2051] = 4    
	  end  
	end       
		  if $game_variables[@prog][3] == 4 || $game_variables[@prog][19] == 2
			 xp = 20
			 yp = 10
		  else
			 xp = 0
			 yp = 10         
		  end  
		  px = 100
		  py = 100           
    if $game_switches[3215] == true #centerhead
      pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  if $game_variables[@prog][3] == 4 || $game_variables[@prog][19] == 2
		  xp = 50
		  yp = -20
		  else
		  xp = 200
		  yp = -20
		  end
		end
		if $game_switches[2411] == true       
		  if $game_variables[@prog][3] == 4 || $game_variables[@prog][19] == 2
		  xp = 380
		  yp = 340  
		  px = 50
		  py = 50 
		else
		  xp = 365
		  yp = 345         
		  px = 70
		  py = 70         
		  end     
		end
		if $game_switches[579] == true #Status Screen        
		  if $game_variables[@prog][3] == 4 || $game_variables[@prog][19] == 2 #huge 
		  xp = 5
		  yp = 50          
		  px = 40
		  py = 40 
		else
		  xp = 45
		  yp = 140        
		  px = 50
		  py = 50         
		  end 
		end  
		  if $game_switches[3529] == true #LVL UP Menu
		  #defx 238
		  #defy 252
		  xp = 240
		  yp = 252
		  if $game_variables[@prog][3] == 4 || $game_variables[@prog][19] == 2
		  xp = 255
		  px = 40
		  py = 40 
		  else
		  px = 50
		  py = 50         
		  end   
		end   
		  if $game_switches[3416] == true #Diary
		  xp = 140
		  yp = 310
		  if $game_variables[@prog][3] == 4 || $game_variables[@prog][19] == 2
		  px = 60
		  py = 60 
		  else
		  px = 70
		  py = 70         
		  end  
		end      
  cost = ""
  bod = ""
  col = ""
  hs = ""
  fang = ""
  base = "MerBod" 
  baseDre = "MerDre"
  bco = "G"
  fco = "Gy"
  hco = "Blk"
  hs = "Wil"
  bod = "FStd"   
  es = "Std"
  nojew = 0
  expbas = "MerExp"
  acc = ""
  ############
  if $game_variables[@prog][1] == 0 #MER F
	sex = ""
  else
	sex = "m"
  end 
  ############    
  if $game_variables[@prog][4] == 0 #MER GREEN
	bco = "G"
  elsif $game_variables[@prog][4] == 1 #MER RED
	bco = "T"  
  elsif $game_variables[@prog][4] == 2 #MER BLUE
	bco = "B"  
  elsif $game_variables[@prog][4] == 3 #MER WHITE
	bco = "P"  
  end 
  ############ 
  if $game_variables[@prog][5] == 0 #GREY FIN
	fco = "Gy"
  elsif $game_variables[@prog][5] == 1 #GREEN FIN
	fco = "G"  
  elsif $game_variables[@prog][5] == 2 #BLUE FIN
	fco = "B"  
  elsif $game_variables[@prog][5] == 3 #PINK FIN
	fco = "P"  
  end 
  ############  
  if $game_variables[@prog][6] == 0 #BLACK HAIR
	hco = "Blk"
  elsif $game_variables[@prog][6] == 1 #RED HAIR
	hco = "Red"
  elsif $game_variables[@prog][6] == 2 #GREEN HAIR
	hco = "Gre"
  elsif $game_variables[@prog][6] == 3 #WHITE HAIR
	hco = "Whi"
  elsif $game_variables[@prog][6] == 4 #BLUE HAIR
	hco = "Gry"
  end 
  # alt col?
	 nospeH = 0
   if $game_variables[@prog][27] == 5 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col    
	hcol = hco
  else
   if $game_variables[@prog][27] == 1  #GREEN HAIR
	hcol = "Blk"  
  elsif $game_variables[@prog][27] == 2  #BROWN HAIR
	hcol = "Red"     
  elsif $game_variables[@prog][27] == 3  #PURPLE HAIR
	hcol = "Gre" 
  elsif $game_variables[@prog][27] == 4  #WHITE HAIR
	hcol = "Whi" 
  elsif $game_variables[@prog][27] == 5  #SPECIAL HAIR
	hcol = "Spe"  
  end
  end
  ############
  if $game_variables[@prog][11] == 0 #STANDARD EARS
	es = "Std"
  elsif $game_variables[@prog][11] == 1 #LARGE EARS
	es = "Lar"
  elsif $game_variables[@prog][11] == 2 #LONG EARS
	es = "Lon"
  end 
  if $game_variables[@prog][3] == 4 #giant 
  if $game_variables[@prog][13] == 1 || $game_variables[@prog][13] == 4 #JEWEL
	js = "1"
  elsif $game_variables[@prog][13] == 2 || $game_variables[@prog][13] == 5 #JEWEL
	js = "2"
  elsif $game_variables[@prog][13] == 3 || $game_variables[@prog][13] == 6 #JEWEL
	js = "3"
  end  
	else
  if $game_variables[@prog][13] == 1 #JEWEL
	js = "B1"
  elsif $game_variables[@prog][13] == 2 #JEWEL
	js = "R1"
  elsif $game_variables[@prog][13] == 3 #JEWEL
	js = "Y1"
  elsif $game_variables[@prog][13] == 4 #JEWEL
	js = "B2"
  elsif $game_variables[@prog][13] == 5 #JEWEL
	js = "R2"
  elsif $game_variables[@prog][13] == 6 #JEWEL
	js = "Y2"
  end
end  
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -330
		yp = -160
    px = 100
	  py = 100    
  end    
	$game_map.screen.pictures[111].show("MermaidPbodShade", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Mock"
	elsif $game_variables[2051] == 5 
	  expS = "Wary"
	 end           
	expr = "MermaidPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
		else 
  if $game_variables[@prog][3] == 4 #giant 
	  expbas = "MerExpL"
	  fang = ""
	else
	  expbas = "MerExp"
	if $game_variables[@prog][12] == 1 #teethy
	  fang = "F"
	else
	  fang = ""
	end       
  end          
	 if $game_variables[2051] == 0 
		 expt = "Std"        
	elsif $game_variables[2051] == 1 
		  expt = "Sad"
	elsif $game_variables[2051] == 2 
		  expt = "Rage"
	elsif $game_variables[2051] == 3 
		  expt = "Love"
	elsif $game_variables[2051] == 4 
		  expt = "Mock"
	elsif $game_variables[2051] == 5 
		  expt = "Wary"
	  end  
	      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
		expt = "Tsun"
	elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
		expt = "Yan"
  elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expt = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expt = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expt = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expt = "Nemu"
  end                  
	exp = expbas + fang + expt    
  if @ski == "Spooky" 
    if $game_variables[@prog][3] == 4 #giant 
    exp = "MerExpLSpoop"  
  else
    exp = "MerExpSpoop"  
    end
  end  
  $game_map.screen.pictures[118].show(exp, pos, xp, yp, px, py, 255, 0)      
	  if $game_variables[@prog][3] == 0
		  bod = "FStd"           
	elsif $game_variables[@prog][3] == 1
		  bod = "FCur"
	elsif $game_variables[@prog][3] == 2
		  bod = "FOrc"
	elsif $game_variables[@prog][3] == 3
		  bod = "FTwi"
	elsif $game_variables[@prog][3] == 4
		  bod = "FGia"
	elsif $game_variables[@prog][3] == 5
		  bod = "MStd"          
		end    
	#CHUBS#    
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 if $game_variables[@prog][3] == 3
		  bod = "TwiChu"
	 elsif $game_variables[@prog][3] == 4
		  bod = "FGiaChu"
	 else
		  bod = "Chu"
	end     
   end     
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n"    
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 #cost = "d"
	 cost = ""
	 $game_map.screen.pictures[111].show("MerCrown", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 if $game_variables[@prog][3] == 4 #giant
	 $game_map.screen.pictures[119].show("MerHLm", pos, xp, yp, px, py, 255, 0)
   else
	 $game_map.screen.pictures[119].show("MerHm", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
	 if $game_variables[@prog][3] == 4 #giant
	 $game_map.screen.pictures[119].show("MerHLs", pos, xp, yp, px, py, 255, 0)
	 else
	 $game_map.screen.pictures[119].show("MerHs", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
	 if $game_variables[@prog][3] == 4 #giant
	 $game_map.screen.pictures[119].show("MerHLp", pos, xp, yp, px, py, 255, 0)
	 else
	 $game_map.screen.pictures[119].show("MerHp", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"   
	 if $game_variables[@prog][3] == 4 #giant
	 $game_map.screen.pictures[119].show("MerHLb", pos, xp, yp, px, py, 255, 0)
   else
	 helm = "MerHb" + bod
	 $game_map.screen.pictures[119].show(helm, pos, xp, yp, px, py, 255, 0)
	 end  
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"
	 if $game_variables[@prog][3] == 4 #giant
	if pos == 1
		  yd = 0.7 * px
	  else
		  yd = 1.4 * px
	  end    
		  yb = yp - yd        
	 $game_map.screen.pictures[111].show("MerHLu", pos, xp, yb, px, py, 255, 0)
	 $game_map.screen.pictures[119].show("MerHLub", pos, xp, yb, px, py, 255, 0)
   else
	if pos == 1
		  yd = 0.85 * px
	  else
		  yd = 1.7 * px
	  end    
		  yb = yp - yd      
	 $game_map.screen.pictures[119].show("MerHu", pos, xp, yb, px, py, 255, 0)
	 end
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   elsif $game_switches[4009] == true || $game_variables[@prog][17] == 9 #nun
	 cost = "c"
	 if $game_variables[@prog][3] == 4 #giant
	 $game_map.screen.pictures[119].show("MerHLc", pos, xp, yp, px, py, 255, 0)
		else
	 $game_map.screen.pictures[119].show("MerHc", pos, xp, yp, px, py, 255, 0)
	 end   
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 #cost = "w"
	 cost = ""
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 if $game_variables[@prog][3] == 4 #giant
		yd = 3.3 * px
		xb = xp
		yb = yp - yd        
	 $game_map.screen.pictures[119].show("MerH20MaskL", pos, xb, yb, px, py, 255, 0)
   elsif $game_variables[@prog][7] <= 2
		  yd = 1.5 * px
		  xd = 0.4 * px
		xb = xp - xd
		yb = yp - yd         
	 $game_map.screen.pictures[119].show("MerH20MaskCu", pos, xb, yb, px, py, 255, 0)
   else
	  if pos == 1
		  xd = 0.05 * px
	  else        
		  xd = 0.1 * px
	  end  
		yd = 1.8 * px
		xb = xp - xd
		yb = yp - yd    
	 $game_map.screen.pictures[119].show("MerH20MaskOc", pos, xb, yb, px, py, 255, 0)
	 end   
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 if $game_variables[@prog][3] == 4 #giant
	   $game_map.screen.pictures[119].show("MerF20MaskGia", pos, xp, yp, px, py, 255, 0)
	 else
	   $game_map.screen.pictures[119].show("MerF20Mask", pos, xp, yp, px, py, 255, 0)
	 end 
    elsif $game_switches[4020] == true || $game_variables[@prog][17] == 20 #shell
	 cost = "x3"    
	 if $game_variables[@prog][3] == 4 #giant
     $game_map.screen.pictures[111].show("MerX3MaskGiab", pos, xp, yp, px, py, 255, 0)
	   $game_map.screen.pictures[119].show("MerX3MaskGia", pos, xp, yp, px, py, 255, 0)
	 else
	   $game_map.screen.pictures[111].show("MerX3Maskb", pos, xp, yp, px, py, 255, 0)
     $game_map.screen.pictures[119].show("MerX3Mask", pos, xp, yp, px, py, 255, 0)
     acc = "MerAccX3" + bod
     $game_map.screen.pictures[120].show(acc, pos, xp, yp, px, py, 255, 0)
	 end   
  end     
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
   end   
  end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
  if $game_variables[@prog][3] == 4 #giant    
	if $game_variables[@prog][26] == 0       
	 if $game_variables[@prog][7] == 0
	   hs = "Wil"
	 elsif $game_variables[@prog][7] == 1
	   hs = "Afr"
	 elsif $game_variables[@prog][7] == 2
	   hs = "Sho"
	 end       
   else     
	 if $game_variables[@prog][26] == 1
	   hs = "80s"
	 elsif $game_variables[@prog][26] == 2
	   hs = "Flo"   
	 elsif $game_variables[@prog][26] == 3
	   hs = "Bra"   
	 end        
	end       
   else
   if $game_variables[@prog][26] == 0         
	 if $game_variables[@prog][7] == 0
	   hs = "Wil"
	 elsif $game_variables[@prog][7] == 1
	   hs = "Bob"
	 elsif $game_variables[@prog][7] == 2
	   hs = "Sho"
	 elsif $game_variables[@prog][7] == 3
	   hs = "Pon"
	 elsif $game_variables[@prog][7] == 4
	   hs = "Wit"
	 end      
   else     
	 if $game_variables[@prog][26] == 1
		  hs = "Cur"
	 elsif $game_variables[@prog][26] == 2
		  hs = "Cur2"   
	 elsif $game_variables[@prog][26] == 3
		  hs = "Flo"   
	 elsif $game_variables[@prog][26] == 4
		  hs = "Pon2"   
	 elsif $game_variables[@prog][26] == 5
		  hs = "Wil2"   
	 end    
	end    
  end
  # Mermaid Head
   if $game_variables[@prog][3] == 4 #giant
	hb = "MerHL" + hs + hcol + "b"
	$game_map.screen.pictures[112].show(hb, pos, xp, yp, px, py, 255, 0)   
	hf = "MerHL" + hs + hcol
	$game_map.screen.pictures[117].show(hf, pos, xp, yp, px, py, 255, 0)
   else
	hb = "MerH" + hs + hcol + "b"
	$game_map.screen.pictures[112].show(hb, pos, xp, yp, px, py, 255, 0)
	hf = "MerH" + hs + hcol
	$game_map.screen.pictures[117].show(hf, pos, xp, yp, px, py, 255, 0)
  end
   if $game_variables[@prog][3] == 4 #giant  
	  # Mermaid Tail
	  tail = "MerTail" + bod + fco
	  $game_map.screen.pictures[113].show(tail, pos, xp, yp, px, py, 255, 0)
	  # Mermaid Body
	  body = base + bod + bco
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	else
	  # Mermaid Body
	  body = base + bod + bco + fco
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)   
	end  
  # Mermaid Dress
  if cost != "n"   
  dre = baseDre + bod + cost
	$game_map.screen.pictures[115].show(dre, pos, xp, yp, px, py, 255, 0)
  end  
  # Mermaid Ears
   if $game_variables[@prog][3] != 4 #giant
	 ear = "MerEar" + es + bco
	 $game_map.screen.pictures[116].show(ear, pos, xp, yp, px, py, 255, 0)
  end
  # Mermaid Jewel
  if $game_variables[@prog][13] == 1 && nojew == 0
  if $game_variables[@prog][3] == 4 #giant  
  jew = "MerJewL" + js
  else
  jew = "MerJew" + js  
  end
  $game_map.screen.pictures[120].show(jew, pos, xp, yp, px, py, 255, 0)
  end  
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end   
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 55
	@c2= 15
	@c3= 5
	@c4= 10
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end 
  #--------------------------------------------------
  if $game_variables[@prog][0] == 19 #bird
   #FIX#
  if $game_variables[@prog][3] >= 5
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#            
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #scoff
		$game_variables[2051] = 4    
	  end  
	end       
	bigbrd = 0
	if $game_variables[@prog][3] == 3 || $game_variables[@prog][3] == 4 || $game_variables[@prog][3] == 6
	bigbrd = 1
	end
		  if bigbrd == 1
			 xp = -105
			 yp = -35 
		  else
			 xp = -125
			 yp = 50           
		  end  
		  px = 100
		  py = 100          
    if $game_switches[3215] == true #centerhead
      pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		if bigbrd == 0
		  xp = 70
		  yp = -20
		else
		  xp = 120
		  yp = -30   
		  end     
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70     
		  xp = 370
		  yp = 405
		if $game_variables[@prog][19] == 2
		  xp += 15   
		  yp -= 70        
		 elsif bigbrd == 1
		  xp = 380
		  yp = 350
		 end      
		end
  #      if $game_switches[579] == true
  #        px = 80
  #        py = 80
  #        xp = 50
  #        yp = -40
  #iif $game_variables[@prog][19] == 2
  #        xp += 35
  #        yp -= 10      
  #end           
  #end      
		if $game_switches[579] == true #Status Screen
		  pos = 1
		  px = 50
		  py = 50
		if bigbrd == 0
		  xp = 150
		  yp = 290
		else
		  xp = 180
		  yp = 250      
		  end 
		end  
		  if $game_switches[3529] == true #LVL UP Menu
		  pos = 1
		 if bigbrd == 0
		  xp = 250
		  yp = 300
		else
		  xp = 250
		  yp = 247     
		  if $game_variables[@prog][3] == 3 #secr
		  xp += 30
		  yp += 10               
		  end  
		  end 
		  px = 50
		  py = 50   
		end   
		if $game_switches[3416] == true #Diary
		  pos = 1
		  xp = 110
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  bod = ""
  col = ""
  hs = ""
  base = "BirBod" 
  baseDre = "BirDre"
  col = "B"
  co2 = "B"
  hs = "Bun"
  bod = "Bir"    
  expB = "BirExp"
  expS = ""
  expE = ""
  glasses = ""
  glaSt = ""
  if $game_variables[@prog][1] == 0 #BIR F
	sex = ""
  else
	sex = "m"
  end    
  #PLUME COL
  if $game_variables[@prog][4] == 0 #BIR BLUE
	col1 = "B"
  elsif $game_variables[@prog][4] == 1 #BIR BLACK
	col1 = "Bk"  
  elsif $game_variables[@prog][4] == 2 #BIR BROWN
	col1 = "Br"  
  elsif $game_variables[@prog][4] == 3 #BIR PINK
	col1 = "P"  
  elsif $game_variables[@prog][4] == 4 #BIR RED
	col1 = "R"  
  elsif $game_variables[@prog][4] == 5 #BIR WHITE
	col1 = "W" 
  elsif $game_variables[@prog][4] == 6 #BIR YELLOW
	col1 = "Y"   
  end 
  #HAIR COL  
   nospeH = 0
   if $game_variables[@prog][27] == 9 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col
  if $game_variables[@prog][5] == 0 #BLUE
	col2 = "B"
  elsif $game_variables[@prog][5] == 1 #BLACK
	col2 = "Bk"  
  elsif $game_variables[@prog][5] == 2 #BROWN
	col2 = "Br"  
  elsif $game_variables[@prog][5] == 3 #OLIVE
	col2 = "O"  
  elsif $game_variables[@prog][5] == 4 #PINK
	col2 = "P"  
  elsif $game_variables[@prog][5] == 5 #PINK WHITE
	col2 = "Pw"  
  elsif $game_variables[@prog][5] == 6 #RED
	col2 = "R"
  elsif $game_variables[@prog][5] == 7 #WHITE
	col2 = "W"  
end 
	  else
		if $game_variables[@prog][27] == 1
		  col2 = "B"
		elsif $game_variables[@prog][27] == 2
		  col2 = "Bk"
		elsif$game_variables[@prog][27] == 3
		  col2 = "Br"
		elsif $game_variables[@prog][27] == 4
		  col2 = "O"
		elsif $game_variables[@prog][27] == 5
		  col2 = "P"
		elsif $game_variables[@prog][27] == 6
		  col2 = "Pw"
		elsif $game_variables[@prog][27] == 7
		  col2 = "R"
		elsif $game_variables[@prog][27] == 8
		  col2 = "W"
		elsif $game_variables[@prog][27] == 9
		  col2 = "Spe"
		end                 
	  end       
  ##############
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
	  xp = -145
	  yp = -60
    px = 100
    py = 100
   end     
	$game_map.screen.pictures[111].show("BirdPbodShade", pos, xp, yp, px, py, 255, 0)
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	 expS = "Tch"
	elsif $game_variables[2051] == 5
	 expS = "Bed"
 end        
	expr = "BirdPexp" + expS  
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)    
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end     
   else 
  #EXP
  if $game_variables[@prog][11] == 0
	expS = "Bir"
  elsif $game_variables[@prog][11] == 1
	expS = "Swl"  
  elsif $game_variables[@prog][11] == 2
	expS = "Par"  
  elsif $game_variables[@prog][11] == 3
	expS = "Sec"  
  elsif $game_variables[@prog][11] == 4
	expS = "Swa"  
  elsif $game_variables[@prog][11] == 5
	expS = "Duk"  
  end 
	if $game_variables[2051] == 0 
		expE = "std"
  elsif $game_variables[2051] == 1 
		expE = "sad"
  elsif $game_variables[2051] == 2 
		expE = "rage"
  elsif $game_variables[2051] == 3 
		expE = "love"
  elsif $game_variables[2051] == 4 
		expE = "scoff"
  elsif $game_variables[2051] == 5
		expE = "bed"
  end
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
  expr = expB + expS + expE
  if @ski == "Spooky" 
    expr = "BirExpSpoop"
  end   
  $game_map.screen.pictures[117].show(expr, pos, xp, yp, px, py, 255, 0)      
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n"    
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[112].show("BirCrown", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[118].show("BirHm", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
	 $game_map.screen.pictures[112].show("BirHpb", pos, xp, yp, px, py, 255, 0) 
	 if $game_variables[@prog][3] == 1
	   $game_map.screen.pictures[118].show("BirHpSwl", pos, xp, yp, px, py, 255, 0)     
	 else
	  $game_map.screen.pictures[118].show("BirHp", pos, xp, yp, px, py, 255, 0) 
	 end  
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"   
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u" 
	  if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true# pic center or diary 
		  yd = 0.25 * px
	  else        
		  yd = 0.5 * px
	  end  
		yb = yp - yd       
	 $game_map.screen.pictures[118].show("BirHu", pos, xp, yb, px, py, 255, 0)
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
	  if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true# pic center or diary 
		  yd = 0.25 * px
	  else        
		  yd = 0.5 * px
	  end  
		yb = yp - yd          
	 $game_map.screen.pictures[118].show("BirHq", pos, xp, yb, px, py, 255, 0)
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 #cost = "w"
	 cost = ""
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[118].show("BirH20Mask", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
  if $game_variables[@prog][1] == 0 #fem only
	 col1 = "c20"
  end  
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[118].show("BirF20Mask", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #x0 - Goth
	 cost = "x0"    
	 $game_map.screen.pictures[119].show("BirX0Mask", pos, xp, yp, px, py, 255, 0)    
  elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22
	 cost = "x5"      
   $game_map.screen.pictures[118].show("BirX5Mask", pos, xp, yp, px, py, 255, 0)
  end    
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
   end     
  end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "Bir"           
  elsif $game_variables[@prog][3] == 1
		  bod = "Swl"
  elsif $game_variables[@prog][3] == 2
		  bod = "Par"
  elsif $game_variables[@prog][3] == 3
		  bod = "Sec"
  elsif $game_variables[@prog][3] == 4
		  bod = "Swa"
  elsif $game_variables[@prog][3] == 5
		  bod = "Haw"
  elsif $game_variables[@prog][3] == 6
		  bod = "Fla"        
		end
  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   if bigbrd == 1
		   bod = "ChuMod"
	   else
		   bod = "Chu"
	   end       
	 end        
  # Hairstyles 
	if $game_variables[@prog][26] == 0 
  if $game_variables[@prog][7] == 0
	hs = "Bun"
  elsif $game_variables[@prog][7] == 1
	hs = "Flo"
  elsif $game_variables[@prog][7] == 2
	hs = "Hpo"
  elsif $game_variables[@prog][7] == 3
	hs = "Scr"
  elsif $game_variables[@prog][7] == 4
	hs = "Sho"
  elsif $game_variables[@prog][7] == 5
	hs = "Vsh"
  elsif $game_variables[@prog][7] == 6
	hs = "Wsh"  
  end 
   else
	if $game_variables[@prog][26] == 1
	   hs = "Fl2"
  elsif $game_variables[@prog][26] == 2
	   hs = "Pon"   
  elsif $game_variables[@prog][26] == 3
	   hs = "Sh2"   
  elsif $game_variables[@prog][26] == 4
	   hs = "Sh3"   
  elsif $game_variables[@prog][26] == 5
	   hs = "Shl"   
	 end 
   end      
  # HEAD
	hf = "BirH" + hs + col2
	$game_map.screen.pictures[115].show(hf, pos, xp, yp, px, py, 255, 0)
  # GLASSES
   unless $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020  if $game_variables[@prog][6] != 0
	if $game_variables[@prog][6] == 1
	glaSt = "Thick"
	elsif $game_variables[@prog][6] == 2
	glaSt = "Sec"
	elsif $game_variables[@prog][6] == 3
	glaSt = "Swa"
	elsif $game_variables[@prog][6] == 4
	glaSt = "Avi"
	elsif $game_variables[@prog][6] == 5
	glaSt = "Ban" 
	end
	glasses = "BirAcc" + glaSt
	$game_map.screen.pictures[119].show(glasses, pos, xp, yp, px, py, 255, 0)
  end
  # BODY
  body = base + bod +  col1
  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
  # COSTUME
  if cost != "n" && cost != "c20"  
  dre = baseDre + bod + cost
  $game_map.screen.pictures[114].show(dre, pos, xp, yp, px, py, 255, 0)
  end  
  # XWING
  if cost != "c20"  
  if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 4 #swl/swan
	win = "BirW" + bod + col1
	$game_map.screen.pictures[111].show(win, pos, xp, yp, px, py, 255, 0)
  end
  end
  if $game_variables[@prog][3] == 2
	$game_map.screen.pictures[116].show("BirAccPar", pos, xp, yp, px, py, 255, 0)
  end  
  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 95
	@c2= 0
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
   end
  #--------------------------------------------------
 if $game_variables[@prog][0] == 20 #oni
  #FIX#
   if $game_variables[@prog][3] >= 5
	  $game_variables[@prog][3] = 0
   end
  #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#            
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #scoff
		$game_variables[2051] = 4    
	  end  
	end       
	bigoni = 0
	if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 3
	bigoni = 1
	end
	px = 100
	py = 100   
	if bigoni == 1
	xp = -50
	yp = -30      
	  else
	xp = -80
	yp = -40
	end
	pos = 0
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end   
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 360
		  yp = 400
      pos = 1
		end  
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 60
		py = 60         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 250
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
		px = 70
		py = 70   
		pos = 1
	  end     
  cost = ""
  bod = ""
  col = ""
  hs = ""
  base = "OniBod" 
  baseDre = "OniDre"
  col = "R"
  hcol = "W"
  hs = "Pun"
  bod = "StdF"    
  expB = "OniExp"
  expS = ""
  expE = ""
  expr = ""
  glasses = ""
  glaSt = ""
  sex = ""
  hfB = ""
  broS = ""
  brows = ""
  hoS = ""
  if $game_variables[@prog][1] == 0 #ONI F
	sex = ""
  else
	sex = "m"
  end    
  #BODY COL
  if $game_variables[@prog][4] == 0 #ONI RED
	col = "R"
  elsif $game_variables[@prog][4] == 1 #ONI BLUE
	col = "B"  
  elsif $game_variables[@prog][4] == 2 #ONI OLIVE
	col = "O"  
  elsif $game_variables[@prog][4] == 3 #ONI BLACK
	col = "Bl"  
  elsif $game_variables[@prog][4] == 4 #ONI PURPLE
	col = "P"  
  end 
  #HAIR COL  
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
     nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col
  if $game_variables[@prog][6] == 0 #WHITE
	hcol = "W"
  elsif $game_variables[@prog][6] == 1 #BLUE
	hcol = "B"  
  elsif $game_variables[@prog][6] == 2 #BLACK
	hcol = "Bl"  
  elsif $game_variables[@prog][6] == 3 #PINK
	hcol = "P"  
  elsif $game_variables[@prog][6] == 4 #RED
	hcol = "R"  
  end 
      else
        if $game_variables[@prog][27] == 1
          hcol = "W"
        elsif $game_variables[@prog][27] == 2
          hcol = "B"
        elsif $game_variables[@prog][27] == 3
          hcol = "Bl"
        elsif $game_variables[@prog][27] == 4
          hcol = "P"
        elsif $game_variables[@prog][27] == 5
          hcol = "R"
        elsif $game_variables[@prog][27] == 6
          hcol = "Spe"
        end                      
      end       
  ##############
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
    xp = -380
	  yp = -150
    px = 100
	  py = 100
   end
	$game_map.screen.pictures[111].show("OniPbrace", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Roar"
  elsif $game_variables[2051] == 5
		expS = "Grin"    
	 end        
	expr = "OniPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)        
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
   else 
  #EXP
  if $game_variables[@prog][11] == 0
	expS = ""
  elsif $game_variables[@prog][11] == 1
	expS = "U"  
  elsif $game_variables[@prog][11] == 2
	expS = "D"  
  elsif $game_variables[@prog][11] == 3
	expS = "T"  
  end 
  expE = "Std"
	if $game_variables[2051] == 0 
		expE = "Std"
  elsif $game_variables[2051] == 1 
		expE = "Sad"
  elsif $game_variables[2051] == 2 
		expE = "Rage"
  elsif $game_variables[2051] == 3 
		expE = "Love"
  elsif $game_variables[2051] == 4 
		expE = "Roar"
  elsif $game_variables[2051] == 5
		expE = "Grin"    
  end
#voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 85  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
  expr = expB + expS + expE
  if @ski == "Spooky" 
    expr = "OniExpSpoop"
  end     
  $game_map.screen.pictures[117].show(expr, pos, xp, yp, px, py, 255, 0)      
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n"    
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[112].show("OniCrown", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
	 $game_map.screen.pictures[118].show("OniHm", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
	 $game_map.screen.pictures[118].show("OniHs", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"   
	 if $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 4
	 $game_map.screen.pictures[118].show("OniHbSli", pos, xp, yp, px, py, 255, 0)   
	 else
	 $game_map.screen.pictures[118].show("OniHb", pos, xp, yp, px, py, 255, 0)   
	 $game_map.screen.pictures[111].show("OniBat", pos, xp, yp, px, py, 255, 0)   
	 end
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u" 
	 $game_map.screen.pictures[118].show("OniHu", pos, xp, yb, px, py, 255, 0)
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 #cost = "w"
	 cost = ""
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[118].show("OniHH20", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[118].show("OniHC20", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
   elsif $game_switches[4021] == true || $game_variables[@prog][17] == 21 #floatie
	 cost = "x4"   
	elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22
	 cost = "x5"       
  elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #colosseum
	 cost = "b2"  
   if $game_variables[@prog][1] == 0
	 $game_map.screen.pictures[118].show("OniHb2F", pos, xp, yp, px, py, 255, 0)
 else
   $game_map.screen.pictures[118].show("OniHb2M", pos, xp, yp, px, py, 255, 0)
   end
   accB = "OniAxeb2"
		if $game_variables[@prog][3] == 0
		  accB += "StdF"           
    elsif $game_variables[@prog][3] == 1
		  accB += "CurF"
    elsif $game_variables[@prog][3] == 2
		  accB += "SliF"
    elsif $game_variables[@prog][3] == 3
		  accB += "StdM"
    elsif $game_variables[@prog][3] == 4
		  accB += "SliM"      
		end	    
   $game_map.screen.pictures[111].show(accB, pos, xp, yp, px, py, 255, 0)   
   end    
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 if cost != "x4"
	   cost = "Chu"
	 end
   end     
  end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "StdF"           
  elsif $game_variables[@prog][3] == 1
		  bod = "CurF"
  elsif $game_variables[@prog][3] == 2
		  bod = "SliF"
  elsif $game_variables[@prog][3] == 3
		  bod = "StdM"
  elsif $game_variables[@prog][3] == 4
		  bod = "SliM"      
		end
  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   if bigoni == 1
		   bod = "ChuBig"
	   else
		   bod = "Chu"
	   end       
	 end        
  # Hairstyles 
  needHb = 0
    if $game_variables[@prog][26] == 0 
  if $game_variables[@prog][7] == 0
	hs = "Pun"
  elsif $game_variables[@prog][7] == 1
	hs = "Pon"
	needHb = 1
  elsif $game_variables[@prog][7] == 2
	hs = "Wil"
	needHb = 1
  elsif $game_variables[@prog][7] == 3
	hs = "Dre"
	needHb = 1    
  elsif $game_variables[@prog][7] == 4
	hs = "Scr"
	needHb = 1
  elsif $game_variables[@prog][7] == 5
	hs = "Afr"
  elsif $game_variables[@prog][7] == 6
	hs = "Dri"  
	needHb = 1
  end 
   else
    if $game_variables[@prog][26] == 1
       hs = "Lud"
  elsif $game_variables[@prog][26] == 2
       hs = "Sam"   
  elsif $game_variables[@prog][26] == 3
       hs = "Oni"   
  elsif $game_variables[@prog][26] == 4
       hs = "Cur"  
       needHb = 1
  elsif $game_variables[@prog][26] == 5
       hs = "Lon"   
       $game_map.screen.pictures[111].show("OniHLonXb", pos, xp, yp, px, py, 255, 0)
     end 
   end      
  # HEAD
	hf = "OniH" + hs + hcol
	$game_map.screen.pictures[115].show(hf, pos, xp, yp, px, py, 255, 0)
	if needHb == 1
	  hfB = hf + "b"
	  $game_map.screen.pictures[111].show(hfB, pos, xp, yp, px, py, 255, 0)
	end  
  # NAILS
	if $game_variables[@prog][12] == 1
	nails = "OniNails" + bod
	$game_map.screen.pictures[114].show(nails, pos, xp, yp, px, py, 255, 0)
	end     
  # BROWS
	if $game_variables[@prog][13] == 1
	  if expS = "Std" || expS = "Rage"
	  broS = "Std"
	else
	  broS = "Sad"
	  end
	brows = "OniBrows" + broS
	$game_map.screen.pictures[119].show(brows, pos, xp, yp, px, py, 255, 0)
	end     
  # HORNS
	if $game_variables[@prog][5] == 0
	hoS = "1"
	elsif $game_variables[@prog][5] == 1
	hoS = "2"
	elsif $game_variables[@prog][5] == 2
	hoS = "Cur"
	end
	horns = "OniHo" + hoS + col
	$game_map.screen.pictures[119].show(horns, pos, xp, yp, px, py, 255, 0)
  # BODY
  body = base + bod +  col
  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
  # COSTUME
  if cost != "n"
  dre = baseDre + bod + cost
  $game_map.screen.pictures[114].show(dre, pos, xp, yp, px, py, 255, 0)
  end  
  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 0
	@c2= 95
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
 end   
 #--------------------------------------------------
 if $game_variables[@prog][0] == 32 #toy
  #FIX#
   if $game_variables[@prog][3] >= 5
	  $game_variables[@prog][3] = 0
   end
  #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#            
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #scoff
		$game_variables[2051] = 4    
	  end  
	end       
	bloon = 0
  hBase = ""
	px = 100
	py = 100   
	xp = -140
	yp = 75  
	if $game_variables[@prog][3] == 2
	bloon = 1
  hBase = "Bal"
  xp = -60
	yp = 25  
  end
	pos = 0
    if $game_switches[3215] == true #centerhead
      pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end   
		if $game_switches[2359] == true || $game_switches[2466] == true || @prog == 3394
		  xp = 400
		  yp = 325
      pos = 1
		end  
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 60
		py = 60         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 250
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
		px = 70
		py = 70   
		pos = 1
	  end     
  cost = ""
  bod = ""
  col = ""
  hs = ""
  base = "ToyBod" 
  baseDre = "ToyDre"
  col = "C"
  hcol = "C"
  hs = "Sho"
  bod = "FluF"    
  expB = "ToyExp"
  expS = ""
  expE = ""
  expr = ""
  glasses = ""
  glaSt = ""
  sex = ""
  hfB = ""
  broS = ""
  brows = ""
  hoS = ""
	tail = ""
  ears = ""  
  butZip = ""
  expAccS = ""
  head = ""
  mimi = ""
  if $game_variables[@prog][1] == 0 #TOY F
	sex = ""
  else
	sex = "m"
  end    
  trasp = 255
  if @prog == 3394
    trasp = 185
  end  
  #BODY COL
  if bloon == 1
    colS = ["B","G","P","R","Y"]
    hcolS = ["B","G","P","R","Y"]
    hsS = ["Bra","Bun","Cur","Lon","Twi"]
    hbS = [0,0,0,0,0]
  else  
    colS = ["C","B","Bk","W","Y"]
    hcolS = ["C","B","Bk","W","Y"]  
    hsS = ["Cur","Flu","Lon","Sho","Tie","Twi","Vlo","Vsh"]
    hbS = [0,1,1,0,1,0,1,0]
  end  
  @i = $game_variables[@prog][4]  
	col = colS[@i]
  #HAIR COL  
   nospeH = 0
   noEars = 0
   noHair = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
     nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col
    @i = $game_variables[@prog][6]  
	  hcol = hcolS[@i] 
   else
    @i = $game_variables[@prog][27]  
    hcolS = ["C","C","B","Bk","W","Y","Spe"]  
	  hcol = hcolS[@i] 
   end  
  ##############
  
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
    xp = -380
	  yp = -150
    px = 100
	  py = 100
   end
	$game_map.screen.pictures[111].show("ToyPbrace", pos, xp, yp, px, py, trasp, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"   
	 end        
	expr = "ToyPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, trasp, 0)        
	if inMenu == 0
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
   else 
  #EXP
  if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 3
	expS = "Flu"
  elsif $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 4
	expS = "Mar"  
  elsif $game_variables[@prog][3] == 2
	expS = "Bal"  
  end 
  expE = "Std"
	if $game_variables[2051] == 0 
		expE = "Std"
  elsif $game_variables[2051] == 1 
		expE = "Sad"
  elsif $game_variables[2051] == 2 
		expE = "Rage"
  elsif $game_variables[2051] == 3 
		expE = "Love"
  elsif $game_variables[2051] == 4 
		expE = "Roar"
  elsif $game_variables[2051] == 5
		expE = "Grin"    
  end
#voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 85  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
  expr = expB + expS + expE
  if @ski == "Spooky" 
    expr = "ToyExpSpoop"
  end     
    $game_map.screen.pictures[117].show(expr, pos, xp, yp, px, py, trasp, 0)   
  #ACCESSORY EXP  
  if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 3 #plush
    if $game_variables[@prog][12] == 1
      butZip = "ToyAccButtons"
    elsif $game_variables[@prog][12] == 2
      butZip = "ToyAccMouth"
    end  
    $game_map.screen.pictures[118].show(butZip, pos, xp, yp, px, py, trasp, 0)   
  elsif $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 4 #mario
    if $game_variables[@prog][12] == 1
      butZip = "ToyAccButtons"
    elsif $game_variables[@prog][12] == 2
      butZip = "ToyAccNose" + col
    end      
    $game_map.screen.pictures[118].show(butZip, pos, xp, yp, px, py, trasp, 0)   
  end  
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n"    
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
   noEars = 1
   noHair = 1
   if bloon == 1
     head = "ToyHBald" + col
   else
     head = "ToyHd" + col
   end  
	 $game_map.screen.pictures[120].show(head, pos, xp, yp, px, py, trasp, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
   noEars = 1
   if bloon == 1
   $game_map.screen.pictures[120].show("ToyHmBal", pos, xp, yp, px, py, trasp, 0)  
   $game_map.screen.pictures[111].show("ToyHmBalb", pos, xp, yp, px, py, trasp, 0)  
     else
	 $game_map.screen.pictures[120].show("ToyHm", pos, xp, yp, px, py, trasp, 0)
   $game_map.screen.pictures[111].show("ToyHmb", pos, xp, yp, px, py, trasp, 0)
   end   
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   noEars = 1
   if bloon == 1
   $game_map.screen.pictures[111].show("ToyHsBal", pos, xp, yp, px, py, trasp, 0)  
     else
	 $game_map.screen.pictures[111].show("ToyHs", pos, xp, yp, px, py, trasp, 0)
   end      
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"   
	 $game_map.screen.pictures[120].show("ToyHb", pos, xp, yp, px, py, trasp, 0)
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u" 
   noEars = 1
   noHair = 1
   if bloon == 1
   $game_map.screen.pictures[120].show("ToyHuBal", pos, xp, yp, px, py, trasp, 0)  
     else
	 $game_map.screen.pictures[120].show("ToyHu", pos, xp, yp, px, py, trasp, 0)
   end
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   $game_map.screen.pictures[120].show("ToyHq", pos, xp, yp, px, py, trasp, 0)
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 #cost = "w"
	 cost = ""
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[111].show("ToyHH20", pos, xp, yp, px, py, trasp, 0)
  elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[111].show("ToyHC20", pos, xp, yp, px, py, trasp, 0)
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"      
   $game_map.screen.pictures[111].show("ToyHF20", pos, xp, yp, px, py, trasp, 0)
   end    
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 if cost != "x4"
	   cost = "Chu"
	 end
   end     
 end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "FluF"           
  elsif $game_variables[@prog][3] == 1
		  bod = "MarF"
  elsif $game_variables[@prog][3] == 2
		  bod = "Bal"
  elsif $game_variables[@prog][3] == 3
		  bod = "FluM"
  elsif $game_variables[@prog][3] == 4
		  bod = "MarM"      
		end
  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
    if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 3
	   bod = "ChuFlu"
      elsif $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 4
	   bod = "ChuMar"  
      elsif $game_variables[@prog][3] == 2
	   bod = "ChuBal"  
      end 
	 end        
  # Hairstyles 
    if $game_variables[@prog][26] == 0 || bloon == 1
     @i = $game_variables[@prog][7]
	   hs = hsS[@i]
   else
     @i = $game_variables[@prog][26]
     hsS = ["Sec","Sec","Bob","Wil","Pig","Dol"]
     hbS = [0,0,0,1,0,0]    
     hs = hsS[@i]
   end  
    # HEAD 
  if noHair == 0
	hf = "ToyH" + hBase + hs + hcol
	$game_map.screen.pictures[116].show(hf, pos, xp, yp, px, py, trasp, 0)
	if hbS[@i] == 1
	  hfB = hf + "b"
	  $game_map.screen.pictures[113].show(hfB, pos, xp, yp, px, py, trasp, 0)
	end   
  end
  # ACCS
  if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 3 #plushie
	if $game_variables[@prog][11] == 1
	mimi = "Cat"
	elsif $game_variables[@prog][11] == 2
	mimi = "Bun"
	elsif $game_variables[@prog][11] == 3
	mimi = "Fox"
  end
  if noEars == 0 && $game_variables[@prog][11] != 0
    ears = "ToyE" + mimi + col
    $game_map.screen.pictures[119].show(ears, pos, xp, yp, px, py, trasp, 0)
  end  
	tail = "ToyT" + mimi + col
	$game_map.screen.pictures[112].show(tail, pos, xp, yp, px, py, trasp, 0)
  end
  # BODY
  body = base + bod +  col
  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, trasp, 0)
  # COSTUME
  if cost != "n"
  dre = baseDre + bod + cost
  $game_map.screen.pictures[114].show(dre, pos, xp, yp, px, py, trasp, 0)
  end  
  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 0
	@c2= 95
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
 end   
  #--------------------------------------------------
 if $game_variables[@prog][0] == 30 #plant
  #FIX#
   if $game_variables[@prog][3] >= 6
	  $game_variables[@prog][3] = 0
   end
  #FIX#
  if $game_variables[@prog][3] >= 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#            
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #scared
		$game_variables[2051] = 4    
	  end  
	end       
	bigplant = 0
  smolplant = 0
	if $game_variables[@prog][3] == 3
	  bigplant = 1
  elsif $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 5 #stumps
    smolplant = 1
  elsif $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 4 #flowers
    floplant = 1
  end
	px = 100
	py = 100   
	if bigplant == 1
	xp = -115
	yp = -60      
  elsif smolplant == 1
	xp = -105
	yp = 70
  else
	xp = -90
	yp = 20
	end
	pos = 0
    if $game_switches[3215] == true #centerhead
      pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end   
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 360
		  yp = 400
      pos = 1
	end  
	 if $game_switches[2411] == true    
		xp = 365
		yp = 345    
    if bigplant == 0
      yp += 60
      if smolplant == 1
      yp += 30
      end  
	  end        
		px = 70
		py = 70         
		pos = 1     
  elsif $game_switches[579] == true
		xp = 158
		yp = 250
    if bigplant == 0
      yp += 60
      if smolplant == 1
      yp += 30
      end  
	  end    
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
    if bigplant == 0
      yp += 60
      if smolplant == 1
      yp += 30
      end
	  end        
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
    if bigplant == 0
      yp += 60
      if smolplant == 1
      yp += 30
      end
	  end       
		px = 70
		py = 70   
		pos = 1
	  end     
  cost = ""
  bod = ""
  col = ""
  hs = ""
  base = "PlaBod" 
  baseDre = "PlaDre"
  col = "G"
  hcol = "G"
  hs = "" #"Pun"
  bod = "StdF"    
  expB = "PlaExp"
  expS = ""
  expE = ""
  expr = ""
  glasses = ""
  glaSt = ""
  sex = ""
  hfB = ""
  broS = ""
  hoS = ""
  bulb = ""
  snout = ""
  bulbS = ""
  flohor = ""
  snoutExp = ""
  back = ""
  acc = ""
  accS = ""
  if $game_variables[@prog][1] == 0 #PLANT F
	sex = ""
  else
	sex = "m"
  end    
  #BODY COL
  if $game_variables[@prog][4] == 0 #PLANT GREEN
	col = "G"
  elsif $game_variables[@prog][4] == 1 #PLANT BLUE
	col = "B"  
  elsif $game_variables[@prog][4] == 2 #PLANT YELLOW
	col = "Y"  
  elsif $game_variables[@prog][4] == 3 #PLANT WHITE
	col = "W"  
  elsif $game_variables[@prog][4] == 4 #PLANT WOOD
	col = "Woo"  
  end 
  #HAIR COL  
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
     nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col
  if $game_variables[@prog][6] == 0 #Green Leaf
	hcol = "G"
  elsif $game_variables[@prog][6] == 1 #Red Leaf
	hcol = "R"  
  elsif $game_variables[@prog][6] == 2 #Yellow Leaf
	hcol = "Y"  
  elsif $game_variables[@prog][6] == 3 #White Leaf
	hcol = "W"  
  elsif $game_variables[@prog][6] == 4 #Brown Leaf
	hcol = "Woo"  
  end 
      else
        if $game_variables[@prog][27] == 1
          hcol = "G"
        elsif $game_variables[@prog][27] == 2
          hcol = "R"
        elsif$game_variables[@prog][27] == 3
          hcol = "Y"
        elsif $game_variables[@prog][27] == 4
          hcol = "W"
        elsif $game_variables[@prog][27] == 5
          hcol = "Woo"
        elsif $game_variables[@prog][27] == 6
          hcol = "Spe"
        end                      
      end       
  ##############
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
    xp = -340
	  yp = -45
    px = 100
	  py = 100
   end
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 70
		py = 70         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 240
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
		px = 70
		py = 70   
		pos = 1
	  end  
	$game_map.screen.pictures[111].show("PlantPbrace", pos, xp, yp, px, py, 255, 0)
  expS = "Std"
	if $game_variables[2051] == 0 
	 expS = "Std"
	elsif $game_variables[2051] == 1 
	 expS = "Sad"
	elsif $game_variables[2051] == 2 
	 expS = "Rage"
	elsif $game_variables[2051] == 3 
	 expS = "Love"
	elsif $game_variables[2051] == 4 
	  expS = "Scared"
	elsif $game_variables[2051] == 5
	  expS = "Glad"    
	 end        
	expr = "PlantPexp" + expS 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)        
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
   else 
  #EXP
  if $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 5 #stumps
  expS = "M"
  elsif $game_variables[@prog][11] == 0
	expS = ""
  elsif $game_variables[@prog][11] == 1
	expS = "S"  
  elsif $game_variables[@prog][11] == 2
	expS = "M"  
  elsif $game_variables[@prog][11] == 3
	expS = "H"    
  end 
  expE = "Std"
	if $game_variables[2051] == 0 
		expE = "Std"
    snoutExp = "Std"
  elsif $game_variables[2051] == 1 
		expE = "Sad"
    snoutExp = "Sad"
  elsif $game_variables[2051] == 2 
		expE = "Rage"
    snoutExp = "Sad"
  elsif $game_variables[2051] == 3 
		expE = "Love"
    snoutExp = "Glad"
  elsif $game_variables[2051] == 4 
		expE = "Scared" 
    snoutExp = "Sad"
  elsif $game_variables[2051] == 5
		expE = "Glad" 
    snoutExp = "Glad"    
  end
#voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 85  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end        
  expr = expB + expS + expE
  if @ski == "Spooky" 
    expr = "PlaExpSpoop"
  end     
  $game_map.screen.pictures[116].show(expr, pos, xp, yp, px, py, 255, 0)      
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n"    
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 $game_map.screen.pictures[112].show("PlaCrown", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   acc = "PlaHs"
   if $game_variables[@prog][3] == 0
		  acc += "StdF"           
   elsif $game_variables[@prog][3] == 1
		  acc += "AlraF"
   elsif $game_variables[@prog][3] == 2
		  acc += "StuF"
   elsif $game_variables[@prog][3] == 3
		  acc += "Tree"
   else
      acc += "Male"
   end      
   $game_map.screen.pictures[118].show(acc, pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"   
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u" 
	 $game_map.screen.pictures[118].show("PlaHu", pos, xp, yb, px, py, 255, 0)
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 #cost = "w"
	 cost = ""
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
  elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
   $game_map.screen.pictures[112].show("PlaHC20b", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[118].show("PlaHC20", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
   acc = "PlaHF20"
   if $game_variables[@prog][3] == 0
		  acc += "StdF"           
   elsif $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 4
		  acc += "AlraF"
   elsif $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 5
		  acc += "StuF"
   elsif $game_variables[@prog][3] == 3
		  acc += "Tree"
   end      
   $game_map.screen.pictures[118].show(acc, pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #saur
	 cost = "x1" 
   acc = "PlaSaur"
   if $game_variables[@prog][3] == 0
		  acc += "StdF"           
   elsif $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 4
		  acc += "AlraF"
   elsif $game_variables[@prog][3] == 2 || $game_variables[@prog][3] == 5
		  acc += "StuF"
   elsif $game_variables[@prog][3] == 3
		  acc += "Tree"
   end   
   $game_map.screen.pictures[112].show(acc, pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #colosseum
	 cost = "b2"          
   $game_map.screen.pictures[118].show("PlaHB2", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"         
   end    
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	if $game_variables[@prog][3] == 0
		  bod = "Chu"           
  elsif $game_variables[@prog][3] == 1
		  bod = "ChuAlra"
  elsif $game_variables[@prog][3] == 2
		  bod = "ChuStu"
  elsif $game_variables[@prog][3] == 3
		  bod = "ChuTree"
    end    
    if cost == "n"
      cost = "Water"
    end  
   end     
  end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
	if $game_variables[@prog][3] == 0
		  bod = "StdF"           
  elsif $game_variables[@prog][3] == 1
		  bod = "AlraF"
  elsif $game_variables[@prog][3] == 2
		  bod = "StuF"
  elsif $game_variables[@prog][3] == 3
		  bod = "Tree"
  elsif $game_variables[@prog][3] == 4
		  bod = "AlraM"      
  elsif $game_variables[@prog][3] == 5
		  bod = "StuM"          
	end
  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	if $game_variables[@prog][3] == 0
		  bod = "Chu"           
  elsif $game_variables[@prog][3] == 1
		  bod = "ChuAlra"
  elsif $game_variables[@prog][3] == 2
		  bod = "ChuStu"
  elsif $game_variables[@prog][3] == 3
		  bod = "ChuTree"
  end    
end      
  #FLOWER/HORNS
  if $game_variables[@prog][3] == 3 #trees
   flohor = "PlaHo" + $game_variables[@prog][5].to_s
  else #others -> bulb
   if $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 4 #Alra
		 flohor = "PlaFlower"
     if $game_variables[@prog][1] == 0
       flohor += "F"
     else
       flohor += "M"
     end  
     flohor += hcol      
	 end
  end 
  $game_map.screen.pictures[113].show(flohor, pos, xp, yp, px, py, 255, 0)  
  # Hairstyles 
  needHb = 0
    if $game_variables[@prog][26] == 0 
  if $game_variables[@prog][7] == 0
	hs = "Lea"
	needHb = 1
  elsif $game_variables[@prog][7] == 1
	hs = "LeaL"  
	needHb = 1  
  elsif $game_variables[@prog][7] == 2
	hs = "Flo"
	needHb = 1  
  elsif $game_variables[@prog][7] == 3
	hs = "Spi"  
  elsif $game_variables[@prog][7] == 4
	hs = "Mos"
	needHb = 1
  elsif $game_variables[@prog][7] == 5
	hs = "Scr"
	needHb = 1
  elsif $game_variables[@prog][7] == 6
	hs = "Tho"
	needHb = 1 
  elsif $game_variables[@prog][7] == 7
	hs = "Rib"    
  end 
   else
    if $game_variables[@prog][26] == 1
       hs = "Bun"
       needHb = 1 
  elsif $game_variables[@prog][26] == 2
       hs = "Coa"   
       needHb = 1 
  elsif $game_variables[@prog][26] == 3
       hs = "Cur"   
       needHb = 1 
  elsif $game_variables[@prog][26] == 4
       hs = "Flo2"   
  elsif $game_variables[@prog][26] == 5
       hs = "Twi"   
     end 
   end      
  # HEAD
	hf = "PlaH" + hs + hcol + "f"
	$game_map.screen.pictures[117].show(hf, pos, xp, yp, px, py, 255, 0)
	if needHb == 1
	  hfB = "PlaH" + hs + hcol + "b"
	  $game_map.screen.pictures[111].show(hfB, pos, xp, yp, px, py, 255, 0)
	end  
  # ACCESSORY
   if $game_variables[@prog][12] == 1
	 accS = "Butter"
   elsif $game_variables[@prog][12] == 2
	 accS = "Firef"
   elsif $game_variables[@prog][12] == 3
	 accS = "Seal"
  end
  acc = "PlaAcc" + accS
	  $game_map.screen.pictures[121].show(acc, pos, xp, yp, px, py, 255, 0)
  #BULB
   if $game_variables[@prog][13] == 0
   bulbS = "Std"
   elsif $game_variables[@prog][13] == 1
	 bulbS = "Rose"
   elsif $game_variables[@prog][13] == 2
	 bulbS = "Chry"
   elsif $game_variables[@prog][13] == 3
	 bulbS = "Pump"
   elsif $game_variables[@prog][13] == 4
	 bulbS = "Lotus"  
   end   
  bulb = "PlaBulb" + bulbS    
  $game_map.screen.pictures[119].show(bulb, pos, xp, yp, px, py, 255, 0)
  # MOUTH
	if expS == "M"
	snout = "PlaStuMou" + col  + "Std"
	$game_map.screen.pictures[118].show(snout, pos, xp, yp, px, py, 255, 0)
	end      
  # BODY
  body = base + bod +  col
  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
  # COSTUME
  if cost != "n"
  dre = baseDre + bod + cost
  $game_map.screen.pictures[115].show(dre, pos, xp, yp, px, py, 255, 0)
  end  
  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 0
	@c2= 95
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
 end    
  #--------------------------------------------------
 if $game_variables[@prog][0] == 31 #shadow
  #FIX#
   if $game_variables[@prog][3] >= 5
	  $game_variables[@prog][3] = 0
   end
  #FIX#
  if $game_variables[@prog][3] >= 3
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#           
  shadM = ""
  ### SHAD ###
     if $game_variables[2051] != 7 #test for Shad forms
     @shadMaps = [125,531,532,533,535]
     if @shadMaps.include?$game_map.map_id
       shadM = "Sha"
     elsif $game_variables[2051] == 66 #force Shad form
       shadM = "Sha"
     end    
     end
  ### SHAD ###    
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #tch
		$game_variables[2051] = 4    
	  elsif $game_variables[4000][2] == 5
		  #glad
		$game_variables[2051] = 5       
	  end  
	end       
	bigsha = 0
  lilsha = 0
	if $game_variables[@prog][3] == 4# || $game_variables[@prog][3] == 1
	  bigsha = 1
  elsif $game_variables[@prog][3] == 2  
    lilsha = 1
  end
	px = 100
	py = 100   
	if bigsha == 1
	xp = -290
	yp = -115   
  elsif lilsha == 1
	xp = -290
	yp = -65
  else
	xp = -290
	yp = -85
	end
	pos = 0
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end   
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 360
		  yp = 350
      pos = 1
	end  
	 if $game_switches[2411] == true    
		xp = 335
		yp = 355
    if bigsha == 1
      yp -= 30
	  elsif lilsha == 1
      yp += 30
    end  
		px = 70
		py = 70         
		pos = 1     
  elsif $game_switches[579] == true
		xp = 158
		yp = 310
    if bigsha == 1
      yp -= 30
	  end  
		px = 50
		py = 50        
		pos = 1
  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 230 
		yp = 265
    if bigsha == 1
      yp -= 30
	  elsif lilsha == 1
      yp += 30
    end     
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 360
    if bigsha == 1
      yp -= 30
	  end  
		px = 70
		py = 70   
		pos = 1
	  end     
  cost = ""
  bod = ""
  col = ""
  hs = ""
  base = "ShaBod" 
  baseDre = "ShaDre"
  col = "Gr"
  hcol = "Y"
  hs = "" #"Pun"
  bod = "StdF"    
  expB = "ShaExp"
  expS = ""
  expE = ""
  expr = ""
  glaSt = ""
  sex = ""
  hfB = ""
  broS = ""
  tatcol = ""
  tatS = ""
  shaear = ""
  tatcol = ""
  tattoo = ""
  earS = ""
  back = ""
  acc = ""
  accS = ""
  tatnum = 0
  tpSha = 255
  if $game_variables[@prog][1] == 0 #SHADOW F
	sex = ""
  else
	sex = "m"
  end    
  #BODY COL
  if $game_variables[@prog][4] == 0 #SHADOW GREY
	col = "Gy"
  elsif $game_variables[@prog][4] == 1 #SHADOW BW
	col = "BW"  
  elsif $game_variables[@prog][4] == 2 #SHADOW GREEN
	col = "Gr"  
  elsif $game_variables[@prog][4] == 3 #SHADOW BLUE
	col = "B"   
end 
  tatnum = $game_variables[@prog][5]
  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub tats
    if tatnum >= 4
      tatnum -= 4
    end  
  end  
  #TATTOO COL
  if tatnum == 0 #SHADOW GREY
	tatcol = "B"
  elsif tatnum == 1 #SHADOW BW
	tatcol = "G"  
  elsif tatnum == 2 #SHADOW GREEN
	tatcol = "R"  
  elsif tatnum == 3 #SHADOW BLUE
	tatcol = "Y"   
  elsif tatnum == 4 #SHADOW BLUE
	tatcol = "B2"  
  elsif tatnum == 5 #SHADOW BLUE
	tatcol = "G2"  
  elsif tatnum == 6 #SHADOW BLUE
	tatcol = "R2"  
  elsif tatnum == 7 #SHADOW BLUE
	tatcol = "Y2"    
  end 
  #HAIR COL  
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
     nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col
  if $game_variables[@prog][6] == 0 #YELLOW HAIR
	hcol = "Y"
  elsif $game_variables[@prog][6] == 1 #RED HAIR
	hcol = "R"  
  elsif $game_variables[@prog][6] == 2 #WHITE HAIR
	hcol = "W"  
  elsif $game_variables[@prog][6] == 3 #GREEN HAIR
	hcol = "Gr"  
  elsif $game_variables[@prog][6] == 4 #BLUE HAIR
	hcol = "B"  
  end 
      else
        if $game_variables[@prog][27] == 1
          hcol = "Y"
        elsif $game_variables[@prog][27] == 2
          hcol = "R"
        elsif$game_variables[@prog][27] == 3
          hcol = "W"
        elsif $game_variables[@prog][27] == 4
          hcol = "Gr"
        elsif $game_variables[@prog][27] == 5
          hcol = "B"
        elsif $game_variables[@prog][27] == 6
          hcol = "Spe"
        end                      
      end       
  ##############  
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
    xp = -340
	  yp = -45
    px = 100
	  py = 100
   end
	  if $game_switches[2411] == true    
		xp = 365
		yp = 345       
		px = 70
		py = 70         
		pos = 1     
	  elsif $game_switches[579] == true
		xp = 158
		yp = 240
		px = 50
		py = 50        
		pos = 1
	  elsif $game_switches[3529] == true #port center / LVLUp
		xp = 242 
		yp = 245
		px = 50
		py = 50   
		pos = 1
	  elsif $game_switches[3416] == true #Diary
		xp = 150 
		yp = 300
		px = 70
		py = 70   
		pos = 1
  end  
  @shadMaps = [125,531,532,533,535]
  if @shadMaps.include?$game_map.map_id
  $game_map.screen.pictures[111].show("ShadowPShabrace", pos, xp, yp, px, py, 255, 0)  
  expB = "ShadowPexpSha"
    else
	$game_map.screen.pictures[111].show("ShadowPbrace", pos, xp, yp, px, py, 255, 0)
  expB = "ShadowPexp"
  end
  expE = "Std"
	if $game_variables[2051] == 0 
	 expE = "Std"
	elsif $game_variables[2051] == 1 
	 expE = "Sad"
	elsif $game_variables[2051] == 2 
	 expE = "Rage"
	elsif $game_variables[2051] == 3 
	 expE = "Love"
  elsif $game_variables[2051] == 4 
  	expE = "Tch"
	elsif $game_variables[2051] == 5 
	  expE = "Glad"    
  elsif $game_variables[2051] == 6 || $game_variables[2051] == 7 
    expE = "Eye"
    if !@shadMaps.include?$game_map.map_id
      expE = "Std"
    end      
	 end        
	expr = expB + expE 
	$game_map.screen.pictures[112].show(expr, pos, xp, yp, px, py, 255, 0)        
	if inMenu == 0 
		$game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
		return 
		end
   else 
  #EXP
  if $game_variables[@prog][12] == 0 # STD ones vvv #
	expS = "F"
  elsif $game_variables[@prog][12] == 1
	expS = "M"  
  elsif $game_variables[@prog][12] == 2
	expS = "Y"  
  elsif $game_variables[@prog][12] == 3 # fanged ones vvv #
	expS = "FF"    
  elsif $game_variables[@prog][12] == 4
	expS = "MF"  
  elsif $game_variables[@prog][12] == 5
	expS = "YF"    
  end 
  # Shadow Exps #
  if shadM == "Sha"
   expS = "Sha"     
  end  
  # ###### #
  expE = "Std"
	if $game_variables[2051] == 66 
		expE = ["Std","Sad","Rage","Love","Tch","Eye"].sample
  end  
	if $game_variables[2051] == 0 
		expE = "Std"
  elsif $game_variables[2051] == 1 
		expE = "Sad"
  elsif $game_variables[2051] == 2 
		expE = "Rage"
  elsif $game_variables[2051] == 3 
		expE = "Love"
  elsif $game_variables[2051] == 4 
		expE = "Tch" 
  elsif $game_variables[2051] == 5
		expE = "Glad"  
  elsif $game_variables[2051] == 6 || $game_variables[2051] == 7
		expE = "Eye"     
    if shadM != "Sha"
      expE = "Std"
    end  
  end
#voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 85  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS     
  #iif $game_variables[@prog][1] == 0   
  if shadM == ""
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n"    
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
	 #$game_map.screen.pictures[112].show("PlaCrown", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 
	 cost = "m"
   $game_map.screen.pictures[120].show("ShaHm", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4004] == true || $game_variables[@prog][17] == 4 
	 cost = "s"
   $game_map.screen.pictures[111].show("ShaHsb", pos, xp, yp, px, py, 255, 0)
   $game_map.screen.pictures[120].show("ShaHs", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"    
   expS = cost
	 $game_map.screen.pictures[120].show("ShaHp", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6 
	 cost = "b"  
   expS = cost
   $game_map.screen.pictures[120].show("ShaHb", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 
	 cost = "u"      
	 $game_map.screen.pictures[120].show("ShaHu", pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   $game_map.screen.pictures[120].show("ShaHq", pos, xp, yp, px, py, 255, 0)   
  elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 #cost = "w"
	 cost = ""
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"  
   expS = cost
   $game_map.screen.pictures[120].show("ShaHH20", pos, xp, yp, px, py, 255, 0)  
  elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
  elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"     
   acc = "ShaHF20"
	 if $game_variables[@prog][3] == 0
		  acc += "StdF"           
   elsif $game_variables[@prog][3] == 1
		  acc += "SliF"
   elsif $game_variables[@prog][3] == 2
		  acc += "ShoF"   
   else
      acc += "StdF" 
   end   
   $game_map.screen.pictures[112].show(acc, pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5" 
   end    
	#if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	#   if $game_variables[@prog][3] == 0
	#   	  bod = "ChuStdF"          
  #   elsif $game_variables[@prog][3] == 1
	#  	  bod = "ChuSliF"
  #   elsif $game_variables[@prog][3] == 2
	#  	  bod = "ChuShoF"      
  #   end  
  # end    
  end # shadM == ""
end
# EXPRESSIONS
if expS != "Sha" && cost != "b" && cost != "H20" && cost != "p"
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
   elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
   elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end     
end  
  expr = expB + expS + expE
  if @ski == "Spooky" && expS != "Sha" 
    expr = "ShaExpSpoop"
  end     
  $game_map.screen.pictures[119].show(expr, pos, xp, yp, px, py, 255, 0) 
  # COSTUMES
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
	if $game_variables[@prog][3] == 0
		  bod = "StdF"           
  elsif $game_variables[@prog][3] == 1
		  bod = "SliF"
  elsif $game_variables[@prog][3] == 2
		  bod = "ShoF"
  elsif $game_variables[@prog][3] == 3
		  bod = "StdM"
  elsif $game_variables[@prog][3] == 4
		  bod = "BigM"         
	end
  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
    cost = ""
   if $game_variables[@prog][3] == 0
	 	  bod = "ChuStdF"          
    elsif $game_variables[@prog][3] == 1
		  bod = "ChuSliF"
    elsif $game_variables[@prog][3] == 2
	 	  bod = "ChuShoF"      
    end  
end      
  if shadM != "Sha"
  # EAR
  if $game_variables[@prog][11] == 0
	 earS = "Lon"
   elsif $game_variables[@prog][11] == 1
	 earS = "Sho"
   elsif $game_variables[@prog][11] == 2
	 earS = "Rou"
  end
  shaear = "ShaEar" + earS + col
	  $game_map.screen.pictures[116].show(shaear, pos, xp, yp, px, py, 255, 0)  
  # PIERCE
  if $game_variables[@prog][13] == 1
	  pierce = "ShaPierce" + earS
	  $game_map.screen.pictures[117].show(pierce, pos, xp, yp, px, py, 255, 0)
  end    
  end
  # Hairstyles 
  needHb = 0
    if $game_variables[@prog][26] == 0 
  if $game_variables[@prog][7] == 0
	hs = "Swi"
	needHb = 1
  elsif $game_variables[@prog][7] == 1
	hs = "Vsho"  
  elsif $game_variables[@prog][7] == 2
	hs = "Bra"
  elsif $game_variables[@prog][7] == 3
	hs = "Pon"  
  elsif $game_variables[@prog][7] == 4
	hs = "Sho"
  elsif $game_variables[@prog][7] == 5
	hs = "Tuf"
  elsif $game_variables[@prog][7] == 6
	hs = "Sli" 
  elsif $game_variables[@prog][7] == 7
	hs = ""  #BAAAALD
  end 
   else
    if $game_variables[@prog][26] == 1
       hs = "Bun"
  elsif $game_variables[@prog][26] == 2
       hs = "For"   
  elsif $game_variables[@prog][26] == 3
       hs = "Lon"   
  elsif $game_variables[@prog][26] == 4
       hs = "Smo"   
       needHb = 1
  elsif $game_variables[@prog][26] == 5
       hs = "Twi"   
     end 
   end      
  if shadM == "Sha"
    col = "Sha"
    hcol = "Sha"
    expS = "Sha"
    tpSha = 240
  end   
  # HEAD
  if cost == "p" #no hair
    hs = ""
  end  
	hf = "ShaH" + hs + hcol
	$game_map.screen.pictures[118].show(hf, pos, xp, yp, px, py, tpSha, 0)
	if needHb == 1
	  hfB = "ShaH" + hs + hcol + "b"
	  $game_map.screen.pictures[112].show(hfB, pos, xp, yp, px, py, tpSha, 0)
	end     
  # BODY
  body = base + bod + col
  $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, tpSha, 0)
  # TATTOOS
  tattoo = "ShaTat" + bod +  tatcol + shadM
  $game_map.screen.pictures[114].show(tattoo, pos, xp, yp, px, py, tpSha, 0)  
  # COSTUME
  if cost != "n" && shadM != "Sha"
  dre = baseDre + bod + cost
  $game_map.screen.pictures[115].show(dre, pos, xp, yp, px, py, 255, 0)
  end  
  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 0
	@c2= 95
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end     
  #-------------------------------------
  if $game_variables[@prog][0] == 16
  #FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#    
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
  elsif $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
  elsif $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
  elsif $game_variables[4000][2] == 4
		  #prey
		$game_variables[2051] = 4    
	  end  
	end       
		  xp = -265
		  if $game_variables[@prog][3] == 5
			xp += 70
		  end  
		  yp = 0        
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  px = 80
		  py = 80   
		  xp = 50
		  yp = 0
		  end
		if $game_switches[2411] == true
		  px = 50
		  py = 50        
		 if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 5
		  xp = 205 + @bon
		  yp = 145
		else
		  xp = 175 + @bon
		  yp = 145
		end
		  xp = 365
		  yp = 345
		end
	  if $game_switches[579] == true
		  px = 40
		  py = 40        
		 if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 5
		  xp = 15
		  yp = 90
		else
		  xp = 0
		  yp = 90
		end          
	  end 
		if $game_switches[3529] == true
		  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 45
		  py = 45 
		 if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 5
		  xp += 20
		end  
		 if $game_variables[@prog][3] == 4
		  xp -= 20
		end       
	  end    
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end    
  cost = ""
  bod = ""
  col = ""
  head = ""
  heS = ""
  tail = ""
  taS = ""
  wings = ""
  wiS = ""
  expS = ""
  expE = ""
  draexp = ""
  xbun = ""
  ybun = ""
  maidh = ""
  basedre = "DraDre"
  base = "DraBod"    
  if $game_variables[@prog][19] == 2
   if inMenu == 0 
    pos = 0
		xp = -300
		yp = -115
   end    
  bod = "WyvernPbodShade"
  exp = "WyvernPExp"  
	if $game_variables[2051] == 0 
    exp += "Std"
	   elsif $game_variables[2051] == 1 
    exp += "Sad"
	   elsif $game_variables[2051] == 2 
    exp += "Rage"
	   elsif $game_variables[2051] == 3 
    exp += "Love"
	   elsif $game_variables[2051] == 4 
    exp += "Scared"
	   elsif $game_variables[2051] == 4 
    exp += "Embarass"    
  end    
  $game_map.screen.pictures[111].show(bod, pos, xp, yp, px, py, 255, 0)
  $game_map.screen.pictures[112].show(exp, pos, xp, yp, px, py, 255, 0)  
	 if inMenu == 0 
	 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	 return 
	 end
  else    
  #########
  ####### EXP #########
  #########
  if $game_variables[@prog][3] == 5 #seahorse progeny
	expS = "S"
  elsif $game_variables[@prog][12] == 0
	expS = ""
  else
	expS = "F"
  end  
  if $game_variables[2051] == 0 
	   expE = "Std"
  elsif $game_variables[2051] == 1 
	   expE = "Sad"
  elsif $game_variables[2051] == 2 
	   expE = "Rage"
  elsif $game_variables[2051] == 3 
	   expE = "Love"
  elsif $game_variables[2051] == 4 
	   expE = "Prey"     
   end     
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end            
	draexp = "DraExp" + expS + expE
  if @ski == "Spooky" 
    if $game_variables[@prog][3] == 5 #seahorse progeny
     draexp = "DraExpSSpoop"  
   else
     draexp = "DraExpSpoop"  
     end
  end
	$game_map.screen.pictures[118].show(draexp, pos, xp, yp, px, py, 255, 0)
   ### ############ ###
   txp = xp
   typ = yp
		 if $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 3
   typ -= 40
		 end  
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1
	 cost = "n" 
   else
   if $game_switches[4024] == true || $game_variables[@prog][17] == 41 #wyv SS
	 cost = "s"
   elsif $game_switches[4001] == true || $game_variables[@prog][17] == 1 
	 cost = "d"
   elsif $game_switches[4003] == true || $game_variables[@prog][17] == 3 #dragon maid
	 cost = "m"
		if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 5
		  bod = "S"      
		elsif $game_variables[@prog][3] == 1
		  bod = "1"          
		elsif $game_variables[@prog][3] == 2
		  bod = "2"          
		elsif $game_variables[@prog][3] == 3
		  bod = "3"         
		elsif $game_variables[@prog][3] == 4 #male
		  bod = "S"        
		end     
   maidh = "DraMaidBonnet" + bod
   $game_map.screen.pictures[119].show(maidh, pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4030] == true || $game_variables[@prog][17] == 30 #pierced
	 cost = "pie"
   elsif $game_switches[4004] == true
	 if @dra != 0
	  if @dra == 10
	  cost = "sI"
	  elsif @dra == 11
	  cost = "sII"
	  end 
  	end 
   elsif $game_variables[@prog][17] == 4 #dpI
	 cost = "sI"
   elsif $game_variables[@prog][17] == 40 #dpII
	 cost = "sII"
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 #dragon prisoner
	 cost = "p"
   elsif $game_switches[4006] == true || $game_variables[@prog][17] == 6
	 cost = ""
   elsif $game_switches[4007] == true || $game_variables[@prog][17] == 7 #dragon bunnies
	 cost = "u"
   xbun = xp
   if $game_variables[@prog][3] == 5
		  xbun = xp - (1 * px)  
   end   
   ybun = yp - (0.69 * px)
	 $game_map.screen.pictures[111].show("DraBunMaskb", pos, xbun, ybun, px, py, 255, 0)
	 $game_map.screen.pictures[119].show("DraBunMask", pos, xbun, ybun, px, py, 255, 0)   
   elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8 #courtesan
	 cost = "q"
   elsif $game_switches[4009] == true || $game_variables[@prog][17] == 9 #nun
	 cost = "c"
	 if $game_variables[@prog][3] != 5
	 $game_map.screen.pictures[119].show("DraNunHood", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4010] == true || $game_variables[@prog][17] == 10 #queen worker
	 cost = "w"
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18
	 cost = "x1I"   
   elsif $game_switches[4018] == true 
	 if @dra == 10
	 cost = "x1I"
   else
	 cost = ""
   end
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 if $game_variables[@prog][3] == 5
	 $game_map.screen.pictures[111].show("DraH20Mask4", pos, xp, yp, px, py, 255, 0)
   else
	 $game_map.screen.pictures[111].show("DraH20Mask", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 if $game_variables[@prog][3] == 5
	 $game_map.screen.pictures[119].show("DraC20Mask4", pos, xp, yp, px, py, 255, 0)
   else
	 $game_map.screen.pictures[119].show("DraC20Mask", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"
	 $game_map.screen.pictures[111].show("DraF20Maskb", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[119].show("DraF20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"   
   elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #reined ride
	 cost = "x0"
	 xbask = xp
	 if $game_variables[@prog][3] == 0 #snakedra
	   xbask += 0.4 * px
	 elsif $game_variables[@prog][3] == 5 #seadra
	   xbask -= 0 * px
	 end  
	 $game_map.screen.pictures[111].show("DraX0Carry", pos, xbask, yp, px, py, 255, 0)
   if $game_variables[@prog][3] == 5 #no waterDra 
	  heS = "4"
  elsif $game_variables[@prog][7] == 0
		heS = "Hor"
  elsif $game_variables[@prog][7] == 1
		heS = "Uni"
  elsif $game_variables[@prog][7] == 2
		heS = "Thi"
  elsif $game_variables[@prog][7] == 3
		heS = "Jet"
  elsif $game_variables[@prog][7] == 4
		heS = "Wat"
	  end
	 mask = "DraX0Mask" + heS
	 $game_map.screen.pictures[119].show(mask, pos, xp, yp, px, py, 255, 0)
  end     
  	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
  	 cost = "Chu"  
    end   
  end   
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
		if $game_variables[@prog][3] == 0
		  bod = "S"      
		elsif $game_variables[@prog][3] == 1
		  bod = "1"          
		elsif $game_variables[@prog][3] == 2
		  bod = "2"          
		elsif $game_variables[@prog][3] == 3
		  bod = "3"         
		elsif $game_variables[@prog][3] == 5
		  bod = "4"
		elsif $game_variables[@prog][3] == 4
		  bod = "M"        
		end   
		  if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0
			if $game_variables[@prog][3] == 1 || $game_variables[@prog][3] == 2
			 bod = "12Chu" 
			  else
			bod += "Chu"
		  end        
		  end
  ### COLOR      
   if $game_variables[@prog][4] == 0 #YELLOW DRAKE
	  col = "Y"
   elsif $game_variables[@prog][4] == 1 #RED DRAKE
	  col = "R"
   elsif $game_variables[@prog][4] == 2 #BLUE DRAKE
	  col = "B"
   elsif $game_variables[@prog][4] == 3 #GREEN DRAKE
	  col = "G"
   elsif $game_variables[@prog][4] == 4 #BLACK DRAKE
	  col = "K"
   elsif $game_variables[@prog][4] == 5 #WHITE DRAKE
	  col = "W"  
	end
  ###  
  if $game_variables[@prog][3] != 5
  ### WINGS
	 if $game_variables[@prog][5] == 0
	   wiS = "L"
	 elsif $game_variables[@prog][5] == 1
	   wiS = "C"
	 elsif $game_variables[@prog][5] == 2
	   wiS = "S"
	 end 
	 wings = "DraW" + wiS + col 
	$game_map.screen.pictures[112].show(wings, pos, xp, yp, px, py, 255, 0)
  ### TAIL
	if $game_variables[@prog][3] != 0 && $game_variables[@prog][3] != 5 #no snake/seadra
	if $game_variables[@prog][6] == 1
		taS = "Std" 
  elsif $game_variables[@prog][6] == 2
		taS = "Plu" 
  elsif $game_variables[@prog][6] == 3
		taS = "Clu" 
  elsif $game_variables[@prog][6] == 4
		taS = "Fin" 
  elsif $game_variables[@prog][6] == 5
		taS = "Mas" 
   end    
	tail = "DraT" + taS + col
	$game_map.screen.pictures[113].show(tail, pos, txp, typ, px, py, 255, 0)
	end
  ### HEAD
	if $game_variables[@prog][7] == 0
		heS = "Hor"
  elsif $game_variables[@prog][7] == 1
		heS = "Uni"
  elsif $game_variables[@prog][7] == 2
		heS = "Thi"
  elsif $game_variables[@prog][7] == 3
		heS = "Jet"
  elsif $game_variables[@prog][7] == 4
		heS = "Wat"
	  end  
	head = "DraH" + heS + col
	$game_map.screen.pictures[116].show(head, pos, xp, yp, px, py, 255, 0)
  ### SPOTS
	if $game_variables[@prog][11] == 1
	  spots = "DraSpot" + col
	  $game_map.screen.pictures[117].show(spots, pos, xp, yp, px, py, 255, 0)
	end 
  ###
  end
   dress =  basedre + bod + cost 
	  $game_map.screen.pictures[115].show(dress, pos, xp, yp, px, py, 255, 0)
	  if $game_variables[@prog][1] == 0
		  body = base + bod + col + "n"
		else
		  body = base + bod + col 
		end     
	  $game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
		 $game_map.screen.pictures[122].show("dialogueframe", 0, 0, 0, px, py, 255, 0)
	   end
	 end   
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= -30
	@c2= 65
	@c3= 45
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end   
  #--------------------  
  if $game_variables[@prog][0] == 21 #Drider Prog
    #puts($game_variables[@prog].to_s)
   #FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#     
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  elsif $game_variables[4000][2] == 1 || $game_variables[4000][2] == 6
		  #sad        
		$game_variables[2051] = 1   
	  elsif $game_variables[4000][2] == 2 || $game_variables[4000][2] == 5
		  #rage        
		$game_variables[2051] = 2   
	  elsif $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  elsif $game_variables[4000][2] == 4
		  #prey
		$game_variables[2051] = 4    
	  end  
	end    
		xp = -230
		yp = 0
   if $game_variables[@prog][3] == 3
	   yp += 20
   end     
    if $game_switches[3215] == true #centerhead
      pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end    
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 50
		  yp = -45
	if $game_variables[@prog][3] == 3
		  xp = 40
		  yp = 0
   end           
		end
		if $game_switches[2411] == true    
		  px = 70
		  py = 70
		  xp = 365
		  yp = 345     
		 if $game_variables[@prog][3] == 3 #humanlike body
			xp -= 55
			yp += 20 
		  end           
	  end
		if $game_switches[3529] == true
  xp = 238 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		  if $game_variables[@prog][3] == 3
	xp -= 45
  end   
		  if $game_variables[@prog][3] == 4
	xp -= 20
	end   
		end  
			if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end
	cost = ""
  #iif $game_variables[@prog][1] == 0   
  if @prog == 7428 #shiruku
	$game_map.screen.pictures[111].show("DriCrown", pos, xp, yp, px, py, 255, 0)
  end    
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1  #naked
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1  #regalia
	 cost = "d"
	  $game_map.screen.pictures[111].show("DriCrown", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[121].show("DriC20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #chill 2020
	 cost = "f20"
	 if $game_variables[@prog][3] == 0
	  bodFl= "Tar"
	   elsif $game_variables[@prog][3] == 1
	  bodFl= "Wid"
	   elsif $game_variables[@prog][3] == 2
	  bodFl= "Ush"
	   elsif $game_variables[@prog][3] == 3
	  bodFl= "Hum"
	   elsif $game_variables[@prog][3] == 4  
	  bodFl= "Jum"
	end  
	bodyBFl = "DriDre" + bodFl + "f20b"
	$game_map.screen.pictures[115].show(bodyBFl, pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #net
	 cost = "x0"     
	 if $game_variables[@prog][3] == 0
	  bodFl= "Tar"
	   elsif $game_variables[@prog][3] == 1
	  bodFl= "Wid"
	   elsif $game_variables[@prog][3] == 2
	  bodFl= "Ush"
	   elsif $game_variables[@prog][3] == 3
	  bodFl= "Hum"
	   elsif $game_variables[@prog][3] == 4  
	  bodFl= "Jum"
	end  
	bodyBFl = "DriDre" + bodFl + "x0b"   
  $game_map.screen.pictures[115].show(bodyBFl, pos, xp, yp, px, py, 255, 0)
  elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #drider ballgown
	 cost = "x1" 
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5" 
	 $game_map.screen.pictures[121].show("Drix5Mask", pos, xp, yp, px, py, 255, 0)   
  end  
	if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"  
   end  
  end       
  #end 
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
  ###########   EXPRESSIONS   ###########
  #######################################
  expS = ""
  if $game_variables[@prog][11] == 0
	  expS = ""
  elsif $game_variables[@prog][11] == 1
	  expS = "6"
  elsif $game_variables[@prog][11] == 2
	  expS = "B"
  elsif $game_variables[@prog][11] == 3
	  expS = "E"
  end  
  if @prog == 7428 #shiruku
	expS = "Or"
  end    
  #######################################  
  expE = "Std"
  if $game_variables[2051] == 0
		  expE = "Std"
  elsif $game_variables[2051] == 1 
		  expE = "Sad"
  elsif $game_variables[2051] == 2 
		  expE = "Rage"
  elsif $game_variables[2051] == 3 
		  expE = "Love"
  elsif $game_variables[2051] == 4 
		  expE = "Prey"
    end  
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end          
  exp = "DriExp" + expS + expE
  if @ski == "Spooky" 
    exp = "DriExpSpoop"
  end   
  $game_map.screen.pictures[120].show(exp, pos, xp, yp, px, py, 255, 0)
  #######################################
	if $game_variables[@prog][3] == 3    
	base = "DriBod"  
	else
	base = "DriTop"  
	end
	baseSpi = "DriSpi"
	baseDre = "DriDre" 
	baseB = "DriB"
	basecl = "DriClaw"
	baseH = "DriH"
   ##########
   #BODIES #
   ##########  
  if $game_variables[@prog][3] == 0
	bod = "Tar"
  elsif $game_variables[@prog][3] == 1
	bod = "Wid"
  elsif $game_variables[@prog][3] == 2
	bod = "Ush"
  elsif $game_variables[@prog][3] == 3
	bod = "Hum"
  elsif $game_variables[@prog][3] == 4  
	bod = "Jum"
  end   
   ##########
   #COLORS #
   ##########
	 if $game_variables[@prog][5] == 0 #PURPLE FUR   
	   col2 = "Pur"
  elsif $game_variables[@prog][5] == 1 #GREY FUR   
	   col2 = "Gri"
  elsif $game_variables[@prog][5] == 2 #WHITE FUR  
	  col2 = "Whi"     
  elsif $game_variables[@prog][5] == 3 #GREEN FUR   
	  col2 = "Gre"   
  elsif $game_variables[@prog][5] == 4 #RED/BLACK FUR   
	  col2 = "Bla"   
	  end
  if $game_variables[@prog][4] == 0 #PURPLE DRIDER
	col1 = "Pur"
  elsif $game_variables[@prog][4] == 1 #VIOLET DRIDER
	col1 = "Vio"   
  elsif $game_variables[@prog][4] == 2 #WHITE DRIDER
	col1 = "Whi"
  elsif $game_variables[@prog][4] == 3 #GREEN DRIDER
	col1 = "Gre"
  elsif $game_variables[@prog][4] == 4 #BLACK DRIDER
	col1 = "Bla"
  end  
  if @prog == 7428 #shiruku
  col1 = "Bla"
	col2 = "Or"  
end  
  # alt col?
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
	 nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col      
	hcol = col2
  else
	if $game_variables[@prog][27] == 1  #PURPLE HAIR
  hcol = "Pur"     
  elsif $game_variables[@prog][27] == 2  #GREY HAIR
  hcol = "Gri"       
  elsif $game_variables[@prog][27] == 3  #WHITE HAIR
  hcol = "Whi"   
  elsif $game_variables[@prog][27] == 4  #GREEN HAIR
  hcol = "Gre"   
  elsif $game_variables[@prog][27] == 5  #BLACK HAIR
  hcol = "Bla"    
  elsif $game_variables[@prog][27] == 6  #SPECIAL HAIR
  hcol = "Spe"  
  end
  end
   ##########
   #SPIDER # no chub
   ##########
   if $game_variables[@prog][3] != 3
   bodySpi = baseSpi + bod + col2
   $game_map.screen.pictures[115].show(bodySpi, pos, xp, yp, px, py, 255, 0)  
  end  
   ##########
   #BACKS# sometimes no chub
   ##########
	 baseB= "DriB"
	 bodyB = baseB + bod + col2
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	if $game_variables[@prog][3] == 0 || $game_variables[@prog][3] == 1
	 baseB= "DriBChu"
	 bodyB = baseB + col2
	end
  end 
  $game_map.screen.pictures[114].show(bodyB, pos, xp, yp, px, py, 255, 0)
   ##########
   #CHUB?#
   ##########
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 if $game_variables[@prog][3] == 3
	 bod = "ChuHum"  
	   else
	 bod = "Chu"
   end
   end
   ##########
   #HAIR#
   ##########
  needHb = 0
  needEar = 0
    if $game_variables[@prog][26] == 0 
   if $game_variables[@prog][7] == 0
	 ha = "Lon"
   needHb = 1
   needEar = 1
  elsif $game_variables[@prog][7] == 1
	 ha = "Flo"
   needHb = 1
  elsif $game_variables[@prog][7] == 2
	 ha = "Bob"
   needEar = 1
  elsif $game_variables[@prog][7] == 3
	 ha = "Pig"
  elsif $game_variables[@prog][7] == 4
	 ha = "Pun"
   end   
 else
   #hair Fix
    if $game_variables[@prog][26] > 5
      $game_variables[@prog][26] = [1,2,3,4,5].sample
    end  
    if $game_variables[@prog][26] == 1
       ha = "Sho"
  elsif $game_variables[@prog][26] == 2
       ha = "Gei"   
  elsif $game_variables[@prog][26] == 3
       ha = "Gei2"   
  elsif $game_variables[@prog][26] == 4
       ha = "Pun2"  
  elsif $game_variables[@prog][26] == 5
       ha = "Sof"   
     end 
   end      
   hair = baseH + ha + hcol
  $game_map.screen.pictures[117].show(hair, pos, xp, yp, px, py, 255, 0)
	if needHb == 1
	  hfB = "DriH" + ha + hcol + "b"
	  $game_map.screen.pictures[113].show(hfB, pos, xp, yp, px, py, 255, 0)
	end 
	if needEar == 1
	  ear = "DriEar" + col1
	  $game_map.screen.pictures[112].show(ear, pos, xp, yp, px, py, 255, 0)
	end   
   ##########
   #CLAW#
   ##########
   if $game_variables[@prog][6] != 0
	 cl = ""
	 if $game_variables[@prog][6] == 1
	  cl = ""
	 elsif $game_variables[@prog][6] == 2
	  cl = "F"
	 end
  claw = basecl + cl + bod + hcol
  $game_map.screen.pictures[119].show(claw, pos, xp, yp, px, py, 255, 0)
  end
   ##########
   #HUMAN #
   ##########
   if $game_variables[@prog][1] == 0
	 body = base + bod + col1 + "n"
   else
	 body = base + bod + col1
  end 
  $game_map.screen.pictures[116].show(body, pos, xp, yp, px, py, 255, 0)
   ##########
   #DRESS #
   ##########
   if cost == ""
   dress = "DriDre" + bod + col2  
	 else
   dress = "DriDre" + bod + cost 
   end
   $game_map.screen.pictures[118].show(dress, pos, xp, yp, px, py, 255, 0)
   ##########
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #       
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 35
	@c2= 15
	@c3= 55
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end
  #--------------------  
   if $game_variables[@prog][0] == 22
   #FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#      
	if $game_variables[4000][0] == 1
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #prey
		$game_variables[2051] = 4    
	  end  
	end       
		  xp = -40
	  if $game_variables[@prog][3] != 3    
		  yp = -75       
		else
		  yp = -85
	  end    
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end     
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 160
		  yp = -110
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70        
		  xp = 395
		  yp = 315
		end
	  if $game_switches[579] == true
		  px = 50
		  py = 50        
		  xp = 35
		  yp = 70
		end 
	  if $game_switches[3529] == true
  xp = 258 #port center without ADV menu check
		  yp = 252
		  px = 50
		  py = 50   
		end        
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end           
  if $game_variables[4000][3] == 1 #naked
	  $game_switches[4002] = true  
  end  
	cost = ""    
  #iif $game_variables[@prog][1] == 0   
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1  #naked
	 cost = "n" 
  else
   if $game_switches[4001] == true || $game_variables[@prog][17] == 1  #regalia
	 cost = "d"
		 if @prog == 4022
		  if $game_variables[@prog][3] == 3
		  $game_map.screen.pictures[111].show("LamCrownGorgon", pos, xp, yp, px, py, 255, 0)
		else
		  if $game_variables[@prog][7] == 0
		 $game_map.screen.pictures[111].show("LamCrownSkele", pos, xp, yp, px, py, 255, 0) 
  elsif $game_variables[@prog][7] == 1
		  $game_map.screen.pictures[111].show("LamCrownPhara", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][7] == 2
		  $game_map.screen.pictures[111].show("LamCrownAfro", pos, xp, yp, px, py, 255, 0)
  elsif $game_variables[@prog][7] >= 3
		  $game_map.screen.pictures[111].show("LamCrownStd", pos, xp, yp, px, py, 255, 0)
		  end 
		 end  
	   end  
	 elsif $game_switches[4008] == true || $game_variables[@prog][17] == 8  #court
	 cost = "q" 
	 if $game_variables[@prog][7] != 2 #afro
	 $game_map.screen.pictures[118].show("LamHeadq", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4009] == true || $game_variables[@prog][17] == 9  #nun
	 cost = "c" 
	 if $game_variables[@prog][7] != 2 #afro
	 $game_map.screen.pictures[118].show("LamNunHood", pos, xp, yp, px, py, 255, 0)
	 end
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[118].show("LamH20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[118].show("LamC20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[118].show("LamF20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4018] == true || $game_variables[@prog][17] == 18 #quetza
	 cost = "x1"    
	 $game_map.screen.pictures[118].show("LamX1Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4023] == true || $game_variables[@prog][17] == 23 #coloss 2
	 cost = "x6"    
	 $game_map.screen.pictures[118].show("LamX6Mask", pos, xp, yp, px, py, 255, 0)   
  end    
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
   end     
   end
  #end
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  #######################################
  base = "LamBod"
  basedre = "LamDre"
  exp = ""
  expE = ""
  expS = ""
		  if $game_variables[@prog][3] == 0
		  bod = "P"
  elsif $game_variables[@prog][3] == 1
		  bod = "S"
  elsif $game_variables[@prog][3] == 2
		  bod = "C"
  elsif $game_variables[@prog][3] == 3
		  bod = "G"
  elsif $game_variables[@prog][3] == 4
		  bod = "M"
		end 
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 if $game_variables[@prog][3] == 3
	   bod = "GChu"
	 else
	 bod = "Chu"
	 end
   end       
	  if $game_variables[@prog][5] == 0 #RED SCALES
		col = "R"
	  elsif $game_variables[@prog][5] == 1 #GREY SCALES
		col = "Gy"
	  elsif $game_variables[@prog][5] == 2 #GREEN SCALES
		col = "G"   
	  elsif $game_variables[@prog][5] == 3 #PURPLE SCALES
	  col = "P"   
	elsif $game_variables[@prog][5] == 4 #WHITE SCALES
	  col = "W"
	end 
  ###EXP###
  if $game_switches[4001] == true || $game_variables[@prog][17] == 1  #regalia
    expS = "r"
  else
    expS = ""
  end  
	if $game_variables[2051] == 0 
		 expE = "Std"
	 elsif $game_variables[2051] == 1 
		 expE = "Sad"
	 elsif $game_variables[2051] == 2 
		 expE = "Rage"
	 elsif $game_variables[2051] == 3 
		 expE = "Love"
	 elsif $game_variables[2051] == 4 
		 expE = "Prey"
   end  
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end          
  exp = "LamExp" + expE + expS
  if @ski == "Spooky" 
    exp = "LamExpSpoop"
  end 
  $game_map.screen.pictures[117].show(exp, pos, xp, yp, px, py, 255, 0)
  ###EXP###
   unless $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	   if $game_variables[@prog][6] == 1
		  if $game_variables[@prog][3] == 0
		  $game_map.screen.pictures[114].show("LamClaP", pos, xp, yp, px, py, 255, 0)
		  elsif $game_variables[@prog][3] == 1
		  $game_map.screen.pictures[114].show("LamClaS", pos, xp, yp, px, py, 255, 0)
		  elsif $game_variables[@prog][3] == 2
		  $game_map.screen.pictures[114].show("LamClaC", pos, xp, yp, px, py, 255, 0)
		  elsif $game_variables[@prog][3] == 3
		  $game_map.screen.pictures[114].show("LamClaG", pos, xp, yp, px, py, 255, 0)
		  elsif $game_variables[@prog][3] == 4
		  $game_map.screen.pictures[114].show("LamClaM", pos, xp, yp, px, py, 255, 0)
		end        
  end
  end
  ########
  #SKIN COLOR#
  ########
  if $game_variables[@prog][4] == 0 #STANDARD LAMIA
	sk = "H"
  elsif $game_variables[@prog][4] == 1 #TANNED LAMIA
	sk = "T"
  elsif $game_variables[@prog][4] == 2 #PURPLE LAMIA
	sk = "P"  
  end  
  ########
  #HAIR COLOR#
  ########
  unless $game_variables[@prog][3] == 3  
   nospeH = 0
   if $game_variables[@prog][27] == 6 && $game_variables[@prog][26] == 0 
     nospeH = 1
   end  
   if $game_variables[@prog][27] == 0 || nospeH == 1 #no cust col
  if $game_variables[@prog][11] == 0 #PINK HAIR
	hcol = "P"
  elsif $game_variables[@prog][11] == 1 #BLONDE HAIR
	hcol = "B"
  elsif $game_variables[@prog][11] == 2 #BLACK HAIR
	hcol = "K"
  elsif $game_variables[@prog][11] == 3 #GREEN HAIR
	hcol = "G"
  elsif $game_variables[@prog][11] == 4 #SILVER HAIR
	hcol = "S"
  end  
      else
        if $game_variables[@prog][27] == 1
          hcol = "P"
        elsif $game_variables[@prog][27] == 2
          hcol = "B"
        elsif$game_variables[@prog][27] == 3
          hcol = "K"
        elsif $game_variables[@prog][27] == 4
          hcol = "G"
        elsif $game_variables[@prog][27] == 5
          hcol = "S"
        elsif $game_variables[@prog][27] == 6
          hcol = "Spe"
        end                      
      end       
  ########
  #HAIR STYLE#
  ########
  #HAIR revert      
	if $game_variables[@prog][26] >= 6
	  $game_variables[@prog][26] = 0
	end       
  needb = 0
   if $game_variables[@prog][26] == 0 
  	if $game_variables[@prog][7] == 0
	  hsty = "Jol"
    elsif $game_variables[@prog][7] == 1
	  hsty = "Far"
    needb = 1
    elsif $game_variables[@prog][7] == 2
	  hsty = "Afr"
    elsif $game_variables[@prog][7] == 3
	  hsty = "Bra"
    elsif $game_variables[@prog][7] == 4
	  hsty = "Bob"
    end
   else
    if $game_variables[@prog][26] == 1
       hsty = "Rib"
  elsif $game_variables[@prog][26] == 2
       hsty = "Bra2"  
  elsif $game_variables[@prog][26] == 3
       hsty = "Bra3"   
  elsif $game_variables[@prog][26] == 4
       hsty = "Flo"   
  elsif $game_variables[@prog][26] == 5
       hsty = "Puf"   
     end 
   end      
  ########
  #HAIR DISPLAY# 
  ########
	 hair =  "LamH" + hsty + hcol 
	  $game_map.screen.pictures[116].show(hair, pos, xp, yp, px, py, 255, 0) 
	  if needb == 1
		hairb = "LamH" + hsty + hcol + "b"
		$game_map.screen.pictures[112].show(hairb, pos, xp, yp, px, py, 255, 0)
	  end 
  end #end of gorgon Stop
  ########
  #DRESS DISPLAY# 
  ########
	dress =  basedre + bod + cost 
	  $game_map.screen.pictures[115].show(dress, pos, xp, yp, px, py, 255, 0)   
  ########
  #BODY DISPLAY# 
  ########    
		if $game_variables[@prog][3] == 4
		  body = base + bod + sk + col 
		else
		  body = base + bod + sk + col + "n"
		end 
	   $game_map.screen.pictures[113].show(body, pos, xp, yp, px, py, 255, 0)
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #       
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end 
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 15
	@c2= 15
	@c3= 55
	@c4= 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end      
  #--------------------  
   if $game_variables[@prog][0] == 23 #FAIRIES
  #FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  else
	$game_variables[@prog][1] = 0
  end 
  #FIX#  
	if $game_variables[4000][0] == 1   
		if $game_variables[4000][2] == 0 || $game_variables[4000][2] == 10 || $game_variables[4000][2] == 11
		  #std
		$game_variables[2051] = 0    
	  end
		if $game_variables[4000][2] == 1
		  #sad        
		$game_variables[2051] = 1   
	  end
		if $game_variables[4000][2] == 2
		  #rage        
		$game_variables[2051] = 2   
	  end
		if $game_variables[4000][2] == 3
		  #love
		$game_variables[2051] = 3    
	  end
		if $game_variables[4000][2] == 4
		  #love
		$game_variables[2051] = 3    
	  end       
	  end
		  xp = -3
		  yp = 150
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 220
		  yp = 15
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70        
		  xp = 360
		  yp = 330
		end
	  if $game_switches[579] == true
		  px = 50
		  py = 50        
		  xp = 35
		  yp = 70
		end 
	  if $game_switches[3529] == true
		  xp = 225 #port center without ADV menu check
		  yp = 240
		  px = 50
		  py = 50   
		end        
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end
  cost = ""
   xh = xp
   yh = yp 
   xpa = 0
   ypa = 0
   xha = 0
   yha = 0 
	if $game_switches[4005] == true || $game_variables[@prog][17] == 5 #prison
	if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
   xpa = +0.1
   ypa = +0.3
   xha = -0.08
   yha = +0.74
	  else
   xpa = 0.2
   ypa = -0.3
   xha = -0.23
   yha = 0.57
  end 
  else
   if $game_variables[@prog][3] == 3 #BAZ
   xpa = 0.15
   ypa = 0
   xha = 0.15
   yha = 0
   end
   end 
   xpa *= px
   ypa *= px
   xha *= px
   yha *= px  
   xp += xpa
   yp += ypa
   xh += xha
   yh += yha    
  #iif $game_variables[@prog][1] == 0
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1  #naked
	 cost = "n" 
   else
   if $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[120].show("FaiH20Mask", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chill 2020
	 cost = "c20"    
	 $game_map.screen.pictures[120].show("FaiC20Mask", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[113].show("FaiC20Maskb", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"    
	 $game_map.screen.pictures[120].show("FaiF20Mask", pos, xp, yp, px, py, 255, 0)
	 elsif $game_switches[4017] == true || $game_variables[@prog][17] == 17 #x0 - Goth
	 cost = "x0"    
	 $game_map.screen.pictures[120].show("FaiX0Mask", pos, xp, yp, px, py, 255, 0)    
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5"    
	 $game_map.screen.pictures[120].show("FaiX5Mask", pos, xp, yp, px, py, 255, 0)   
   elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 #prison
	 cost = "Pri"  
   if $game_variables[@prog][4] == 0
	 c1 = "P"
  elsif $game_variables[@prog][4] == 1
	 c1 = "T"
  elsif $game_variables[@prog][4] == 2
	 c1 = "G"
   end
   if $game_variables[@prog][5] == 0
	 c2 = "B"
  elsif $game_variables[@prog][5] == 1
	 c2 = "Bl"
  elsif $game_variables[@prog][5] == 2
	 c2 = "G"
  elsif $game_variables[@prog][5] == 3
	 c2 = "Gy"
  elsif $game_variables[@prog][5] == 4
	 c2 = "P"
  elsif $game_variables[@prog][5] == 5
	 c2 = "Y"
   end 
   bodyh = "FaiBod" + cost + c1 + c2
   $game_map.screen.pictures[114].show(bodyh, pos, xp, yp, px, py, 255, 0) 
 end 
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 cost = "Chu"
   end   
 end   
  #end
  base = "FaiBod"
  basedre = "FaiDre"
  basew = "FaiW"
  basee = "FaiE"
  ear = ""
  bod = ""
  ha = ""
  hc = ""
  w = ""
  exp = ""
  expE = ""
  if cost != "Pri" #bb difference
	  if $game_variables[@prog][3] == 3
		bbadd = 0.15 * px
			xp += bbadd
			xh += bbadd
	  end 
	end        
  ###EXP### 
	  if $game_variables[2051] == 0 
		  expE = "Std"
		elsif $game_variables[2051] == 1 
		  expE = "Sad"
		elsif $game_variables[2051] == 2 
		  expE = "Rage"
		elsif $game_variables[2051] == 3 
		  expE = "Love"
		elsif $game_variables[2051] == 4 
		  expE = "Cry"
    end  
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end            
  exp = "FaiExp" + expE
  if @ski == "Spooky" 
    exp = "FaiExpSpoop"
  end    
  $game_map.screen.pictures[119].show(exp, pos, xh, yh, px, py, 255, 0)
  ###EXP###
  if cost != "Pri"
		  if $game_variables[@prog][3] == 0
		  bod = "Std"
		  elsif $game_variables[@prog][3] == 1
		  bod = "Leg"
		  elsif $game_variables[@prog][3] == 2
		  bod = "Sli"
		  elsif $game_variables[@prog][3] == 3
		  bod = "Baz"
	   	elsif $game_variables[@prog][3] == 4
		  bod = "Boi"
		end      
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #chub 
	 bod = "Chu"
   end       
  #######################################
  if $game_variables[@prog][1] == 1
	cost = ""
  end  
  ####################################### 
  if $game_variables[@prog][4] == 0 #Pale
	 col = "P"
  elsif $game_variables[@prog][4] == 1 #Tan
	  col = "T"
  elsif $game_variables[@prog][4] == 2 #Green
	  col = "G"   
	end 
  #####
  if $game_variables[@prog][5] == 0 #Brown
	 hc  = "B"
  elsif $game_variables[@prog][5] == 1 #Blue
	  hc  = "Bl"
  elsif $game_variables[@prog][5] == 2 #Green
	  hc  = "G"   
  elsif $game_variables[@prog][5] == 3 #Grey
	  hc  = "Gy"   
  elsif $game_variables[@prog][5] == 4 #Pink
	  hc = "P"
  elsif $game_variables[@prog][5] == 5 #Yellow
	  hc = "Y"
	end 
  #####
  if $game_variables[@prog][7] == 0 #Afro
	 ha = "Afr"
  elsif $game_variables[@prog][7] == 1 #Comb
	  ha = "Com"
  elsif $game_variables[@prog][7] == 2 #Hime
	  ha = "Him"   
  elsif $game_variables[@prog][7] == 3 #Pigtail
	  ha = "Pig"   
  elsif $game_variables[@prog][7] == 4 #Short
	  ha = "Sho"
  elsif $game_variables[@prog][7] == 5 #Silky
	  ha = "Sil"
	end 
  #####
  if $game_variables[@prog][6] == 0 #WINGS
	  w = "Std"
  elsif $game_variables[@prog][6] == 1 
	  w = "Lar"
  elsif $game_variables[@prog][6] == 2 
	  w = "But"   
  elsif $game_variables[@prog][6] == 3 
	  w = "Bat"   
	end 
  #####     
	wings = basew + w
	$game_map.screen.pictures[111].show(wings, pos, xp, yp, px, py, 255, 0)
  #####
	body = base + bod + col
	$game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
  #####  
  if $game_variables[@prog][11] == 1 #EAR
	ear = basee + col
	$game_map.screen.pictures[115].show(ear, pos, xp, yp, px, py, 255, 0)
  end  
  #####  
  if $game_variables[@prog][12] == 1 #Antennae
	$game_map.screen.pictures[117].show("FaiAnt", pos, xp, yp, px, py, 255, 0)
  end  
  #####
	if cost != "n"
	dress =  basedre + bod + cost
	  $game_map.screen.pictures[116].show(dress, pos, xp, yp, px, py, 255, 0) 
	end  
  #####
	hair = "FaiH" + ha + hc + "f"
	hairB = "FaiH" + ha + hc + "b"
	$game_map.screen.pictures[112].show(hairB, pos, xp, yp, px, py, 255, 0)
	$game_map.screen.pictures[118].show(hair, pos, xp, yp, px, py, 255, 0)
  #####
  end
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #       
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 20
	@c2= 10
	@c3= 75
	@c4= 40
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end          
  #--------------------  
   if $game_variables[@prog][0] == 24 #CRYSTALS  
		  px = 100
		  py = 100  
		  xp = -65
		  yp = 5 
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 160
		  yp = -40
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70        
		  xp = 340
		  yp = 330
		end
	  if $game_switches[579] == true
		  px = 50
		  py = 50        
		  xp = 35
		  yp = 70
		end 
	  if $game_switches[3529] == true
		  xp = 215 #port center without ADV menu check
		  yp = 245
		  px = 50
		  py = 50   
		end        
		  if $game_switches[3416] == true
		  xp = 140 #port center without ADV menu check
		  yp = 310
		  px = 70
		  py = 70   
		end      
  cost = ""
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1  #naked
	 cost = "n" 
   end
   if $game_switches[4016] == true || $game_variables[@prog][17] == 16 #bloom 2020
	 cost = "f20"
	 $game_map.screen.pictures[118].show("CryF20Mask", pos, xp, yp, px, py, 255, 0)
	 $game_map.screen.pictures[111].show("CryF20Maskb", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4015] == true || $game_variables[@prog][17] == 15 #chillbite 2020
	 cost = "c20"   
   elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	 $game_map.screen.pictures[118].show("CryH20Mask", pos, xp, yp, px, py, 255, 0)
  end   
  if $game_switches[5510] == true #dressed progeny on delivery
	cost = ""
  end  
  base = "CryBod"
  basedre = "CryDre"
  bod = ""
  bodex = ""
  ben = ""
  ha = ""
  exp = ""
  expE = ""
   xb = ""
   yb = ""
		  if $game_variables[@prog][3] == 0
		  bod = "Sli"
		  elsif $game_variables[@prog][3] == 1
		  bod = "Cur"
		  elsif $game_variables[@prog][3] == 2
		  bod = "Gen"
		  elsif $game_variables[@prog][3] == 3
		  bod = "Rel"
		end
  if $game_variables[@prog][11] == 1 #Cracked
	 bodex = "crack"
   end
  ##### 
   ben = "CryBen" + bod 
  #####
  if cost == "c20"
	col = "c20"
  else
  if $game_variables[@prog][4] == 0 #Amethyst
	 col = "Ame"
  elsif $game_variables[@prog][4] == 1 #Diamond
	  col = "Dia"
  elsif $game_variables[@prog][4] == 2 #Ruby
	  col = "Rub"   
  elsif $game_variables[@prog][4] == 3 #Lapislazuli
	  col = "Lap"   
  elsif $game_variables[@prog][4] == 4 #Zircon
	  col = "Zir"
  elsif $game_variables[@prog][4] == 5 #Bort
	  col = "Bor"
  elsif $game_variables[@prog][4] == 6 #Phosphophyllite
	  col = "Pho"
  elsif $game_variables[@prog][4] == 7 #Opal
	  col = "Opa"
	end 
	end
  #####
  if $game_variables[@prog][7] == 0 #Bangs
	 ha = "Ban"
  elsif $game_variables[@prog][7] == 1 #Emo
	  ha = "Emo"
  elsif $game_variables[@prog][7] == 2 #Braids
	  ha = "Bra"   
  elsif $game_variables[@prog][7] == 3 #Tufts
	  ha = "Tuf"   
  elsif $game_variables[@prog][7] == 4 #Blades
	  ha = "Bla"
  elsif $game_variables[@prog][7] == 5 #Short
	  ha = "Sho"
  elsif $game_variables[@prog][7] == 6 #Side Bangs
	  ha = "Sid"
	end 
  ###EXP###
  expE = "Calm"
	if $game_variables[2051] == 0 
		if $game_variables[@prog][3] == 3
		  expE = "Meditate"
		else    
		  expE = "Calm"
		end        
  elsif $game_variables[2051] == 1 
		  expE = "Disappoint"
  elsif $game_variables[2051] == 2 
		  expE = "Rage"
  elsif $game_variables[2051] == 3 
		  expE = "Love"
  elsif $game_variables[2051] == 4 
		 expE = "Surprise"
   end  
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expE = "Tsun"
  elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20 
    expE = "Yan"
    elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expE = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expE = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expE = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expE = "Nemu"
  end           
  exp = "CryExp" + expE
  if @ski == "Spooky"
    exp = "CryExpSpoop"
  end 
  $game_map.screen.pictures[114].show(exp, pos, xp, yp, px, py, 255, 0)
  ###EXP###
	if cost != "n"
	dress =  basedre + bod + cost 
	  $game_map.screen.pictures[117].show(dress, pos, xp, yp, px, py, 255, 0) 
	end  
  #####
	body = base + col + bod + bodex
   xb = xp
   yb = yp
   if cost == "c20"
   if $game_switches[3529] == true || $game_switches[3416] == true || $game_switches[2411] == true # pic center or diary
   xb = xp - (0.055*px)
   yb = yp - (1.02*px)
	  else
   xb = xp - (1.01*px)
   yb = yp - (2.04*px)
  end 
  end
	$game_map.screen.pictures[113].show(body, pos, xb, yb, px, py, 255, 0)
  #####
	hair = "CryH" + col + ha + "f"
	hairB = "CryH" + col + ha + "b"
	$game_map.screen.pictures[112].show(hairB, pos, xp, yp, px, py, 255, 0)
	$game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0)
  #####
  if $game_variables[@prog][1] == 1 && cost == "n" #Male 
	  $game_map.screen.pictures[116].show(ben, pos, xp, yp, px, py, 255, 0)
  end
  #####
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #       
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
  #### TONES ####
		#check skill#
if @ski == "Moonlit"
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 45
	@c2= 45
	@c3= 75
	@c4= 45
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####      
	 return
	 end 
  #--------------------  
   if $game_variables[@prog][0] == 25 #HOLSTAURI 
   #FIX#
  if $game_variables[@prog][3] == 4
	$game_variables[@prog][1] = 1
  elsif $game_variables[@prog][3] <= 2
	$game_variables[@prog][1] = 0
  end 
  #FIX#       
		  px = 100
		  py = 100  
		  xp = 35
		  yp = 30
    if $game_switches[3215] == true #centerhead
                 pos = 1
		  px = pxHead
		  py = pyHead 
		  xp = xpHead
		  yp = ypHead
    end       
		if $game_switches[2359] == true || $game_switches[2466] == true
		  xp = 260
		  yp = -20
		  end
		if $game_switches[2411] == true
		  px = 70
		  py = 70        
		  xp = 390
		  yp = 345
		end
	  if $game_switches[579] == true
		  px = 90
		  py = 100        
		  xp = 35
		  yp = 70
		end 
	  if $game_switches[3529] == true
		  xp = 255 #port center without ADV menu check
		  yp = 255
		  px = 50
		  py = 50   
		end        
		  if $game_switches[3416] == true
		  xp = 400 #port center without ADV menu check
		  yp = 340
		  px = 70
		  py = 70   
		end      
  cost = ""
  ymask = ""
  ymask = yp
  if $game_variables[@prog][1] == 1 #male
   ymask -= (0.3 * px)
  end  
  if $game_switches[4002] == true || $game_variables[@prog][17] == 2 || nkdCheat == 1  #naked
	 cost = "n" 
  else 
  if $game_switches[4004] == true || $game_variables[@prog][17] == 4
	 cost = "s"   
  elsif $game_switches[4005] == true || $game_variables[@prog][17] == 5 
	 cost = "p"
	 $game_map.screen.pictures[120].show("HolPMask", pos, xp, ymask, px, py, 255, 0)
	 $game_map.screen.pictures[111].show("HolMilkBox", pos, xp, yp, px, py, 255, 0)
   elsif $game_switches[4022] == true || $game_variables[@prog][17] == 22 #bartender
	 cost = "x5" 
	 $game_map.screen.pictures[120].show("Holx5Mask", pos, xp, yp, px, py, 255, 0)      
  elsif $game_switches[4013] == true || $game_variables[@prog][17] == 13 #hall 2020
	 cost = "h20"    
	if pos == 1
	  ymask -= (0.3 * px)
	else
	  ymask -= (0.6 * px)
	end  
	 $game_map.screen.pictures[120].show("HolH20Mask", pos, xp, ymask, px, py, 255, 0)
  end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 cost = "Chu"
   end  
  end   
  if $game_switches[5510] == true #dressed progeny on delivery
	cost = ""
  end    
	if $game_variables[@prog][1] == 1 && cost != "s" #kazak cow
	 cost = ""
  end   
  base = "HolBod"
  basedre = "HolDre"
  bod = ""
  col1 = ""
  col2 = ""
  ha = ""
  ear = ""
  earS = ""
  ha = ""
  hc = ""
  hair = ""
  hairB = ""
  acc = ""
  horn = ""
  hoS = ""
  dress = ""
	 if $game_variables[@prog][3] == 0
		  bod = "Std"
  elsif $game_variables[@prog][3] == 1
		  bod = "Cur"
  elsif $game_variables[@prog][3] == 2
		  bod = "Sli"
  elsif $game_variables[@prog][3] == 3
		  bod = "Futa"
  elsif $game_variables[@prog][3] == 4
		  bod = "Bull"        
		end
   if $game_variables[@prog][28] == 1 && $game_variables[@prog][1] == 0 #thicc
	 if $game_variables[@prog][3] == 3
		  bod = "FutaChu"
		else  
		  bod = "Chu"
	  end    
   end 
  ##### SKIN COLOR
  if $game_variables[@prog][4] == 0 #Std
	 col1 = "Std"
  elsif $game_variables[@prog][4] == 1 #Tanned
	  col1 = "Tan"
  elsif $game_variables[@prog][4] == 2 #Black
	  col1 = "Bla"
  end
  ##### FUR COLOR
  if $game_variables[@prog][1] == 1
  col2 = ""
  else
  if $game_variables[@prog][5] == 0 #BW
	 col2 = "BW"
  elsif $game_variables[@prog][5] == 1 #Brown
	  col2 = "Br"
  elsif $game_variables[@prog][5] == 2 #Purple
	  col2 = "P"
  elsif $game_variables[@prog][5] == 3 #White
	  col2 = "W"
  elsif $game_variables[@prog][5] == 4 #Grey
	  col2 = "Gy"
	end
  end  
  #####
	body = base + bod + col1 + col2
	$game_map.screen.pictures[114].show(body, pos, xp, yp, px, py, 255, 0)
	if $game_variables[@prog][1] == 1 #male
	 yp -= (0.3 * px)
	end  
  ##### EAR STYLE
  if $game_variables[@prog][6] == 0 #BW
	 earS = "Std"
  elsif $game_variables[@prog][6] == 1 #Brown
	  earS = "Up"
  elsif $game_variables[@prog][6] == 2 #Purple
	  earS = "Flop"
	end  
  ear = "HolE" + earS + col2
	$game_map.screen.pictures[113].show(ear, pos, xp, yp, px, py, 255, 0)
  ##### HAIR STYLE
  if $game_variables[@prog][7] == 0 #Pony
	 ha = "Pon"
  elsif $game_variables[@prog][7] == 1 #Long
	  ha = "Lon"
  elsif $game_variables[@prog][7] == 2 #Short
	  ha = "Sho"   
  elsif $game_variables[@prog][7] == 3 #Braids
	  ha = "Bra"   
  elsif $game_variables[@prog][7] == 4 #Wild
	  ha = "Wil"
	end 
  ##### HAIR COL
  if $game_variables[@prog][11] == 0 #Blue
	 hc = "B"
  elsif $game_variables[@prog][11] == 1 #Blonde
	  hc = "Bl"
  elsif $game_variables[@prog][11] == 2 #Brown
	  hc = "Br"   
  elsif $game_variables[@prog][11] == 3 #Red
	  hc = "R"   
  elsif $game_variables[@prog][11] == 4 #White
	  hc = "W"
	end   
	hair = "HolH" + ha + hc + "F"
	hairB = "HolH" + ha + hc + "B"
	$game_map.screen.pictures[112].show(hairB, pos, xp, yp, px, py, 255, 0)
	$game_map.screen.pictures[115].show(hair, pos, xp, yp, px, py, 255, 0) 
  ##### EXTRA
  acc = ""
  if $game_variables[@prog][13] == 1 #Freckles
	acc = "HolFre" + col1
  elsif $game_variables[@prog][13] == 2 #Nose#1
	acc = "HolRing1"
  elsif $game_variables[@prog][13] == 3 #Nose#2
	acc = "HolRing2"
  end
  if $game_variables[@prog][13] != 0
	$game_map.screen.pictures[119].show(acc, pos, xp, yp, px, py, 255, 0)
  end  
  ##### HORNS
  if $game_variables[@prog][12] == 0 #Straight
	 hoS = "Std"
  elsif $game_variables[@prog][12] == 1 #Curve
	  hoS = "Cur"
  elsif $game_variables[@prog][12] == 2 #Bent
	  hoS = "Ben"   
  elsif $game_variables[@prog][12] == 3 #Thicc
	  hoS = "Thi"       
	end     
  horn = "HolHo" + hoS
	$game_map.screen.pictures[117].show(horn, pos, xp, yp, px, py, 255, 0)  
  ##### EXP
  exp = "HolExp"
  expS = ""
	  if  $game_variables[2051] == 0   
		expS = "Std"
  elsif $game_variables[2051] == 1 
		expS = "Sad"               
  elsif $game_variables[2051] == 2 
		expS = "Rage"              
  elsif $game_variables[2051] == 3
		expS = "Love"          
  elsif $game_variables[2051] == 4
		expS = "Milk"          
  end   
      #voice Base
        voiceAc = "voiceRND"
    if $game_variables[7330] != 1
      voiceAc += "susp"
    end  
    voiceV = 90
    voiceP = 100  
    #pitch/volume changes
    if $game_variables[4000][2] == 1
      voiceV -= 10
      voiceP -= 15
    elsif $game_variables[4000][2] == 2
      voiceV += 15
      voiceP += 20     
    elsif $game_variables[4000][2] == 3
      voiceV += 10
      voiceP -= 10      
    end     
#CHAR TRAITS
if @ski == "Tsundere" && $game_variables[2051] == 2
      voiceV += 5
      voiceP += 5 
    expS = "Tsun"
 elsif @ski == "Yandere" && $game_variables[2051] == 3
      voiceP -= 20
    expS = "Yan"
  elsif @ski == "Kuudere" && $game_variables[2051] == 1
      voiceP -= 10
    expS = "Kuu"
   elsif @ski == "Dandere" && $game_variables[2051] == 1
    expS = "Dan"
   elsif @ski == "Erodere" && $game_variables[2051] == 3
    expS = "Ero"
   elsif @ski == "Nemuidere" && $game_variables[2051] == 4
      voiceP -= 10
    expS = "Nemu"
  end         
  if $game_variables[@prog][1] == 1
	exp += "M"
  end
  exp += expS
  if @ski == "Spooky" 
    exp = "HolExpSpoop"
  end  
  $game_map.screen.pictures[116].show(exp, pos, xp, yp, px, py, 255, 0)
  #####     
	if cost != "n"
	  if $game_variables[@prog][1] == 1 #male
		yp += (0.3 * px)
	  end  
	  dress =  basedre + bod + cost 
	  $game_map.screen.pictures[118].show(dress, pos, xp, yp, px, py, 255, 0) 
	end  
  #####
	   if inMenu == 0
		 if $game_variables[4000][2] != 10 && $game_variables[4000][2] != 11
   # VOICE SCRIPT #
   voiceAc += (rand(4)+1).to_s
unless $game_switches[4600] == true
  RPG::SE.new(voiceAc, voiceV, voiceP).play
end  
   # VOICE SCRIPT #        
		 $game_map.screen.pictures[122].show("dialogueframeNoSE", 0, 0, 0, px, py, 255, 0)
	   end
	 end  
	#### TONES ####
		#check skill#
if @ski == "Moonlit"      
	@c1= -68
	@c2= -68
	@c3= 0
	@c4= 68
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end    
	elsif $game_variables[@prog][16] == 1 && $game_variables[@prog][0] != 99 #Shiny
	@c1= 135
	@c2= 25
	@c3= 25
	@c4= 0
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(@c1, @c2, @c3, @c4), 1)
		 @p += 1
	   end
	end  
  if $game_switches[2411] == true
	@m = 2249 + $game_variables[2067] 
	if $game_variables[@m][8] == 1 || $game_variables[@m][8] == 2 || $game_variables[@m][8] == 3 || $game_variables[@m][8] == 4 || $game_variables[@m][8] == 5 || $game_variables[@m][8] == 6 || $game_variables[@m][8] == 8 || $game_variables[@m][8] == 20
	   @p = 111
	   while @p <= 121
		 $game_map.screen.pictures[@p].start_tone_change(Tone.new(0, 0, 0, 255), 1)
		 @p += 1
	   end
	   end
	 end  
	 #### TONES ####
	 return
	 end            
  #--------------------  
	@dra = 0
   end
   end
   #--------------------
	  @name = name  
	  @origin = origin
	  @x = x.to_f
	  @y = y.to_f
	  @zoom_x = zoom_x.to_f
	  @zoom_y = zoom_y.to_f
	  @opacity = opacity.to_f
	  @blend_type = blend_type
	  init_target
	  init_tone
	  init_rotate
	end
	#--------------------------------------------------------------------------
	# * Move Picture
	#--------------------------------------------------------------------------
	def move(origin, x, y, zoom_x, zoom_y, opacity, blend_type, duration)
	  @origin = origin
	  @target_x = x.to_f
	  @target_y = y.to_f
	  @target_zoom_x = zoom_x.to_f
	  @target_zoom_y = zoom_y.to_f
	  @target_opacity = opacity.to_f
	  @blend_type = blend_type
	  @duration = duration
	end
	#--------------------------------------------------------------------------
	# * Change Rotation Speed
	#--------------------------------------------------------------------------
	def rotate(speed)
	  @rotate_speed = speed
	end
	#--------------------------------------------------------------------------
	# * Start Changing Color Tone
	#--------------------------------------------------------------------------
	def start_tone_change(tone, duration)
	  @tone_target = tone.clone
	  @tone_duration = duration
	  @tone = @tone_target.clone if @tone_duration == 0
	end
	#--------------------------------------------------------------------------
	# * Erase Picture
	#--------------------------------------------------------------------------
	def erase
	 if @number == 1 || @number == 100 || $game_switches[579] == true
	   for n in 111..122
	   $game_map.screen.pictures[n].show("",0,0,0,0,0,0,0)
	   end
	 end    
	  @name = ""
	  @origin = 0
	end
	#--------------------------------------------------------------------------
	# * Frame Update
	#--------------------------------------------------------------------------
	def update
	  update_move
	  update_tone_change
	  update_rotate
	end
	#--------------------------------------------------------------------------
	# * Update Picture Move
	#--------------------------------------------------------------------------
	def update_move
	  return if @duration == 0
	  d = @duration
	  @x = (@x * (d - 1) + @target_x) / d
	  @y = (@y * (d - 1) + @target_y) / d
	  @zoom_x  = (@zoom_x  * (d - 1) + @target_zoom_x)  / d
	  @zoom_y  = (@zoom_y  * (d - 1) + @target_zoom_y)  / d
	  @opacity = (@opacity * (d - 1) + @target_opacity) / d
	  @duration -= 1
	end
	#--------------------------------------------------------------------------
	# * Update Color Tone Change
	#--------------------------------------------------------------------------
	def update_tone_change
	  return if @tone_duration == 0
	  d = @tone_duration
	  @tone.red   = (@tone.red   * (d - 1) + @tone_target.red)   / d
	  @tone.green = (@tone.green * (d - 1) + @tone_target.green) / d
	  @tone.blue  = (@tone.blue  * (d - 1) + @tone_target.blue)  / d
	  @tone.gray  = (@tone.gray  * (d - 1) + @tone_target.gray)  / d
	  @tone_duration -= 1
  	end
	#--------------------------------------------------------------------------
	# * Update Rotation
	#--------------------------------------------------------------------------
	def update_rotate
	  return if @rotate_speed == 0
	  @angle += @rotate_speed / 2.0
	  @angle += 360 while @angle < 0
	  @angle %= 360
	end
end