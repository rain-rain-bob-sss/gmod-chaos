AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local dmgscale=50000
local hookname="Chaos_ONESHOT"
effect.startfunc=function()
    if(CLIENT)then return end
    CHAOS.ADDHOOK("EntityTakeDamage",hookname)
    hook.Add("EntityTakeDamage",hookname,function(target,dmg)
        dmg:ScaleDamage(dmgscale)
    end)
end
effect.endfunc=function()
    if(CLIENT)then return end
    hook.Remove("EntityTakeDamage",hookname)
end
effect.internalmul=2
effect.name="ONESHOT,OH NO!!!"
effect.showeffecttime=true
CHAOS.AddEffect(effect)