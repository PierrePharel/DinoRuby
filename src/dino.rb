#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "animation.rb"

class Dino
	attr_writer :state

	def initialize(window)
		@window = window
		@state = :run # run, jump, move_down, dead
		# animations
		@run = Animation.new(SDL::Surface.load("../assets/dino_run.png"), SDL::Rect.new(0, 0, 48, 47), 15)
		@down = Animation.new(SDL::Surface.load("../assets/dino_down.png"), SDL::Rect.new(0, 0, 64, 30), 15)
		# animations position set
		@run.pos.y = (@window.h - @run.tex.h) - 10
		@down.pos.y = (@window.h - @down.tex.h) - 10
	end

	def run
		SDL::Surface.blit(@run.tex, @run.rect.x, 0, @run.rect.w, @run.rect.h, @window, @run.pos.x, @run.pos.y)
		@run.anime
	end

	def down
		SDL::Surface.blit(@down.tex, @down.rect.x, 0, @down.rect.w, @down.rect.h, @window, @down.pos.x, @down.pos.y)
		@down.anime
	end

	def jump
		@counter += 1
		@jump_pos.y -= 10
		SDL::Surface.blit(@run_sprite, 0, 0, @run_anim.w, @run_anim.h, @window, @jump_pos.x, @jump_pos.y)
		@jump_pos.y = (@window.h - @run_sprite.h) - 10 if @counter >= 20
		@counter = 0 if @jump_pos.y >= 50
	end

	def animation
		run if @state == :run
		down if @state == :move_down
		#jump if @state == :jump
	end

	def draw
		animation
	end
end