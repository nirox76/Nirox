util.AddNetworkString("OpenATMMenu")
util.AddNetworkString("AccountMoneyChange")

local meta = FindMetaTable( "Player" )

function meta:CreateBankAccount()
	
	local steamid = self:SteamID64()
	
	if steamid == nil then
		steamid = "novalue"
	end
	
	file.CreateDir("bank/"..steamid, "DATA")
	file.Write( "bank/"..steamid.."/moneybank.txt", "0" )
	
	self:SetNWInt("AccountMoney", 0)
	
end

function meta:SetMoneyBank( val )
	
	local steamid = self:SteamID64()
	
	local val = val or 0
	
	if steamid == nil then
		steamid = "novalue"
	end
	
	file.CreateDir("bank/"..steamid, "DATA")
	file.Write( "bank/"..steamid.."/moneybank.txt", val )
	
	self:SetNWInt("AccountMoney", tonumber(val))
	
end

function meta:GetBankMoney()
	local steamid = self:SteamID64()
	
	if steamid == nil then
		steamid = "novalue"
	end
	
	local money = file.Read( "bank/"..steamid.."/moneybank.txt" )
	
	return money
	
end

net.Receive("AccountMoneyChange", function( len, ply )
	local method = net.ReadInt( 32 )
	local money = net.ReadInt( 32 )
	local ent = net.ReadEntity()
	
	if not IsValid( ent ) then return end
	if not IsValid( ply ) then return end
	
	local dist = ent:GetPos():Distance( ply:GetPos() )
	
	if dist > 250 then return end
	
	if method == 1 then
		if money <= ply:getDarkRPVar("money") then
			ply:SetMoneyBank( tonumber(ply:GetBankMoney()) + tonumber(money) )
			ply:addMoney( -tonumber(money) )
		end
	elseif method == 2 then
		if money <= tonumber(ply:GetBankMoney()) then
			ply:SetMoneyBank( tonumber(ply:GetBankMoney()) - tonumber(money) )
			ply:addMoney( tonumber(money) )
		end
	elseif method == 3 then
		local pl = net.ReadEntity()
		if not IsValid( pl ) then return end
		
		if money <= tonumber(ply:GetBankMoney()) then
			ply:SetMoneyBank( tonumber(ply:GetBankMoney()) - tonumber(money) )
			pl:SetMoneyBank( tonumber(pl:GetBankMoney()) + tonumber(money) )
			DarkRP.notify(pl, 1, 10, ply:Name().." vous a fais un transfert de "..money.."€.")
		
		end
		
	end
	
end)


hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn.Bank", function( ply )
	local steamid = ply:SteamID64()
	
	if steamid == nil then
		steamid = "novalue"
	end
	
	if not file.Exists("bank/"..steamid.."/moneybank.txt", "DATA") then
		timer.Simple(0.5, function()
			ply:CreateBankAccount()
		end)
	else
	
		ply:SetNWInt("AccountMoney", tonumber(ply:GetBankMoney()) )
	
	end
	
end)