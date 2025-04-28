module SceneManager
  
  def self.dispose_kale
    if @scene.is_a?(Scene_Map)
      @scene.spriteset.dispose_lights
    else
      @stack.reverse.each do |s|
        if s.is_a?(Scene_Map)
          s.spriteset.dispose_lights
          return
        end
      end
    end
  end
  
  def self.restore_kale
    if @scene.is_a?(Scene_Map)
      @scene.spriteset.setup_lights
    else
      @stack.reverse.each do |s|
        if s.is_a?(Scene_Map)
          s.spriteset.setup_lights
          return
        end
      end
    end
  end
  
end


module Autosave
  
  def self.call
    SceneManager.dispose_kale
    DataManager.save_game_without_rescue(17) #$game_variables[ToddAutoSaveAce::VARIABLE]
    SceneManager.restore_kale
  end
  
end