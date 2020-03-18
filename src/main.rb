#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "window.rb"
require "clock.rb"

# SDL initialization
SDL.init(SDL::INIT_VIDEO)
state = true
timer = Clock.new
window = Window.new(Screen::WindowWidth, Screen::WindowHeight)
puts(SDL.instance_methods)

SDL::Key.enable_key_repeat(10, 10)
# main loop
while state
	timer.start
	while event = SDL::Event.poll
		# events parsing
		case event	
		when SDL::Event::KeyDown
			window.event(event.sym)
		when SDL::Event::Quit
			state = false
		else
			window.event
		end
	end
	# draw here
	window.clear
	window.draw 
	# update window content
	window.update
	# fps regulation
	SDL.delay((1000 / Screen::FPS) - timer.get_ticks) if timer.get_ticks < (1000 / Screen::FPS)
end

SDL.quit