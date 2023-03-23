--local scrw,scrh = ScrW(),ScrH()

net.Receive("GiveAchiveTable",function()
    --[[LocalPlayer().achivki = achivki
    for k,v in pairs(LocalPlayer().achivki) do
        v.Unlocked = false 
    end
    --]]

end)
hook.Add( "InitPostEntity", "Achiv", function()
    net.Start( "InitAchiv" )
    net.SendToServer()
end )

net.Receive("ClientInitAchiv",function()
    --LocalPlayer():SetPData("Achiv",util.TableToJSON(achivki))
    --PrintTable(util.JSONToTable(LocalPlayer():GetPData("Achiv",0)))
    local tbl = util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(achivki)))
    --local comprs = util.Decompress(net.ReadString())
    PrintTable(tbl)
    --LocalPlayer():SetPData("Achiv",util.TableToJSON(tbl))  --util.JSONToTable(LocalPlayer():GetPData("Achiv",util.TableToJSON(achivki)))
    LocalPlayer().achivki = tbl
    PrintTable(LocalPlayer().achivki)
end)

net.Receive("headAchiv",function()
    LocalPlayer():UnlockAchiv(2)
end)