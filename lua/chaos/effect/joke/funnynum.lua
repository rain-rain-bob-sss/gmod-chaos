AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.startfunc=function()
    if(CLIENT)then return end
    for i,v in pairs(player.GetAll())do
        v:SetHealth(4)
        v:SetArmor(20)
        v:ChatPrint("Funny number!")
    end
end
effect.internalmul=0.2
effect.name="Funny number"
effect.showeffecttime=false
CHAOS.AddEffect(effect)