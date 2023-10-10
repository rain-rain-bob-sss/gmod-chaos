AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.tickfunc=function()
    if(CLIENT)then return end
    for i,v in ipairs(player.GetAll())do
        --if(v:Alive())then
            local wep=v:GetActiveWeapon()
            if(IsValid(wep))then
                wep:SetNextPrimaryFire((wep:GetNextPrimaryFire()-CurTime())*0.8+CurTime())
                wep:SetNextSecondaryFire((wep:GetNextSecondaryFire()-CurTime())*0.8+CurTime())
            end
        --end
    end
end
effect.internalmul=1.5
effect.name="RAPID FIRE(PLAYER ONLY)"
effect.showeffecttime=true
CHAOS.AddEffect(effect)