#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "clock.rb"

class Dino
	attr_writer :state

	def initialize(window)
		@window = window
		@state = :run # run, jump, move_down, dead
		@sprite = SDL::Surface.load("../assets/dino_stand.png")
		@move_down = SDL::Surface.load("../assets/dino_move_down.png")
		@x = 0
		@y = (window.h - @sprite.h) - 10
		@frame_size = {:width => 48, :height => 47}
		@cur_frame = 0
	end

	def run
		SDL::Surface.blit(@sprite, @cur_frame, 0, @frame_size[:width], @frame_size[:height], @window, @x, @y)
		@cur_frame += @frame_size[:width] if SDL.get_ticks % 6 == 0
		@cur_frame = 0 if @cur_frame >= 144
	end

	def animation
		run
	end

	def draw
		animation
	end
end