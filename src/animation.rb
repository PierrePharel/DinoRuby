#!/usr/bin/env ruby -wKU
# encoding: UTF-8
$LOAD_PATH << '.'
require "sdl"
require "common.rb"

class Animation
	attr_accessor :pos, :state
	attr_reader :tex, :rect, :limit

	def initialize(tex, rect, limit = 0)
		@tex = tex
		@pos = SDL::Vec2.new(0, 0)
		@rect = rect
		@limit = limit
		@counter = 0
		@state = State.new(:none, :none)
	end

	def anime
		@counter += 1
		@rect.x += @rect.w if @counter >= @limit
		@rect.x = 0 if @rect.x == @tex.w
		@counter = 0 if @counter >= @limit
	end

	def jump
		@counter += 1
		@pos.y -= 2 #if @counter
		if @pos.y <= 6 
			@counter = 0 
			@pos.y = (SDL::Screen.get.h - @rect.w) - 10
			return false
		end

		return true
	end
end