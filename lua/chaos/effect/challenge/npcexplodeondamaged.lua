AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local nextthink=3
local hookname="Chaos_explodeondamaged"
effect.startfunc=function(e)
    if(CLIENT)then return end
    hook.Add("EntityTakeDamage",hookname,function(NPC,dmg)
        if(NPC:IsNPC())then
            local effectData = EffectData()
            effectData:SetOrigin( NPC:GetPos() )
            util.Effect( "cball_explode", effectData )
            local pos=NPC:GetPos()
            local dmg=NPC:Health()
            e.SetColor(Color(0,127,255))
            e.NextThink(NPC,CurTime()+1e9)
            timer.Simple(0.3,function()
                util.BlastDamage(dmg:GetInflictor(),dmg:GetAttacker(),pos,500,dmg)
            end)
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