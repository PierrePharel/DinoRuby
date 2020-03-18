#!/usr/bin/env ruby -wKU
# encoding: UTF-8
require "sdl"

module SDL

	Vec2 = Struct.new(:x, :y)
	def check_collision?(rect_a, rect_b)
		# first box
		left_a = rect_a.pos.x
		right_a = rect_a.pos.x + rect_a.rect.w
		top_a = rect_a.pos.y
		bottom_a = rect_a.pos.y + rect_a.rect.h
		# second box
		left_b = rect_b.pos.x
		right_b = rect_b.pos.x + rect_b.rect.w
		top_b = rect_b.pos.y
		bottom_b = rect_b.pos.y + rect_b.rect.h

		return false if bottom_a <= top_b

		return false if top_a >= bottom_b

		return false if right_a <= left_b

		return false if left_a >= right_b

		return true
	end

	module_function :check_collision?
end

module Screen
	# Frame Per Second
	FPS = 60
	# window dimension
	WindowWidth = 600
	WindowHeight = 150
end

