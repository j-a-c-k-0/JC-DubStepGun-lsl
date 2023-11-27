string notecardName = "&uuids";
integer notecardLine;
integer animated0;
integer slider3;
key notecardQueryId;
key notecardKey;
key keyUUID;
list songlist;

integer getLinkNum(string primName)
{
integer primCount = llGetNumberOfPrims();
integer i;
for (i=0; i<primCount+1;i++){  
if (llGetLinkName(i)==primName) return i;
}
return FALSE;
}
ReadNotecard()
{
    if (llGetInventoryKey(notecardName) == NULL_KEY)
    {
    llOwnerSay( "Notecard '" + notecardName + "' missing or unwritten.");
    return;
    }
    else if (llGetInventoryKey(notecardName) == notecardKey) return;
    notecardKey = llGetInventoryKey(notecardName);
    notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
}
search_music(string search)
{
        integer Lengthx = llGetListLength(songlist); integer x;
        for ( ; x < Lengthx; x += 1)
        {
        string A = llToLower(search); string B = llToLower(llList2String(songlist, x));
        integer search_found = ~llSubStringIndex(B,A);
        if (search_found)
        { 
        list item = llParseString2List(llList2String(songlist, x), ["|"], []);
        llMessageLinked(LINK_THIS,0,"upload_note|idle_music=" + llList2String(item, 1),"");
        return;
        }
    }llOwnerSay("could not find in database"); 
}
default 
{
    on_rez(integer start_param) 
    {
    llResetScript();
    }
    changed(integer change)
    {
    if (change & CHANGED_INVENTORY){llResetScript();}
    } 
    run_time_permissions(integer perm)
    {
    if(PERMISSION_TAKE_CONTROLS & perm){llTakeControls( CONTROL_BACK|CONTROL_FWD, TRUE, TRUE );}
    }
    state_entry() 
    {
    ReadNotecard();
    animated0 = getLinkNum("gif1");
    slider3 = getLinkNum("slider3");
    llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"0"]);
    llRequestPermissions(llGetOwner(), PERMISSION_TAKE_CONTROLS); 
    }
    link_message(integer sender_num, integer num, string msg, key id)
    {
      list params = llParseString2List(msg, ["|"], []);
      if(msg == "[ Reset ]"){llResetScript();}
      if(llList2String(params, 0) == "database_loop")
      {
      search_music(llList2String(params,1));
      llMessageLinked(LINK_THIS,0,"music_changed","");
      llSetLinkPrimitiveParamsFast(animated0,[PRIM_DESC,""]); 
      }
    }
    dataserver(key query_id, string data)
    {
        if (query_id == notecardQueryId)
        {
            if (data == EOF)
            {
            llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,(string)llGetFreeMemory()]); 
            llMessageLinked(LINK_THIS,0,"m_update",""); return; 
            }else{
            songlist += data; ++notecardLine;
            llMessageLinked(LINK_THIS, 0, "loop_add_music"+"|"+data, NULL_KEY);
            notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
            }
        }
    }
}