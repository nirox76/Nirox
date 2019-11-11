local SizeX = 750
local SizeY = 500

surface.CreateFont("ATM_FONT1",
{
	font = "Arial",
	size = 40,
	weight = 1000
}
)
surface.CreateFont("ATM_FONT2",
{
	font = "Arial",
	size = 30,
	weight = 1000
}
)

surface.CreateFont("ATM_FONT3",
{
	font = "Arial",
	size = 20,
	weight = 1000
}
)

local niroxlogo = Material("materials/banquelogo.png")

local function OpenATMMenu( page, ent )
	
	local box = vgui.Create("DFrame")
	box:SetSize(SizeX,SizeY)
	box:SetPos(ScrW()/2-SizeX/2,ScrH()/2-SizeY/2)
	box:SetVisible(true)
	box:MakePopup()
	box:SetDraggable(false)
	box:SetTitle("")
	box:ShowCloseButton(false)
	box.Paint = function(s , w , h)
		draw.RoundedBox(0,2,2,w , h, Color(0,0,0))
	end
	
	local content = vgui.Create("DScrollPanel", box )
	content:SetSize( SizeX-10, SizeY-10 )
	content:SetPos( 5, 5 )
	content.Paint = function(s , w , h)
		draw.RoundedBox(0,2,2,w , h, Color(64, 64, 64, 150))
	end
	
	local logo = vgui.Create("DScrollPanel", content )
	logo:SetSize( 0 * 750/9/100, 300 * 750/9/100)
	logo:SetPos( 0, 0 )
	logo.Paint = function(s , w , h)
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0, 0, w, h, 0)
	end
	
	local LabelError = vgui.Create( "DLabel", content )
	LabelError:SetSize( SizeX, 30 )
	LabelError:SetPos( 20, SizeY-30-20 )
	LabelError:SetTextColor(Color(255,0,0))
	LabelError:SetFont("ATM_FONT3")
	LabelError:SetText( "" )
	
	
	local buttonDisc = vgui.Create("DButton", content)
	buttonDisc:SetSize( 150, 40)
	buttonDisc:SetPos( SizeX-100-350-10,10 )
	buttonDisc:SetFont("ATM_FONT3")
	buttonDisc:SetTextColor(Color(66,66,66))
	buttonDisc:SetText( "Déconnexion" )
	buttonDisc.Paint = function(s , w , h)
		if buttonDisc:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0))
				else
					draw.RoundedBox(0,0,0,w,h,Color(255,255,255,255))				
			    end
	end
	
    local buttonMoney = vgui.Create("DButton", content)
	buttonMoney:SetSize( 400, 40)
	buttonMoney:SetPos( SizeX-550-20,SizeY-40-20 )
	buttonMoney:SetFont("ATM_FONT3")
	buttonMoney:SetTextColor(Color(66,66,66))
	
	local money = LocalPlayer():GetNWInt("AccountMoney") or 0
	
	buttonMoney:SetText( "Argent:"..money.."€" )
	buttonMoney.Paint = function(s , w , h)
		draw.RoundedBox(0,0,0,w , h, Color(255,255,255,255))
	end
	
	buttonMoney.Think = function()
		local money = LocalPlayer():GetNWInt("AccountMoney") or 0
		buttonMoney:SetText( "Argent:"..money.."€" )
	end
	
	buttonDisc.DoClick = function()
		box:Close()
		OpenATMMenu( 6, ent )
	end
	
	if page == 1 then
	
	local button1 = vgui.Create("DButton", content)
	button1:SetSize( 300, 70)
	button1:SetPos( (SizeX-10)/2-150, 300 * 750/9/100 - 10 )
	button1:SetFont("ATM_FONT2")
	button1:SetText( "CHARGEMENT..." )
	button1:SetTextColor(Color(66,66,66))
	button1.Paint = function(s , w , h)
		draw.RoundedBox(0,0,0,w , h, Color(255,255,255,255))
	end
	
	timer.Simple(1, function()
		
		if box and IsValid(box) then
			box:Close()
			OpenATMMenu( 2, ent )
		end
		
	end)
	
	end
	
	if page == 2 then

	local button1 = vgui.Create("DButton", content)
	button1:SetSize( 200, 70)
	button1:SetPos( (SizeX-10)/2-100, 220 * 750/9/100 - 10 )
	button1:SetFont("ATM_FONT2")
	button1:SetText( "DÉPOT" )
	button1:SetTextColor(Color(66,66,66))
	button1.Paint = function(s , w , h)
		if button1:IsHovered() then
					draw.RoundedBox(15,0,0,w,h,Color(0, 0, 0))
				else
					draw.RoundedBox(15,0,0,w,h,Color(255,255,255))				
			    end
	end
	button1.DoClick = function()
		box:Close()
		OpenATMMenu( 3, ent )
	end

	local button2 = vgui.Create("DButton", content)
	button2:SetSize( 200, 70)
	button2:SetPos( (SizeX-10)/2-100, 210 * 750/9/100 + 80 - 10)
	button2:SetFont("ATM_FONT2")
	button2:SetText( "RETRAIT" )
	button2:SetTextColor(Color(66,66,66))
	button2.Paint = function(s , w , h)
		if button2:IsHovered() then
					draw.RoundedBox(15,0,0,w,h,Color(0, 0, 0))
				else
					draw.RoundedBox(15,0,0,w,h,Color(255,255,255,255))				
			    end
	end
	button2.DoClick = function()
		box:Close()
		OpenATMMenu( 4, ent )
	end
	
	local button3 = vgui.Create("DButton", content)
	button3:SetSize( 200, 70)
	button3:SetPos( (SizeX-10)/2-100, 201 * 750/9/100 + 80 + 80 - 10 )
	button3:SetFont("ATM_FONT2")
	button3:SetText( "TRANSFERT" )
	button3:SetTextColor(Color(66,66,66))
	button3.Paint = function(s , w , h)
		if button3:IsHovered() then
					draw.RoundedBox(15,0,0,w,h,Color(0, 0, 0))
				else
					draw.RoundedBox(15,0,0,w,h,Color(255,255,255,255))				
			    end
	end
	button3.DoClick = function()
		box:Close()
		OpenATMMenu( 5, ent )
	end
	
	end
	
	if page == 3 then
		
		if buttonDisc and IsValid( buttonDisc ) then
			buttonDisc:SetText("Retour")
			buttonDisc.DoClick = function() 
				box:Close()
				OpenATMMenu( 2, ent )
			end
		end
		
		local TextEntry = vgui.Create( "DTextEntry", content )
		TextEntry:SetSize( 300, 40 )
		TextEntry:SetPos( (SizeX-10)/2-150, 300 * 750/9/100 - 10 )
		TextEntry:SetFont("ATM_FONT3")
		TextEntry:SetText( "0" )
		TextEntry:SetNumeric( true )
	
		local button1 = vgui.Create("DButton", content)
		button1:SetSize( 200, 70)
		button1:SetPos( (SizeX-10)/2-100, 300 * 750/9/100 + 80 - 10)
		button1:SetFont("ATM_FONT2")
		button1:SetTextColor(Color(66,66,66))
		button1:SetText( "DÉPOSER" )
		button1.Paint = function(s , w , h)
			if button1:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0))
				else
					draw.RoundedBox(0,0,0,w,h,Color(255,255,255,255))				
			    end
		end
		button1.DoClick = function()
			local val = tonumber(TextEntry:GetValue())
			
			if not isnumber( val ) then return end
			
			if val <= LocalPlayer():getDarkRPVar("money") then
				net.Start("AccountMoneyChange")
					net.WriteInt(1, 24)
					net.WriteInt( val, 24 )
					net.WriteEntity( ent )
				net.SendToServer()
				LabelError:SetSize( 400, 70)
		        LabelError:SetPos( (SizeX-10)/2-130, 250 * 400/9/100 + 80 - 10)
				LabelError:SetTextColor(Color(0,255,0))
				LabelError:SetText("SUCCES: Dépot d'argent effectué.")
			else
			    LabelError:SetSize( 1000, 70)
		        LabelError:SetPos( (SizeX-5)/2-200, 250 * 400/9/100 + 80 - 10)
				LabelError:SetTextColor(Color(255,0,0))
				LabelError:SetText("ERREUR: Vous n'avez pas autant d'argent sur vous!")
			end
		end
	
	end
	
	if page == 4 then
		if buttonDisc and IsValid( buttonDisc ) then
			buttonDisc:SetText("Retour")
			buttonDisc.DoClick = function() 
				box:Close()
				OpenATMMenu( 2, ent )
			end
		end
		local TextEntry = vgui.Create( "DTextEntry", content )
		TextEntry:SetSize( 300, 40 )
		TextEntry:SetPos( (SizeX-10)/2-150, 300 * 750/9/100 - 10 )
		TextEntry:SetFont("ATM_FONT2")
		TextEntry:SetText( "0" )
		TextEntry:SetNumeric( true )
	
		local button1 = vgui.Create("DButton", content)
		button1:SetSize( 200, 70)
		button1:SetPos( (SizeX-10)/2-100, 300 * 750/9/100 + 80 - 10)
		button1:SetFont("ATM_FONT2")
		button1:SetText( "RETIRER" )
		button1:SetTextColor(Color(66,66,66))
		button1.Paint = function(s , w , h)
			if button1:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0))
				else
					draw.RoundedBox(0,0,0,w,h,Color(255,255,255,255))				
			    end
		end
		button1.DoClick = function()
			local val = tonumber(TextEntry:GetValue())
			if not isnumber( val ) then return end
			if val <= LocalPlayer():GetNWInt("AccountMoney") then
				net.Start("AccountMoneyChange")
					net.WriteInt(2, 32)
					net.WriteInt( val, 32 )
					net.WriteEntity( ent )
				net.SendToServer()
				LabelError:SetSize( 1000, 70)
		        LabelError:SetPos( (SizeX-5)/2-140, 270 * 400/9/100 + 80 - 10)
				LabelError:SetTextColor(Color(0,255,0))
				LabelError:SetText("SUCCES: Retrait d'argent effectué.")
			else
				LabelError:SetSize( 1000, 70)
		        LabelError:SetPos( (SizeX-5)/2-200, 250 * 400/9/100 + 80 - 10)
				LabelError:SetTextColor(Color(255,0,0))
				LabelError:SetText("ERREUR: Vous n'avez pas assez d'argent en banque!")
			end
		end
	
	end
	
	if page == 5 then
		if buttonDisc and IsValid( buttonDisc ) then
			buttonDisc:SetText("Retour")
			buttonDisc.DoClick = function() 
				box:Close()
				OpenATMMenu( 2, ent )
			end
		end
		local TextEntry = vgui.Create( "DTextEntry", content )
		TextEntry:SetSize( 300, 40 )
		TextEntry:SetPos( (SizeX-10)/2-150, 300 * 750/9/100 - 10 )
		TextEntry:SetFont("ATM_FONT2")
		TextEntry:SetText( "0" )
		TextEntry:SetNumeric( true )
		
		local DComboBox = vgui.Create( "DComboBox", content )
		DComboBox:SetPos( (SizeX-10)/2-100, 240 * 750/9/100 + 80 + 80 - 10 )
		DComboBox:SetSize( 200, 50 )
		DComboBox:SetFont("ATM_FONT3")
		DComboBox:SetValue( "CHOIX DU JOUEUR..." )
		for k, v in pairs(player.GetAll()) do
			if v != LocalPlayer() then
				DComboBox:AddChoice( v:Name() )
			end
		end
		
		DComboBox.Paint = function(s , w , h)
			draw.RoundedBox(0,0,0,w , h, Color(156,156,156,255))
		end
		
		local button2 = vgui.Create("DButton", content)
		button2:SetSize( 200, 50)
		button2:SetPos( (SizeX-10)/2-100, 270 * 750/9/100 + 80 - 10)
		button2:SetFont("ATM_FONT3")
		button2:SetText( "ENVOYER" )
		button2:SetTextColor(Color(66,66,66))
		button2.Paint = function(s , w , h)
			if button2:IsHovered() then
					draw.RoundedBox(0,0,0,w,h,Color(0,0,0))
				else
					draw.RoundedBox(0,0,0,w,h,Color(255,255,255,255))				
			    end
		end
		
		button2.DoClick = function()
			local val = tonumber(TextEntry:GetValue())
			if not isnumber( val ) then return end
			if val <= LocalPlayer():GetNWInt("AccountMoney") then
				local ply
				for k , v in pairs(player.GetAll()) do
				
					if v:Name() == DComboBox:GetValue() then
						ply = v
						break
					end
				
				end
				
				if ply and IsValid( ply ) then
				
					net.Start("AccountMoneyChange")
						net.WriteInt(3, 32)
						net.WriteInt( val, 32 )
						net.WriteEntity( ent )
						net.WriteEntity( ply )
					net.SendToServer()
					LabelError:SetSize( 1000, 70)
		            LabelError:SetPos( (SizeX-5)/2-200, 250 * 400/9/100 + 80 - 10)
					LabelError:SetTextColor(Color(0,255,0))
					LabelError:SetText("SUCCES: Transfert d'argent effectué.")
				else
					LabelError:SetSize( 1000, 70)
		            LabelError:SetPos( (SizeX-5)/2-200, 250 * 400/9/100 + 80 - 10)
					LabelError:SetTextColor(Color(255,0,0))
					LabelError:SetText("ERREUR: Aucun joueur ne correspond à celui sélectionné!")
				end
			else
				LabelError:SetSize( 1000, 70)
		        LabelError:SetPos( (SizeX-5)/2-200, 250 * 400/9/100 + 80 - 10)
				LabelError:SetTextColor(Color(255,0,0))
				LabelError:SetText("ERREUR: Vous n'avez pas assez d'argent en banque!")
			end
		end
		
	end
	
	if page == 6 then
	
	if buttonDisc and IsValid( buttonDisc ) then
		buttonDisc:Remove()
	end
	
	local button1 = vgui.Create("DButton", content)
	button1:SetSize( 400, 70)
	button1:SetPos( (SizeX-10)/2-200, 300 * 750/9/100 - 10 )
	button1:SetFont("ATM_FONT2")
	button1:SetText( "FERMETURE DU COMPTE..." )
	button1:SetTextColor(Color(66,66,66))
	button1.Paint = function(s , w , h)
		draw.RoundedBox(0,0,0,w , h, Color(255,255,255,255))
	end
	
	timer.Simple(1, function()
		
		if box and IsValid(box) then
			box:Close()
		end
		
	end)

	end
end


net.Receive("OpenATMMenu", function()
	
	OpenATMMenu( 1, net.ReadEntity() )
	
end)
