achivki = {}
local plym = FindMetaTable("Player")



function AddAchiv(data)
    achivki[table.Count(achivki) + 1] = data
end

AddAchiv({
    name = "I am the cure",
    description = "Find a secret item on map and kill someone by him",
    icon = "serverlogo.png",
    nets = "CureAchiv",
    unlocked = false,
})

AddAchiv({
    name = "Headshot",
    description = "Kill someone in the head",
    icon = "serverlogo.png",
    nets = "headAchiv",
    unlocked = false,
})

function plym:UnlockAchiv(id)
    local scrw,scrh = ScrW(),ScrH()
    if not achivki[id] then print("ERROR TO GIVE ACHIV") return end 
    --if not self.achivki then self.achivki = util.TableToJSON(achivki) end 
    local jsontable = LocalPlayer().achivki
    local iconmat = Material(jsontable[id].icon)
    if jsontable[id].unlocked == true then return end 
    jsontable[id].unlocked = true
    self:SetPData("Achiv",util.TableToJSON(jsontable))
    LocalPlayer().achivki = util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(achivki)))
    net.Start("Unlock")
    net.WriteString(self:GetPData("Achiv",util.TableToJSON(achivki)))
    net.SendToServer()
    local notice = vgui.Create("DPanel")
    notice:SetPos(scrw * 1,scrh * 0.25)
    notice:SetSize(scrw * 0.1,scrh * 0.1)
    notice:SetToolTip(jsontable[id].description)
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
    local jsontable = util.JSONToTable(self.achivki)
    if jsontable[id].unlocked == false then return end 
    jsontable[id].unlocked = false 
    self:SetPData("Achiv",util.TableToJSON(jsontable))
    LocalPlayer().achivki = util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(achivki)))
    net.Start("Lock")
    net.WriteString(self:GetPData("Achiv",util.TableToJSON(achivki)))
    net.SendToServer()
end 

function plym:ResetAchiv()
    LocalPlayer():SetPData("Achiv",util.TableToJSON(achivki))
    LocalPlayer().achivki = util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(achivki)))
    net.Start("Reset")
    net.WriteString(self:GetPData("Achiv",util.TableToJSON(achivki)))
    net.SendToServer()
end 