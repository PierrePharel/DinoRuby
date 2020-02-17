$LOAD_PATH << '.'
require "win_infos.rb"
require "window.rb"

window = Window.new(WinInfos::WindowWidth, WinInfos::WindowHeight)
window.show