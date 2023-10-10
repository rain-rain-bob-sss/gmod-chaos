AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local hookname="Chaos_You may not press reload."
local CMoveData = FindMetaTable("CUserCmd")

effect.startfunc=function()
    if(CLIENT)then return end
    hook.Add("StartCommand",hookname,function(ply,cmd)
        if cmd:KeyDown(IN_RELOAD) then
            cmd:RemoveKey(IN_RELOAD)
            ply:ChatPrint("You may not press reload.")
        end
    end)
end
effect.endfunc=function()
    if(CLIENT)then return end
    hook.Remove("SetupMove",hookname)
end
effect.internalmul=0.2
effect.name="NO PRESSING RELOAD."
effect.showeffecttime=true
CHAOS.AddEffect(effect)