AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
effect.startfunc=function()
    if(CLIENT)then return end
    for i,v in pairs(player.GetAll())do
        for i=1,20 do
            v:EmitSound("player/pl_pain7.wav",100,80,1,CHAN_STATIC)
        end
        v:ChatPrint("HAh! jump scare!")
    end
end
effect.endfunc=function()
    if(CLIENT)then return end
    for i,v in pairs(player.GetAll())do
        for i=1,40 do
            v:EmitSound("player/pl_pain5.wav",100,80,1,CHAN_STATIC)
        end
        v:ChatPrint("HAh! jump scare!,AGAIN!")
    end
end
effect.internalmul=0.2
effect.name="Jumpscare!"
CHAOS.AddEffect(effect)