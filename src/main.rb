#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "window.rb"
require "clock.rb"

# SDL initialization
SDL.init(SDL::INIT_VIDEO)
timer = Clock.new
window = Window.new(Screen::WindowWidth, Screen::WindowHeight)

SDL::Key.enable_key_repeat(10, 10)
# main loop
while window.isopen?
	timer.start
	while event = SDL::Event.poll
		# events handling
		case event	
		when SDL::Event::KeyDown
			window.event(event.sym)
		when SDL::Event::Quit
			window.close
		else
			window.event
		end
	end

	if !window.paused? && window.isopen?
		# draw here
		window.draw 
		# update window content
		window.update
	end

	# fps regulation
	SDL.delay((1000 / Screen::FPS) - timer.get_ticks) if timer.get_ticks < (1000 / Screen::FPS)
end

SDL.quit