#==============================================================================
# ** Cache
#------------------------------------------------------------------------------
#  This module loads graphics, creates bitmap objects, and retains them.
# To speed up load times and conserve memory, this module holds the
# created bitmap object in the internal hash, allowing the program to
# return preexisting objects when the same bitmap is requested again.
#==============================================================================

module Cache
  #--------------------------------------------------------------------------
  # * Get Animation Graphic
  #--------------------------------------------------------------------------
  def self.animation(filename, hue)
    load_bitmap("Graphics/Animations/", filename, hue)
  end
  #--------------------------------------------------------------------------
  # * Get Battle Background (Floor) Graphic
  #--------------------------------------------------------------------------
  def self.battleback1(filename)
    load_bitmap("Graphics/Battlebacks1/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Battle Background (Wall) Graphic
  #--------------------------------------------------------------------------
  def self.battleback2(filename)
    load_bitmap("Graphics/Battlebacks2/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Battle Graphic
  #--------------------------------------------------------------------------
  def self.battler(filename, hue)
    load_bitmap("Graphics/Battlers/", filename, hue)
  end
  #--------------------------------------------------------------------------
  # * Get Character Graphic
  #--------------------------------------------------------------------------
  def self.character(filename)
    load_bitmap("Graphics/Characters/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Face Graphic
  #--------------------------------------------------------------------------
  def self.face(filename)
    load_bitmap("Graphics/Faces/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Parallax Background Graphic
  #--------------------------------------------------------------------------
  def self.parallax(filename)
    load_bitmap("Graphics/Parallaxes/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Picture Graphic
  #--------------------------------------------------------------------------
  def self.picture(filename)
   if filename.include?"CallFaceKnight"
   filename = "Hero"
   #####
    @shadMaps = [125,531,532,533,535]
    @shaFace = 0
    if @shadMaps.include?$game_map.map_id
     @shaFace = 1  
    end 
   #####
   if @shaFace == 1
     filename = "HeroShadow"
   elsif $game_switches[2713] == true
     filename = "HeroPoss"
   else  
   traitK = $game_variables[628]
   if $game_switches[783] == true #classic K
     traitK = 1
   end   
   knight = ""
   if traitK == 2 || traitK == 102 || traitK == 1002 #BattleReady
     knight = "Battle"        
   elsif traitK == 3 || traitK == 103 || traitK == 1003 #Stud
     knight = "Stud"
   elsif traitK == 4 || traitK == 104 || traitK == 1004 #Pacifista
     knight = "Pacifista"        
   elsif traitK == 5 || traitK == 105 || traitK == 1005 #Monster
     knight = "Monster"
   elsif traitK == 6 || traitK == 106 || traitK == 1006 #Beast
     knight = "Beast" 
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
   elsif traitK == 12 || traitK == 112 || traitK == 1012 #Counsellor
     knight = "Counsellor"          
   elsif traitK == 13 || traitK == 113 || traitK == 1013 #SoulMaster
     knight = "Soul"
   elsif traitK == 14 || traitK == 114 || traitK == 1014 #Necromancer
     knight = "Necro"     
   elsif traitK == 15 || traitK == 115 || traitK == 1015 #Slaver
     knight = "Slaver"     
   elsif traitK == 16 || traitK == 116 || traitK == 1016 #Goddess
     knight = "Goddess"          
   elsif traitK == 17 || traitK == 117 || traitK == 1017 #Chef
     knight = "Chef"   
   elsif traitK == 18 || traitK == 118 || traitK == 1018 #Peasant
     knight = "Peasant"      
   elsif traitK == 19 || traitK == 119 || traitK == 1019 #Houndmaster
     knight = "Hound"      
   elsif traitK == 20 || traitK == 120 || traitK == 1020 #Guild
     knight = "Guild"      
   elsif traitK == 21 || traitK == 121 || traitK == 1021 #Snitch
     knight = "Snitch"             
   elsif traitK == 22 || traitK == 122 || traitK == 1022 #Incubus
     knight = "Incubus"
   elsif traitK == 23 || traitK == 123 || traitK == 1023 #Banker
     knight = "Banker"
   elsif traitK == 24 || traitK == 124 || traitK == 1024 #Mason
     knight = "Mason"
   elsif traitK == 25 || traitK == 125 || traitK == 1025 #Insurgent
     knight = "Insurgent"     
   elsif traitK == 26 || traitK == 126 || traitK == 1026 #Brawler
     knight = "Brawler"
   elsif traitK == 27 || traitK == 127 || traitK == 1027 #Zealot
     knight = "Zealot"       
   elsif traitK == 28 || traitK == 128 || traitK == 1028 #MonsterEater
     knight = "MonsterEater"   
   elsif traitK == 29 || traitK == 129 || traitK == 1029 #Dice
     knight = "Dice"     
   elsif traitK == 30 || traitK == 130 || traitK == 1030 #Dream
     knight = "Dream"      
   elsif traitK == 31 || traitK == 131 || traitK == 1031 #Rabi
     knight = "Rabi"     
   elsif traitK == 32 || traitK == 132 || traitK == 1032 #Magi
     knight = "Magi"     
   elsif traitK == 33 || traitK == 133 || traitK == 1033 #Clockwork
     knight = "Clockwork"
   end    
   filename += knight  
   end
   load_bitmap("Graphics/Faces/", filename)  
     else
   load_bitmap("Graphics/Pictures/", filename)
   end
  end
  #--------------------------------------------------------------------------
  # * Get System Graphic
  #--------------------------------------------------------------------------
  def self.system(filename)
    load_bitmap("Graphics/System/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Tileset Graphic
  #--------------------------------------------------------------------------
  def self.tileset(filename)
    load_bitmap("Graphics/Tilesets/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Title (Background) Graphic
  #--------------------------------------------------------------------------
  def self.title1(filename)
    load_bitmap("Graphics/Titles1/", filename)
  end
  #--------------------------------------------------------------------------
  # * Get Title (Frame) Graphic
  #--------------------------------------------------------------------------
  def self.title2(filename)
    load_bitmap("Graphics/Titles2/", filename)
  end
  #--------------------------------------------------------------------------
  # * Load Bitmap
  #--------------------------------------------------------------------------
  def self.load_bitmap(folder_name, filename, hue = 0)
    @cache ||= {}
    if filename.empty?
      empty_bitmap
    elsif hue == 0
      normal_bitmap(folder_name + filename)
    else
      hue_changed_bitmap(folder_name + filename, hue)
    end
  end
  #--------------------------------------------------------------------------
  # * Create Empty Bitmap
  #--------------------------------------------------------------------------
  def self.empty_bitmap
    Bitmap.new(32, 32)
  end
  #--------------------------------------------------------------------------
  # * Create/Get Normal Bitmap
  #--------------------------------------------------------------------------
  def self.normal_bitmap(path)
    @cache[path] = Bitmap.new(path) unless include?(path)
    @cache[path]
  end
  #--------------------------------------------------------------------------
  # * Create/Get Hue-Changed Bitmap
  #--------------------------------------------------------------------------
  def self.hue_changed_bitmap(path, hue)
    key = [path, hue]
    unless include?(key)
      @cache[key] = normal_bitmap(path).clone
      @cache[key].hue_change(hue)
    end
    @cache[key]
  end
  #--------------------------------------------------------------------------
  # * Check Cache Existence
  #--------------------------------------------------------------------------
  def self.include?(key)
    @cache[key] && !@cache[key].disposed?
  end
  #--------------------------------------------------------------------------
  # * Clear Cache
  #--------------------------------------------------------------------------
  def self.clear
    @cache ||= {}
    @cache.clear
    GC.start
  end
end
