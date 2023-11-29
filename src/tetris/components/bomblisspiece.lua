local Piece = require("tetris.components.piece")

local BomblissPiece = Piece:extend()

function BomblissPiece:new(shape, rotation, position, block_offsets, gravity, lock_delay, skin, colour, big)
	self.super.new(self, shape, rotation, position, block_offsets, gravity, lock_delay, skin, colour, big)
end

function BomblissPiece:draw(opacity, brightness, grid, partial_das)
	if opacity == nil then opacity = 1 end
	if brightness == nil then brightness = 1 end
	love.graphics.setColor(brightness, brightness, brightness, opacity)
	local offsets = self:getBlockOffsets()
	local gravity_offset = 0
	if config.gamesettings.smooth_movement == 1 and 
	   grid ~= nil and not self:isDropBlocked(grid) then
		gravity_offset = self.gravity * 16
	end
	if partial_das == nil then partial_das = 0 end
	local bomb = self.bomb or 1
	for index, offset in pairs(offsets) do
		local x = self.position.x + offset.x
		local y = self.position.y + offset.y
		local skin, colour = self.skin,self.colour
		if self.fullBomb or index == self.bomb then
			skin, colour = "gem", "R"
		end
		if self.big then
			love.graphics.draw(
				blocks[skin][colour],
				64+x*32+partial_das*2, 16+y*32+gravity_offset*2,
				0, 2, 2
			)
		else
			love.graphics.draw(
				blocks[skin][colour],
				64+x*16+partial_das, 16+y*16+gravity_offset
			)
		end
	end
	return false
end

return BomblissPiece