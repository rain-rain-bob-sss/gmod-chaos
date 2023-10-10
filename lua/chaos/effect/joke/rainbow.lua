AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local hookname="CHAOS_2dskyboxrb"
effect.startfunc=function()
    if(SERVER)then return end
    hook.Add("PostDraw2DSkyBox","2dskyboxrainbow",function()
        local col=HSVToColor(CurTime()*5%360,1,0.8)
        surface.SetDrawColor(col.r,col.g,col.b)
        draw.NoTexture()
        surface.DrawRect(0,0,ScrW(),ScrH())
    end)
end
effect.endfunc=function()
    if(SERVER)then return end
    hook.Remove("PostDraw2DSkyBox","2dskyboxrainbow")
end
effect.internalmul=0.8
effect.name="Rainbow 2d skybox"
effect.showeffecttime=false
CHAOS.AddEffect(effect)