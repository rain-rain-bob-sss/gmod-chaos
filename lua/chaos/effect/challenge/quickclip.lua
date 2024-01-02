local enabled=true
if(enabled)then
    AddCSLuaFile()
    local effect=table.Copy(CHAOS.BASEEFFECT)
    effect.tickfunc=function(e)
        if(CLIENT)then return end
        for i,v in ipairs(player.GetAll())do
            if(v and v:IsValid())then
                v:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
            end
        end
    end
    effect.endfunc=function()
        if(CLIENT)then return end
        for i,v in ipairs(player.GetAll())do
            if(v and v:IsValid())then
                v:SetCollisionGroup(COLLISION_GROUP_PLAYER)
            end
        end
    end
    effect.internalmul=CHAOS.DURATION
    effect.name="Quick clip"
    effect.showeffecttime=true
    CHAOS.AddEffect(effect)
end