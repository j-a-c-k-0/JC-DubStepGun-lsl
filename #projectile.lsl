integer fire = FALSE;
integer switch = FALSE;
integer particle0;
integer particle1;
integer particle2;
float event_timer = .01;

integer getLinkNum(string primName)
{
integer primCount = llGetNumberOfPrims();
integer i;
for (i=0; i<primCount+1;i++){  
if (llGetLinkName(i)==primName) return i;
} 
return FALSE;
}
vector color(integer A)
{
if(A> 2){return <0.00000, 0.66667, 1.00000>;} 
if(A> 1){return <0.50196, 0.00000, 1.00000>;} 
return<0.00000, 0.66667, 1.00000>;
}
barrel0()
{
llLinkParticleSystem(particle1,[ 
PSYS_PART_FLAGS,(123
|PSYS_PART_INTERP_COLOR_MASK
|PSYS_PART_INTERP_SCALE_MASK
|PSYS_PART_EMISSIVE_MASK ), 
PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
PSYS_PART_START_ALPHA,1,
PSYS_PART_END_ALPHA,.8,
PSYS_PART_START_GLOW,1,
PSYS_PART_END_GLOW,.5,   
PSYS_PART_START_COLOR,<0.00000, 0.66667, 1.00000>,
PSYS_PART_END_COLOR,<0.00000, 0.66667, 1.00000>,
PSYS_PART_START_SCALE,<0,0,0>,
PSYS_PART_END_SCALE,<.5+llFrand(1),.5+llFrand(1),0>,
PSYS_PART_MAX_AGE,0.1,
PSYS_SRC_MAX_AGE,.1,
PSYS_SRC_ACCEL,<0,0,0>,
PSYS_SRC_TEXTURE,"9b2328f7-29a7-4d67-2c6c-b6f489ab133e",
PSYS_SRC_BURST_PART_COUNT,1,
PSYS_SRC_BURST_RADIUS,0,
PSYS_SRC_BURST_RATE,0.2,
PSYS_SRC_BURST_SPEED_MIN,0.00,
PSYS_SRC_BURST_SPEED_MAX,0,
PSYS_SRC_ANGLE_BEGIN,0,
PSYS_SRC_ANGLE_END,0,
PSYS_SRC_OMEGA,<0,0,0>]);
}
barrel1()
{
llLinkParticleSystem(particle2,[ 
PSYS_PART_FLAGS,(123
|PSYS_PART_INTERP_COLOR_MASK
|PSYS_PART_INTERP_SCALE_MASK
|PSYS_PART_EMISSIVE_MASK ), 
PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
PSYS_PART_START_ALPHA,1,
PSYS_PART_END_ALPHA,.8,
PSYS_PART_START_GLOW,1,
PSYS_PART_END_GLOW,.5, 
PSYS_PART_START_COLOR,<0.50196, 0.00000, 1.00000>,
PSYS_PART_END_COLOR,<0.50196, 0.00000, 1.00000>,
PSYS_PART_START_SCALE,<0,0,0>,
PSYS_PART_END_SCALE,<.5+llFrand(1),.5+llFrand(1),0>,
PSYS_PART_MAX_AGE,0.1,
PSYS_SRC_MAX_AGE,.1,
PSYS_SRC_ACCEL,<0,0,0>,
PSYS_SRC_TEXTURE,"9b2328f7-29a7-4d67-2c6c-b6f489ab133e",
PSYS_SRC_BURST_PART_COUNT,1,
PSYS_SRC_BURST_RADIUS,0,
PSYS_SRC_BURST_RATE,0.2,
PSYS_SRC_BURST_SPEED_MIN,0.00,
PSYS_SRC_BURST_SPEED_MAX,0,
PSYS_SRC_ANGLE_BEGIN,0,
PSYS_SRC_ANGLE_END,0,
PSYS_SRC_OMEGA,<0,0,0>]);
}
plasma_wave()
{
vector color = color((integer)llFrand(3));
llLinkParticleSystem(particle0,[ 
PSYS_PART_FLAGS,(20
|PSYS_PART_INTERP_COLOR_MASK
|PSYS_PART_INTERP_SCALE_MASK
|PSYS_PART_EMISSIVE_MASK ), 
PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
PSYS_PART_START_ALPHA,1,
PSYS_PART_END_ALPHA,.8,
PSYS_PART_START_GLOW,0.7,
PSYS_PART_END_GLOW,.2,   
PSYS_PART_START_COLOR,color,
PSYS_PART_END_COLOR,color,
PSYS_PART_START_SCALE,<0,0,0>,
PSYS_PART_END_SCALE,<1.5,1.5,0>,
PSYS_PART_MAX_AGE,.1,
PSYS_SRC_MAX_AGE,.1,
PSYS_SRC_ACCEL,<0,0,0>,
PSYS_SRC_TEXTURE,"852ac415-72ef-eb0f-1e12-12ccd61d3ae6",
PSYS_SRC_BURST_PART_COUNT,1,
PSYS_SRC_BURST_RADIUS,0,
PSYS_SRC_BURST_RATE,0.2,
PSYS_SRC_BURST_SPEED_MIN,0.00,
PSYS_SRC_BURST_SPEED_MAX,0,
PSYS_SRC_ANGLE_BEGIN,0,
PSYS_SRC_ANGLE_END,0,
PSYS_SRC_OMEGA,<0,0,0>]);
}
shockwave()
{
llLinkParticleSystem(particle0,[ 
PSYS_PART_FLAGS,(20
|PSYS_PART_INTERP_COLOR_MASK
|PSYS_PART_INTERP_SCALE_MASK
|PSYS_PART_EMISSIVE_MASK ), 
PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
PSYS_PART_START_ALPHA,.1,
PSYS_PART_END_ALPHA,0,
PSYS_PART_START_GLOW,0.05,
PSYS_PART_END_GLOW,0,   
PSYS_PART_START_COLOR,<1,1,1>,
PSYS_PART_END_COLOR,<1,1,1>,
PSYS_PART_START_SCALE,<0,0,0>,
PSYS_PART_END_SCALE,<1,1,0>,
PSYS_PART_MAX_AGE,0.3,
PSYS_SRC_MAX_AGE,.1,
PSYS_SRC_ACCEL,<0,0,0>,
PSYS_SRC_TEXTURE,"3afeacc3-1ba7-eaf1-9d3c-de222eec147e",
PSYS_SRC_BURST_PART_COUNT,1,
PSYS_SRC_BURST_RADIUS,0,
PSYS_SRC_BURST_RATE,0.2,
PSYS_SRC_BURST_SPEED_MIN,0.00,
PSYS_SRC_BURST_SPEED_MAX,0,
PSYS_SRC_ANGLE_BEGIN,0,
PSYS_SRC_ANGLE_END,0,
PSYS_SRC_OMEGA,<0,0,0>]);
}
rezzer(string object,float speed,vector pos,rotation rot,string data,integer num)
{
  if(llGetInventoryType(object) == INVENTORY_OBJECT)
  {
  llRezObjectWithParams(object,[
  REZ_FLAGS,REZ_FLAG_TEMP|REZ_FLAG_NO_COLLIDE_FAMILY|REZ_FLAG_NO_COLLIDE_OWNER,
  REZ_POS,pos+llRot2Fwd(rot)*.1,FALSE,FALSE,REZ_VEL,llRot2Fwd(rot)*speed,
  FALSE,FALSE,REZ_ROT,rot,FALSE,REZ_PARAM_STRING,data,REZ_PARAM,num]);
  }
}
float limit = 3;
float count;
Collision_bullet() 
{
rotation rot = llGetRot(); 
vector fwd = llRot2Fwd(rot);
vector size = llGetAgentSize(llGetOwner())*0.4;
if(count>limit)
{
plasma_wave(); rezzer("Col_Wub2",110,llGetPos()+<0,0,size.z>+fwd*(llVecMag(llGetVel()*0.0)+1.0),rot,"",1); switch = FALSE;
count = 0; 
}else{
count = count + 1;
}
if(switch == FALSE)
{
barrel1(); rezzer("Col_Wub1",110,llGetPos()+<0,0,size.z>+fwd*(llVecMag(llGetVel()*0.0)+1.0),rot,"",1); switch = TRUE;
}else{
barrel0(); rezzer("Col_Wub0",110,llGetPos()+<0,0,size.z>+fwd*(llVecMag(llGetVel()*0.0)+1.0),rot,"",1); switch = FALSE;
}}
float limi = 2;
float coun;
default_bullet() 
{
rotation rot = llGetRot(); 
vector fwd = llRot2Fwd(rot);
vector size = llGetAgentSize(llGetOwner())*0.4; 
if(coun>limi)
{
plasma_wave(); rezzer("Wub1",110,llGetPos()+<0.0,0.0,size.z>+fwd*(llVecMag(llGetVel()*0.0)+1.0),rot,"",1); switch = FALSE;
coun = 0; 
}else{
coun = coun + 1;
}
if(switch == FALSE)
{
barrel1(); rezzer("Wub0",110,llGetPos()+<0.0,0.0,size.z>+fwd*(llVecMag(llGetVel()*0.0)+1.0),rot,"",1); switch = TRUE;
}else{
barrel0(); rezzer("Wub2",110,llGetPos()+<0.0,0.0,size.z>+fwd*(llVecMag(llGetVel()*0.0)+1.0),rot,"",1); switch = FALSE;
}}
bullet_Shockwave(string A) 
{
rotation rot = llGetRot(); 
vector fwd = llRot2Fwd(rot);
vector size = llGetAgentSize(llGetOwner())*0.4;            
rezzer(A,0,llGetPos()+<0.0,0.0,size.z>+fwd*(llVecMag(llGetVel()*0.0)+1.0),rot,"",1);
}
default
{
    changed(integer change)
    {
    if(change & CHANGED_INVENTORY){llResetScript();}
    }
    on_rez(integer start_param) 
    {
    llResetScript();
    }
    state_entry()
    {
    llSetTimerEvent(event_timer);
    llLinkParticleSystem(LINK_SET,[]);
    particle0 = getLinkNum("particle0");
    particle1 = getLinkNum("particle1");
    particle2 = getLinkNum("particle2");
    llSetLinkPrimitiveParamsFast(particle1,[PRIM_DESC,""]);
    llRequestPermissions(llGetOwner(),PERMISSION_TAKE_CONTROLS);
    }
    run_time_permissions(integer perm)
    {
    if(PERMISSION_TAKE_CONTROLS & perm){llTakeControls( CONTROL_BACK|CONTROL_FWD, TRUE, TRUE );}
    }
    timer() 
    {
    list target0 =llGetLinkPrimitiveParams(particle0,[PRIM_DESC]);
    list target1 =llGetLinkPrimitiveParams(particle1,[PRIM_DESC]);
    if(llList2String(target1,0) == "shoot")
    {
    if(fire == FALSE){fire = TRUE;}else{if(fire == TRUE){llLinkParticleSystem(LINK_SET,[]); fire = FALSE;}}
    if(llList2String(target0,0) == "Collision_Wub"){Collision_bullet();}
    if(llList2String(target0,0) == "Default_Wub"){default_bullet();}
    if(llList2String(target0,0) == "Small_Shockwave"){shockwave();bullet_Shockwave(llList2String(target0,0));}
    if(llList2String(target0,0) == "Medium_Shockwave"){shockwave();bullet_Shockwave(llList2String(target0,0));}
    if(llList2String(target0,0) == "Large_Shockwave"){shockwave();bullet_Shockwave(llList2String(target0,0));}
    if(llList2String(target0,0) == "ExLarge_Shockwave"){shockwave();bullet_Shockwave(llList2String(target0,0));}
} } }
