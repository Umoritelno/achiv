util.AddNetworkString("GiveAchiveTable")
util.AddNetworkString("InitAchiv")
util.AddNetworkString("ClientInitAchiv")
util.AddNetworkString("Unlock")
util.AddNetworkString("Reset")
util.AddNetworkString("Lock")

for k,v in pairs(achivki) do
    util.AddNetworkString(v.nets)
end

--[[local defaultstatus = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,

}
--]]

net.Receive("InitAchiv",function(len,ply)
    net.Start("ClientInitAchiv")
    ply.achivki = util.JSONToTable(ply:GetPData("Achiv",util.TableToJSON(newachivki)))
    --PrintTable(ply.achivki)
    --net.WriteTable(util.JSONToTable(ply:GetPData("Achiv",util.TableToJSON(achivki))))
    --net.WriteString("Byu")
    --net.WriteString(util.Compress(util.TableToJSON(ply:GetPData("Achiv",achivki))))
    net.Send(ply)
end)

net.Receive("Unlock",function(len,ply)
    local jsontbl = net.ReadString()
    ply:SetPData("Achiv",jsontbl)
end)

net.Receive("Lock",function(len,ply)
    local jsontbl = net.ReadString()
    ply:SetPData("Achiv",jsontbl)
end)

net.Receive("Reset",function(len,ply)
    local jsontbl = net.ReadString()
    ply:SetPData("Achiv",jsontbl)
end)

hook.Add("PlayerSpawn","Achiv",function(ply)
    --net.Start("ClientInitAchiv")
    --net.WriteTable(util.JSONToTable(ply:GetPData("Achiv",util.TableToJSON(achivki))))
    --net.WriteString(util.Compress(util.TableToJSON(ply:GetPData("Achiv",achivki))))
    --net.Send(ply)
    --ply:SetPData("Achiv",util.TableToJSON(achivki))
    --ply:GetPData("Achiv",util.TableToJSON(achivki))
    --ply.achivki = ply:GetPData("Achiv",util.TableToJSON(achivki))
    --PrintTable(util.JSONToTable(ply.achivki))
    --ply:SetPData("Achiv",util.TableToJSON(ply.achivki))
    --PrintTable(util.JSONToTable(ply:GetPData("Achiv")))
    --[[for k,v in pairs(ply.achivki) do
        v.Unlocked = false 
    end
    --]]
    --net.Start("GiveAchiveTable")
    --net.Send(ply)
end)

hook.Add("PlayerHurt","Yablocko",function(victim,attacker,remain,taken)
    if remain <= 0 and victim:LastHitGroup() == 1 then
        net.Start("headAchiv")
        net.Send(attacker)
    end
end)

hook.Add("PlayerSay","showerachiv",function(sender,text,tm)
    if string.lower(text) == "noclip into the breach shower" then 
        net.Start("showerAchiv")
        net.Send(sender)
    end
end)

hook.Add("PlayerDeath","DieAchiv",function(victim,inflictor,attacker)
    net.Start("DieAchiv")
    net.Send(victim)
end)