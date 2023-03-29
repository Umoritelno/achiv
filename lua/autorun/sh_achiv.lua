achivki = {}
local plym = FindMetaTable("Player")


function AddAchiv(data)
    achivki[table.Count(achivki) + 1] = data
end

AddAchiv({
    name = "Welcome to server Анальные булки",
    description = "Join to our community",
    icon = "serverlogo.png",
    nets = "CureAchiv",
    secret = false,
})

AddAchiv({
    name = "Apple",
    description = "Blow someones apple",
    icon = "headshot.png",
    nets = "headAchiv",
    secret = false,
})

AddAchiv({
    name = "Secret Phrase",
    description = "shower",
    icon = "shower.png",
    nets = "showerAchiv",
    secret = true,
})

AddAchiv({
    name = "Sooner or later",
    description = "This cannot be avoided",
    icon = "Die.jpg",
    nets = "DieAchiv",
    secret = false,
})

newachivki = {}
for i = 1, table.Count(achivki) do
    newachivki[i] = false
end

function plym:UnlockAchiv(id)
    local scrw,scrh = ScrW(),ScrH()
    if not achivki[id] then print("ERROR TO GIVE ACHIV") return end 
    --if not self.achivki then self.achivki = util.TableToJSON(achivki) end 
    local jsontable = LocalPlayer().achivki
    local iconmat = Material(achivki[id].icon)
    if jsontable[id] == true then return end 
    jsontable[id] = true
    self:SetPData("Achiv",util.TableToJSON(jsontable))
    LocalPlayer().achivki = util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(newachivki)))
    net.Start("Unlock")
    net.WriteString(self:GetPData("Achiv",util.TableToJSON(newachivki)))
    net.SendToServer()
    local notice = vgui.Create("DPanel")
    notice:SetPos(scrw * 1,scrh * 0.25)
    notice:SetSize(scrw * 0.1,scrh * 0.1)
    notice:SetToolTip(achivki[id].description)
    --[[notice.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h * 0.9,Color(255,255,255))
        surface.SetDrawColor( 255, 255, 255 )
        surface.SetMaterial(iconmat)
        surface.DrawTexturedRect(0,0,w,h)
end
--]]
    --notice:Dock(RIGHT)
    --notice:DockMargin(ScrW() * 0.1,ScrH() * 0.75,0,scrh * 0.1)
    image = vgui.Create("DPanel",notice)
    image:Dock(FILL)
    image:DockMargin(0,0,scrw * 0.03,0)
    image.Paint = function(s,w,h)
        --draw.RoundedBox(0,0,0,w ,h,Color(255,255,255))
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial(iconmat)
            surface.DrawTexturedRect(0,0,w,h)
    end
    notice:MoveTo(scrw * 0.93,scrh * 0.25,0.5,0,-1,function()
        timer.Simple(7.5,function()
            notice:MoveTo(scrw * 1,scrh * 0.25,0.5,0,-1,function()
                notice:Remove()
            end)
        end)
    end)
    --[[notice.think = function()
        print(notice.timer)
        if notice.timer <= CurTime() then
            notice:Remove()
        end
    --]]
    --end
end 

function plym:LockAchiv(id) 
    local jsontable = self.achivki
    if jsontable[id] == false then return end 
    jsontable[id] = false 
    self:SetPData("Achiv",util.TableToJSON(jsontable))
    LocalPlayer().achivki = util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(newachivki)))
    net.Start("Lock")
    net.WriteString(self:GetPData("Achiv",util.TableToJSON(newachivki)))
    net.SendToServer()
end 

function plym:ResetAchiv()
    LocalPlayer():SetPData("Achiv",util.TableToJSON(newachivki))
    LocalPlayer().achivki = util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(newachivki)))
    net.Start("Reset")
    net.WriteString(self:GetPData("Achiv",util.TableToJSON(newachivki)))
    net.SendToServer()
end 