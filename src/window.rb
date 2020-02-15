$LOAD_PATH << '.'
require "gosu"
require "zorder.rb"
require "land.rb"

WindowWidth = 600
WindowHeight = 150
Background = Gosu::Image.new("../assets/background.png")
LandSprite = Land.new 

class Window < Gosu::Window
	def initialize(width, height)
		super(width, height)
		self.caption = "Dino Ruby"
	end

	def draw
		# background drawing
		Background.draw(0, 0, ZOrder::Background)
		LandSprite.draw
	end
end