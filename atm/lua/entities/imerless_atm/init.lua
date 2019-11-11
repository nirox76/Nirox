AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel( "models/props_unique/atm01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
	
		phys:Wake()
	
	end
	self:SetUseType( SIMPLE_USE )
	
end

function ENT:Use( a, c )

	net.Start("OpenATMMenu")
		net.WriteEntity(self)
	net.Send(c)

end
