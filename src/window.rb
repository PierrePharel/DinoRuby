#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "land.rb"
require "dino.rb"
#include SDL

class Window
	attr_accessor :state

	def initialize(width, height)
		@width = width 
		@height = height
		# window settings
		@window = SDL::Screen.open(@width, @height, 32, SDL::HWSURFACE | SDL::DOUBLEBUF)
		SDL::WM.set_caption("Dino Ruby", "")
		# objects for drawing
		@day_color = @window.format.map_rgb(255, 255, 255)
		@land = Land.new
		@rex = Rex.new
		@ptero = Ptero.new
		@state = :open
	end

	def update
		@window.flip
		SDL::Key.scan
	end

	def clear
		@window.fill_rect(0, 0, @width, @height, @day_color)
	end

	def event(current_event = SDL::Key::NIL)
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
		#@ptero.draw
		@rex.draw
		check_collision
	end

	def isopen?
		return false if @state == :closed
		return true
	end

	def close
		@state = :closed
	end

	def paused? 
		return false if @state != :paused
		return true 
	end

	private
	def pause
		@state = :paused
	end

	def check_collision
		if @rex.state == :jump
			if SDL.check_collision?(@rex.jump.collision_box(0, -30, 0, 0), @ptero.ptero.collision_box(0, -10, 20, -30)) || SDL.check_collision?(@rex.jump.collision_box(10, -30, -30, -20), @land.cactus.collision_box)
				pause
			end
		elsif @rex.state == :move_down 
			if SDL.check_collision?(@rex.down.collision_box(0, -30, 0, 0), @ptero.ptero.collision_box) || SDL.check_collision?(@rex.down.collision_box(0, -10, 0, 0), @land.cactus.collision_box)
				pause
			end
		else
			if SDL.check_collision?(@rex.run.collision_box(0, -30, 0, 0), @ptero.ptero.collision_box(0, -10, 20, -30)) || SDL.check_collision?(@rex.run.collision_box(0, -10, 0, 0), @land.cactus.collision_box)
				pause
			end
		end	
	end
end