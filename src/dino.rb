#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "animation.rb"

class Rex
	attr_reader :run, :jump, :down
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

	def m_run
		SDL::Surface.blit(@run.tex, @run.rect.x, 0, @run.rect.w, @run.rect.h, @window, @run.pos.x, @run.pos.y)
		@run.anime
	end

	def m_down
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
		m_run if @state == :run
		m_down if @state == :move_down
		m_jump if @state == :jump
	end

	def draw
		animation
	end
end

class Ptero
	attr_reader :ptero
	#attr_accessor :n

	def initialize
		@window = SDL::Screen.get
		@ptero = Animation.new(SDL::Surface.load("../assets/ptero.png"), SDL::Rect.new(0, 0, 48, 42), 8)
		@ptero.pos.x = (@window.w - @ptero.rect.w)
		@ptero.pos.y = (@window.h - (@ptero.rect.h * 1.5))
		@y_factor = [1.25, 1.5, 2.25] # down, middle, up 
		#@n = 0
		@xvel = 2.8
	end

	def move
		@ptero.pos.x -= @xvel 
		if @ptero.pos.x <= -(@ptero.rect.w)
			@ptero.pos.y = (@window.h - (@ptero.rect.h * @y_factor[rand(0..2)]))
			@ptero.pos.x = @window.w
		end
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