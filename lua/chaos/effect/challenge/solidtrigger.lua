AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.startfunc=function()
    --if(CLIENT)then return end
    for i,v in pairs(ents.FindByClass("trigger_*"))do
        v.CHAOS_WASSOLID=v:IsSolid()
        v:SetNotSolid(false)
    end
end
effect.endfunc=function()
    --if(CLIENT)then return end
    for i,v in pairs(ents.FindByClass("trigger_*"))do
        if(not v.CHAOS_WASSOLID)then
            v:SetNotSolid(true)
        end
    end
end
effect.internalmul=1.25
effect.name="Trigger is solid"
effect.showeffecttime=true
local added=false
hook.Add("OnEntityCreated","CHAOS_LOADSOLIDTRIGGEREFFECT",function(ent)
    if(ent:IsValid() and string.StartsWith(string.lower(ent:GetClass()),"trigger_"))then
        if(not added)then
            CHAOS.AddEffect(effect)
            added=true 
        end
    end
end)