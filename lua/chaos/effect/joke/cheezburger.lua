AddCSLuaFile()
local effect=table.Copy(CHAOS.BASEEFFECT)
local hookname="Chaos_CHEEZBURGER"
effect.startfunc=function()
    if(CLIENT)then return end
    CHAOS.ADDHOOK("EntityFireBullets",hookname)
    hook.Add("EntityFireBullets",hookname,function(target,data)
        local cbg=ents.Create("prop_physics")
        if(cbg and cbg:IsValid())then
            cbg:SetPos(data.Src)
            cbg:SetAngles(data.Dir:Angle())
            cbg:SetModel("models/food/burger.mdl")
            hook.Add("ShouldCollide",cbg,function(ent1,ent2)
                if (ent1==e and ent2==cbg) or (ent1==cbg and ent2==cbg)then
                    return false
                end
            end)
            cbg:Spawn()
            cbg:AddCallback('PhysicsCollide',function()
                timer.Simple(3,function()
                    if(cbg and cbg:IsValid())then
                        cbg:Remove()
                    end
                end)
            end)
            cbg:GetPhysicsObject():SetVelocity(data.Dir*15000)
            cbg:GetPhysicsObject():SetMass(100)
            cbg:SetPhysicsAttacker(target,500)
        end
    end)
end
effect.endfunc=function()
    if(CLIENT)then return end
    hook.Remove("EntityFireBullets",hookname)
end
effect.internalmul=1.5
effect.name="Can i haz some cheez burgers? Yes ofc!"
effect.showeffecttime=true
CHAOS.AddEffect(effect)