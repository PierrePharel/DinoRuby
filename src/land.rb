require "gosu"
require "zorder.rb"

class Land
	def initialize
		@image = Gosu::Image.new("../assets/land.png") 
	end

	def draw 
		@image.draw(0, 0, ZOrder::Land) 
	end
end