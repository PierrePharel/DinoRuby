#!/usr/bin/env ruby -wKU
# encoding: UTF-8

module SDL
	Vec2 = Struct.new(:x, :y)
end

module Infos
	# Frame Per Second
	FPS = 60
	# window dimension
	WindowWidth = 600
	WindowHeight = 150
end

State = Struct.new(:a, :o)