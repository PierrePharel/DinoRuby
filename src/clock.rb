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

	def stop
		@state = :stop
	end

	def pause
		if @state == :started 
			@paused_ticks = SDL.get_ticks - @start_ticks
		end
	end

	def unpause
		if @state == :paused
			@start_ticks = SDL.get_ticks - @paused_ticks
			@paused_ticks = 0
		end
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