local Grid = require("tetris.components.grid")

local PhysicianGrid = Grid:extend()
physician_blocks = {}
loadImageTable(physician_blocks, {
	N = {
		R = "res/img/phys/rn",
		Y = "res/img/phys/yn",
		B = "res/img/phys/bn",
		F = "res/img/phys/wn",
		X = "res/img/s9"
	},
	E = {
		R = "res/img/phys/re",
		Y = "res/img/phys/ye",
		B = "res/img/phys/be",
		F = "res/img/phys/we",
		X = "res/img/s9"
	},
	S = {
		R = "res/img/phys/rs",
		Y = "res/img/phys/ys",
		B = "res/img/phys/bs",
		F = "res/img/phys/ws",
		X = "res/img/s9"
	},
	W = {
		R = "res/img/phys/rw",
		Y = "res/img/phys/yw",
		B = "res/img/phys/bw",
		F = "res/img/phys/ww",
		X = "res/img/s9"
	},
	O = {
		R = "res/img/phys/r",
		Y = "res/img/phys/y",
		B = "res/img/phys/b",
		F = "res/img/phys/w",
		X = "res/img/s9"
	},
	V = {
		R = "res/img/gem1",
		Y = "res/img/gem7",
		B = "res/img/gem4",
		F = "res/img/gem9",
		X = "res/img/gem9"
	}
})

-- local skin_connection_offs = {
-- 	N = {x = 0, y = -1},
-- 	E = {x = 1, y = 0},
-- 	S = {x = 0, y = 1},
-- 	W = {x = -1, y = 0},
-- }

function PhysicianGrid:isCellOccupied(x, y)
	return self:isOccupied(x - 1, y - 1)
end

-- function PhysicianGrid:checkConnection(x, y)
-- 	local offs = skin_connection_offs[self:getCell(x, y).skin]
-- 	if offs then
-- 		if not self:isCellOccupied(x + offs.x - 1, y + offs.y - 1) then
-- 			self:setCell(
-- 				x, y,
-- 				{
-- 					skin = "O",
-- 					colour = self.grid[y][x].colour
-- 				},
-- 				self.grid_age[y][x]
-- 			)
-- 		end
-- 	end
-- end

function PhysicianGrid:cleanVanishZone()
	for y = 1, 4 do
		for x = 1, self.width do
			self:setCell(x, y)
		end
	end
	for x = 1, self.width do
		if self.grid[5][x].skin == "N" then
			self:setCell(
				x, 5,
				{
					skin = "O",
					colour = self.grid[5][x].colour
				},
				self.grid_age[5][x]
			)
		end
	end
end

function PhysicianGrid:findClearedChains()
	local chains = {}
	for y = 5, self.height do
		for x = 1, self.width do
			if self.grid[y][x].skin ~= "" then
				if (self:getCell(x - 1, y)).colour ~= self.grid[y][x].colour then
					local len = 1
					local positions = {{x = x, y = y}}
					while (self:getCell(x + len, y)).colour == self.grid[y][x].colour do
						table.insert(positions, {x = x + len, y = y})
						len = len + 1
					end
					if (#positions >= 4) then
						table.insert(chains, positions)
					end
				end
				if (self:getCell(x, y - 1)).colour ~= self.grid[y][x].colour then
					local len = 1
					local positions = {{x = x, y = y}}
					while (self:getCell(x, y + len)).colour == self.grid[y][x].colour do
						table.insert(positions, {x = x, y = y + len})
						len = len + 1
					end
					if (#positions >= 4) then
						table.insert(chains, positions)
					end
				end
			end
		end
	end
	return chains
end

function PhysicianGrid:clearChains(chains)
	local viruses = 0
	for _, chain in pairs(chains) do
		for _, pos in pairs(chain) do
			if self.grid[pos.y][pos.x].skin == "V" then
				viruses = viruses + 1
			end

			self:setCell(pos.x, pos.y)

			if (self:getCell(pos.x, pos.y + 1) or {}).skin == "N" then
				self:setCell(
					pos.x, pos.y + 1,
					{
						skin = "O",
						colour = self.grid[pos.y + 1][pos.x].colour
					},
					self.grid_age[pos.y + 1][pos.x]
				)
			end

			if (self:getCell(pos.x - 1, pos.y) or {}).skin == "E" then
				self:setCell(
					pos.x - 1, pos.y,
					{
						skin = "O",
						colour = self.grid[pos.y][pos.x - 1].colour
					},
					self.grid_age[pos.y][pos.x - 1]
				)
			end

			if (self:getCell(pos.x, pos.y - 1) or {}).skin == "S" then
				self:setCell(
					pos.x, pos.y - 1,
					{
						skin = "O",
						colour = self.grid[pos.y - 1][pos.x].colour
					},
					self.grid_age[pos.y - 1][pos.x]
				)
			end

			if (self:getCell(pos.x + 1, pos.y) or {}).skin == "W" then
				self:setCell(
					pos.x + 1, pos.y,
					{
						skin = "O",
						colour = self.grid[pos.y][pos.x + 1].colour
					},
					self.grid_age[pos.y][pos.x + 1]
				)
			end
		end
	end
	return viruses
end

function PhysicianGrid:stepGravity()
	local somethingFell = false
	for y = self.height - 1, 1, -1 do
		local toDrop = {}
		for x = 1, self.width do
			if self:isCellOccupied(x, y) and not self:isCellOccupied(x, y + 1) then
				local cell = self:getCell(x, y)
				if cell.skin ~= "V" and not ((cell.skin == "E" and self:isCellOccupied(x + 1, y + 1)) or (cell.skin == "W" and self:isCellOccupied(x - 1, y + 1))) then
					table.insert(toDrop, x)
				end
			end
		end
		for _, x in pairs(toDrop) do
			somethingFell = true
			self:setCell(
				x, y + 1,
				self:getCell(x, y),
				self.grid_age[y][x]
			)
			self:setCell(x, y)
		end
	end
	return somethingFell
end

function PhysicianGrid:markClearedRows()
	return {}
end

function PhysicianGrid:clearClearedRows()
	return false
end

function PhysicianGrid:getClearedRowCount()
	return 0, {}
end

function PhysicianGrid:applyPiece(piece)
	if piece.big then
		self:applyBigPiece(piece)
		return
	end
	local offsets = piece:getBlockOffsets()
	local skins = piece:getBlockSkins();
	for index, offset in pairs(offsets) do
		local x = piece.position.x + offset.x
		local y = piece.position.y + offset.y
		if y + 1 > 0 and y < self.height then
			self.grid[y+1][x+1] = {
				skin = skins[index],
				colour = piece.colors[index]
			}
		end
	end
	self:cleanVanishZone()
end

function PhysicianGrid:applyBigPiece(piece)
	local offsets = piece:getBlockOffsets()
	local skins = piece:getBlockSkins();
	for index, offset in pairs(offsets) do
		local x = piece.position.x + offset.x
		local y = piece.position.y + offset.y
		for a = 1, 2 do
			for b = 1, 2 do
				if y*2+a > 0 and y*2 < self.height then
					self.grid[y+1][x+1] = {
						skin = skins[index],
						colour = piece.colors[index]
					}	
				end
			end
		end
	end
	self:cleanVanishZone()
end

function PhysicianGrid:draw()
	for y = 5, self.height do
		for x = 1, self.width do
			if physician_blocks[self.grid[y][x].skin] and
			physician_blocks[self.grid[y][x].skin][self.grid[y][x].colour] then
				if self.grid_age[y][x] < 2 then
					love.graphics.setColor(1, 1, 1, 1)
					drawSizeIndependentImage(physician_blocks[self.grid[y][x].skin]["F"], 48+x*16, y*16, 0, 16, 16)
				else
					if self.grid[y][x].colour == "X" then
						love.graphics.setColor(0, 0, 0, 0)
					else
						love.graphics.setColor(1, 1, 1, 1)
					end
					drawSizeIndependentImage(physician_blocks[self.grid[y][x].skin][self.grid[y][x].colour], 48+x*16, y*16, 0, 16, 16)
				end
			end
		end
	end
end

function Grid:drawOutline() end

return PhysicianGrid