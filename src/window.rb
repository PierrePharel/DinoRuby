$LOAD_PATH << '.'
require "gosu"
require "zorder.rb"
require "land.rb"

class Window < Gosu::Window
	def initialize(width, height)
		super(width, height)
		self.caption = "Dino Ruby"
		@background = Gosu::Image.new("../assets/background.png")
		@land = Land.new
	end

	def draw
		@background.draw(0, 0, ZOrder::Background)
		@land.draw
	end
end