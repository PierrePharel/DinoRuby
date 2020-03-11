#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require "sdl"

class Clock
	
	def initialize
		@start_ticks = 0
		@paused_ticks = 0
		@state = :stop # paused, started, stop
	end

	def start
		@state = :started
		@start_ticks = SDL.get_ticks
	end

	def get_state
		return @state
	end

	def get_ticks
		if @state == :started
			return SDL.get_ticks - @start_ticks
		elsif @state == :paused 
			return @paused_ticks
		end
	end
end