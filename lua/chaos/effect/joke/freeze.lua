AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local nextthink=3
local hookname="Chaos_freezeondamaged"
effect.startfunc=function(e)
    if(CLIENT)then return end
    hook.Add("EntityTakeDamage",hookname,function(NPC,dmg)
        if(NPC:IsNPC())then
            local effectData = EffectData()
            effectData:SetOrigin( NPC:GetPos() )
            util.Effect( "GunshipImpact", effectData )
            e.SetColor(Color(0,127,255))
            e.NextThink(NPC,CurTime()+1e9)
        end
    end)
end
effect.endfunc=function(e)
    if(CLIENT)then return end
    hook.Remove("EntityTakeDamage",hookname)
end
effect.internalmul=1.25
effect.name="Npc Freezes on damaged"
effect.showeffecttime=true
CHAOS.AddEffect(effect)