local Piece = require("tetris.components.piece")
require("tetris.components.physiciangrid") -- Require physiciangrid to load skin assets

local PhysicianPiece = Piece:extend()

function PhysicianPiece:new(shape, rotation, position, block_offsets, gravity, lock_delay, block_skins, colors, big)
	self.super.new(self, shape, rotation, position, block_offsets, gravity, lock_delay, "2tie", colors[1], big)
	self.colors = colors
	self.block_skins = block_skins
end

function PhysicianPiece:getBlockSkins()
	return self.block_skins[self.shape][self.rotation + 1]
end

function PhysicianPiece:draw(opacity, brightness, grid, partial_das)
	if opacity == nil then opacity = 1 end
	if brightness == nil then brightness = 1 end
	love.graphics.setColor(brightness, brightness, brightness, opacity)
	local offsets = self:getBlockOffsets()
	local skins = self:getBlockSkins();
	local gravity_offset = 0
	if config.gamesettings.smooth_movement == 1 and 
	   grid ~= nil and not self:isDropBlocked(grid) then
		gravity_offset = self.gravity * 16
	end
	if partial_das == nil then partial_das = 0 end
	for index, offset in pairs(offsets) do
		local x = self.position.x + offset.x
		local y = self.position.y + offset.y
		local colour = self.colors[index] or "R"
		local skin = skins[index] or "O"
		if self.big then
			love.graphics.draw(
				physician_blocks[skin][colour],
				64+x*32+partial_das*2, 16+y*32+gravity_offset*2,
				0, 2, 2
			)
		else
			love.graphics.draw(
				physician_blocks[skin][colour],
				64+x*16+partial_das, 16+y*16+gravity_offset
			)
		end
	end
	return false
end

return PhysicianPiece