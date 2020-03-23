#!/usr/bin/env ruby -wKU
# encoding: UTF-8
$LOAD_PATH << '.'
require "sdl"
require "common.rb"

class Animation
	attr_accessor :pos, :tex
	attr_reader :rect, :limit

	def initialize(tex, rect, limit = 0)
		@tex = tex
		@pos = SDL::Vec2.new(0, 0)
		@rect = rect
		@limit = limit
		@counter = 0
	end

	def anime
		@counter += 1
		@rect.x += @rect.w if @counter >= @limit
		@rect.x = 0 if @rect.x == @tex.w
		@counter = 0 if @counter >= @limit
	end

	def collision_box(lval = 0, rval = 0, tval = 0, bval = 0)
		box = nil

		if lval == 0 && rval == 0 && tval == 0 && bval == 0
			box = SDL::Box.new(@pos.x, @pos.x + @rect.w, @pos.y, @pos.y + @rect.h) 
		else
			box = SDL::Box.new(@pos.x + lval, (@pos.x + @rect.w) + rval, @pos.y + tval, (@pos.y + @rect.h) + bval)
		end

		return box
	end
end