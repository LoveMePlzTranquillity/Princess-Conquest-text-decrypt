#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# **Graphic/Audio file missing crash Fix
# **By Skitzen
# ** Version 1.0
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
=begin

**Plug n play, no need for any customization unless wanted.**

This script gets rid of the crash that happens when a file is missing during 
game play. The game will announce exactly what is missing from what folder and 
then continue on with the game.

This is especially perfect for beta testing, but can also be used in the full 
release of a game.

** Compatibility issues:
None so far that I can find, works with scripts that require calling filess 
from folders not in the main folders.
Please let me know if you find any.

Known bugs:
Does not display name of missing audio file, or custom audio folders if any. 
(looking into it still.)

If you find any other bugs, please report them here: 
http://forums.rpgmakerweb.com/index.php?/user/438-skitzen/


**Credit
Feel free to use this in any commercial/non-commercial work. I just ask that you
at least give credit to me for the work.

=end
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#Start

class << Bitmap
	alias_method :error_new, :new unless method_defined?(:error_new)
	 def new(*args)
	 error_new(*args)
	rescue
	 if args.size == 1
	print ("Missing resource file: "), args[0]
  end
	begin
	error_new
	rescue
	error_new(32, 32)
	end
  end
end

	module Audio
	 class << self
	 alias_method :error_play_bgm, :bgm_play
	 alias_method :error_play_bgs, :bgs_play
	 alias_method :error_play_se, :se_play
	 alias_method :error_play_me, :me_play
end
	
	def self.bgm_play(filename, volume = 100, pitch = 100, pos = "Audio/BGM/")
	self.error_play_bgm(filename, volume, pitch, pos)
	rescue
	print ("Missing resource file: Audio/BGM/    ")
end

	def self.bgs_play(filename, volume = 100, pitch = 100, pos = "Audio/BGS/")
	self.error_play_bgs(filename, volume, pitch, pos)
	rescue
	print ("Missing resource file: Audio/BGS/    ")
end

	def self.se_play(filename, volume = 100, pitch = 100)
	self.error_play_se(filename, volume, pitch)
	rescue
	print ("Missing resource file: Audio/SE/    ")
end

	def self.me_play(filename, volume = 100, pitch = 100)
	self.error_play_me(filename, volume, pitch)
	rescue
	print ("Missing resource file: Audio/ME/    ")
end
end