AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local hookname="CHAOS_dclm"
effect.startfunc=function()
    if(SERVER)then return end
    local a=Material("model_color")
hook.Add("PostDraw2DSkyBox",hookname,function()cam.Start3D(Vector(0,0,0),Angle())render.SetMaterial(a)
    render.DrawQuadEasy(Vector(1,0,0)*20,Vector(-1,0,0),640,640,HSVToColor(CurTime()*50%360,1,1),0)
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