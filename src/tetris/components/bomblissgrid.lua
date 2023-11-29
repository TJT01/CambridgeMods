local Grid = require("tetris.components.grid")

local BomblissGrid = Grid:extend()

function BomblissGrid:markClearedRows()
	return {}
end

function BomblissGrid:clearClearedRows()
	return false
end

function BomblissGrid:getClearedRowCount()
	return 0, {}
end

function BomblissGrid:applyPiece(piece)
	if piece.big then
		self:applyBigPiece(piece)
		return
	end
	bomb = piece.bomb or 1
	offsets = piece:getBlockOffsets()
	for index, offset in pairs(offsets) do
		x = piece.position.x + offset.x
		y = piece.position.y + offset.y
		if y + 1 > 0 and y < self.height then
			if piece.fullBomb or bomb == index then
				self.grid[y+1][x+1] = {
					skin = "gem",
					colour = "R"
				}
			else
				self.grid[y+1][x+1] = {
					skin = piece.skin,
					colour = piece.colour
				}
			end
			
		end
	end
end

function BomblissGrid:applyBigPiece(piece)
	offsets = piece:getBlockOffsets()
	for index, offset in pairs(offsets) do
		x = piece.position.x + offset.x
		y = piece.position.y + offset.y
		for a = 1, 2 do
			for b = 1, 2 do
				if y*2+a > 0 and y*2 < self.height then
					if bomb == index then
						self.grid[y+1][x+1] = {
							skin = "gem",
							colour = "R"
						}
					else
						self.grid[y*2+a][x*2+b] = {
							skin = piece.skin,
							colour = piece.colour
						}
					end
				end
			end
		end
	end
end

return BomblissGrid