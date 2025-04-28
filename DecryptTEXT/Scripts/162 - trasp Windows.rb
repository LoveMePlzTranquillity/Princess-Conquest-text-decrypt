class Window_TitleCommand < Window_Command
  alias galv_ocedic_title_command_initialize initialize
  def initialize
    galv_ocedic_title_command_initialize
    self.opacity = 0
  end
end