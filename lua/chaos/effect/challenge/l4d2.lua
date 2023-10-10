local enabled=false--NOT FINISHED,DONT USE
if(enabled)then
    AddCSLuaFile()
    local effect=table.Copy(CHAOS.BASEEFFECT)
    local classes={"npc_zombie","npc_fastzombie"}
    effect.startfunc=function(e)
        if(CLIENT)then return end
        for i,v in ipairs(player.GetAll())do
            
        end
    end
    effect.internalmul=0.5
    effect.name="Spawn zombie on head"
    effect.showeffecttime=false
    CHAOS.AddEffect(effect)
end