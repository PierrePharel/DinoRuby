#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require "sdl"

class Animation
	attr_accessor :pos
	attr_reader :tex, :rect, :limit

	def initialize(tex, rect, limitpf)
		@tex = tex
		@pos = SDL::Vec2.new(0, 0)
		@rect = rect
		@limitpf = limitpf
		@counter = 0
	end

	def anime
		@counter += 1
		@rect.x += @rect.w if @counter >= 10
		@rect.x = 0 if @rect.x == tex.w
		@counter = 0 if @counter >= 10
	end
end