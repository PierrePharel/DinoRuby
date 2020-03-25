#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "animation.rb"

class Rex
	attr_reader :run, :jump, :down
	attr_accessor :state, :state_old
	Yvel = 9
	Gravity = 0.5

	def initialize
		@window = SDL::Screen.get
		@state = :run # run, jump, move_down, dead
		@tate_old = :none
		@score = {:str => "00000", :counter => 0}
		@hi_score = "00000"
		# animations and textures
		@run = Animation.new(SDL::Surface.load("../assets/rex_run.png"), SDL::Rect.new(0, 0, 48, 47), 5)
		@jump = Animation.new(SDL::Surface.load("../assets/rex_run.png"), SDL::Rect.new(0, 0, 48, 47), 10)
		@down = Animation.new(SDL::Surface.load("../assets/rex_down.png"), SDL::Rect.new(0, 0, 64, 30), 10)
		@numbers = SDL::Texture.new(SDL::Surface.load("../assets/score.png"), SDL::Rect.new(0, 0, 9, 11))
		@dead = SDL::Texture.new(SDL::Surface.load("../assets/rex_dead.png"), SDL::Rect.new(0, 0, 40, 43))
		# animations position set
		@run.pos.y = (@window.h - @run.rect.h) - 10
		@jump.pos.y = (@window.h - @run.rect.h) - 10
		@down.pos.y = (@window.h - @down.rect.h) - 10 
		@yvel = Yvel
	end

	def draw
		score
		if @state != :dead
			animation
		else
			m_dead
		end
	end

	private
	def move
		@run.pos.x += 0.5
		@jump.pos.x += 0.5
		@down.pos.x += 0.5
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
			@yvel -= Gravity
		end

		if @jump.pos.y >= (@window.h - @jump.rect.h) - 10 
			@jump.pos.y = (@window.h - @jump.rect.h) - 10
			#@state = :none
			@yvel = Yvel
			@state = :run
		end

		# fast down move
		if SDL::Key.press?(SDL::Key::DOWN)
			@jump.pos.y -= @yvel
			@yvel -= Gravity
			if @jump.pos.y >= (@window.h - @jump.rect.h) - 10
				@state = :run
				@yvel = Yvel
			end
		end
	end

	def animation
		m_run if @state == :run
		m_down if @state == :move_down
		m_jump if @state == :jump
		move if @run.pos.x < 20
	end
end

class Ptero
	attr_reader :ptero
	#attr_accessor :n

	def initialize
		@window = SDL::Screen.get
		@ptero = Animation.new(SDL::Surface.load("../assets/ptero.png"), SDL::Rect.new(0, 0, 46, 40), 6)
		@ptero.pos.x = (@window.w - @ptero.rect.w)
		@ptero.pos.y = (@window.h - (@ptero.rect.h * 1.5))
		@y_factor = [1.25, 1.5, 2.5] # down, middle, up 
		#@n = 0
		@xvel = 5
	end

	def draw
		animation
	end

	private
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
end