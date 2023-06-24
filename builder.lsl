integer getLinkNum(string primName)
{
integer primCount = llGetNumberOfPrims();
integer i;
for (i=0; i<primCount+1;i++){  
if (llGetLinkName(i)==primName) return i;
}return FALSE;}
default
{
 state_entry()
 {
 llSetLinkPrimitiveParamsFast(LINK_THIS,[PRIM_SIZE,<0.010000,0.010000,0.010000>,PRIM_ROT_LOCAL,<0.653282,0.270601,0.653292,-0.270571>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("DubStepGun"),[PRIM_POS_LOCAL,<0.000000,0.000002,-0.048100>,PRIM_SIZE,<0.328460,0.906713,0.442068>,PRIM_ROT_LOCAL,<-0.000019,-0.000002,-0.000022,-1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("speaker"),[PRIM_POS_LOCAL,<-0.045380,-0.415950,-0.066060>,PRIM_SIZE,<0.132871,0.025695,0.132872>,PRIM_ROT_LOCAL,<-0.000029,0.707106,-0.000002,-0.707108>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("starget"),[PRIM_POS_LOCAL,<-0.003811,0.198002,-0.052505>,PRIM_SIZE,<0.045128,0.045128,0.047153>,PRIM_ROT_LOCAL,<0.499996,-0.500021,-0.500004,0.499979>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("particle0"),[PRIM_POS_LOCAL,<-0.045390,-0.455687,-0.066157>,PRIM_SIZE,<0.010000,0.010000,0.074941>,PRIM_ROT_LOCAL,<0.707107,0.000000,0.000000,0.707107>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("particle2"),[PRIM_POS_LOCAL,<-0.006327,-0.455682,0.122563>,PRIM_SIZE,<0.010000,0.010000,0.074941>,PRIM_ROT_LOCAL,<0.707107,0.000000,0.000000,0.707107>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("particle1"),[PRIM_POS_LOCAL,<-0.006327,-0.455679,0.050295>,PRIM_SIZE,<0.010000,0.010000,0.074941>,PRIM_ROT_LOCAL,<0.707107,0.000000,0.000000,0.707107>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("gif2"),[PRIM_POS_LOCAL,<-0.003818,0.390593,0.034898>,PRIM_SIZE,<0.055152,0.070808,0.077300>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("gif1"),[PRIM_POS_LOCAL,<0.104490,0.046722,0.034183>,PRIM_SIZE,<0.010000,0.096077,0.053604>,PRIM_ROT_LOCAL,<0.092296,-0.092296,0.701057,0.701057>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("meter"),[PRIM_POS_LOCAL,<-0.033937,0.028008,0.010985>,PRIM_SIZE,<0.010000,0.010000,0.070000>,PRIM_ROT_LOCAL,<0.923880,0.000000,0.000000,0.382680>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("slider3"),[PRIM_POS_LOCAL,<-0.003830,0.301480,0.014770>,PRIM_SIZE,<0.080579,0.018188,0.010000>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("slider2"),[PRIM_POS_LOCAL,<-0.003830,0.278930,0.030180>,PRIM_SIZE,<0.080579,0.018188,0.010000>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("slider4"),[PRIM_POS_LOCAL,<-0.003830,0.325260,0.008150>,PRIM_SIZE,<0.080579,0.018188,0.010000>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("slider1"),[PRIM_POS_LOCAL,<-0.003830,0.255890,0.030170>,PRIM_SIZE,<0.080579,0.018188,0.010000>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("vinyl"),[PRIM_POS_LOCAL,<-0.003663,0.027296,0.027342>,PRIM_SIZE,<0.053000,0.247305,0.246102>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("turn3"),[PRIM_POS_LOCAL,<-0.003901,-0.117590,0.127442>,PRIM_SIZE,<0.068108,0.033288,0.063447>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("turn2"),[PRIM_POS_LOCAL,<-0.003654,-0.183191,0.127440>,PRIM_SIZE,<0.068108,0.033288,0.063447>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSetLinkPrimitiveParamsFast(getLinkNum("turn1"),[PRIM_POS_LOCAL,<-0.003651,-0.247518,0.127437>,PRIM_SIZE,<0.068108,0.033288,0.063447>,PRIM_ROT_LOCAL,<0.000000,0.000000,0.000000,1.000000>]);
 llSleep(0.2);
 llRemoveInventory(llGetScriptName());
}}
