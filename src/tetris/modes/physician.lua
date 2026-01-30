local GameMode = require("tetris.modes.gamemode")
local Ruleset = require("tetris.rulesets.ruleset")
local PhysicianPiece = require("tetris.components.physicianpiece")
local PhysicianGrid = require("tetris.components.physiciangrid")
--Ruleset
local PhysicianRuleset = Ruleset:extend()

PhysicianRuleset.name = "????? Ruleset"
PhysicianRuleset.hash = "PhysicianRules"

PhysicianRuleset.softdrop_lock = true
PhysicianRuleset.harddrop_lock = false
PhysicianRuleset.world = true
PhysicianRuleset.spawn_above_field = false

PhysicianRuleset.colourscheme = {
	[1] = "R"
}

PhysicianRuleset.next_sounds = {
	[1] = "T"
}

PhysicianRuleset.block_offsets = {
	[1] = {
		{ {x=0, y=0}, {x=1, y=0} },
		{ {x=0, y=-1}, {x=0, y=0} },
		{ {x=1, y=0}, {x=0, y=0} },
		{ {x=0, y=0}, {x=0, y=-1} },
	},
}

PhysicianRuleset.block_skins = {
	[1] = {
		{ "E", "W" },
		{ "S", "N" },
		{ "W", "E" },
		{ "N", "S" },
	}
}

PhysicianRuleset.spawn_positions = {
	[1] = { x=4, y=4 },
}

PhysicianRuleset.big_spawn_positions = {
	[1] = { x=2, y=2 },
}

function PhysicianRuleset:initializePiece(
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

	local piece = PhysicianPiece(data.shape, data.orientation - 1, {
		x = spawn_x,
		y = spawn_positions[data.shape].y - spawn_dy
	}, self.block_offsets, 0, 0, self.block_skins, data.colors, big)
	
	self:onPieceCreate(piece)
		
	if irs then
		self:rotatePiece(inputs, piece, grid, {}, true)
		if (data.orientation - 1) ~= piece.rotation then
			playSE("irs")
		end
	end
	return piece
end

--Gamemode
local Physician = GameMode:extend()

local BagRandomizer = require 'tetris.randomizers.bag'

Physician.name = "Physician"
Physician.hash = "Physician"
Physician.tagline = "sample text"
Physician.ruleset_override = true

local colors = {"R", "Y", "B"}
local nextSounds = {
	R = {R = "I", Y = "L", B = "S"},
	Y = {R = "L", Y = "O", B = "Z"},
	B = {R = "S", Y = "Z", B = "J"},
}

local checkPositions = {
	{x = -2, y = 0}, {x = 2, y = 0}, {x = 0, y = -2}, {x = 0, y = 2}
}

function Physician:new()
	Physician.super:new()
	self._ruleset = PhysicianRuleset()
	
	self.level = 6
	
	self.ready_frames = 0
	
	self.grid = PhysicianGrid(8, 16+4)
	self.classic_lock = true
	self.enable_hard_drop = false
	
	self.next_score = 100
	
	self:startGenerateMap()
end

function Physician:startGenerateMap()
	self.gems = 0
	
	local max_gem_height
	
	if self.level >= 19 then
		max_gem_height = 13
	elseif self.level >= 17 then
		max_gem_height = 12
	elseif self.level >= 15 then
		max_gem_height = 11
	else
		max_gem_height = 10
	end
	
	self.mapgen_remain = math.min((self.level + 1) * 4, 8 * max_gem_height)
	self.gen_positions = {}
	
	for x = 1, 8 do
		for y = (20 - max_gem_height + 1), 20 do
			table.insert(self.gen_positions, {x = x, y = y})
		end
	end

	self.gTime = 0
end

function Physician:generateMap()
	while self.mapgen_remain > 0 do
		local r = love.math.random(1, #self.gen_positions)
		local p = self.gen_positions[r]
		self.gen_positions[r], self.gen_positions[#self.gen_positions] = self.gen_positions[#self.gen_positions], nil
		
		local colorIdx = self.mapgen_remain % 4
		
		if colorIdx == 0 then
			colorIdx = love.math.random(1, 3)
		end
		
		local valid = {R = true, Y = true, B = true}
		
		self.mapgen_remain = self.mapgen_remain - 1
		
		for _, checkPos in pairs(checkPositions) do
			valid[
				self.grid:getCell(p.x + checkPos.x, p.y + checkPos.y).colour
			] = nil
		end
		
		for i = 1, 3 do
			if valid[colors[colorIdx]] then
				self.grid:setCell(p.x, p.y, {skin = "V", colour = colors[colorIdx]})
				self.gems = self.gems + 1
				break
			else
				colorIdx = (colorIdx % 3) + 1
			end
		end
	end
	
	if self.mapgen_remain <= 0 then
		self.ready_frames = 100
	end
end

function Physician:getBackground()
	return self.level
end

function Physician:initialize(_)
	local rule = self._ruleset
	self.ruleset = _ruleset
	self.super.initialize(self, rule)
	scene.ruleset = rule
end

function Physician:getNextPiece(ruleset)
	local p = self.super.getNextPiece(self, ruleset)
	p.colors = {colors[love.math.random(1, 3)], colors[love.math.random(1, 3)]}
	return p
end

function Physician:playNextSound(ruleset)
	playSE("blocks", nextSounds[self.next_queue[1].colors[1]][self.next_queue[1].colors[2]])
end

function Physician:onPieceLock(piece, _)
	local r = self.super.onPieceLock(self, piece, _)
	self:tryClear()
	return r
end

function Physician:tryClear()
	local chains = self.grid:findClearedChains()
	if #chains ~= 0 then
		local cleareds = self.grid:clearChains(chains)
		self.gems = self.gems - cleareds
		for i = 1, cleareds do
			self.score = self.score + self.next_score
			self.next_score = self.next_score * 2
		end
		self.gTime = 30
		playSE("erase", "single")
	else
		self.next_score = 100
	end
end

function Physician:advanceOneFrame(inputs, ruleset)
	scene.ruleset = self._ruleset
	
	if self.mapgen_remain > 0 then
		self:generateMap()
		
		return false
	end
	
	self.super.advanceOneFrame(self, inputs, self._ruleset)
	if self.gTime > 0 then
		self.gTime = self.gTime - 1
		if self.gTime == 0 then
			if self.grid:stepGravity() then
				self.gTime = 20
				playSE("fall")
			else
				self:tryClear()
			end
		end
		self.prev_inputs = copy(inputs)
		return false
	end
	
	return true
end

function Physician:drawNextQueue(ruleset)
	function drawPiece(piece, skin, offsets, pos_x, pos_y, colors, fullBomb)
		for index, offset in pairs(offsets) do
			local x = offset.x + ruleset:getDrawOffset(piece, rotation).x + ruleset.spawn_positions[piece].x
			local y = offset.y + ruleset:getDrawOffset(piece, rotation).y + 4.7
			local colour = colors[index] or "R"
			love.graphics.draw(blocks[skin][colour], pos_x+x*16, pos_y+y*16)
		end
	end
	for i = 1, self.next_queue_length do
		self:setNextOpacity(i)
		local next_piece = self.next_queue[i].shape
		local skin = self.next_queue[i].skin
		local rotation = self.next_queue[i].orientation
		local colors = self.next_queue[i].colors
		if config.side_next then -- next at side
			drawPiece(next_piece, skin, ruleset.block_offsets[next_piece][rotation], 192, -16+i*48, colors)
		else -- next at top
			drawPiece(next_piece, skin, ruleset.block_offsets[next_piece][rotation], -16+i*80, -32, colors)
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

function Physician:drawCustom()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setFont(font_3x5_2)
	love.graphics.printf("LEVEL", 208, 120, 80, "left")
	love.graphics.printf("GEMS", 208, 200, 80, "left")
	love.graphics.printf("SCORE", 208, 280, 80, "left")
	love.graphics.setFont(font_3x5_3)
	love.graphics.printf(self.level, 208, 140, 80, "left")
	love.graphics.printf(self.gems, 208, 220, 80, "left")
	love.graphics.printf(self.score, 208, 300, 120, "left")
end

return Physician
