return
AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local shakescale=10
local hookname="Chaos_WHATHAVEYOUDONE??"
effect.startfunc=function()
    if(CLIENT)then return end
    hook.Add("EntityFireBullets",hookname,function(target,data)
        local oldcallback=data.Callback
        data.Callback=function(e,t,c)
            if(oldcallback)then
                oldcallback(e,t,c)
            end
            util.ScreenShake(e:GetPos(),data.Damage/5*shakescale,0.5,math.min(20,data.Force/100)*shakescale,500,true)
            util.ScreenShake(t.HitPos,data.Damage/5*shakescale,0.5,math.max(5,math.min(50,data.Force/10))*shakescale,500,true)
        end
        return true
    end)
end
effect.endfunc=function()
    if(CLIENT)then return end
    hook.Remove("EntityFireBullets",hookname)
end
effect.internalmul=2
effect.name="Shaking bullets"
effect.showeffecttime=true
CHAOS.AddEffect(effect)