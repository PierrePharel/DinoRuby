#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "win_infos.rb"
require "window.rb"
require "clock.rb"

FPS = 60

# SDL initialization
SDL.init(SDL::INIT_VIDEO)
state = true
timer = Clock.new
window = Window.new(WinInfos::WindowWidth, WinInfos::WindowHeight)

# main loop
while state
	timer.start
	while event = SDL::Event.poll
		# events parsing
		case event	
		when SDL::Event::KeyDown
			case event.sym
			when SDL::Key::UP
			end
		when SDL::Event::Quit
			state = false
		end
	end
	# draw here
	window.clear
	window.draw
	# update window content
	window.update
	SDL.delay(15) if timer.get_ticks < (1000 / FPS)
end

SDL.quit