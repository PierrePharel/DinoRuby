#!/usr/bin/env ruby -wKU
# encoding: UTF-8
$LOAD_PATH << '.'
require "sdl"
require "common.rb"

class Animation < Objekt
	attr_accessor :pos, :tex
	attr_reader :rect, :limit

	def initialize(tex, limit = 0)
		@tex = tex.img
		@pos = SDL::Vec2.new(0, 0)
		@rect = tex.rect
		@limit = limit
		@counter = 0
	end

	def anime
		@counter += 1
		@rect.x += @rect.w if @counter >= @limit
		@rect.x = 0 if @rect.x == @tex.w
		@counter = 0 if @counter >= @limit
	end
end