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
		@land = Land.new
		@rex = Rex.new
		@ptero = Ptero.new
	end

	def update
		@window.flip
		SDL::Key.scan
	end

	def clear
		@window.fill_rect(0, 0, @width, @height, @clear_color)
	end

	def event(current_event = nil)
		if current_event == SDL::Key::UP || @rex.state == :jump
			@rex.state = :jump
		elsif current_event == SDL::Key::DOWN
			@rex.state = :move_down
		else
			@rex.state = :run			
		end
	end

	def draw
		@land.draw
		@rex.draw
		@ptero.draw
	end
end