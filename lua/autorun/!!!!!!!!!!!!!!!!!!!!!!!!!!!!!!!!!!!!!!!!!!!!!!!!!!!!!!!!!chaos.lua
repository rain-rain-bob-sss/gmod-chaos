if(SERVER)then
    AddCSLuaFile()
end
--WELCOME TO CODE OF CHAOS,HOW TO ENABLE CHAOS:enter chaos 1 in console!
local oldemt=oldemt or table.Copy(FindMetaTable("Entity"))
local oldpmt=oldpmt or table.Copy(FindMetaTable("Player"))
local oldwmt=oldwmt or table.Copy(FindMetaTable("Weapon"))
CHAOS={}
print(CHAOS," CHAOS TABLE LOADED")
CHAOS.DEV=true
CHAOS.AddEffect=function(ED)
    table.insert(CHAOS.EFFECT,ED)
end
CHAOS.VERSION="beta_1.2"--in your custom effect you can check version
CHAOS.DURATION=80
CHAOS.INTERNAL=30
CHAOS.CURRENTTIMELEFT=CHAOS.INTERNAL
CHAOS.READY=30--Time to ready.
CHAOS.DELTATIME=0
CHAOS.BHOP=true
CHAOS.NOJUMP=false
for i,v in pairs(hook.GetTable())do
    if(string.StartsWith(string.lower(i),"chaos_"))then
        hook.Remove(i,v)
    end
end
hook.Add("StartCommand","CHAOS_BHOPING",function(ply,cmd) 
    if(CHAOS.NOJUMP)then return end
    if (bit.band(cmd:GetButtons(),IN_JUMP)~=0) then
	    if(not ply:IsOnGround() and ply:GetMoveType() ~= MOVETYPE_LADDER and ply:GetMoveType() ~= MOVETYPE_NOCLIP and ply:WaterLevel()<2) then
	        cmd:SetButtons(bit.band(cmd:GetButtons(),bit.bnot(IN_JUMP)))
	    end
	end
end)
--funcs's arg is entity metatable,player meta table,weapon meta table
--tick func's last arg is sec left.
--to get delta time,just use FrameTime().
--all the effect files are run in shared state
CHAOS.BASEEFFECT={ --use table.Copy(CHAOS.BASEEFFECT),if you use this as base class.
    startfunc=function(e,p,w) return end,
    tickfunc=function(e,p,w) return end,
    endfunc=function() return end,
    internalmul=1,
    showeffecttime=true,
    name="Nothing,kid.",
}
--Effect functions are pcalled.
CHAOS.EFFECT={

}
CHAOS.STOP=false
CHAOS.CURRENT=CHAOS.CURRENT or {}
CHAOS.ADDHOOK=function() end
for i,v in pairs(CHAOS.CURRENT)do
    v.endfunc(oldemt,oldpmt,oldemt,true)
    CHAOS.CURRENT[i]=nil
end
function CHAOS.HANDLECONVAR(name,old,new)
    if(name=="chaos_duration")then
        CHAOS.DURATION=tonumber(new) or 40
    elseif(name=="chaos_internal")then
        CHAOS.INTERNAL=tonumber(new) or 30
    elseif(name=="chaos")then
        local bool=tobool(tonumber(new))
        if(bool)then
            CHAOS.STOP=false
        else
            CHAOS.STOP=true
        end
    end
end
local durationconvar=CreateConVar("chaos_duration",80,FCVAR_GAMEDLL+524288+FCVAR_REPLICATED+FCVAR_NOTIFY,"Base Duration of effects",0)
local internalconvar=CreateConVar("chaos_internal",60,FCVAR_GAMEDLL+524288+FCVAR_REPLICATED+FCVAR_NOTIFY,"New Effect Internal",5)
local chaosconvar=CreateConVar("chaos",1,FCVAR_GAMEDLL+524288+FCVAR_REPLICATED+FCVAR_NOTIFY,"0 To disable,1 to enable",0,1)
cvars.AddChangeCallback("chaos_duration",CHAOS.HANDLECONVAR,"chaos_adcallback")
cvars.AddChangeCallback("chaos_internalconvar",CHAOS.HANDLECONVAR,"chaos_bdcallback")
cvars.AddChangeCallback("chaos",CHAOS.HANDLECONVAR,"chaos_cdcallback")
local nws4="chaos_yellowbarpercent"
if(CLIENT)then
    CHAOS.yellowbarpercent=0
    net.Receive(nws4,function(_,_)
        CHAOS.yellowbarpercent=net.ReadFloat()
    end)
    local fontname="chaos_font"
    local gwidth=ScrW()
    local gheight=ScrH()
    local NScrW=function()
        return gwidth
    end
    local NScrH=function()
        return gheight
    end
    --Some stupid dont update their gmod,fuck you.
    function ScreenScale( width )
      return width * ( NScrW() / 640.0 )
    end
    
    function ScreenScaleH( height )
      return height * ( NScrH() / 480.0 )
    end
    SScale = ScreenScale
    SScaleH = ScreenScaleH
    surface.CreateFont(fontname,{font="DermaLarge",extended=true,size=SScale(13),outline=true})
    local alladjust={x=0,y=0}
    hook.Add("InputMouseApply","chaos_message_move",function(c,x,y,a)
      alladjust.x=alladjust.x+x*-0.03
      alladjust.y=alladjust.y+y*-0.03
    end)
    hook.Add("Think","chaos_message_velocity_move",function()
      local p=LocalPlayer()
      local moveang=p:EyeAngles()
      moveang[1]=0
      local movevel=WorldToLocal(p:GetVelocity(),Angle(),Vector(),moveang)
      --print(movevel)
      alladjust.x=alladjust.x+movevel.y*0.015
      alladjust.y=alladjust.y+movevel.x*0.005
    end)
    hook.Add("HUDPaint","chaos_message_Drawing",function()
      local co=0
      alladjust.x=Lerp(0.05,alladjust.x,0)
      alladjust.y=Lerp(0.05,alladjust.y,0)
      for i,v in pairs(CHAOS.CURRENT)do
        --print(v)
        if(not v)then continue end
        --if(v.sec<0)then continue end
        if(v.sec==nil)then continue end
        surface.SetFont(fontname)
        local w,h=surface.GetTextSize(v.name)
        local sec=math.Round(v.sec)
        if(not v.showeffecttime)then
            sec=""
        end
        draw.DrawText(v.name.."   "..sec,fontname,ScrW()/2+SScale(100)+alladjust.x,ScrH()/2+-SScaleH(200)+alladjust.y+co,Color(255,255,0,200),TEXT_ALIGN_CENTER)
        co=co+h
      end
    end)
    hook.Add("HUDPaint","chaos_yellowbar",function()
        local w=NScrW()*CHAOS.yellowbarpercent
        --print(w)
        surface.SetDrawColor(255,255,0,200)
        surface.DrawRect(alladjust.x*0.2,alladjust.y*0.2,w,SScaleH(8))
    end)
  end
--from gmod wiki

local effectDirectory = "chaos/effect"
local function AddFile( File, directory )
	local prefix = string.lower( string.Left( File, 3 ) )
    --if(SERVER)then
        include( directory .. File )
    --end
    print("CHAOS [AUTOLOAD] FILE: "..directory..File)
end

local function IncludeDir( directory )
	directory = directory .. "/"

	local files, directories = file.Find( directory .. "*", "LUA" )

	for _, v in ipairs( files ) do
		if string.EndsWith( v, ".lua" ) then
			AddFile( v, directory )
		end
	end

	for _, v in ipairs( directories ) do
		print( "CHAOS [AUTOLOAD] Directory: " .. v )
		IncludeDir( directory .. v )
	end
end
local nws3="chaos_reloadeffects"
IncludeDir( effectDirectory )
concommand.Add("chaos_reloadeffects",function(p)
    if(p==NULL or p:IsAdmin())then
        CHAOS.EFFECT={
            CHAOS.BASEEFFECT
        }
        CHAOS.CURRENT={}
        IncludeDir( effectDirectory )
        net.Start(nws3)
        net.Broadcast()
    end
end)
concommand.Add("chaos_fixupnpcthink",function(p)
    if(p==NULL or p:IsAdmin())then
        for i,v in pairs(ents.FindByClass("npc_*"))do
            oldemt.NextThink(v,CurTime()+0.3)
        end
    end
end)
concommand.Add("chaos_fixcamera",function(p)
    if(p==NULL or p:IsAdmin())then
        for i,v in pairs(ents.FindByClass("point_viewcontrol"))do
            v:Remove()
        end
    end
end)
local tm=table.Copy(timer)
local nws="CHAOS_EFFECT"
local nws2="CHAOS_EFFECTSEC" --bro wtf
local function effectrunner()
    for i,v in pairs(CHAOS.CURRENT)do
        if(v==nil)then continue end
        if(v.sec==nil)then
            v.sec=CHAOS.DURATION*v.internalmul
        end
        if(not v.firstruned)then
            v.firstruned=true
            if(v.startfunc)then
                pcall(v.startfunc,oldemt,oldpmt,oldwmt,v.sec)
                --v.startfunc(oldemt,oldpmt,oldwmt)
            end
        end
        if(SERVER)then
            v.sec=v.sec-1*FrameTime()
            if(SERVER)then
                net.Start(nws2,true)
                net.WriteInt(i,32)
                net.WriteFloat(v.sec)
                net.Broadcast()
            end
        end
        pcall(v.tickfunc,oldemt,oldpmt,oldwmt,v.sec)
        --v.tickfunc(oldemt,oldpmt,oldwmt,v.sec)
        if(v.sec<0)then
            pcall(v.endfunc,oldemt,oldpmt,oldwmt)
            --v.endfunc(oldemt,oldpmt,oldwmt)
            CHAOS.CURRENT[i]=nil
        end
    end
end
CHAOS.CANSELECT=function(tbl)
    if(tbl.CANSELECT)then
        if(tbl.CANSELECT()==false)then
            return false
        end
    end
    return true
end
CHAOS.RANDOMFUNC=function()
    if(CLIENT)then return end
    if(CHAOS.STOP)then return end
    local e={}
    local count=0
    for i,v in pairs(CHAOS.EFFECT)do
        for i,v2 in pairs(CHAOS.CURRENT)do
            if(v.name==v2.name and not e[v2.name])then
                e[v2.name]=true
                count=count+1
            end
        end
    end
    local selected=math.random(1,#CHAOS.EFFECT)
    local tbl=table.Copy(CHAOS.EFFECT[selected])
    if(not tbl or not istable(tbl))then
        return
    end
    tbl.numforsend=selected
    local no=false
    for i,v in pairs(CHAOS.CURRENT)do
        if(v.name==tbl.name)then
            no=true
            break
        end
    end
    if(not CHAOS.CANSELECT(tbl))then
        return false
    end
    if(no)then
        if(count==CHAOS.EFFECT)then
            return
        end
        CHAOS.RANDOMFUNC()
        return
    end
    if(CHAOS.DEV)then
        PrintTable(tbl)
    end
    local index=#CHAOS.CURRENT+1
    CHAOS.CURRENT[index]=tbl
    net.Start(nws)
    net.WriteInt(index,32)
    net.WriteInt(selected,32)
    net.Broadcast()
end
CHAOS.TESTFUNC=function(num,dur)
    if(CLIENT)then return end
    local selected=num
    local tbl=table.Copy(CHAOS.EFFECT[selected])
    if(dur)then
        tbl.sec=dur
    end
    if(not tbl or not istable(tbl))then
        return
    end
    tbl.numforsend=selected
    if(CHAOS.DEV)then
        PrintTable(tbl)
    end
    local index=#CHAOS.CURRENT+1
    CHAOS.CURRENT[index]=tbl
    net.Start(nws)
    net.WriteInt(index,32)
    net.WriteInt(selected,32)
    net.Broadcast()
end
timer.Create("CHAOS_RUN",0,0,effectrunner)
concommand.Add("chaos_effectslist",function(p)
    if(p==NULL or p:IsAdmin())then
        PrintTable(CHAOS.EFFECT)
    end
end)
concommand.Add("chaos_effectsrandom",function(p)
    if(p==NULL or p:IsAdmin())then
        CHAOS.RANDOMFUNC()
    end
end)
concommand.Add("chaos_effectstest",function(p,c,args)
    if(p==NULL or p:IsAdmin())then
        local num=tonumber(args[1])
        if(num)then
            CHAOS.TESTFUNC(num)
        else
            print("Number is invalid.")
        end
    end
end)
concommand.Add("chaos_effectstestdur",function(p,c,args)
    if(p==NULL or p:IsAdmin())then
        local num=tonumber(args[1])
        local num2=tonumber(args[2])
        if(num and num2)then
            CHAOS.TESTFUNC(num,num2)
        else
            print("Number is invalid.")
        end
    end
end)
if(SERVER)then
    util.AddNetworkString(nws)
    util.AddNetworkString(nws2)
    util.AddNetworkString(nws3)
    util.AddNetworkString(nws4)
    hook.Add("PlayerInitialSpawn","CHAOS_MESSAGEONJOIN",function(p)
        if(CHAOS.DEV)then
            p:PrintMessage(HUD_PRINTTALK,"Warning! this server is running chaos-devmode,if you see this and no idea why this happen,tell [TW]Rain_bob.")
        end
        for i,v in pairs(CHAOS.CURRENT)do
            if(v)then
                net.Start(nws)
                net.WriteInt(index,32)
                net.WriteInt(v.numforsend,32)
                net.Broadcast()
            end
        end
    end)
    local run=0 
    tm.Simple(CHAOS.READY,function()
        --tm.Create("CHAOS_CHAOS ARE HAPPENING,OH NO!!!",CHAOS.INTERNAL,0,CHAOS.RANDOMFUNC)
        hook.Add("Think","CHAOS_THINK",function()
            CHAOS.CURRENTTIMELEFT=CHAOS.CURRENTTIMELEFT-1*FrameTime()
            if(not CHAOS.STOP)then
                net.Start(nws4)
                net.WriteFloat(CHAOS.CURRENTTIMELEFT/CHAOS.INTERNAL)
                net.Broadcast()
            else
                net.Start(nws4)
                net.WriteFloat(0)
                net.Broadcast()
            end
            if(CHAOS.CURRENTTIMELEFT<0)then
                CHAOS.CURRENTTIMELEFT=CHAOS.INTERNAL
                CHAOS.RANDOMFUNC()
            end
        end)
    end)
elseif(CLIENT)then
    net.Receive(nws,function(_,_)
        local index=net.ReadInt(32)
        local selected=net.ReadInt(32)
        --print(selected)
        CHAOS.CURRENT[index]=table.Copy(CHAOS.EFFECT[selected])
        print(CHAOS.EFFECT[selected].name)
    end)
    net.Receive(nws2,function(_,_)
        local tbl=CHAOS.CURRENT[net.ReadInt(32)]
        if(tbl)then
            tbl.sec=net.ReadFloat()
        end
    end)
    net.Receive(nws3,function(_,_)
        CHAOS.EFFECT={}
        CHAOS.CURRENT={}
        IncludeDir( effectDirectory )
    end)
end
