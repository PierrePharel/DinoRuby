#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"

class Dino
	attr_writer :state

	def initialize(window)
		@window = window
		@state = :run # run, jump, move_down, dead
		@run_sprite = SDL::Surface.load("../assets/dino_stand.png")
		@move_down_sprite = SDL::Surface.load("../assets/dino_move_down.png")
		@run_pos = SDL::Vec2.new(0, (@window.h - @run_sprite.h) - 10)
		@down_pos = SDL::Vec2.new(0, (@window.h - @move_down_sprite.h) - 10) 
		@run_anim = SDL::Rect.new(0, 0, 48, 47)
		@down_anim = SDL::Rect.new(0, 0, 64, 30)
	end

	def run
		SDL::Surface.blit(@run_sprite, @run_anim.x, 0, @run_anim.w, @run_anim.h, @window, @run_pos.x, @run_pos.y)
		@run_anim.x += @run_anim.w if SDL.get_ticks % 15 == 0
		@run_anim.x = 0 if @run_anim.x == 144
	end

	def move_down
		SDL::Surface.blit(@move_down_sprite, @down_anim.x, 0, @down_anim.w, @down_anim.h, @window, @down_pos.x, @down_pos.y)
		@down_anim.x += @down_anim.w if SDL.get_ticks % 20 == 0
		@down_anim.x = 0 if @down_anim.x == @move_down_sprite.w
	end

	def animation
		run if @state == :run
		move_down if @state == :move_down
	end

	def draw
		animation
	end
end