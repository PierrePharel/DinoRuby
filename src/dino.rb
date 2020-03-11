#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "animation.rb"

class Rex
	attr_accessor :state

	def initialize
		@window = SDL::Screen.get
		@state = :run # run, jump, move_down, dead
		# animations
		@run = Animation.new(SDL::Surface.load("../assets/rex_run.png"), SDL::Rect.new(0, 0, 48, 47), 5)
		@jump = Animation.new(SDL::Surface.load("../assets/rex_run.png"), SDL::Rect.new(0, 0, 48, 47), 10)
		@down = Animation.new(SDL::Surface.load("../assets/rex_down.png"), SDL::Rect.new(0, 0, 64, 30), 10)
		# animations position set
		@run.pos.y = (@window.h - @run.rect.h) - 10
		@jump.pos.y = (@window.h - @run.rect.h) - 10
		@down.pos.y = (@window.h - @down.rect.h) - 10
		@gravity = 0.5
		@yvel = 9
	end

	def run
		SDL::Surface.blit(@run.tex, @run.rect.x, 0, @run.rect.w, @run.rect.h, @window, @run.pos.x, @run.pos.y)
		@run.anime
	end

	def down
		SDL::Surface.blit(@down.tex, @down.rect.x, 0, @down.rect.w, @down.rect.h, @window, @down.pos.x, @down.pos.y)
		@down.anime
	end

	def m_jump
		SDL::Surface.blit(@jump.tex, @jump.rect.x, 0, @jump.rect.w, @jump.rect.h, @window, @jump.pos.x, @jump.pos.y)
		if @state == :jump
			@jump.pos.y -= @yvel
			@yvel -= @gravity
		end

		if @jump.pos.y >= (@window.h - @jump.rect.h) - 10 
			@state = :none
			@yvel = 9
			@state = :run
		end

		# fast down move
		if SDL::Key.press?(SDL::Key::DOWN)
			@jump.pos.y -= @yvel
			@yvel -= @gravity
			if @jump.pos.y >= (@window.h - @jump.rect.h) - 10
				@state = :run
				@yvel = 9
			end
		end
	end

	def animation
		run if @state == :run
		down if @state == :move_down
		m_jump if @state == :jump
	end

	def draw
		animation
	end
end

class Ptero

	def initialize
		@window = SDL::Screen.get
		@ptero = Animation.new(SDL::Surface.load("../assets/ptero.png"), SDL::Rect.new(0, 0, 48, 42), 10)
		@ptero.pos.x = (@window.w - @ptero.rect.w)
	end

	def move
		@ptero.pos.x -= 0.5
	end

	def animation
		SDL::Surface.blit(@ptero.tex, @ptero.rect.x, 0, @ptero.rect.w, @ptero.rect.h, @window, @ptero.pos.x, @ptero.pos.y)
		@ptero.anime
		move
	end

	def draw
		animation
	end
end