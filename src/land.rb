require "gosu"
require "zorder.rb"
require "win_infos.rb"

class Land
	def initialize
		@images = Gosu::Image.load_tiles("../assets/land.png", 300, 14)
		@x = 0
		@y = WinInfos::WindowHeight - (@images[0].height + 10)
		@speed = 3.5 # current value is 3.5
		@land = [2, 1, 0, 3]
	end

	def make_land
		i = 0

		@land.clear
		while i < 4
			@land.push(rand(0...4))
			i += 1
		end
	end

	def animation
		make_land if Gosu.milliseconds % 1200 == 0
		@x -= @speed if Gosu.milliseconds
		@images[@land[0]].draw(@x, @y, ZOrder::Land)
		@images[@land[1]].draw(@x + 300, @y, ZOrder::Land)
		@images[@land[2]].draw(@x + 600, @y, ZOrder::Land)
		@images[@land[3]].draw(@x + 900, @y, ZOrder::Land)
	end

	def draw
		animation
	end
end