AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
if(CLIENT)then
    local mat=CreateMaterial("chaos_trigger", "UnlitGeneric", {
        ["$basetexture"] = 'tools/toolstrigger',
        ["$vertexalpha"] = 1,
        ["$vertexcolor"] = 1,
    })
end
effect.startfunc=function()
    --if(CLIENT)then return end
    for i,v in pairs(ents.FindByClass("trigger_*"))do
        v.CHAOS_WASSOLID=v:IsSolid()
        v:SetNotSolid(false)
        if(CLIENT)then
            v:RemoveEffects(EF_NODRAW)
            v:SetRenderMode(RENDERMODE_TRANSCOLOR)
            v:SetMaterial("chaos_trigger")
            v:SetSubMaterial(nil,"chaos_trigger")
        end
    end
end
effect.tickfunc=function()
    for i,v in pairs(ents.FindByClass("trigger_*"))do
        if(CLIENT)then
            v:RemoveEffects(EF_NODRAW)
            v:SetRenderMode(RENDERMODE_TRANSCOLOR)
            v:SetMaterial("chaos_trigger")
            v:SetSubMaterial(nil,"chaos_trigger")
        end
    end
end
effect.endfunc=function()
    --if(CLIENT)then return end
    for i,v in pairs(ents.FindByClass("trigger_*"))do
        if(not v.CHAOS_WASSOLID)then
            v:SetNotSolid(true)
            if(CLIENT)then
                v:AddEffects(EF_NODRAW)
            end
        end
    end
end
effect.CANSELECT=function()
    return #ents.FindByClass("trigger_*")>0
end
effect.internalmul=1.25
effect.name="Trigger is solid"
effect.showeffecttime=true
CHAOS.ADDEFFECT(effect)