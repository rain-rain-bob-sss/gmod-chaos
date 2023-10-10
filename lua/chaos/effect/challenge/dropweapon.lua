AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.startfunc=function()
    if(CLIENT)then return end
    for i,v in pairs(player.GetAll())do
        v:ViewPunch(Angle(-90,10,20))
        for i=1,5 do
            v:DropWeapon()
        end
        v:ChatPrint("Opps!")
    end
end
effect.internalmul=0.2
effect.name="Drop 5 weapons"
effect.showeffecttime=false
CHAOS.AddEffect(effect)