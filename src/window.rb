#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "land.rb"
require "dino.rb"

class Window
	attr_accessor :state

	def initialize(width, height)
		@width = width 
		@height = height
		# window setting
		@window = SDL::Screen.open(@width, @height, 32, SDL::HWSURFACE | SDL::DOUBLEBUF)
		SDL::WM.set_caption("Dino Ruby", "")
		# objects drawing
		@day = @window.format.map_rgb(247, 247, 247)
		@night = @window.format.map_rgb(0, 0, 0)
		@land = Land.new
		@rex = Rex.new
		@ptero = Ptero.new
		@state = :open
	end

	def update
		@window.flip
		SDL::Key.scan
	end

	def time
		@window.fill_rect(0, 0, @width, @height, @day)
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
		score = @rex.score[:str].to_i
		time
		@land.draw(score)
		@ptero.draw if @ptero.draw?(score, @land.cactus.pos)
		@rex.draw 
		check_collision(score)
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

	def check_collision(score)
		check_ptero_collision
		check_cactus_collision #if !@ptero.draw?(score, @land.cactus.pos)
=begin
		if @rex.state == :jump
			if SDL.check_collision?(@rex.jump.collision_box(0, -30), @ptero.ptero.collision_box(0, -10, 20, -30)) || SDL.check_collision?(@rex.jump.collision_box(10, -30, -30, -20), @land.cactus.collision_box)
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end
		elsif @rex.state == :move_down 
			if SDL.check_collision?(@rex.down.collision_box(0, -30), @ptero.ptero.collision_box) || SDL.check_collision?(@rex.down.collision_box(0, -15), @land.cactus.collision_box)
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end
		elsif @rex.state == :run 
			if SDL.check_collision?(@rex.run.collision_box(0, -30), @ptero.ptero.collision_box(0, -10, 20, -30)) || SDL.check_collision?(@rex.run.collision_box(0, -10), @land.cactus.collision_box)
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end
		end	
=end
	end

	def check_ptero_collision
		if @rex.state == :jump
			if SDL.check_collision?(@rex.jump.collision_box(0, -30), @ptero.ptero.collision_box(0, -10, 20, -30))
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end
		elsif @rex.state == :move_down
			if SDL.check_collision?(@rex.down.collision_box(0, -30), @ptero.ptero.collision_box)
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end
		elsif @rex.state == :run 
			if SDL.check_collision?(@rex.run.collision_box(0, -30), @ptero.ptero.collision_box(0, -10, 20, -30)) 
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end 
		end
	end

	def check_cactus_collision
		if @rex.state == :jump
			if SDL.check_collision?(@rex.jump.collision_box(10, -30, -30, -20), @land.cactus.collision_box)
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end
		elsif @rex.state == :move_down
			if SDL.check_collision?(@rex.down.collision_box(0, -15), @land.cactus.collision_box)
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end
		elsif @rex.state == :run 
			if SDL.check_collision?(@rex.run.collision_box(0, -10), @land.cactus.collision_box)
				@rex.state_old = @rex.state
				@rex.state = :dead
				draw
				pause
			end 
		end
	end
end