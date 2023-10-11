AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.tickfunc=function()
    if(CLIENT)then return end
    for i,v in ipairs(player.GetAll())do
        v:SetGroundEntity(game.GetWorld())
    end
end
effect.internalmul=0.5
effect.name="Walking on air(But you cannot jump)"
effect.showeffecttime=true
CHAOS.AddEffect(effect)