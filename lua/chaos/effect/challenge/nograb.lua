AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local hookname="CHAOS_NoGrab"
effect.startfunc=function()
    hook.Add("PlayerCanPickupItem",hookname,function(ply,item)
        local normal=((ply:GetShootPos()+ply:GetAimVector()*-50)-item:GetPos()):GetNormalized()
        normal=normal*200
        if(not item.nextbf)then
            item.nextbf=0
        end
        if(IsValid(item:GetPhysicsObject()) and item.nextbf<CurTime())then
            item.nextbf=CurTime()+1
            item:GetPhysicsObject():SetVelocity(normal)
        end
        return false
    end)
    hook.Add("PlayerCanPickupWeapon",hookname,function(ply,item)
        local normal=((ply:GetShootPos()+ply:GetAimVector()*-50)-item:GetPos()):GetNormalized()
        normal=normal*200
        if(not item.nextbf)then
            item.nextbf=0
        end
        if(IsValid(item:GetPhysicsObject()) and item.nextbf<CurTime())then
            item.nextbf=CurTime()+1
            item:GetPhysicsObject():SetVelocity(normal)
        end
        return false
    end)
end
effect.endfunc=function()
    hook.Remove("PlayerCanPickupItem",hookname)
    hook.Remove("PlayerCanPickupWeapon",hookname)
end
effect.tickfunc=function()
    if(CLIENT)then return end
    for i,v in ipairs(player.GetAll())do
        v:DropObject()
    end
end
effect.internalmul=0.5
effect.name="Butterfinger."
effect.showeffecttime=true
CHAOS.AddEffect(effect)