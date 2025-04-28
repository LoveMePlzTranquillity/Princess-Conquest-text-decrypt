#==============================================================================
# +++ MOG - Weather EX (v2.3) +++
#==============================================================================
# By Moghunter 
# http://www.atelier-rgss.com/
#==============================================================================
# Sistema de clima com efeitos animados.
#==============================================================================
# As imagens usadas pelo sistema do clima devem ser gravadas na pasta
#
# GRAPHICS/WEATHER/
#
#==============================================================================
# UTILIZAÇÃO
# 
# Use o comando abaixo através da função chamar script.*(Evento)
#
# weather(TYPE, POWER, IMAGE_FILE)
#
# TYPE - Tipo de clima. (de 0 a 6)
# POWER - Quantidade de partículas na tela. (de 1 a 10)
# IMAGE_FILE - Nome da imagem.
#
# Exemplo (Eg)
#
# weather(0, 5, "Leaf")
#
#==============================================================================
# Tipos de Clima.
#
# O sistema vem com 7 climas pré-configurados, que podem ser testados na demo
# que vem com esse script.
#
# 0 - (Rain)  
# 1 - (Wind)
# 2 - (Fog)  
# 3 - (Light)
# 4 - (Snow)
# 5 - (Spark)
# 6 - (Random)
# 7 - (Confetti)
# 8 - (Balloon)
# 9 - (Windy Particles)  
#
#==============================================================================
# NOTA
#
# Evite de usar imagens muito pesadas ou de tamanho grande, caso for usar
# diminua o poder do clima para evitar lag.
#
#==============================================================================
#==============================================================================
# Para parar o clima use o comando abaixo.
#
# weather_stop
#==============================================================================
# Para parar o clima após a batalha use o código abaixo. 
#
# weather_stop_b
#
#==============================================================================
# Para parar reativar o clima com as caracteríticas préviamente usadas use o
# comando abaixo.
#
# weather_restore
#==============================================================================
# Se você precisar ativar um novo clima mas deseja gravar as caracteríticas 
# do clima atual para ser reativado depois use os códigos abaixo.
#
# weather_store
# weather_restore_store
#
#==============================================================================

# REGISTER #
# MAP 486 - Rose Caravan - weather(1, 2, "Rose_01")
# CE 993 - Plant Ruins Prep - weather(0, 5, "Leaf_01A")

#==============================================================================
# ● Histórico (Version History)
#==============================================================================
# v 2.3 - Compatibilidade com MOG Battle Camera.
# v 2.2 - Adicionado o comando parar o clima após a batalha.
# v 2.1 - Melhoria na posição das partículas durante as transições
#         de scenes.
# v 2.0 - Correção do bug do Crash aleatório.
#==============================================================================
module MOG_WEATHER_EX
  #Prioridade do clima na tela.
  WEATHER_SCREEN_Z = 50 
  #Definição da eficiência do poder do clima.
  #NOTA -  Um valor muito alto pode causar lag, dependendo do tipo de clima e
  #        imagem usada.
  WEATHER_POWER_EFIC = 5
  #Ativar o clima no sistema de batalha.
  WEATHER_BATTLE = true
end

$imported = {} if $imported.nil?
$imported[:mog_weather_ex] = true

#==============================================================================
# ■ Cache
#==============================================================================
module Cache
  
  #--------------------------------------------------------------------------
  # ● Weather
  #--------------------------------------------------------------------------
  def self.weather(filename)
      load_bitmap("Graphics/Weather/", filename)
  end
  
end

#==============================================================================
# ■ Game System
#==============================================================================
class Game_System
  
  attr_accessor :weather
  attr_accessor :weather_restore
  attr_accessor :weather_record_set
  attr_accessor :weather_temp
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------  
  alias weather_ex_initialize initialize  
  def initialize
      @weather = [-1,0,""]
      @weather_restore = [-1,0,""]
      @weather_temp = [-1,0,""]
      @weather_record_set = [-1,0,""]
      weather_ex_initialize 
  end  
  
end  

#==============================================================================
# ■ Game Temp
#==============================================================================
class Game_Temp

  attr_accessor :weather_ex_set
  attr_accessor :weather_fade
  attr_accessor :weather_rf_time
  attr_accessor :weather_fstop
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------  
  alias mog_weather_ex_temp_initialize initialize
  def initialize
      @weather_ex_set = []
      @weather_fade = false
      @weather_rf_time = 0
      @weather_fstop = false
      mog_weather_ex_temp_initialize
  end  
  
end

#==============================================================================
# ■ Game Interpreter
#==============================================================================
class Game_Interpreter
  
  #--------------------------------------------------------------------------
  # ● Weather
  #--------------------------------------------------------------------------    
  def weather(type = -1, power = 0, image = "")
      $game_temp.weather_fade = false
      $game_temp.weather_rf_time = 0
      $game_system.weather.clear
      $game_system.weather = [type,power,image]
  end
  
  #--------------------------------------------------------------------------
  # ● Weather Stop
  #--------------------------------------------------------------------------     
  def weather_stop
      $game_temp.weather_fade = false
      $game_system.weather.clear
      $game_system.weather = [-1,0,""]
      $game_system.weather_restore  = [-1,0,""]
      $game_system.weather_temp = [-1,0,""]      
  end
  
  #--------------------------------------------------------------------------
  # ● Weather Restore
  #--------------------------------------------------------------------------       
  def weather_restore
      $game_temp.weather_fade = false
      if $game_system.weather[0] != -1
         w = $game_system.weather
         $game_system.weather_restore = [w[0],w[1],w[2]] 
         $game_system.weather.clear
         $game_system.weather = [-1,0,""]
         return
      end
      w = $game_system.weather_restore 
      weather(w[0],w[1],w[2])
  end
  
  #--------------------------------------------------------------------------
  # ● Weather Fade
  #--------------------------------------------------------------------------         
  def weather_fade(value)
      $game_temp.weather_fade = value
  end
  
  #--------------------------------------------------------------------------
  # ● Weather Store
  #--------------------------------------------------------------------------           
  def weather_store
      w = $game_system.weather 
      $game_system.weather_record_set = [w[0],w[1],w[2]]
  end  
  
  #--------------------------------------------------------------------------
  # ● Weather Restore Store
  #--------------------------------------------------------------------------           
  def weather_restore_store
      w = $game_system.weather_record_set
      weather(w[0],w[1],w[2])      
  end    
  
  #--------------------------------------------------------------------------
  # ● Weather Stop B
  #--------------------------------------------------------------------------           
  def weather_stop_b
      $game_temp.weather_fstop = true
  end
  
end  

#==============================================================================
# ** Spriteset_Map
#==============================================================================
class Spriteset_Map
  
  #--------------------------------------------------------------------------
  # * Create Viewport
  #--------------------------------------------------------------------------
  alias mog_weather_ex_create_viewports create_viewports
  def create_viewports
      create_viewport_weather
      mog_weather_ex_create_viewports      
  end
    
  #--------------------------------------------------------------------------
  # * Create Viewport Weather
  #--------------------------------------------------------------------------
  def create_viewport_weather
      return if @viewport_weather != nil
      @viewport_weather = Viewport.new
      @viewport_weather.z = MOG_WEATHER_EX::WEATHER_SCREEN_Z
      @viewport_weather.ox = ($game_map.display_x * 32)
      @viewport_weather.oy = ($game_map.display_y * 32) 
  end
      
  #--------------------------------------------------------------------------
  # * Dispose Viewports
  #--------------------------------------------------------------------------
  alias mog_weather_ex_dispose_viewports dispose_viewports
  def dispose_viewports      
      mog_weather_ex_dispose_viewports
      dispose_viewport_weather
  end
  
  #--------------------------------------------------------------------------
  # * Dispose Viewport Weather
  #--------------------------------------------------------------------------
  def dispose_viewport_weather
      return if @viewport_weather == nil
      @viewport_weather.dispose    
  end
    
  #--------------------------------------------------------------------------
  # * Update Viewports
  #--------------------------------------------------------------------------
  alias mog_weather_ex_update_viewports update_viewports
  def update_viewports
      mog_weather_ex_update_viewports
      update_viewport_weather
  end
  
  #--------------------------------------------------------------------------
  # * Update Viewports Weather
  #--------------------------------------------------------------------------
  def update_viewport_weather
      return if @viewport_weather == nil
      @viewport_weather.ox = ($game_map.display_x * 32) 
      @viewport_weather.oy = ($game_map.display_y * 32)
  end     
  
end

#==============================================================================
# ** Spriteset_Battle
#==============================================================================
class Spriteset_Battle
  
  #--------------------------------------------------------------------------
  # * Create Viewport
  #--------------------------------------------------------------------------
  alias mog_weather_ex_create_viewports_battle create_viewports
  def create_viewports
      mog_weather_ex_create_viewports_battle
      create_viewport_weather    
  end
    
  #--------------------------------------------------------------------------
  # * Create Viewport Weather
  #--------------------------------------------------------------------------
  def create_viewport_weather
      return if @viewport_weather != nil
      @viewport_weather = Viewport.new
      @viewport_weather.z = MOG_WEATHER_EX::WEATHER_SCREEN_Z
  end
    
  #--------------------------------------------------------------------------
  # * Dispose Viewports
  #--------------------------------------------------------------------------
  alias mog_weather_ex_dispose_viewports_battle dispose_viewports
  def dispose_viewports      
      mog_weather_ex_dispose_viewports_battle
      dispose_viewport_weather
  end
  
  #--------------------------------------------------------------------------
  # * Dispose Viewport Weather
  #--------------------------------------------------------------------------
  def dispose_viewport_weather
      return if @viewport_weather == nil
      @viewport_weather.dispose    
  end
    
  #--------------------------------------------------------------------------
  # * Update Viewports
  #--------------------------------------------------------------------------
  alias mog_weather_ex_update_viewports_battle update_viewports
  def update_viewports
      mog_weather_ex_update_viewports_battle
      update_viewport_weather        
  end  
  
  #--------------------------------------------------------------------------
  # * Update Viewports Weather
  #--------------------------------------------------------------------------
  def update_viewport_weather
      return if @viewport_weather == nil
      if $imported[:mog_battle_camera]
         @viewport_weather.ox = $game_temp.viewport_oxy[0]
         @viewport_weather.oy = $game_temp.viewport_oxy[1]
      end   
  end    
  
end

#==============================================================================
# ■ Weather_EX
#==============================================================================
class Weather_EX
  
  #--------------------------------------------------------------------------
  # ● Initialize
  #--------------------------------------------------------------------------  
  def initialize(viewport = nil ,type = 0, image_name = "",index = 0,nx,ny)
      @wp = Sprite.new
      @wp.bitmap = Cache.weather(image_name.to_s)
      @wp.opacity = 0
      @wp.viewport = viewport
      @cw = @wp.bitmap.width
      @cwm = (@cw / 2) + @cw
      @ch = @wp.bitmap.height
      @chm = (@ch / 2) + @ch
      @range_x = [-@cwm,Graphics.width + @cwm]
      @range_y = [-@chm,Graphics.height + @chm]
      @angle_speed = 0
      @x_speed = 0
      @y_speed = 0
      @zoom_speed = 0
      @opacity_speed = 0
      @type = type
      @index = index
      @nx = 0
      @nx_old = 0
      @ny = 0
      @ny_old = 0      
      @old_nx = nx
      @old_ny = ny
      type_setup(nx,ny)
  end
  
  #--------------------------------------------------------------------------
  # ● x
  #--------------------------------------------------------------------------      
  def x
      @wp.x
  end
  
  #--------------------------------------------------------------------------
  # ● y
  #--------------------------------------------------------------------------      
  def y
      @wp.y
  end
  
  #--------------------------------------------------------------------------
  # ● Opacity
  #--------------------------------------------------------------------------      
  def opacity
      @wp.opacity
  end
  
  #--------------------------------------------------------------------------
  # ● Angle
  #--------------------------------------------------------------------------      
  def angle
      @wp.angle
  end
  
  #--------------------------------------------------------------------------
  # ● Zoom X
  #--------------------------------------------------------------------------      
  def zoom_x
      @wp.zoom_x
  end  
  
  #--------------------------------------------------------------------------
  # ● Dispose Weather
  #--------------------------------------------------------------------------      
  def dispose_weather
      return if @wp == nil
      @wp.bitmap.dispose
      @wp.dispose
      @wp = nil
  end
  
  #--------------------------------------------------------------------------
  # ● Pre Values
  #--------------------------------------------------------------------------    
  def pre_values(index)
      return if  $game_temp.weather_ex_set[index] == nil
      @wp.x = $game_temp.weather_ex_set[index][0]
      @wp.y = $game_temp.weather_ex_set[index][1]
      @wp.opacity = 1#$game_temp.weather_ex_set[index][2]
      @wp.angle = $game_temp.weather_ex_set[index][3]
      @wp.zoom_x = $game_temp.weather_ex_set[index][4]
      @wp.zoom_y = $game_temp.weather_ex_set[index][4]
      $game_temp.weather_ex_set[index].clear
      $game_temp.weather_ex_set[index] = nil
  end  
  
  #--------------------------------------------------------------------------
  # ● Type Setup
  #--------------------------------------------------------------------------      
  def type_setup(nx = 0, ny = 0)
      @cw2 = [@range_x[1] + nx, @range_x[0] + nx]
      @ch2 = [@range_y[1] + ny, @range_y[0] + ny]
      check_weather_type
      pre_values(@index)
      @opacity_speed = -1 if $game_temp.weather_fade
  end
  
  #--------------------------------------------------------------------------
  # ● Update
  #--------------------------------------------------------------------------    
  def update_weather(nx = 0, ny = 0)
      @wp.x += @x_speed
      @wp.y += @y_speed
      @wp.opacity += @opacity_speed
      @wp.angle += @angle_speed
      @wp.zoom_x += @zoom_speed
      @wp.zoom_y += @zoom_speed
      check_loop_map(nx,ny)
      type_setup(nx,ny) if can_reset_setup?
  end  

  #--------------------------------------------------------------------------
  # ● Check Loop Map
  #--------------------------------------------------------------------------        
  def check_loop_map(nx,ny)
      if (@old_nx - nx).abs > 32
         @cw2 = [@range_x[1] + nx, @range_x[0] + nx]
         @wp.x += nx
         @wp.x -= @old_nx if nx == 0
      end   
      if (@old_ny - ny).abs > 32
         @ch2 = [@range_y[1] + ny, @range_y[0] + ny]
         @wp.y += ny
         @wp.y -= @old_ny if ny == 0
      end         
      @old_nx = nx
      @old_ny = ny    
  end  
    
  #--------------------------------------------------------------------------
  # ● Can Reset Setup
  #--------------------------------------------------------------------------      
  def can_reset_setup?
      return true if @wp.x > @cw2[0] or @wp.x <  @cw2[1]
      return true if @wp.y > @ch2[0]  or @wp.y < @ch2[1] 
      return true if @wp.opacity == 0
      return true if @wp.zoom_x > 2.0 or @wp.zoom_x < 0.5 
      return false
  end
  
 #--------------------------------------------------------------------------
 # ● Check Weather Type
 #--------------------------------------------------------------------------                         
 def check_weather_type 
     case @type
         when 0;   rain
         when 1;   wind   
         when 2;   fog
         when 3;   light
         when 4;   snow
         when 5;   spark
         when 6;   random           
         when 7;   balloon
         when 8;   confetti
         when 9;   windy
         when 10;  snowEff
         when 11;  frozen
         when 12;  sandStorm
         when 13;  shadow
         when 14;  greenfog   
         when 15;  cave
         when 16;  caveIn
         when 17;  slowFog
      end
 end
    
 #--------------------------------------------------------------------------
 # ● Snow
 #--------------------------------------------------------------------------                          
 def snow
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @y_speed = [[rand(5), 1].max, 5].min
     @opacity_speed = 5
     @angle_speed = rand(3)
   end   
   
 #--------------------------------------------------------------------------
 # ● SnowEff
 #--------------------------------------------------------------------------                          
 def snowEff
     @rnd = ['Snow_01','Snow_01A','Snow_01B','Snow_01B','Snow_01B'].sample
     @wp.bitmap = Cache.weather(@rnd)   
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @y_speed = [[rand(5), 1].max, 5].min
     @opacity_speed = 5
     @wp.blend_type = rand(2)
     @angle_speed = rand(3)
   end     
   
 #--------------------------------------------------------------------------
 # ● caveIn
 #--------------------------------------------------------------------------                          
 def caveIn
     @rnd = ['RockB_1','RockB_2','RockB_1','RockB_2','RockG_1','RockG_2','Dust_01'].sample
     @wp.bitmap = Cache.weather(@rnd)   
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @y_speed = [[rand(10), 5].max, 10].min
     @opacity_speed = 5
     @wp.blend_type = 0
     @angle_speed = rand(3)
 end       

 #--------------------------------------------------------------------------
 # ● SandS
 #--------------------------------------------------------------------------                          
  def sandStorm
     @rnd = ['Sand_01','Sand_01A','Dust_01'].sample
     @wp.bitmap = Cache.weather(@rnd)    
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0]) / 2
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @x_speed = [[rand(10), 1].max, 10].min
     @y_speed = [[rand(10), 1].max, 10].min
     @opacity_speed = 10
 end     
   
 #--------------------------------------------------------------------------
 # ● Spark
 #--------------------------------------------------------------------------                           
 def spark
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 0.5
     @wp.zoom_x = (rand(100) + 100) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @wp.blend_type = 1     
     @opacity_speed = 10
     @zoom_speed = -0.01
   end
   
  #--------------------------------------------------------------------------
 # ● Cave
 #--------------------------------------------------------------------------                           
 def cave
     @rnd = ['Pool_01','Pool_02','Pool_02','Pool_03'].sample
     @wp.bitmap = Cache.weather(@rnd)    
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 0.5
     @wp.zoom_x = (rand(100) + 100) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @wp.blend_type = 0
     @opacity_speed = 5
     @zoom_speed = -0.0025
 end  
 
 #--------------------------------------------------------------------------
 # ● Rain
 #--------------------------------------------------------------------------                          
 def rain
     @wp.x = rand(@cw2[0])       
     if @start == nil
        @wp.y = rand(@ch2[0]) 
        @start = true
     else
        @wp.y = @ch2[1]        
     end   
     @wp.opacity = 1
     @wp.zoom_y = (rand(50) + 100) / 100.0
     @wp.zoom_x = (rand(25) + 100) / 100.0
     @y_speed = [[rand(10) + 10, 10].max, 20].min
     @opacity_speed = 10
 end    
 
  #--------------------------------------------------------------------------
 # ● Greenfog
 #--------------------------------------------------------------------------                            
 def greenfog
     @rnd = ['GreenFog_01','GreenFog_02'].sample  
     @wp.bitmap = Cache.weather(@rnd)   
     rand_angle = rand(2)
     @wp.angle = rand_angle == 1 ? 180 : 0
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = (rand(100) + 25) / 200.0
     @wp.zoom_x = (rand(100) + 200) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @x_speed = [[rand(3), 1].max, 10].min
     @opacity_speed = 10
   end
   
 #--------------------------------------------------------------------------
 # ● Fog
 #--------------------------------------------------------------------------                            
 def fog
     rand_angle = rand(2)
     @wp.angle = rand_angle == 1 ? 180 : 0
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @x_speed = [[rand(10), 1].max, 10].min
     @opacity_speed = 10
 end
 
 #--------------------------------------------------------------------------
 # ● Light
 #--------------------------------------------------------------------------                           
 def light 
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @wp.blend_type = 1
     @angle_speed = [[rand(3), 1].max, 3].min
     @y_speed = -[[rand(10), 1].max, 10].min
     @opacity_speed = 2
 end
 
 #--------------------------------------------------------------------------
 # ● Frozen
 #--------------------------------------------------------------------------                           
 def frozen
     @rnd = ['Snow_01','Snow_01A','Snow_01B'].sample  
     @wp.bitmap = Cache.weather(@rnd)     
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 100) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @wp.blend_type = 1     
     @opacity_speed = 10
     @zoom_speed = -0.01
 end   
   
 #--------------------------------------------------------------------------
 # ● Balloon
 #--------------------------------------------------------------------------                           
 def balloon 
     @r = rand(10)
     if @r < 1
     @rnd = ['Balloon_01','Balloon_01A','Balloon_01B','Balloon_01C','Balloon_01D'].sample  
       else
     @rnd = ['Balloon_01','Balloon_01A','Balloon_01B','Balloon_01C'].sample
     end
     @wp.bitmap = Cache.weather(@rnd)
     @wp.angle = 0
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @wp.blend_type = 0
     @y_speed = -[[rand(5), 1].max, 5].min
     @opacity_speed = 5
   end
   
 #--------------------------------------------------------------------------
 # ● Confetti
 #--------------------------------------------------------------------------                           
 def confetti 
     @rnd = ['Confetti_01','Confetti_01A','Confetti_01B','Confetti_01C'].sample
     @wp.bitmap = Cache.weather(@rnd)
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @y_speed = [[rand(5), 1].max, 5].min
     @opacity_speed = 5
     @angle_speed = rand(3)
   end   
   
  #--------------------------------------------------------------------------
 # ● Shadow
 #--------------------------------------------------------------------------                           
 def shadow 
     @rnd = ['Shadow_01A','Shadow_01B','Shadow_01C'].sample
     @wp.bitmap = Cache.weather(@rnd)
     @wp.angle = [0,180].sample
     @wp.x = rand(@cw2[0])
     @wp.y = @ch2[0]
     @wp.opacity = 0.15
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @y_speed = -[[rand(3), 1].max, 3].min
     @opacity_speed = 5
     @angle_speed = 0
   end   
   
 #--------------------------------------------------------------------------
 # ● Wind
 #--------------------------------------------------------------------------                          
 def wind
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @x_speed = [[rand(10), 1].max, 10].min
     @y_speed = [[rand(10), 1].max, 10].min
     @opacity_speed = 10
 end   

  #--------------------------------------------------------------------------
 # ● Windy
 #--------------------------------------------------------------------------                          
 def windy
     @rnd = ['Leaf_01A','Leaf_01B','Dust_01','Dust_01','Dust_01','Leaf_01C'].sample
     @wp.bitmap = Cache.weather(@rnd)   
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @x_speed = [[rand(10), 1].max, 10].min
     @y_speed = [[rand(10), 1].max, 10].min
     @opacity_speed = 10
   end   
   
#--------------------------------------------------------------------------
 # ● SlowFog
 #--------------------------------------------------------------------------                            
 def slowFog
     @rnd = ['DarkFog_01','DarkFog_02','DarkFog_02'].sample
     @wp.bitmap = Cache.weather(@rnd)  
     rand_angle = rand(2)
     @wp.angle = rand_angle == 1 ? 180 : 0
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 150) / 100.0
     @wp.zoom_y = @wp.zoom_x
     @x_speed = [1,2].sample * [1,-1].sample
     @opacity_speed = 15
 end
      
 #--------------------------------------------------------------------------
 # ● Random
 #--------------------------------------------------------------------------                          
 def random
     @wp.angle = rand(360)
     @wp.x = rand(@cw2[0])
     @wp.y = rand(@ch2[0])
     @wp.opacity = 1
     @wp.zoom_x = (rand(100) + 50) / 100.0
     @wp.zoom_y = @wp.zoom_x
     x_s = [[rand(10), 1].max, 10].min
     y_s = [[rand(10), 1].max, 10].min
     rand_x = rand(2)
     rand_y = rand(2)
     @x_speed = rand_x == 1 ? x_s : -x_s
     @y_speed = rand_y == 1 ? y_s : -y_s      
     @opacity_speed = 10
 end    
 
end

#==============================================================================
# ■ Module Weather EX
#==============================================================================
module Module_Weather_EX
  
 #--------------------------------------------------------------------------
 # ● Create Weather EX
 #--------------------------------------------------------------------------                   
  def create_weather_ex
      dispose_weather_ex
      create_weather_sprite     
  end
  
 #--------------------------------------------------------------------------
 # ● Dispose Wheater EX
 #--------------------------------------------------------------------------                     
  def dispose_weather_ex
      dispose_weather_ex_sprite
  end
 
 #--------------------------------------------------------------------------
 # ● Create Weather Sprite
 #--------------------------------------------------------------------------                       
  def create_weather_sprite
      dispose_weather_ex_sprite
      @old_weather = $game_system.weather
      return if $game_system.weather == [] or $game_system.weather[0] == -1
      @weather_ex = []
      @weather_oxy = [$game_map.display_x * 32, $game_map.display_y * 32]      
      index = 0
      power_efic = MOG_WEATHER_EX::WEATHER_POWER_EFIC
      power_efic = 1 if power_efic < 1
      power = [[$game_system.weather[1] * power_efic, power_efic].max, 999].min
      for i in 0...power
          @weather_ex.push(Weather_EX.new(@viewport_weather,$game_system.weather[0],$game_system.weather[2],index, @viewport1.ox, @viewport1.oy))
          index += 1
      end            
  end
  
 #--------------------------------------------------------------------------
 # ● Dispose Weather EX
 #--------------------------------------------------------------------------                   
  def dispose_weather_ex_sprite
      return if @weather_ex == nil
      index = 0
      for i in @weather_ex
          $game_temp.weather_ex_set[index] = [] if $game_temp.weather_ex_set[index] == nil
          $game_temp.weather_ex_set[index].push(i.x,i.y,i.opacity,i.angle,i.zoom_x)
          i.dispose_weather
          index += 1
      end
      @weather_ex.each {|sprite| sprite.dispose_weather}  
      @weather_ex = nil
  end
  
 #--------------------------------------------------------------------------
 # ● Dispose Refresh
 #--------------------------------------------------------------------------                    
  def dispose_refresh
      $game_temp.weather_ex_set.clear
      return if @weather_ex == nil
      @weather_ex.each {|sprite| sprite.dispose_weather}
      @weather_ex = nil
  end  
  
 #--------------------------------------------------------------------------
 # ● Update Weather EX
 #--------------------------------------------------------------------------                   
  def update_weather_ex
      $game_temp.weather_rf_time -= 1 if $game_temp.weather_rf_time > 0
      refresh_weather_ex if $game_temp.weather_rf_time == 0
      return if @weather_ex == nil
      @weather_ex.each {|sprite| sprite.update_weather(@viewport_weather.ox,@viewport_weather.oy)} 
  end
  
 #--------------------------------------------------------------------------
 # ● Refresh Weather EX
 #--------------------------------------------------------------------------                     
  def refresh_weather_ex
      return if @old_weather == nil
      return if @old_weather == $game_system.weather
      dispose_refresh      
      create_weather_sprite
  end  
    
end  

#==============================================================================
# ■ Spriteset Map
#==============================================================================
class Spriteset_Map
   include Module_Weather_EX  
   
 #--------------------------------------------------------------------------
 # ● Initialize
 #--------------------------------------------------------------------------                   
  alias mog_weather_ex_initialize initialize
  def initialize
      dispose_weather_ex    
      mog_weather_ex_initialize
      create_weather_ex
  end

 #--------------------------------------------------------------------------
 # ● Dispose
 #--------------------------------------------------------------------------                   
  alias mog_weather_ex_dispose dispose
  def dispose
      dispose_weather_ex    
      mog_weather_ex_dispose
  end  

 #--------------------------------------------------------------------------
 # ● Update
 #--------------------------------------------------------------------------                   
  alias mog_weather_ex_update update
  def update
      mog_weather_ex_update
      update_weather_ex
  end  
    
end

if MOG_WEATHER_EX::WEATHER_BATTLE 
#==============================================================================
# ■ Spriteset Battle
#==============================================================================
class Spriteset_Battle
  
   include Module_Weather_EX  
   
 #--------------------------------------------------------------------------
 # ● Initialize
 #--------------------------------------------------------------------------                   
  alias mog_weather_ex_initialize initialize
  def initialize
      dispose_weather_ex    
      mog_weather_ex_initialize
      create_weather_ex
  end

 #--------------------------------------------------------------------------
 # ● Dispose
 #--------------------------------------------------------------------------                   
  alias mog_weather_ex_dispose dispose
  def dispose
      mog_weather_ex_dispose
      dispose_weather_ex 
  end  

 #--------------------------------------------------------------------------
 # ● Update
 #--------------------------------------------------------------------------                   
  alias mog_weather_ex_update update
  def update
      mog_weather_ex_update
      update_weather_ex
  end   
    
end

end

#=============================================================================
# ■ Scene Base
#=============================================================================
class Scene_Base
  
  #--------------------------------------------------------------------------
  # ● Weather Recover Data
  #--------------------------------------------------------------------------  
  def weather_recover_data
      #################
      if $game_system.weather.nil? || $game_system.weather.empty?
       $game_system.weather = [-1,0,""]
       $game_system.weather_temp = [-1,0,""]
       $game_system.weather_restore = [-1,0,""]
      end  
      #################
      if $game_system.weather[0] == -1 
          if !$game_system.weather_restore.empty? and $game_system.weather_restore[0] != -1
             v = $game_system.weather_restore
             $game_system.weather = [v[0],v[1],v[2]]
          end
      end    
  end
  
  #--------------------------------------------------------------------------
  # ● Weather Restore
  #--------------------------------------------------------------------------       
  def weather_recover_scene
      #################
      if $game_system.weather_temp.nil? || $game_system.weather_temp.empty?
       $game_system.weather = [-1,0,""]        
       $game_system.weather_temp = [-1,0,""]
       $game_system.weather_restore = [-1,0,""]
      end      
      #################
      return if $game_system.weather_temp[0] == -1
      w = $game_system.weather_temp
      $game_system.weather = [w[0],w[1],w[2]]
      $game_system.weather_temp.clear
      $game_system.weather_temp = [-1,0,""]
  end  
 
  #--------------------------------------------------------------------------
  # ● Main
  #--------------------------------------------------------------------------         
  alias mog_weather_ex_main main
  def main
      dispose_weather_ex_base
      weather_recover_scene if can_recover_weather_scene?
      mog_weather_ex_main
  end    
  
  #--------------------------------------------------------------------------
  # ● Can Recover Weather Scene
  #--------------------------------------------------------------------------         
  def can_recover_weather_scene?
      return true if SceneManager.scene_is?(Scene_Map)
      return true if SceneManager.scene_is?(Scene_Battle)
      return false
  end  
  
  #--------------------------------------------------------------------------
  # ● terminate
  #--------------------------------------------------------------------------         
  alias mog_weather_ex_terminate_base terminate
  def terminate
      mog_weather_ex_terminate_base
      dispose_weather_ex_base      
  end  

  #--------------------------------------------------------------------------
  # ● Dispose Weather EX Base
  #--------------------------------------------------------------------------           
  def dispose_weather_ex_base
      return if @spriteset == nil
      @spriteset.dispose_weather_ex rescue nil
  end        
  
end

#=============================================================================
# ■ Sprite Battle
#=============================================================================
class Spriteset_Battle  

  #--------------------------------------------------------------------------
  # ● Dispose
  #--------------------------------------------------------------------------           
  alias mog_weather_ex_aft_dispose dispose
  def dispose
      force_stop_weather_ex_after_battle
      mog_weather_ex_aft_dispose
  end

  #--------------------------------------------------------------------------
  # ● Force Stop Weather EX After
  #--------------------------------------------------------------------------           
  def force_stop_weather_ex_after_battle
      return if !$game_temp.weather_fstop
      $game_temp.weather_fstop = false
      $game_temp.weather_fade = false
      $game_system.weather.clear
      $game_system.weather = [-1,0,""]
      $game_system.weather_restore  = [-1,0,""]
      $game_system.weather_temp = [-1,0,""]       
  end
    
  
end

#=============================================================================
# ■ Scene Load
#=============================================================================
class Scene_Load < Scene_File
  
  #--------------------------------------------------------------------------
  # ● On Load Success
  #--------------------------------------------------------------------------
  alias mog_weather_ex_on_load_success on_load_success
  def on_load_success
      mog_weather_ex_on_load_success
      weather_recover_data
  end
end

#=============================================================================
# ■ Scene Manager
#=============================================================================
class << SceneManager
  
  #--------------------------------------------------------------------------
  # ● Call
  #--------------------------------------------------------------------------         
  alias mog_weather_ex_call call
  def call(scene_class)
      weather_dispose
      mog_weather_ex_call(scene_class)
  end
  
  #--------------------------------------------------------------------------
  # ● Weather Restore
  #--------------------------------------------------------------------------       
  def weather_dispose
      return if $game_system.weather == ""
      return if $game_system.weather[0] == -1
      w = $game_system.weather
      $game_system.weather_temp = [w[0],w[1],w[2]]
      $game_system.weather.clear
      $game_system.weather = [-1,0,""]
  end    
  
end