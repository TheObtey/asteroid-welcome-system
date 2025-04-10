AWS.Client.Frame = AWS.Client.Frame or nil
AWS.Client.Fonts = {}

local RX = RX or function(x) return x / 1920 * ScrW() end
local RY = RY or function(y) return y / 1080 * ScrH() end
local blur = Material("pp/blurscreen")

/*
    Create a font dynamically 
*/
function AWS.Client:Font(iSize, sType)
	iSize = iSize or 15
	sType = sType or "Medium" -- Availables: Thin, Light, Medium, SemiBold, Bold, ExtraBold, Italic

	local sName = ("AWS:Font:%i:%s"):format(iSize, sType)
	if not AWS.Client.Fonts[sName] then

		surface.CreateFont(sName, {
			font = ("MontserratWasied %s"):format(sType):Trim(),
			size = RX(iSize),
			weight = 500,
			extended = false
		})

		AWS.Client.Fonts[sName] = true

	end

	return sName
end

/*
    Draw a blur effect on a panel
*/
function AWS.Client:DrawBlur(p, a)

    local x, y = p:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    
    surface.SetDrawColor(color_white)
    surface.SetMaterial(blur)
    
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (a or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end

end

/*
    Show the welcome menu
*/
function AWS.Client:ShowMenu()

    if IsValid(AWS.Client.Frame) then return end

    AWS.Client.Frame = vgui.Create("DFrame")
    
    AWS.Client.Frame:SetSize(RX(1920), RY(1080))
    AWS.Client.Frame:SetPos(0, 0)
    
    AWS.Client.Frame:SetTitle("")
    AWS.Client.Frame:MakePopup(true)
    AWS.Client.Frame:SetDraggable(false)
    AWS.Client.Frame:ShowCloseButton(false)

    function AWS.Client.Frame:Paint(w, h)

        AWS.Client:DrawBlur(self, 4)

        surface.SetDrawColor(AWS.Client.Colors["color1"])
        surface.DrawRect(0, 0, w/2.3, h)

        surface.SetDrawColor(AWS.Client.Colors["color2"])
        surface.DrawRect(w/2.3, 0, RX(20), h)

        surface.SetDrawColor(AWS.Client.Colors["color2"])
        surface.DrawRect(RX(46), RY(46), RX(88), RX(88))
        surface.DrawRect(((w/2.3) / 2) - RX(220)/2, RY(300), RX(220), RX(220))

        draw.SimpleText("Welcome", AWS.Client:Font(26, "Thin"), (w/2.3)/2, RY(530), color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText(LocalPlayer():Nick(), AWS.Client:Font(40, "SemiBold"), (w/2.3)/2, RY(570), color_white, TEXT_ALIGN_CENTER)

    end

    AWS.Client.ImageFetcher:FetchImage(AWS.Client.ServerLogo, "serverLogo", function(path)
    
        if not IsValid(AWS.Client.Frame) then return end

        local ServerLogo = AWS.Client.Frame:Add("DImage")

        ServerLogo:SetSize(RX(80), RX(80))
        ServerLogo:SetPos(RX(50), RY(50))
        ServerLogo:SetImage("data/" .. path)

        local container = AWS.Client.Frame:Add("DPanel")
        container.Paint = nil

        container:SetSize((RX(120)+RX(5)) * #AWS.Client.Links, RX(40))
        container:SetPos(RX(50) + ServerLogo:GetWide() + RX(40), (RY(50) + ServerLogo:GetTall()/2) - RX(40)/2)

        for _, v in pairs(AWS.Client.Links) do
            
            local a = container:Add("DButton")
            
            a:Dock(LEFT)
            a:DockMargin(0, 0, RX(5), 0)
            a:SetWide(RX(120))
            a:SetTextColor(AWS.Client.Colors["text"])
            a:SetFont(AWS.Client:Font(18, "Thin"))
            a:SetText(v.name)

            function a:Paint(w, h)

                surface.SetDrawColor(self:IsHovered() and AWS.Client.Colors["bg2"] or AWS.Client.Colors["bg1"])
                surface.DrawRect(0, 0, w, h)

            end

            function a:DoClick()

                gui.OpenURL(v.link)

            end

        end
    
    end)

    local PlayerAvatar = AWS.Client.Frame:Add("AvatarImage")

    PlayerAvatar:SetSize(RX(210), RX(210))
    PlayerAvatar:SetPos((((AWS.Client.Frame:GetWide()/2.3) / 2) - PlayerAvatar:GetWide()/2), RY(300) + RY(5))
    PlayerAvatar:SetPlayer(LocalPlayer(), 128)

    local StartButton = AWS.Client.Frame:Add("DButton")

    StartButton:SetSize(RX(220), RX(50))
    StartButton:SetPos((((AWS.Client.Frame:GetWide()/2.3) / 2) - StartButton:GetWide()/2), RY(660))
    StartButton:SetTextColor(AWS.Client.Colors["text"])
    StartButton:SetFont(AWS.Client:Font(28, "Medium"))
    StartButton:SetText("Play")

    function StartButton:Paint(w, h)
       
        surface.SetDrawColor(self:IsHovered() and AWS.Client.Colors["bg2"] or AWS.Client.Colors["bg1"])
        surface.DrawRect(0, 0, w, h)

    end
    
    function StartButton:DoClick()

        AWS.Client.Frame:Close()
        LocalPlayer():ChatPrint("Be nice :D")

    end

end

/*
    The player has freshly spawned
*/
hook.Add("InitPostEntity", "AWS:InitPostEntity", AWS.Client.ShowMenu)