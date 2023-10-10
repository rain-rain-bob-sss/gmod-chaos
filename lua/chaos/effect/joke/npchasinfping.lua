AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local nextthink=3
effect.tickfunc=function(e)
    if(CLIENT)then return end
    for i,v in pairs(ents.FindByClass("npc_*"))do
        pcall(function()
            if(v.lastnexthinkseted and v.lastnexthinkseted+5>CurTime())then return end
            v.lastnexthinkseted=CurTime()
            e.NextThink(v,CurTime()+nextthink)
        end)
    end
end

effect.internalmul=1.25
effect.name="Npcs has 9999999999 ping"
effect.showeffecttime=true
CHAOS.AddEffect(effect)