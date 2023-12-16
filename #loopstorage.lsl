string notecardName = "&uuids";
integer ichannel = 14273;
integer notecardLine;
integer cur_page = 1;
integer chanhandlr;
integer particle1;
integer particle2;
integer slider3;
integer music;
key notecardQueryId;
key notecardKey;
key keyUUID;

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
integer getLinkNum(string primName)
{
integer primCount = llGetNumberOfPrims();
integer i;
for (i=0; i<primCount+1;i++){  
if (llGetLinkName(i)==primName) return i;
}
return FALSE;
}
list order_buttons(list buttons)
{
return llList2List(buttons, -3, -1) + llList2List(buttons, -6, -4) +
llList2List(buttons, -9, -7) + llList2List(buttons, -12, -10);
}
list numerizelist(list tlist, integer start, string apnd)
{
list newlist; integer lsize = llGetListLength(tlist); integer i;
for(; i < lsize; i++)
{
newlist += [(string)(start + i) + apnd + llList2String(tlist, i)];
}return newlist;}
dialog_songmenu(integer page)
{
integer slist_size = llLinksetDataCountKeys();
integer pag_amt = llCeil((float)slist_size / 9.0);
if(page > pag_amt) page = 1;
else if(page < 1) page = pag_amt;
cur_page = page; integer songsonpage;
if(page == pag_amt)
songsonpage = slist_size % 9;
if(songsonpage == 0)
songsonpage = 9; integer fspnum = (page*9)-9; list dbuf; integer i;
for(; i < songsonpage; ++i)
{
dbuf += ["Play #" + (string)(fspnum+i)];
}
list snlist = numerizelist(make_list(fspnum,i), fspnum, ". ");
list target1 =llGetLinkPrimitiveParams(particle2,[PRIM_DESC]);
llDialog(llGetOwner(),
"Music = "+llList2String(target1,0)+"\n\n"+
llDumpList2String(snlist, "\n"),order_buttons(dbuf + ["<<<", "[ ♫ songs ]", ">>>"]),ichannel);
}
list make_list(integer a,integer b) 
{
  list inventory; integer i;
  for(i = 0; i < b; ++i)
  {
  list items = llParseString2List(llLinksetDataRead("m-"+(string)(a+i)),["|"],[]);
  inventory += llDeleteSubString(llList2String(items,0),40,1000);
  }return inventory;
}
search_music(string search)
{
        ichannel = llFloor(llFrand(1000000) - 100000); llListenRemove(chanhandlr); chanhandlr = llListen(ichannel, "", NULL_KEY, "");
        integer Lengthx = llLinksetDataCountKeys(); integer x;
        for ( ; x < Lengthx; x += 1)
        { 
        string A = llToLower(search); string B = llToLower(llLinksetDataRead("m-"+(string)x));
        integer search_found = ~llSubStringIndex(B,A);
        if (search_found)
        { 
        list item = llParseString2List(llLinksetDataRead("m-"+(string)x), ["|"], []);
        integer Division= x / 9 ; llOwnerSay("[ "+llList2String(item,0)+" ] [ page = "+(string)(Division+1)+" list = "+(string)x+" ]");
        dialog_songmenu(Division+1);  
        return;
        }
    }llOwnerSay("Could not find anything");
}
dialog0()
{
ichannel = llFloor(llFrand(1000000) - 100000); llListenRemove(chanhandlr); chanhandlr = llListen(ichannel, "", NULL_KEY, ""); dialog_songmenu(cur_page);
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
    llLinksetDataReset(); ReadNotecard(); slider3 = getLinkNum("slider3");
    particle1 = getLinkNum("particle1"); particle2 = getLinkNum("particle2");
    llRequestPermissions(llGetOwner(),PERMISSION_TAKE_CONTROLS);
    }
    link_message(integer sender_num, integer num, string msg, key id)
    {
    list items = llParseString2List(msg,["="],[]);
    if(llList2String(items,0) == "database_loop"){search_music(llList2String(items,1));}
    if(msg == "[ Reset ]"){llResetScript();}
    if(msg == "[ uuid ]"){dialog0();}
    if(msg == "random_music_uuid_T")
    {
      integer x = llFloor(llFrand(llLinksetDataCountKeys())); cur_page = (x/9)+1;   
      list items = llParseString2List(llLinksetDataRead("m-"+(string)x),["|"],[]); llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,llList2String(items,0)]); 
      llMessageLinked(LINK_THIS,0,"erase_data",""); llMessageLinked(LINK_THIS, 0,"fetch_note_rationed|"+llList2String(items,1),"");
      llMessageLinked(LINK_THIS, 0,"song_request","");
    }
    if(msg == "random_music_uuid")
    {
      integer x = llFloor(llFrand(llLinksetDataCountKeys())); cur_page = (x/9)+1;   
      list items = llParseString2List(llLinksetDataRead("m-"+(string)x),["|"],[]); llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,llList2String(items,0)]); 
      llMessageLinked(LINK_THIS,0,"erase_data",""); llMessageLinked(LINK_THIS, 0,"fetch_note_rationed|"+llList2String(items,1),"");
      llMessageLinked(LINK_THIS, 0,"mainmenu_request","");
    } }
    listen(integer chan, string sname, key skey, string text)
    {
    list target1 =llGetLinkPrimitiveParams(particle1,[PRIM_DESC]); if(llList2String(target1,0) == "shoot"){return;} 
    if(skey == llGetOwner()) 
    {
        if(text == "[ ♫ songs ]"){llMessageLinked(LINK_THIS,0,"song_request", "");}
        else if(text == ">>>") dialog_songmenu(cur_page+1);
        else if(text == "<<<") dialog_songmenu(cur_page-1);
        else if(llToLower(llGetSubString(text,0,5)) == "play #")
        {
        integer pnum = (integer)llGetSubString(text, 6, -1);
        list items = llParseString2List(llLinksetDataRead("m-"+(string)pnum),["|"],[]); 
        llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,llList2String(items,0)]); llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"2"]); 
        llMessageLinked(LINK_THIS,0,"erase_data",""); llMessageLinked(LINK_THIS, 0,"fetch_note_rationed|"+llList2String(items,1),"");
        dialog0();
    } } }
    dataserver(key query_id, string data)
    {
        if (query_id == notecardQueryId)
        {
          if (data == EOF){ }else
          {
          llLinksetDataWrite("m-"+(string)music,data);
          music = music + 1; ++notecardLine; notecardQueryId = llGetNotecardLine(notecardName, notecardLine);
    } } } }
