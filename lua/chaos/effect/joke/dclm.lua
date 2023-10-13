AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local hookname="CHAOS_dclm"
local color_white=color_white or Color(255,255,255,255)
effect.startfunc=function()
    if(SERVER)then return end
    local a=Material("model_color")
hook.Add("PostDraw2DSkyBox",hookname,function()cam.Start3D(Vector(0,0,0),Angle())
    render.SetColorMaterial()
    render.DrawQuadEasy(Vector(1,0,0)*20,Vector(-1,0,0),640,640,color_white,0)
    cam.End3D()end)
end
effect.endfunc=function()
    if(SERVER)then return end
    hook.Remove("PostDraw2DSkyBox",hookname)
end
effect.internalmul=0.8
effect.name="Discord light mode be like"
effect.showeffecttime=false
CHAOS.AddEffect(effect)