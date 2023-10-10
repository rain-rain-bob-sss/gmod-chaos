AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.startfunc=function()
    if(CLIENT)then return end
    for i,v in pairs(player.GetAll())do
        v.CHAOS_WASSOLID=v:IsSolid()
        v:SetNotSolid(true)
    end
end
effect.endfunc=function()
    if(CLIENT)then return end
    for i,v in pairs(player.GetAll())do
        if(v.CHAOS_WASSOLID)then
            v:SetNotSolid(false)
        end
    end
end
effect.internalmul=0.5
effect.name="Player is not solid"
effect.showeffecttime=true
CHAOS.AddEffect(effect)