$LOAD_PATH << '.'
require "sdl"
require "win_infos.rb"
require "window.rb"

# SDL initialization
SDL.init(SDL::INIT_VIDEO)
window = Window.new(WinInfos::WindowWidth, WinInfos::WindowHeight)

window.background
# main loop
loop do 
	while event = SDL::Event.poll
		# events parsing
		case event	
		when SDL::Event::Quit
			exit
		end
	end
	# draw here
	window.draw
	# update window content
	window.update
end