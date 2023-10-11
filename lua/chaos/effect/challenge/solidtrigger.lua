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
hook.Add("Initialize","CHAOS_LOADSOLIDTRIGGEREFFECT",function()
    if(#ents.FindByClass("trigger_*")>0)then
        CHAOS.AddEffect(effect)
    end
end)