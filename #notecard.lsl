integer animated0;
integer slider4;
integer intLine1;
string  note_name;
key keyConfigQueryhandle;
key keyConfigUUID;

integer getLinkNum(string primName)
{
integer primCount = llGetNumberOfPrims();
integer i;
for (i=0; i<primCount+1;i++){  
if (llGetLinkName(i)==primName) return i;
}
return FALSE;
}
integer readnote(string notename)
{
  note_name = notename;
  if (llGetInventoryType(note_name) == INVENTORY_SOUND)
  {
  llMessageLinked(LINK_THIS,0,"upload_note|idle_music=" + (string)llGetInventoryKey(note_name),"");
  llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"1"]);
  return 2;
  }
  if (llGetInventoryType(note_name) == INVENTORY_NOTECARD)
  {
  intLine1 = 0;
  keyConfigQueryhandle = llGetNotecardLine(note_name, intLine1); 
  keyConfigUUID = llGetInventoryKey(note_name);
  llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"0"]);
  return 1;
  }
  llMessageLinked(LINK_THIS,0,"database_loop|" + notename,"");
  llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"1"]);
  return 0;
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
    animated0 = getLinkNum("gif1");
    slider4 = getLinkNum("slider4");
    llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"0"]);
    llSetLinkPrimitiveParamsFast(animated0,[PRIM_DESC,"none"]);
    llRequestPermissions(llGetOwner(),PERMISSION_TAKE_CONTROLS);
    }
    run_time_permissions(integer perm)
    {
    if(PERMISSION_TAKE_CONTROLS & perm){llTakeControls( CONTROL_BACK|CONTROL_FWD, TRUE, TRUE );}
    }
    link_message(integer sender_num, integer num, string msg, key id)
    {
    list params = llParseString2List(msg, ["|"], []);
    if(llList2String(params, 0) == "fetch_note_rationed")
    {
      integer value = readnote(llDumpList2String(llList2ListStrided(params, 1, -1, 1), " "));
      if(value == 2){llSetLinkPrimitiveParamsFast(animated0,[PRIM_DESC,""]); llMessageLinked(LINK_THIS,0,"music_changed","");}
    } }
    dataserver(key keyQueryId, string strData)
    {
    if (keyQueryId == keyConfigQueryhandle)
    {
          if (strData == EOF){llSetLinkPrimitiveParamsFast(animated0,[PRIM_DESC,""]); llMessageLinked(LINK_THIS,0,"music_changed","");}else
          {
             keyConfigQueryhandle = llGetNotecardLine(note_name, ++intLine1);
             llMessageLinked(LINK_THIS,0,"upload_note|" + strData,"");
    }  }  }  }