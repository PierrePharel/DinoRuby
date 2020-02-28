#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "land.rb"
require "dino.rb"

class Window 
	def initialize(width, height)
		@width = width 
		@height = height
		# window settings
		@window = SDL::Screen.open(@width, @height, 32, SDL::HWSURFACE | SDL::DOUBLEBUF)
		SDL::WM.set_caption("Dino Ruby", "")
		# objects for drawing
		@clear_color = @window.format.map_rgb(255, 255, 255)
		@land = Land.new(@window)
		@dino = Dino.new(@window)
	end

	def update
		@window.flip
	end

	def clear
		@window.fill_rect(0, 0, @width, @height, @clear_color)
	end

	def events(current_event = nil)
		if current_event == SDL::Key::UP
			puts("UP KEY PRESSED !")
		elsif current_event == SDL::Key::DOWN
			@dino.state = :move_down
		else
			@dino.state = :run			
		end
	end

	def draw
		@land.draw
		@dino.draw
	end
end