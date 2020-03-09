#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "animation.rb"

class Dino
	attr_writer :state
	attr_accessor :jump

	def initialize
		@window = SDL::Screen.get
		@state = :run # run, jump, move_down, dead
		# animations
		@run = Animation.new(SDL::Surface.load("../assets/dino_run.png"), SDL::Rect.new(0, 0, 48, 47), 15)
		@jump = Animation.new(SDL::Surface.load("../assets/dino_run.png"), SDL::Rect.new(0, 0, 48, 47), 10)
		@down = Animation.new(SDL::Surface.load("../assets/dino_down.png"), SDL::Rect.new(0, 0, 64, 30), 20)
		# animations position set
		@run.pos.y = (@window.h - @run.rect.h) - 10
		@jump.pos.y = (@window.h - @run.rect.h) - 10
		@down.pos.y = (@window.h - @down.rect.h) - 10
		@gravity = 0.6
		@yvel = 10
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
		if @jump.state.a == :up
			@jump.pos.y -= @yvel
			@yvel -= @gravity
		end

		if @jump.pos.y >= (SDL::Screen.get.h - @jump.rect.h) - 10 #&& @jump.state.a != :none 
			@jump.state.a = :none
			@yvel = 10
			@state = :run
		end
		#if @jump.pos.y >= 15 && (@jump.state.o == :none || @jump.state.o == :up) 
 		#	@jump.state.a = :up
		#	@jump.pos.y -= 4 #if @counter >= 10
 		#	@jump.state.o = :up
		#elsif @jump.pos.y < (SDL::Screen.get.h - @jump.rect.w) - 10 #&& @jump.state.o == :up
		#	@jump.state.a = :down
		#	@jump.pos.y += 4 #if @counter >= 10 #(SDL::Screen.get.h - @jump.rect.w) - 10
 		#	@jump.state.o = :down
		#end

		#if @jump.pos.y >= (SDL::Screen.get.h - @jump.rect.w) - 10 
		#	@jump.state.a = :none
		#	@jump.state.o = :none
		#	@state = :run
		#end
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