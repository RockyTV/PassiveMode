-- Name: PassiveMode
-- Version: 1.1
-- Description: allows the player to type a command and become passive, not being damaged and not damaging other players.
-- Authors: RockyTV, Anzu
-- Original Release: December 21, 2013
-- Update Release: December 24, 2013

timer = Timer()
numTicks = 0

function SendTables()
	numTicks = numTicks + 1
		if timer:GetSeconds() > 5 then
			Network:Broadcast("PassiveTable", peaceful)
		end
		timer:Restart()
		numTicks = 0
end

function OnPlayerChat(args)
	if args.text == "/passive" or args.text == "/afk" then
        --args.player:SendChatMessage("You just used the /passive command", color)
		if onlyAdmins == true then
			if isAdmin(args.player) then
				if peaceful[args.player:GetSteamId().id] == nil then
					peaceful[args.player:GetSteamId().id] = args.player
					local allowDamage = false
					args.player:SendChatMessage(enableModeMsg1, color)
					args.player:SendChatMessage(enableModeMsg2, color)
					args.player:SendChatMessage(enableModeMsg3, color)
				else
					peaceful[args.player:GetSteamId().id] = nil
					local allowDamage = true
					args.player:SendChatMessage(disableModeMsg1, color)
					args.player:SendChatMessage(disableModeMsg2, color)
				end
			else
				args.player:SendChatMessage(insufficientPermissionMsg, Color(150, 0, 0))
			end
		else
			if peaceful[args.player:GetSteamId().id] == nil then
				peaceful[args.player:GetSteamId().id] = args.player
				local allowDamage = false
				args.player:SendChatMessage(enableModeMsg1, color)
				args.player:SendChatMessage(enableModeMsg2, color)
				args.player:SendChatMessage(enableModeMsg3, color)
			else
				peaceful[args.player:GetSteamId().id] = nil
				local allowDamage = true
				args.player:SendChatMessage(disableModeMsg1, color)
				args.player:SendChatMessage(disableModeMsg2, color)
			end
		end
		--Network:Send(args.player, "AllowDamage", allowDamage)
		
		
		Network:Broadcast("PassiveTable", peaceful)
		
		return false
		
	end
	return true
end

function OnPlayerDeath(args)
    peaceful[args.player:GetSteamId().id] = nil
    --local allowDamage = true
    --Network:Send(args.player, "AllowDamage", allowDamage)
end

function OnPlayerQuit(args)
	peaceful[args.player:GetSteamId().id] = nil
end

function isAdmin(player)
	local idstring = ""
	for i,v in ipairs(adminsList) do
		idstring = idstring .. v .. " "
	end
	
	if(string.match(idstring, tostring(player:GetSteamId()))) then
		return true
	end
	return false
end

Events:Subscribe("PlayerChat", OnPlayerChat)
Events:Subscribe("PlayerDeath", OnPlayerDeath)
Events:Subscribe("PlayerQuit", OnPlayerQuit)
Events:Subscribe("PreTick", SendTables)