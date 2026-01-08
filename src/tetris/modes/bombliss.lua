local GameMode = require("tetris.modes.gamemode")
local Ruleset = require("tetris.rulesets.ruleset")
local BomblissPiece = require("tetris.components.bomblisspiece")
local BomblissGrid = require("tetris.components.bomblissgrid")
--Ruleset
local BomblissRuleset = Ruleset:extend()

BomblissRuleset.name = "Bombliss Ruleset"
BomblissRuleset.hash = "BomblissRules"

BomblissRuleset.softdrop_lock = true
BomblissRuleset.harddrop_lock = false
BomblissRuleset.world = true
BomblissRuleset.spawn_above_field = true

BomblissRuleset.colourscheme = {
	[1] = "C", -- I
	[2] = "C", -- L
	[3] = "C", -- J
	[4] = "C", -- S
	[5] = "C", -- Z
	[6] = "C", -- O
	[7] = "C", -- T
	[8] = "C", -- I2
	[9] = "C", -- I3
	[10] = "C", -- L3
}

BomblissRuleset.next_sounds = {
	[1] = "I",
	[2] = "L",
	[3] = "J",
	[4] = "S",
	[5] = "Z",
	[6] = "O",
	[7] = "T",
	[8] = "T",
	[9] = "L",
	[10] = "J",
}


BomblissRuleset.block_offsets = {
	[1]={ -- I
		{ {x=0, y=0}, {x=-1, y=0}, {x=-2, y=0}, {x=1, y=0} },
		{ {x=0, y=1}, {x=0, y=0}, {x=0, y=-1}, {x=0, y=2} },
		{ {x=-1, y=1}, {x=0, y=1}, {x=1, y=1}, {x=-2, y=1} },
		{ {x=-1, y=0}, {x=-1, y=1}, {x=-1, y=2}, {x=-1, y=-1} },
	},
	[3]={ -- J
		{ {x=0, y=-1}, {x=1, y=-1}, {x=-1, y=-1}, {x=1, y=0} },
		{ {x=0, y=-1}, {x=0, y=0}, {x=0, y=-2}, {x=-1, y=0} },
		{ {x=0, y=-1}, {x=-1, y=-1}, {x=1, y=-1}, {x=-1, y=-2} },
		{ {x=0, y=-1}, {x=0, y=-2}, {x=0, y=0} , {x=1, y=-2} },
	},
	[2]={ -- L
		{ {x=0, y=-1}, {x=1, y=-1}, {x=-1, y=-1}, {x=-1, y=0} },
		{ {x=0, y=-1}, {x=0, y=0}, {x=0, y=-2}, {x=-1, y=-2} },
		{ {x=0, y=-1}, {x=-1, y=-1}, {x=1, y=-1}, {x=1, y=-2} },
		{ {x=0, y=-1}, {x=0, y=-2}, {x=0, y=0}, {x=1, y=0} },
	},
	[6]={ -- O
		{ {x=0, y=0}, {x=-1, y=0}, {x=-1, y=-1}, {x=0, y=-1} },
		{ {x=-1, y=0}, {x=-1, y=-1}, {x=0, y=-1}, {x=0, y=0} },
		{ {x=-1, y=-1}, {x=0, y=-1}, {x=0, y=0}, {x=-1, y=0} },
		{ {x=0, y=-1}, {x=0, y=0}, {x=-1, y=0}, {x=-1, y=-1} },
	},
	[4]={ -- S
		{ {x=1, y=-1}, {x=0, y=-1}, {x=0, y=0}, {x=-1, y=0} },
		{ {x=1, y=1}, {x=1, y=0}, {x=0, y=0}, {x=0, y=-1} },
		{ {x=-1, y=1}, {x=0, y=1}, {x=0, y=0}, {x=1, y=0} },
		{ {x=-1, y=-1}, {x=-1, y=0}, {x=0, y=0}, {x=0, y=1} },
	},
	[7]={ -- T
		{ {x=0, y=-1}, {x=1, y=-1}, {x=-1, y=-1}, {x=0, y=0} },
		{ {x=0, y=-1}, {x=0, y=0}, {x=0, y=-2}, {x=-1, y=-1} },
		{ {x=0, y=-1}, {x=-1, y=-1}, {x=1, y=-1}, {x=0, y=-2} },
		{ {x=0, y=-1}, {x=0, y=-2}, {x=0, y=0}, {x=1, y=-1} },
	},
	[5]={ -- Z
		{ {x=-1, y=-1}, {x=0, y=-1}, {x=0, y=0}, {x=1, y=0} },
		{ {x=1, y=-1}, {x=1, y=0}, {x=0, y=0}, {x=0, y=1} },
		{ {x=1, y=1}, {x=0, y=1}, {x=0, y=0}, {x=-1, y=0} },
		{ {x=-1, y=1}, {x=-1, y=0}, {x=0, y=0}, {x=0, y=-1} },
	},
	[8]={ -- I2
		{ {x=0, y=0}, {x=1, y=0} },
		{ {x=1, y=0}, {x=1, y=1} },
		{ {x=1, y=1}, {x=0, y=1} },
		{ {x=0, y=1}, {x=0, y=0} },
	},
	[9]={ -- I3
		{ {x=0, y=0}, {x=1, y=0}, {x=-1, y=0} },
		{ {x=0, y=0}, {x=0, y=1}, {x=0, y=-1} },
		{ {x=0, y=0}, {x=-1, y=0}, {x=1, y=0} },
		{ {x=0, y=0}, {x=0, y=-1}, {x=0, y=1} },
	},
	[10]={ -- L3
		{ {x=0, y=-1}, {x=0, y=0}, {x=1, y=-1} },
		{ {x=1, y=-1}, {x=-0, y=-1}, {x=1, y=0} },
		{ {x=1, y=0}, {x=1, y=-1}, {x=0, y=0} },
		{ {x=0, y=0}, {x=1, y=0}, {x=0, y=-1} },
	}
}


BomblissRuleset.spawn_positions = {
	[1] = { x=5, y=4 },
	[3] = { x=4, y=5 },
	[2] = { x=4, y=5 },
	[6] = { x=5, y=5 },
	[4] = { x=4, y=5 },
	[7] = { x=4, y=5 },
	[5] = { x=4, y=5 },
	[8] = { x=4, y=5 },
	[9] = { x=4, y=5 },
	[10] = { x=4, y=5 },
}

BomblissRuleset.big_spawn_positions = {
	[1] = { x=3, y=2 },
	[3] = { x=2, y=3 },
	[2] = { x=2, y=3 },
	[6] = { x=3, y=3 },
	[4] = { x=2, y=3 },
	[7] = { x=2, y=3 },
	[5] = { x=2, y=3 },
	[8] = { x=3, y=3 },
	[9] = { x=2, y=3 },
	[10] = { x=2, y=3 },
}

function BomblissRuleset:initializePiece(
	inputs, data, grid, gravity, prev_inputs,
	move, lock_delay, drop_speed,
	drop_locked, hard_drop_locked, big, irs
)
	local spawn_positions
	if big then
		spawn_positions = self.big_spawn_positions
	else
		spawn_positions = self.spawn_positions
	end

	local colours
	if table.equalvalues(
        table.keys(self.colourscheme), {"I", "J", "L", "O", "S", "T", "Z"}
    ) then
		colours = ({self.colourscheme, ColourSchemes.Arika, ColourSchemes.TTC})[config.gamesettings.piece_colour]
	else
		colours = self.colourscheme
	end
	
	local spawn_x = math.floor(spawn_positions[data.shape].x * grid.width / 10)

	local spawn_dy
	if (config.gamesettings.spawn_positions == 1) then
		spawn_dy = (
			self.spawn_above_field and
			self:getAboveFieldOffset(data.shape, data.orientation) or 0
		)
	else
		spawn_dy = (
			config.gamesettings.spawn_positions == 3 and
			self:getAboveFieldOffset(data.shape, data.orientation) or 0
		)
	end

	local piece = BomblissPiece(data.shape, data.orientation - 1, {
		x = spawn_x,
		y = spawn_positions[data.shape].y - spawn_dy
	}, self.block_offsets, 0, 0, data.skin, colours[data.shape], big)
	
	self:onPieceCreate(piece)
	
	if data.bomb then
		piece.bomb = data.bomb
	end
	
	piece.fullBomb = data.fullBomb
	
	if irs then
		self:rotatePiece(inputs, piece, grid, {}, true)
		if (data.orientation - 1) ~= piece.rotation then
			playSE("irs")
		end
	end
	return piece
end

--Gamemode
local Bombliss = GameMode:extend()

local BagRandomizer = require 'tetris.randomizers.bag'

Bombliss.name = "Bomb Contest TB [BETA]"
Bombliss.hash = "Bombliss"
Bombliss.tagline = "sample text"
Bombliss.ruleset_override = true

local explosionSizes = {
	{x1 = -3, y1 = 0, x2 = 3, y2 = 0},
	{x1 = -3, y1 = -1, x2 = 3, y2 = 1},
	{x1 = -3, y1 = -2, x2 = 3, y2 = 2},
	{x1 = -3, y1 = -3, x2 = 3, y2 = 3},
	{x1 = -4, y1 = -4, x2 = 4, y2 = 4},
	{x1 = -5, y1 = -5, x2 = 5, y2 = 5},
	{x1 = -5, y1 = -5, x2 = 5, y2 = 5},
	{x1 = -6, y1 = -6, x2 = 6, y2 = 6},
	{x1 = -6, y1 = -6, x2 = 6, y2 = 6},
	{x1 = -7, y1 = -7, x2 = 7, y2 = 7},
}
--# = block, 0 = bomb
local mapColours = "CCCCCBBBBBMMMMMRRRRROOOOO"
local maps = {
	{
		"    ##    ",
		" ######## ",
		"### 00 ###",
		"### 00 ###",
	},
	{
		"   #  #   ",
		"  ##  ##  ",
		" ## 00 ## ",
		"##  00  ##",
	},
	{
		"####  ####",
		"#        #",
		"#        #",
		"#   00   #",
		"#   00   #",
		"##########",
	},
	{
		"###    ###",
		" ###  ### ",
		"  ##  ##  ",
		" ###00### ",
		"   #00#   ",
		"    ##    ",
		"    ##    ",
	},
	{
		"     #####",
		"     #### ",
		"     ###  ",
		"    00#   ",
		"   #00    ",
		"  ###     ",
		" ####     ",
		"#####     ",
	},
	
	{
		"     0##  ",
		"     0### ",
		"        ##",
		"    ######",
		"  ##0     ",
		" ###0     ",
		"##        ",
		"#####     ",
	},
	{
		"    00    ",
		"   ####   ",
		"  ##  ##  ",
		" ###00### ",
		"    ##    ",
		"    ##    ",
		"    ##    ",
	},
	{
		"    #     ",
		"   #0     ",
		"  ##0     ",
		" ####     ",
		"######    ",
		"     #####",
		"     0### ",
		"     0##  ",
		"     ##   ",
		"     #    ",
	},
	{
		"      ##  ",
		"     ##   ",
		"    00    ",
		"   #0     ",
		"  ##      ",
		" ##       ",
		"##        ",
	},
	{
		"#        #",
		"##      ##",
		"###    ###",
		"# ##  ## #",
		"## #00# ##",
		" ##    ## ",
		"  ##  ##  ",
		"   ####   ",
	},
	
	{
		"    ##    ",
		"   #00#   ",
		"###0  0###",
		"###0  0###",
		"   #00#   ",
		"    ##    ",
		"    ##    ",
	},
	{
		"#         ",
		"##        ",
		"###       ",
		"##0#      ",
		"##0###    ",
		"     #    ",
		"     ##   ",
		"     00#  ",
		"     #### ",
		"     #####",
	},
	{
		"###0##0#  ",
		" # # # #  ",
		" # # # #  ",
		" # # # #  ",
		" # # # #  ",
		" # # # #  ",
	},
	{
		"   ####   ",
		"  0####0  ",
		" 0#    #0 ",
		"##      ##",
		"##      ##",
		"##      ##",
		"##      ##",
		" 0#    #0 ",
		"  0####0  ",
		"   ####   ",
	},
	{
		"0#      #0",
		" #      # ",
		" ##    ## ",
		" ##    ## ",
		" ##    ## ",
		" ###  ### ",
		" ###  ### ",
		" ###  ### ",
		" ###  ### ",
	},
	
	{
		"0###      ",
		"#  #      ",
		"#  #      ",
		"###0###   ",
		"   #  #   ",
		"   #  #   ",
		"   ###0###",
		"      #  #",
		"      #  #",
		"      ###0",
	},
	{
		"   0  0   ",
		"   #  #   ",
		"   #  #   ",
		"0  #  #  0",
		"#  #  #  #",
		"#  #  #  #",
		"#  #  #  #",
		"#  #  #  #",
	},
	{
		" ######## ",
		"##      ##",
		"#0      ##",
		"##      ##",
		"##      ##",
		"######### ",
		"## #####0#",
		"#   ###0##",
		"## #######",
		"######### ",
	},
	{
		"    00    ",
		"   0##0   ",
		"    ##    ",
		"  0####0  ",
		"    ##    ",
		" 0######0 ",
		"    ##    ",
		"    ##    ",
		"    ##    ",
	},
	{
		"##########",
		"#         ",
		"# ########",
		"# #       ",
		"# # ######",
		"# # #     ",
		"# # # ####",
		"# # # #   ",
		"# # # # 00",
	},
	
	{
		"#      ###",
		"#####    #",
		"#     ####",
		"###      #",
		"#      ###",
		"#####    #",
		"#     ####",
		"###      #",
		"#      ###",
		"#####    #",
		"#     ####",
		"###      #",
	},
	{
		"#  #  #  #",
		"#  #  #  #",
		"## ####  #",
		"# ##  #  #",
		"#  # #####",
		"##### #  #",
		"#  #  #  #",
		"# ##  ## #",
		"#  #### ##",
		"#  #  #  #",
		"####  ## #",
		"#  #  #  #",
	},
		{
		"      ### ",
		"   #### # ",
		"#### #### ",
		"# #### ###",
		"### #### #",
		" #### ####",
		" # ####   ",
		" ###  ### ",
		"   #### # ",
		"#### #### ",
		"# ####    ",
		"###       ",
	},
	{
		"   ##     ",
		"   ##     ",
		"   #####  ",
		" ### #####",
		" #####  ##",
		"##  ##  ##",
		"##  ##### ",
		"##### ### ",
		"  ##### ##",
		"     ## ##",
		"  ##### ##",
		"##### ### ",
		"##    ### ",
		"##        ",
	},
	{
		"#  #  #  #",
		"#  #  #  #",
		"#  #  #  #",
		"#  #  #  #",
		"#  ####  #",
		"###   ####",
		"#  #  #  #",
		"## #  # ##",
		" # #  # # ",
		" # #  # # ",
		" # #  # # ",
		" # #### # ",
		" #      # ",
		" #      # ",
	},
}

function Bombliss:new()
    Bombliss.super:new()
	self._ruleset = BomblissRuleset()
	
    self.grid = BomblissGrid(10, 17+4)
	self.markedRows = {}
	self.markedBombs = {}
	self.currentExplosions = {}
	self.explodeTime = 0
	self.classic_lock = true
	self.markedRowIdx = math.huge
	self.rowMarkedAnim = 0
	self.enable_hard_drop = false
	self.allBombRate = 8
	self.allBombCounter = 0
	self.pieces = 100
	self.stageScore = 0
	self.chain = 0
	self.warningFrames = 0
	self.stage = 1
	self.level = 10
	self.stageClear = false
	self.stageClearTime = 0
	
	self.stickyGroups = {}
end

function Bombliss:loadMap(mapNumber)
	self.grid:clear()
	local map = maps[mapNumber]
	local top = self.grid.height - #map
	for y, row in ipairs(map) do
		for x = 1, #row do
			local c = row:sub(x, x)
			if c == "#" then
				self.grid.grid[y + top][x] = {colour = mapColours:sub(mapNumber, mapNumber) or "W", skin = "2tie"}
			elseif c == "0" then
				self.grid.grid[y + top][x] = {colour = "R", skin = "gem"}
			end
		end
	end
	self:findBigBombs(false)
end

function Bombliss:getBackground()
	return self.stage-1
end

function Bombliss:initialize(_)
	local rule = self._ruleset
	self.ruleset = _ruleset
	self.super.initialize(self, rule)
	scene.ruleset = rule
	self:loadMap(self.stage)
end

function Bombliss:initializeOrHold(inputs, ruleset)
	if self.grid:checkForBravo() then
		self.stageClear = true
		self.stageScore = self.pieces
	elseif self.pieces <= 0 then
		self.game_over = true
	else -- What could possibly go wrong?
		self.super.initializeOrHold(self, inputs, ruleset)
	end
end

function Bombliss:getNextPiece(ruleset)
	local p = self.super.getNextPiece(self, ruleset)
	self.allBombCounter = self.allBombCounter + 1
	if self.allBombCounter >= self.allBombRate then
		p.fullBomb = true
		self.allBombCounter = 0
	end
	p.bomb = love.math.random(1, #self.ruleset.block_offsets[p.shape][p.orientation])
	return p
end

function Bombliss:playNextSound(ruleset)
	if self.pieces <= 1 then -- playNextSound fires BEFORE the piece counter is reduced
		return
	else
		self.super.playNextSound(self, ruleset)
	end
end

--cleared_row_count will always be 0
function Bombliss:onPieceLock(piece, cleared_row_count) 
	self.super.onPieceLock(self, piece, cleared_row_count)
	offsets = piece:getBlockOffsets()
	local above = false
	for index, offset in pairs(offsets) do
		y = piece.position.y + offset.y + 1
		if self.grid:isRowFull(y) then
			self:checkRows(true)
			return
		elseif y <= 4 then
			above = true
		end
	end
	if above then
		self.game_over = true
	end
	self:findBigBombs(true)
end

function Bombliss:checkRows(fromPiece)
	local fullRows = 0
	local full = {}
	local bombs = {}
	for y = 1, self.grid.height do
		if self.grid:isRowFull(y) then
			for x = 1, self.grid.width do
				if self.grid:getCell(x, y).skin == "gem" then
					table.insert(bombs, {x = x, y = y, big = self.grid:getCell(x, y).colour == "O"})
					self.explodeTime = 1
				end
				if self.grid:getCell(x, y-1).skin == "gem" and self.grid:getCell(x, y-1).colour == "O" then
					table.insert(bombs, {x = x, y = y-1, big = true})
					self.explodeTime = 1
				end
			end
			fullRows = fullRows + 1
			table.insert(full, y)
		end
	end
	
	if fromPiece or #bombs > 0 then
		self.markedRowIdx = 1
		self.rowMarkedAnim = 30
	end
	
	if #bombs <= 0 then
		self.chain = 0
		self:findBigBombs(true)
	end
	self.markedBombs = bombs
	self.markedRows = full
end

function Bombliss:onPieceEnter()
	if self.pieces <= 0 then
		self.game_over = true
	else
		self.pieces = self.pieces - 1
	end
end

function Bombliss:isSingleBomb(x, y)
	local block = self.grid:getCell(x, y)
	return block.skin == "gem" and block.colour == "R"
end

function Bombliss:findBigBombs(bonus)
	local bonusPieces = 0
	for y = 1, self.grid.height - 1 do
		for x = 1, self.grid.width - 1 do
			if
				self:isSingleBomb(x, y)
				and self:isSingleBomb(x, y+1)
				and self:isSingleBomb(x+1, y)
				and self:isSingleBomb(x+1, y+1)
			then
				self.grid.grid[y][x] = {skin = "gem", colour = "O"}
				self.grid.grid[y+1][x] = {skin = "2tie", colour = "O"}
				self.grid.grid[y][x+1] = {skin = "2tie", colour = "O"}
				self.grid.grid[y+1][x+1] = {skin = "2tie", colour = "O"}
				bonusPieces = bonusPieces + 1
			end
		end
	end
	if bonus then
		self.pieces = self.pieces + bonusPieces
	end
end

function Bombliss:startStickyGravity()
	self.chain = self.chain + 1
	self.stickyGroups = {}
	local checked = {}
	for y = 1, self.grid.height do
		checked[y] = {}
		for x = 1, self.grid.width do
			checked[y][x] = false
		end
	end
	
	for y = 1, self.grid.height do
		for x = 1, self.grid.width do
			local g
			if (not checked[y][x]) and self.grid:isOccupied(x-1, y-1) then
				g = {}
				local grounded = false
				local frontier = {{x = x, y = y}}
				while frontier[1] do
					local px, py = frontier[1].x, frontier[1].y
					table.remove(frontier, 1)
					if
						px >= 1 and px <= self.grid.width
						and py >= 1 and py <= self.grid.height
						and self.grid:isOccupied(px-1, py-1) and (not checked[py][px])
					then
						if py >= self.grid.height then
							grounded = true
						end
						checked[py][px] = true
						table.insert(frontier, {x = px-1, y = py})
						table.insert(frontier, {x = px+1, y = py})
						table.insert(frontier, {x = px, y = py-1})
						table.insert(frontier, {x = px, y = py+1})
						table.insert(g, {x = px, y = py})
					end
				end
				if not grounded and #g > 0 then
					table.insert(self.stickyGroups, g)
				end
			end
		end
	end
	if #self.stickyGroups <= 0 then
		self.chain = 0
	end
end

function Bombliss:explode()
	local nextBombs = {}
	local rect = explosionSizes[math.min(math.max(1, #self.markedRows + self.chain), #explosionSizes)]
	local bigRect = {x1 = -4, y1 = -3, x2 = 5, y2 = 4}
	
	for _, b in pairs(self.markedBombs) do
		self.grid:clearBlock(b.y-1, b.x-1) -- remove bombs to prevent them from re-detonating
	end
	
	local nextExplosions = {}
	
	for _, b in pairs(self.markedBombs) do
		local r = b.big and bigRect or rect
		for x = b.x + r.x1 - 1, b.x + r.x2 do
			for y = b.y + r.y1 - 1, b.y + r.y2 do
				if x >= 1 and x <= self.grid.width and y >= 1 and y <= self.grid.height then
					if x > b.x + r.x1 - 1 and y > b.y + r.y1 - 1 then
						if self.grid:getCell(x, y).skin == "gem" then
							table.insert(nextBombs, {x = x, y = y, big = self.grid:getCell(x, y).colour == "O"})
						end
						self.grid:clearBlock(y-1, x-1)
					else
						if self.grid:getCell(x, y).skin == "gem" and self.grid:getCell(x, y).colour == "O" then
							table.insert(nextBombs, {x = x, y = y, big = true})
						end
					end
				end
			end
		end
		if b.big then
			playSE("erase", "quad")
		else
			playSE("erase", "single")
		end
		table.insert(nextExplosions, {x1 = b.x + r.x1, y1 = b.y + r.y1, x2 = b.x + r.x2, y2 = b.y + r.y2})
	end
	self.markedBombs = nextBombs
	self.currentExplosions = nextExplosions
	self.explodeTime = 30
end

function Bombliss:advanceOneFrame(inputs, ruleset)
	if self.stageClear then
		if self.pieces > 0 and self.stageClearTime >= 90 then
			self.pieces = self.pieces - 1
			self.score = self.score + 1
		else
			self.stageClearTime = self.stageClearTime + 1
		end
		if self.stageClearTime >= 135 and (inputs.rotate_left and not self.prev_inputs.rotate_left) then
			if self.stage >= #maps then
				self.game_over = true
			else
				self.stage = self.stage + 1
				self.stageClear = false
				self.stageClearTime = 0
				self.pieces = 100
				self.ready_frames = 100
				self.allBombCounter = 0
				self.chain = 0
				self:loadMap(self.stage)
				-- generate next queue
				love.math.random()
				self.next_queue = {}
				self.used_randomizer = (
					table.equalvalues(
						table.keys(ruleset.colourscheme),
						self.randomizer.possible_pieces
					) and
					self.randomizer or BagRandomizer(table.keys(ruleset.colourscheme))
				)
				for i = 1, math.max(self.next_queue_length, 1) do
					table.insert(self.next_queue, self:getNextPiece(ruleset))
				end
			end
		end
		self.prev_inputs = copy(inputs)
		return false
	end
	
	self.super.advanceOneFrame(self, inputs, ruleset)
	
	if self.pieces > 10 then
		self.warningFrames = 0
	else
		self.warningFrames = self.warningFrames + 1
	end
	scene.ruleset = self._ruleset
	if self.markedRowIdx <= #self.markedRows then
		self.rowMarkedAnim = self.rowMarkedAnim - 1
		if (self.markedRowIdx < #self.markedRows and self.rowMarkedAnim <= 20) then
			self.rowMarkedAnim = 30
			self.markedRowIdx = self.markedRowIdx + 1
		elseif self.rowMarkedAnim <= 0 then
			self.markedRowIdx = math.huge
		end
		return false
	elseif self.explodeTime > 0 then
		self.explodeTime = self.explodeTime - 1
		if self.explodeTime <= 0 then
			if #self.markedBombs > 0 then
				self:explode()
			else
				self.currentExplosions = {}
				self:startStickyGravity()
			end
		end
		
		return false
	elseif #self.stickyGroups > 0 then
		local blocks = {}
		for i, g in pairs(self.stickyGroups) do
			blocks[i] = {}
			for j, p in pairs(g) do
				blocks[i][j] = self.grid:getCell(p.x, p.y)
				self.grid:clearBlock(p.y-1, p.x-1)
			end
			--[[
			for j, p in pairs(g) do
				self.grid.grid[p.y+1][p.x] = blocks[j]
				p.y = p.y + 1
			end
			]]--
		end
		
		local idx = 1
		while idx <= #self.stickyGroups do
			local g = self.stickyGroups[idx]
			local b = blocks[idx]
			local dead = false
			for i, p in pairs(g) do
				p.y = p.y + 1
				if p.y >= self.grid.height or self.grid:isOccupied(p.x-1, p.y) then
					dead = true
				end
			end
			for i, p in pairs(g) do
				self.grid.grid[p.y][p.x] = b[i]
			end
			if dead then
				table.remove(self.stickyGroups, idx)
				table.remove(blocks, idx)
				playSE("fall")
			else
				idx = idx + 1
			end
		end
		
		if #self.stickyGroups <= 0 then
			self:checkRows()
		end
		return false
	end
end

function Bombliss:drawScoringInfo()
	self.super.drawScoringInfo(self)
	
	local green, blue
	if self.pieces > 10 then
		green, blue = 1, 1
	elseif self.pieces > 5 then
		blue = math.cos(self.warningFrames / 30 * math.pi)*0.5 + 0.5
		green = 1
	else
		blue = math.cos(self.warningFrames / 15 * math.pi)*0.5 + 0.5
		green = blue
	end
	love.graphics.setColor(1, green, blue, 1)
	love.graphics.setFont(font_3x5_3)
	love.graphics.printf(
		self.pieces,
		157, 32, 64, "right"
	)
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(font_3x5_2)
	love.graphics.printf("STAGE", 240, 120, 40, "left")
	love.graphics.printf("GRAND SCORE", 240, 200, 120, "left")
	
	love.graphics.setFont(font_3x5_3)
	love.graphics.printf(self.stage, 240, 140, 90, "left")
	love.graphics.printf(self.score, 240, 220, 90, "left")
end

function Bombliss:drawCustom()
	love.graphics.setColor(0.5, 0.5, 0.5, 1)
	for y = 1, self.grid.height - 1 do
		for x = 1, self.grid.width - 1 do
			local block = self.grid:getCell(x, y)
			if block.skin == "gem" and block.colour == "O" then
				love.graphics.draw(blocks.gem.R, 64 + (x - 1)*16, 16 + (y - 1)*16, 0, 2, 2)
			end
		end
	end
	love.graphics.setColor(1, 1, 1, 1)
	if self.markedRowIdx <= #self.markedRows then
		for i = 1, self.markedRowIdx do
			love.graphics.line(
				64, 88 + (self.markedRows[i]-5)*16,
				64 + self.grid.width*16, 88 + (self.markedRows[i]-5)*16
			)
		end
		
		love.graphics.setFont(font_3x5_3)
		love.graphics.printf(
			self.markedRowIdx + self.chain,
			64, 56 + (self.markedRows[1]-5)*16, self.grid.width*16, "center"
		)
	end
	-- draw explosions
	if #self.currentExplosions > 0 and self.explodeTime > 0 then
		love.graphics.setColor(1, self.explodeTime/30, 0, math.min(self.explodeTime/10, 1))
		for _, explosion in pairs(self.currentExplosions) do
			love.graphics.rectangle(
				"fill",
				64 + (explosion.x1 - 1)*16, 16 + (explosion.y1 - 1)*16,
				16 + (explosion.x2 - explosion.x1)*16, 16 + (explosion.y2 - explosion.y1)*16,
				8
			)
		end
	end
	
	love.graphics.setColor(1, 1, 1, 1)
	if self.stageClear then
		love.graphics.setFont(font_3x5_4)
		love.graphics.printf(
			"Stage " .. self.stage .. " cleared!",
			64, 96, self.grid.width*16, "center"
		)
		if self.stageClearTime >= 45 then
			love.graphics.printf(
				"Score: " .. self.stageScore,
				64, 240, self.grid.width*16, "center"
			)
		end
		love.graphics.setFont(font_3x5_2)
		if self.stageClearTime >= 135 then
			love.graphics.printf(
				"ROTATE LEFT TO CONTINUE",
				64, 360, self.grid.width*16, "center"
			)
		end
	end
end

function Bombliss:drawNextQueue(ruleset)
	local colourscheme
	if table.equalvalues(
		self.used_randomizer.possible_pieces,
		{"I", "J", "L", "O", "S", "T", "Z"}
	) then
		colourscheme = ({ruleset.colourscheme, ColourSchemes.Arika, ColourSchemes.TTC})[config.gamesettings.piece_colour]
	else
		colourscheme = ruleset.colourscheme
	end
	function drawPiece(piece, skin, offsets, pos_x, pos_y, bomb, fullBomb)
		for index, offset in pairs(offsets) do
			local x = offset.x + ruleset:getDrawOffset(piece, rotation).x + ruleset.spawn_positions[piece].x
			local y = offset.y + ruleset:getDrawOffset(piece, rotation).y + 4.7
			if fullBomb or index == bomb then
				love.graphics.draw(blocks.gem.R, pos_x+x*16, pos_y+y*16)
			else
				love.graphics.draw(blocks[skin][colourscheme[piece]], pos_x+x*16, pos_y+y*16)
			end
		end
	end
	for i = 1, math.min(self.next_queue_length, self.pieces) do
		self:setNextOpacity(i)
		local next_piece = self.next_queue[i].shape
		local skin = self.next_queue[i].skin
		local rotation = self.next_queue[i].orientation
		local fullBomb = self.next_queue[i].fullBomb
		local bomb = self.next_queue[i].bomb
		if config.side_next then -- next at side
			drawPiece(next_piece, skin, ruleset.block_offsets[next_piece][rotation], 192, -16+i*48, bomb, fullBomb)
		else -- next at top
			drawPiece(next_piece, skin, ruleset.block_offsets[next_piece][rotation], -16+i*80, -32, bomb, fullBomb)
		end
	end
	if self.hold_queue ~= nil and self.enable_hold then
		self:setHoldOpacity()
		drawPiece(
			self.hold_queue.shape,
			self.hold_queue.skin,
			ruleset.block_offsets[self.hold_queue.shape][self.hold_queue.orientation],
			-16, -32
		)
	end
	return false
end


return Bombliss