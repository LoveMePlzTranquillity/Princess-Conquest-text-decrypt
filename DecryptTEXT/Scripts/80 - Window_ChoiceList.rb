#==============================================================================
# ** Window_ChoiceList
#------------------------------------------------------------------------------
#  This window is used for the event command [Show Choices].
#==============================================================================

class Window_ChoiceList < Window_Command
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(message_window)
    @message_window = message_window
    super(0, 0)
    self.openness = 0
    deactivate
  end
  #--------------------------------------------------------------------------
  # * Start Input Processing
  #--------------------------------------------------------------------------
  def start
    update_placement
    refresh
    select(0)
    open
    activate
  end
  #--------------------------------------------------------------------------
  # * Update Window Position
  #--------------------------------------------------------------------------
  def update_placement  
  ####################  
    self.width = [max_choice_width + 12, 128].max + padding * 2      
    self.x = (Graphics.width/2) - (width/2)
    self.x = [x, 150].max
    self.y = 325      
    widthMin = self.width
  ####################  
  ####### WIDTH ###### 
  ####################  
  if $game_switches[3016] == true || $game_switches[7] == true #trait choosing/wide ch
      widthMin = 300
  elsif $game_switches[7404] == true #ambass choice
      widthMin = 500
  elsif $game_switches[1450] == true || $game_switches[5299] == true || $game_switches[2665] == true || $game_switches[2950] == true || $game_switches[3719] == true || $game_switches[129] == true || $game_switches[3060] == true || $game_map.map_id == 380 || $game_switches[3579] == true #wishes
      widthMin = 325
  elsif $game_switches[5511] == true
      widthMin = 175
  elsif $game_switches[2411] == true
      widthMin = 125
  elsif $game_switches[2665] == true || $game_switches[4336] == true #Manneq event / chill gift
      widthMin = 240
  elsif $game_map.map_id == 397 #rattesein
      widthMin = 200
    elsif $game_switches[3470] == true #guild menu
     widthMin = 200
     if self.width >= 450
       self.width = 450
     elsif self.width <= 200
       self.width = 200
     end
  #else      
  #    self.width = [max_choice_width + 12, 96].max + padding * 2
  #    self.width = [width, Graphics.width].min
end
  self.width = [width, widthMin].max
  self.width = [width, Graphics.width].min
  ####################  
  ###### HEIGHT ###### 
  ####################    
  self.height = fitting_height($game_message.choices.size)
  ####################  
  ###### SELF X ###### 
  ####################   
  if $game_switches[4] == true #recruit
    self.x = 400
  elsif $game_switches[2420] == true #kobdeploy
    self.x = 80      
  elsif $game_switches[3470] == true #guild menu
    self.x = 225 - (self.width/2)
  elsif $game_switches[2411] == true #daycare
    self.x = 672
  elsif $game_switches[3451] == true #lvlUp Menu
    self.x = 637   
  else
    self.x = (Graphics.width/2) - (width/2)
    self.x = [x, 150].max
  end       
  ####################  
  ###### SELF Y ###### 
  ####################  
lowchl = 0
if $game_switches[1198] == true || $game_switches[1200] == true || $game_switches[3979] == true
  lowchl = 1
end  
    if $game_switches[4] == true #recruit
      self.y = 420
    elsif $game_switches[2420] == true #kobdeploy
      self.y = 390        
    elsif $game_switches[2411] == true #daycare
      self.y = 352      
    elsif $game_switches[3451] == true #lvlUp Menu
      self.y = 212       
    elsif $game_switches[521] == true #High Choice
      self.y = 75     
    elsif lowchl == 1 #ani going
      self.y = 475  
    elsif @message_window.y >= Graphics.height / 2
      self.y = @message_window.y - height     
    else
      self.y = @message_window.y + @message_window.height
    end
  end
  #--------------------------------------------------------------------------
  # * Get Maximum Width of Choices
  #--------------------------------------------------------------------------
  def max_choice_width
    $game_message.choices.collect {|s| text_size(s).width }.max
  end
  #--------------------------------------------------------------------------
  # * Calculate Height of Window Contents
  #--------------------------------------------------------------------------
  def contents_height
    item_max * item_height
  end
  #--------------------------------------------------------------------------
  # * Create Command List
  #--------------------------------------------------------------------------
  def make_command_list
    $game_message.choices.each do |choice|
      add_command(choice, :choice)
    end
  end
  #--------------------------------------------------------------------------
  # * Draw Item
  #--------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect_for_text(index)
    draw_text_ex(rect.x, rect.y, command_name(index))
  end
  #--------------------------------------------------------------------------
  # * Get Activation State of Cancel Processing
  #--------------------------------------------------------------------------
  def cancel_enabled?
    $game_message.choice_cancel_type > 0
  end
  #--------------------------------------------------------------------------
  # * Call OK Handler
  #--------------------------------------------------------------------------
  def call_ok_handler
    $game_message.choice_proc.call(index)
    close
  end
  #--------------------------------------------------------------------------
  # * Call Cancel Handler
  #--------------------------------------------------------------------------
  def call_cancel_handler
    $game_message.choice_proc.call($game_message.choice_cancel_type - 1)
    close
  end
end
