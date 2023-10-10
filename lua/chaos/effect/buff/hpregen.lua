AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.tickfunc=function()
    if(CLIENT)then return end
    for i,v in ipairs(player.GetAll())do
        if(v:Alive() and v:Health()<v:GetMaxHealth())then
            v:SetHealth(math.min(v:GetMaxHealth(),v:Health()+5))
        end
    end
end
effect.internalmul=1.5
effect.name="Health regen"
effect.showeffecttime=true
CHAOS.AddEffect(effect)