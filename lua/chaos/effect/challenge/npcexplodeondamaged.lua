AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local nextthink=3
local hookname="Chaos_explodeondamaged"
effect.startfunc=function(e)
    if(CLIENT)then return end
    hook.Add("EntityTakeDamage",hookname,function(NPC,dmg)
        if(NPC:IsNPC())then
            local attacker=dmg:GetAttacker()
            if(attacker:IsNPC() and attacker:Health()<0 or attacker:Health()==0)then
                return
            end
            local effectData = EffectData()
            effectData:SetOrigin( NPC:GetPos() )
            util.Effect( "cball_explode", effectData )
            local pos=NPC:GetPos()
            local edmg=NPC:Health()
            e.SetColor(NPC,Color(0,127,255))
            e.NextThink(NPC,CurTime()+1e9)
            timer.Simple(0.3,function()
                util.BlastDamage(attacker,attacker,pos,100,edmg)
            end)
        end
    end)
end
effect.endfunc=function(e)
    if(CLIENT)then return end
    hook.Remove("EntityTakeDamage",hookname)
end
effect.internalmul=1.25
effect.name="Npc explode on damaged"
effect.showeffecttime=true
CHAOS.AddEffect(effect)