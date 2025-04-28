#==============================================================================
# Gamepad Extender v1.1 (2/20/15)
# by Lone Wolf
#------------------------------------------------------------------------------
# This allows scripters to utilize the extra buttons on modern
# XInput-compatible gamepads.　It requires DirectX 9.0 or later and
# an XInput compatible gamepad. Incompatible pads will default to
# using the standard Input module functionality.
#
# This is not a plug-and-play script. 
# Some knowledge of RGSS is required for proper use.
#
# Instructions:
#	 1) Paste in the Materials section
#  2) Replace button calls in (other) scripts to use gamepad buttons as needed
#        (see Command Reference below)
# Optional:
#	 2) Use the PadConfig section to specify button differences between
#		  Gamepad and Keyboard (for players without gamepads)
#	 3) Replace direct button calls in your scripts (and the defaults) with
#		  PadConfig calls or these will do nothing
#        (see Command Reference below)
#------------------------------------------------------------------------------
# Command Reference:
#------------------------------------------------------------------------------
# All calls to extended buttons on Pad 1 can be made through the Input module.
# When using multiple pads, send calls to WolfPad with pad number (0...3)
#	as the final parameter. (i.e.  WolfPad.press?(:A, 3)  )
#
# The current list of mappable buttons is as follows:
#
#	 :A, :B, :X, :Y     - XBOX 360 standard face buttons.
#	 :L1, :L2, :R1, :R2 - Four triggers (LB, LT, RB, RT)
#	 :SELECT, :START    - Back and Start buttons
#	 :L3, :R3				    - Clickable Analog buttons
#
#	 :UP, :DOWN,
#	 :LEFT, :RIGHT	    - D-Pad buttons
#
#  :L_UP, :L_DOWN
#  :L_LEFT, :L_RIGHT  - Left stick directions
#
#  :R_UP, :R_DOWN
#  :R_LEFT, :R_RIGHT  - Right stick directions
#
# NON-STANDARD MAPPINGS WILL DO NOTHING without a compatible gamepad.
# To that end, use calls to PadConfig to remap non-standard keys into
# the standard domain where possible.
#
#		 for example:    Input.trigger?(PadConfig.page_down)
#		 will return :R1 if a gamepad is plugged in, but :R otherwise
#
# Analog values can be referenced with the following commands:
#	 left_stick
#	 right_stick
#	 left_trigger
#	 right_trigger
#
# Directional values of analog sticks can be referenced with these:
#	 lstick4
#	 lstick8
#	 rstick4
#	 rstick8
#
# Controller vibration can be accessed with these:
#	 vibrate(left_motor, right_motor, frame_duration)
#	 set_motors(left_motor, right_motor)
#
# All functions take an optional gamepad id (0-3) as their final parameter.
#
#------------------------------------------------------------------------------
# Terms of Use:
#------------------------------------------------------------------------------
#	 If you use it, give credit. With a few caveats:
#
#	 Can't call it alpha nay more, but I consider this script in-development.
#	 I make no guarantees of compatibility with other scripts.
#
#  Contact me via PM is you plan on using this in a commercial game.
#  I probably won't charge anything, but I will want to know it's out there.
#
#	 This script was posted at the official RPG Maker forums.
#	 Do modify or redistribute this script by itself, though you may
#	 include a configured version with your own script demos provided
#	 you inclide this header in its entirety.
#------------------------------------------------------------------------------
# Contact Info:
#------------------------------------------------------------------------------
# I can be reached via PM only at the RPG Maker Web forums.
#		(http://forums.rpgmakerweb.com)
#
# PM'ing the user Lone Wolf at other RPG Maker sites may have...
# unpredicatable results. I made someone really happy the day I registered...
#------------------------------------------------------------------------------
# Credits:
# Lone Wolf (99% of the code)
# raulf17 (directional movement bug fix; now obsolete)
#------------------------------------------------------------------------------
# 翻訳したいんですか？いいんだが、まだ未完成です。
#==============================================================================
module PadConfig
    # Basic configuration settings:
    # static:
    CONTROLLERS = 2 # can be any number from 1-4, higher values may cause errors
    # can be redefined by other scripts and changed in-game:
    def self.deadzone # Deadzone for axis input (%), may require adjusting
      0.5
    end
    def self.move_with_stick  # Use left-analog stick with dir4 and dir8
      true
    end
    def self.enable_vibration # Enable force-feedback
      true
    end
    # Use this section to write flexible button-mappings for your scripts.
    # Add additional methods as needed.
    # Format:   
    # $game_switches[1320] == true ? (gamepad binding) : (fallback binding)  
    def self.confirm
      WolfPad.plugged_in? ? :X : :A
    end
    def self.cancel
      WolfPad.plugged_in? ? :B : :B
    end
    def self.dash
      WolfPad.plugged_in? ? :A : :C
    end
    def self.menu
      WolfPad.plugged_in? ? :Y : :B
    end
    def self.page_up
      WolfPad.plugged_in? ? :SELECT : :L
    end
    def self.page_down
      WolfPad.plugged_in? ? :Y : :R
    end
    def self.debug
      WolfPad.plugged_in? ? :L2 : :CTRL
    end
    def self.debug2
      WolfPad.plugged_in? ? :R3 : :F9
    end
    def self.cev
      WolfPad.plugged_in? ? :R1 : :L_CTRL
    end    
  end
  # Main module:
  module WolfPad
    def self.update
        for pad_index in 0...PadConfig::CONTROLLERS
        input = get_state(pad_index)
        if @packet[pad_index] == input[0]
        set_holds(pad_index)
        next
        end
        @packet[pad_index] = input[0]
        @buttons[pad_index] = (input[1] | 0x10000).to_s(2)
        @triggers[pad_index] = [input[2], input[3]]
        @lstick[pad_index] = [constrain_axis(input[4]), -constrain_axis(input[5])]
        @rstick[pad_index] = [constrain_axis(input[6]), -constrain_axis(input[7])]
        set_holds(pad_index)
      end
      update_vibration
      # Extra readout functions go here.
      #dircheck
    end
    def self.test # Prints no. of detected controllers (debugging use only)
      detected = 0
      for i in 0...PadConfig::CONTROLLERS
        self.update
        detected += plugged_in?(i) ? 1 : 0
      end
      puts sprintf("%d XInput controller(s) in use.", detected)
    end
    def self.readout # prints a range from the holds table (debugging use only)
      for i in 00...16
        print sprintf(" %d", @holds[0, i])
        print sprintf(" %d", @holds[1, i])
      end
      puts ";"
    end
    def self.dircheck
      for i in 0...PadConfig::CONTROLLERS
        print sprintf(" %d", key_holds(:UP, i))
        print sprintf(" %d", key_holds(:LEFT, i))
        print sprintf(" %d", key_holds(:DOWN, i))
        print sprintf(" %d", key_holds(:RIGHT, i))
        print " : "
      end
      puts ";"
    end
    # Basic vibration call.
    # For simplicity, motor values should be floats from 0.0 to 1.0
    def self.vibrate(left, right, duration, pad_index = 0)
      return unless PadConfig.enable_vibration
      set_motors(left, right, pad_index)
      @vibrations[pad_index] = duration
    end
    # Counts down vibration event timers
    def self.update_vibration
      for pad in 0...PadConfig::CONTROLLERS
         next if @vibrations[pad] == -1
         @vibrations[pad] -= 1
         if @vibrations[pad] == 0
            @vibrations[pad] = -1
            set_motors(0, 0, pad)
         end
      end
    end
    def self.cev
      #$game_temp.reserve_common_event(61)
      end
    # Set left and right motor speeds. Vibration continues until stopped.
    # Repeated calls with different values can create vibration effects.
    # For simplicity, input values should be floats from 0.0 to 1.0
    def self.set_motors(left, right, pad_index = 0)
      return unless (PadConfig.enable_vibration) || (left == 0 && right == 0)
      left_v = [left * 65535, 65535].min
      right_v = [right * 65535, 65535].min
      vibration = [left_v, right_v].pack("SS")
      @set_state.call(pad_index, vibration)
    end
    def self.press?(button, pad_index = 0)
      key_holds(button, pad_index) > 0
    end
    def self.trigger?(button, pad_index = 0)
      key_holds(button, pad_index) == 1
    end
    def self.repeat?(button, p_i = 0)
      return true if key_holds(button, p_i) == 1
      return true if key_holds(button, p_i) > 30 && key_holds(button, p_i) % 5 == 0
    end
    # Returns left stick as a pair of floats [x, y] between -1.0 and 1.0
    def self.left_stick(pad_index = 0)
      @lstick[pad_index]
    end
    # Returns right stick as a pair of floats [x, y] between -1.0 and 1.0
    def self.right_stick(pad_index = 0)
      @rstick[pad_index]
    end
    # Returns left trigger as float between 0.0 to 1.0
    def self.left_trigger(pad_index = 0)
      @triggers[pad_index][0] / 255.0
    end
    # Returns right trigger as float between 0.0 to 1.0
    def self.right_trigger(pad_index = 0)
      @triggers[pad_index][1] / 255.0
    end    
    def self.dir4(p_i = 0)
      return lstick4(p_i) if PadConfig.move_with_stick
      if press?(:UP, p_i)
       8
      elsif press?(:RIGHT, p_i)
       6
      elsif press?(:LEFT, p_i)
       4
      elsif press?(:DOWN, p_i)
       2
      else
       0
      end
    end
    def self.dir8(p_i = 0)
      return lstick8(p_i) if PadConfig.move_with_stick
      if press?(:UP, p_i) and press?(:LEFT, p_i)
       7
      elsif press?(:UP, p_i) and press?(:RIGHT, p_i)
       9
      elsif press?(:DOWN, p_i) and press?(:LEFT, p_i)
       1
      elsif press?(:DOWN, p_i) and press?(:RIGHT, p_i)
       3
      else
       dir4(p_i)
      end
    end
    # Left-stick direction
    def self.lstick8(p_i = 0)
        flags_to_dir8(key_holds(:L_RIGHT, p_i),key_holds(:L_LEFT, p_i),
                      key_holds(:L_DOWN, p_i),key_holds(:L_UP, p_i))
    end
    def self.lstick4(p_i = 0)
        flags_to_dir4(key_holds(:L_RIGHT, p_i),key_holds(:L_LEFT, p_i),
                      key_holds(:L_DOWN, p_i),key_holds(:L_UP, p_i))
    end
    # Right-stick direction
    def self.rstick8(p_i = 0)
        flags_to_dir8(key_holds(:R_RIGHT, p_i),key_holds(:R_LEFT, p_i),
                      key_holds(:R_DOWN, p_i),key_holds(:R_UP, p_i))
    end
    def self.rstick4(p_i = 0)
        flags_to_dir4(key_holds(:R_RIGHT, p_i),key_holds(:R_LEFT, p_i),
                      key_holds(:R_DOWN, p_i),key_holds(:R_UP, p_i))
    end
    def self.plugged_in?(pad_index = 0)
      @packet[pad_index] && @packet[pad_index] > 0
    end
    def self.keyboard_key?(button)
      !@keys.has_key?(button)
    end
  
    #Helper functions:
    # convert signed half-word axis state to float
    def self.constrain_axis(axis)
      val = axis.to_f / 2**15
      val.abs > PadConfig.deadzone ? val : 0
    end
    
    # derives a dir8 value from directional hold values
    def self.flags_to_dir8(right, left, down, up)
      x = right == left ? 0 : (right > left ? 1 : 2)
      y = down == up ? 0 : (down > up ? 1 : 2)
      table = [[5, 2, 8],
              [ 6, 3, 9],
              [ 4, 1, 7]]
      return table[x][y]
    end
    # derives a dir4 value from directional hold values
    def self.flags_to_dir4(right, left, down, up)
      selection = [right, left, down, up].max
      table = [0,0,down,0,left,0,right,0,up]
      return table.index(selection)
    end
    
    # calculates the precise geometric angle from stick axis values [x,y]
    def self.axis_to_angle(axis)
      cy = -axis[1]
      cx = -axis[0]
      return -1 if cy == 0 && cx == 0
      angle = Math.atan2(cx, cy) * 180 / Math::PI
      angle = angle < 0 ? angle + 360 : angle
      return angle
    end
    
    # Original angle-conversion handlers for analog sticks
    # OBSOLETE: preserved for reference only
    def self.axis_to_dir8(axis)
      angle_to_dir8(axis_to_angle(axis))
    end
    def self.axis_to_dir4(axis)
      angle_to_dir4(axis_to_angle(axis))
    end
  
    def self.angle_to_dir8(angle)
      return 0 if angle == -1
      d = 0
      if angle < 22.5 || angle >= 337.5
       d = 8
      elsif angle < 67.5
       d = 7
      elsif angle < 112.5
       d = 4
      elsif angle < 157.5
       d = 1
      elsif angle < 202.5
       d = 2
      elsif angle < 247.5
       d = 3
      elsif angle < 292.5
       d = 6
      elsif angle < 337.5
       d = 9
      end
      return d
    end
    def self.angle_to_dir4(angle)
      return 0 if angle == -1
      d = 0
      if angle < 45 || angle >= 315
       d = 8
      elsif angle < 135
       d = 4
      elsif angle < 225
       d = 2
      elsif angle < 315
       d = 6
      end
      return d
    end
    
    private # methods past here can't be called from outside
    # This hash correlates RM's Input to XInput keys. Experienced Users only!
    # The Input module will handle any keys not listed here (i.e. :CTRL) itself.
    # Integers refer to specific gamepad button IDs.
    @keys = {
      :UP	=> 15, #d-pad up
      :DOWN => 14, #d-pad left
      :LEFT => 13, #d-pad down
      :RIGHT => 12, #d-pad right
      :A	 => 3, #lower face button
      :B	 => 2, #right face button
      :X	 => 1, #left face button
      :Y	 => 0, #upper face button
      :L1	=> 7, #upper left trigger
      :R1	=> 6, #upper right trigger
      :START => 11,
      :SELECT => 10,
      :L3	=> 9, #left thubstick button
      :R3	=> 8, #right thubstick button
      :L2	=> 16, #lower left trigger (press only)
      :R2	=> 17, #lower right trigger (press only)
      :L_UP	=> 21,
      :L_DOWN	=> 20,
      :L_LEFT	=> 19,
      :L_RIGHT	=>18,
      :R_UP	=> 25,
      :R_DOWN	=> 24,
      :R_LEFT	=> 23,
      :R_RIGHT	=> 22
      }
    #Win32API calls. Leave these alone.
    @set_state = Win32API.new("XINPUT9_1_0", "XInputSetState", "IP", "V")
    @get_state = Win32API.new("XINPUT9_1_0", "XInputGetState", "IP", "L")
    #Initializers
    # Will store data for number of gamepads in use.
    @packet = Array.new(PadConfig::CONTROLLERS)
    @buttons = Array.new(PadConfig::CONTROLLERS)
    @triggers = Array.new(PadConfig::CONTROLLERS)
    @lstick = Array.new(PadConfig::CONTROLLERS)
    @rstick = Array.new(PadConfig::CONTROLLERS)
    # tracks how long buttons have been pressed
    @holds = Table.new(PadConfig::CONTROLLERS, 26)
    # stores vibration event timers
    @vibrations = Array.new(PadConfig::CONTROLLERS, -1)
    def self.key_holds(symbol, pad_index)
      return 0 if keyboard_key?(symbol)
      @holds[pad_index, @keys[symbol]]
    end
    def self.get_state(pad_index)
      state = "\0" * 16
      @get_state.call(pad_index, state)
      return state.unpack("LSCCssss")
    end
    def self.set_holds(p_i)
      for i in 1...17
       @holds[p_i, i-1] = @buttons[p_i][i].to_i > 0 ? @holds[p_i, i-1] + 1 : 0
      end
      @holds[p_i, 16] = left_trigger(p_i) >= 0.5 ? @holds[p_i, 16]+1 : 0
      @holds[p_i, 17] = right_trigger(p_i) >= 0.5 ? @holds[p_i, 17]+1 : 0
      @holds[p_i, 18] = left_stick(p_i)[0] >= 0.5 ? @holds[p_i, 18]+1 : 0
      @holds[p_i, 19] = left_stick(p_i)[0] <= -0.5 ? @holds[p_i, 19]+1 : 0
      @holds[p_i, 20] = left_stick(p_i)[1] >= 0.5 ? @holds[p_i, 20]+1 : 0
      @holds[p_i, 21] = left_stick(p_i)[1] <= -0.5 ? @holds[p_i, 21]+1 : 0
      @holds[p_i, 22] = right_stick(p_i)[0] >= 0.5 ? @holds[p_i, 22]+1 : 0
      @holds[p_i, 23] = right_stick(p_i)[0] <= -0.5 ? @holds[p_i, 23]+1 : 0
      @holds[p_i, 24] = right_stick(p_i)[1] >= 0.5 ? @holds[p_i, 24]+1 : 0
      @holds[p_i, 25] = right_stick(p_i)[1] <= -0.5 ? @holds[p_i, 25]+1 : 0
    end
  end
  # Aliases to tie the above into VXAce's Input module
  module Input
    class <<self
      alias :vxa_update :update
      alias :vxa_press? :press?
      alias :vxa_trigger? :trigger?
      alias :vxa_repeat? :repeat?
      alias :vxa_dir4 :dir4
      alias :vxa_dir8 :dir8
    end
    def self.update
      WolfPad.update
      vxa_update
    end    
  def self.press?(button)
      return vxa_press?(button) if WolfPad.keyboard_key?(button)  
      return vxa_press?(button)       
      return WolfPad.press?(button) if WolfPad.plugged_in?
      #return WolfPad.press?(button)
  end
  def self.trigger?(button)
      return vxa_trigger?(button) if WolfPad.keyboard_key?(button)
      return vxa_trigger?(button)
      return WolfPad.trigger?(button) if WolfPad.plugged_in?      
      #return WolfPad.trigger?(button)
  end
  def self.repeat?(button)
      return vxa_repeat?(button) if WolfPad.keyboard_key?(button)
      return vxa_repeat?(button)
      return WolfPad.repeat?(button) if WolfPad.plugged_in?      
      #return WolfPad.repeat?(button)
    end
    def self.dir4
      if WolfPad.press?(:L_DOWN,1) || WolfPad.press?(:L_LEFT,1) || WolfPad.press?(:L_RIGHT,1) || WolfPad.press?(:L_UP,1)
        return WolfPad.dir4(1)
      elsif WolfPad.press?(:L_DOWN,0) || WolfPad.press?(:L_LEFT,0) || WolfPad.press?(:L_RIGHT,0) || WolfPad.press?(:L_UP,0)
        return WolfPad.dir4(0)
      else
        return vxa_dir4
      end  
    end
    def self.dir8
      if WolfPad.press?(:L_DOWN,1) || WolfPad.press?(:L_LEFT,1) || WolfPad.press?(:L_RIGHT,1) || WolfPad.press?(:L_UP,1)
        return WolfPad.dir8(1)
      elsif WolfPad.press?(:L_DOWN,0) || WolfPad.press?(:L_LEFT,0) || WolfPad.press?(:L_RIGHT,0) || WolfPad.press?(:L_UP,0)
        return WolfPad.dir8(0)
      else
        return vxa_dir8
      end  
    end    
  #  def self.dir4
  #    if WolfPad.plugged_in?(1) && $game_switches[1320] == true
  #      return WolfPad.dir4(1)
  #    elsif WolfPad.plugged_in?(0) && $game_switches[1320] == true
  #      return WolfPad.dir4(0)
  #    else  
  #      return vxa_dir4
  #   end  
  #  end
  #  def self.dir8
  #    if WolfPad.plugged_in?(1) && $game_switches[1320] == true
  #      return WolfPad.dir8(1)
  #   elsif WolfPad.plugged_in?(0) && $game_switches[1320] == true
  #      return WolfPad.dir8(0)
  #    else  
  #      return vxa_dir8
  #    end  
  #  end
    end