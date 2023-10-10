local enabled=true
if(enabled)then
    AddCSLuaFile()
    local effect=table.Copy(CHAOS.BASEEFFECT)
    local allowed={prop_dynamic=true,prop_physics=true,prop_door_rotating=true,item_healthcharger=true,item_suitcharger=true,simple_physics_prop=true,func_physbox_multiplayer=true,func_physbox=true,["*door*"]=true}
    effect.startfunc=function(e)
        if(CLIENT)then return end
        for i,v in ipairs(ents.GetAll())do
            if(v and v:IsValid())then
                if(allowed[v:GetClass()])then
                    local bool=v:PhysicsInit(SOLID_VPHYSICS)
                    if(IsValid(v:GetPhysicsObject()))then
                        v:GetPhysicsObject():EnableMotion(true)
                    end
                end
            end
        end
    end
    effect.internalmul=0.5
    effect.name="Wait what,IM RAN OUT OF GLUE OH NO"
    effect.showeffecttime=false
    CHAOS.AddEffect(effect)
end