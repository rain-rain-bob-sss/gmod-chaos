AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local hookname="Chaos_You may not jump."
local CMoveData = FindMetaTable("CMoveData")

function CMoveData:RemoveKeys(keys)
	-- Using bitwise operations to clear the key bits.
	local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
	self:SetButtons(newbuttons)
end
--uhh
effect.startfunc=function()
    if(CLIENT)then return end
    hook.Add("SetupMove",hookname,function(ply,mvd,cmd)
        if mvd:KeyDown(IN_JUMP) then
            mvd:RemoveKeys(IN_JUMP)
            --ply:ChatPrint("You may not jump.")
        end
    end)
end
effect.endfunc=function()
    if(CLIENT)then return end
    hook.Remove("SetupMove",hookname)
end
effect.internalmul=0.5
effect.name="NO Jump."
effect.showeffecttime=true
CHAOS.AddEffect(effect)