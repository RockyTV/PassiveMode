-- Name: PassiveMode
-- Version: 1.1
-- Description: allows the player to type a command and become passive, not being damaged and not damaging other players.
-- Authors: RockyTV, Anzu
-- Original Release: December 21, 2013
-- Update Release: December 24, 2013

local version = 1.1

class 'PassiveModule'

function PassiveModule:__init()
	self.active = true
	
	Events:Subscribe("ModuleLoad", self, self.ModuleLoad)
	Events:Subscribe("ModuleUnload", self, self.ModuleUnload)
end

function PassiveModule:ModuleLoad()
	print(string.format("version %.02f loaded.", version))
end

function PassiveModule:ModuleUnload()
	print(string.format("version %.02f unloaded.", version))
end

PassiveModule = PassiveModule()