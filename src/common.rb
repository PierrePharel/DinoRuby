#!/usr/bin/env ruby -wKU
# encoding: UTF-8
require "sdl"

module SDL

	Vec2 = Struct.new(:x, :y)
	Box = Struct.new(:left, :right, :top, :bottom)
	Texture = Struct.new(:img, :rect)
	Key::NIL = nil
	def check_collision?(box_a, box_b)
		if box_b.class == Array
			if box_b.size > 0
				if (box_a.bottom <= box_b[0].top || box_a.top >= box_b[0].bottom || box_a.right <= box_b[0].left || box_a.left >= box_b[0].right) &&\
				   (box_a.bottom <= box_b[1].top || box_a.top >= box_b[1].bottom || box_a.right <= box_b[1].left || box_a.left >= box_b[1].right)
					return false
				else
					return true 
				end		
			end
		else
			return false if box_a.bottom <= box_b.top || box_a.top >= box_b.bottom || box_a.right <= box_b.left || box_a.left >= box_b.right 
		end

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

