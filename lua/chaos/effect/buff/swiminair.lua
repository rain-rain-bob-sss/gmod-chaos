AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
vector_origin=Vector(0,0,0)
function CHAOS.AirMove(pl, mv) --Copyed from zs's wisp movement code,credit to jetboom
    if(pl:GetMoveType()==MOVETYPE_NOCLIP)then return end
    local mul=0.97
    local Speed=pl:GetWalkSpeed()*mul
    if(pl:KeyDown(IN_SPEED))then
        Speed=pl:GetRunSpeed()*mul
    end
    --print(Speed)
	pl:SetGroundEntity(NULL)
	mv:SetMaxSpeed(0)
	mv:SetMaxClientSpeed(0)

	local dir = Vector(mv:GetForwardSpeed(), mv:GetSideSpeed(), 0)
	dir:Normalize()
	dir:Normalize()
    dir=dir*8
	local vel = mv:GetVelocity()

	if dir == vector_origin then
		vel = vel * math.max(1 - FrameTime() * 0.75, 0)
	else
		local eyeang = mv:GetAngles()
		vel = vel + 260 * FrameTime() * (eyeang:Forward() * dir.x + eyeang:Right() * dir.y + eyeang:Up() * dir.z)
	end

	if vel:Length() >= Speed then
		vel:Normalize()
		vel = vel * Speed
	end
    vel=vel*mul*mul
	vel.z = vel.z + FrameTime() * (-physenv.GetGravity().z*0.95)
    if(pl:KeyDown(IN_JUMP))then
        vel.z=vel.z+120
    end
	mv:SetVelocity(vel)

	--return true
end
local hookname="CHAOS_SWIMINAIR"
effect.startfunc=function()
    hook.Add("Move",hookname,CHAOS.AirMove)
end
effect.endfunc=function()
    hook.Remove("Move",hookname)
end
effect.internalmul=0.9
effect.name="Swiming in air"
effect.showeffecttime=true
CHAOS.AddEffect(effect)

