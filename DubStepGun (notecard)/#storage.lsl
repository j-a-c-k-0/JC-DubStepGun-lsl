string music_selection = "none";
integer ichannel = 978461;
integer cur_page = 1;
integer radius_link;
integer chanhandlr;
integer slist_size;
integer animated0;
integer animated1;
integer particle1;
integer particle2;
integer slider3;
integer speaker;

startup()
{
animated0 = getLinkNum("gif1");
animated1 = getLinkNum("gif2");
slider3 = getLinkNum("slider3");
speaker = getLinkNum("speaker");
radius_link = getLinkNum("starget");
particle1 = getLinkNum("particle1");
particle2 = getLinkNum("particle2");
slist_size = llGetInventoryNumber(INVENTORY_NOTECARD);
llRequestPermissions(llGetOwner(),PERMISSION_TAKE_CONTROLS);
llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,checklist(music_selection)]);
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
random_channel()
{
ichannel = llFloor(llFrand(1000000) - 100000); llListenRemove(chanhandlr);
chanhandlr = llListen(ichannel, "", NULL_KEY, "");
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
    }return newlist;
}
dialog_songmenu(integer page)
{
    integer pag_amt = llCeil((float)slist_size / 9.0);
    if(page > pag_amt) page = 1;
    if(page < 1) page = pag_amt; cur_page = page;
    integer songsonpage;
    if(page == pag_amt) songsonpage = slist_size % 9;
    if(songsonpage == 0) songsonpage = 9;
    integer fspnum = (page*9)-9;
    list dbuf;
    integer i;
    for(; i < songsonpage; ++i)
    {
    dbuf += ["Play #" + (string)(fspnum+i)];
    }
    list snlist = numerizelist(make_list(fspnum,i), fspnum, ". ");
    llDialog(llGetOwner(),"Music = "+music_selection+"\n\n"+ llDumpList2String(snlist, "\n"),order_buttons(dbuf + ["<<<", "[ main ]", ">>>"]),ichannel);
}
list make_list(integer a,integer b) 
{
list inventory;
integer i;
for (i = 0; i < b; ++i){string name = llGetInventoryName(INVENTORY_NOTECARD,a+i);inventory += name;}
return inventory;
}
string checklist(string A){if(!llGetInventoryNumber(INVENTORY_NOTECARD)){return "none";}else{return A;}}
string check_output(float A){if(.01<=A){return(string)A;}return"OFF";}
search_music(string search)
{
integer Lengthx = llGetInventoryNumber(INVENTORY_NOTECARD); integer x;
for ( ; x < Lengthx; x += 1)
{
  string A = llToLower(search); string B = llToLower(llGetInventoryName(INVENTORY_NOTECARD, x));
  integer search_found = ~llSubStringIndex(B,A);
  if (search_found)
  {
  integer Division= x / 9 ; llOwnerSay("[ "+llGetInventoryName(INVENTORY_NOTECARD,x)+" ] [ page = "+(string)(Division+1)+" list = "+(string)x+" ]");
  dialog_songmenu(Division+1);
  return;
} }llOwnerSay("Could not find anything"); llMessageLinked(LINK_THIS, 0,"mainmenu_request","");}
option_topmenu()
{
list item=llGetLinkPrimitiveParams(radius_link,[PRIM_DESC]);
list target=llGetLinkPrimitiveParams(speaker,[PRIM_DESC]);
list targe=llGetLinkPrimitiveParams(slider3,[PRIM_DESC]);
integer music_list=llGetInventoryNumber(INVENTORY_NOTECARD); 
integer page=(music_list / 9) + 1;
llTextBox(llGetOwner(),
"\n"+"[ Status ]"+"\n\n"+
"Sound Radius = "+(string)llDeleteSubString(llList2String(item,0),4,100)+"\n"+
"Volume = "+(string)llDeleteSubString(llList2String(target,0),4,100)+"\n"+
"Musics = "+(string)music_list+"\n"+
"Page = "+(string)page+"\n\n"+
"[ Command Format ]"+"\n\n"+
"Search > ( s/music )"+"\n"+
"Volume > ( v/0.5 )"+"\n"+
"Radius > ( r/0 )"+"\n"+
"Page > ( p/1 )"+"\n",ichannel);
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
    startup();
    }
    run_time_permissions(integer perm)
    {
    if(PERMISSION_TAKE_CONTROLS & perm){llTakeControls( CONTROL_BACK|CONTROL_FWD, TRUE, TRUE );}
    }
    link_message(integer source, integer num, string str, key id)
    {
      list params = llParseString2List(str, ["|"], []);
      if(str == "song_request"){random_channel(); dialog_songmenu(cur_page);}
      if(str == "option_request"){random_channel(); option_topmenu();}
      if(str == "[ Reset ]"){llResetScript();}
      if(str == "random_request")
      {
      llSetLinkPrimitiveParamsFast(animated0,[PRIM_DESC,""]);
      integer x = llFloor(llFrand(llGetInventoryNumber(INVENTORY_NOTECARD)));
      music_selection = llGetInventoryName(INVENTORY_NOTECARD,x);
      llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,checklist(music_selection)]);
      llMessageLinked(LINK_THIS,0,"erase_data","");llMessageLinked(LINK_THIS, 0,"fetch_note_rationed|"+music_selection,"");
      llMessageLinked(LINK_THIS, 0,"mainmenu_request","");
    } }
    listen(integer chan, string sname, key skey, string text)
    {
    list target1 =llGetLinkPrimitiveParams(animated1,[PRIM_DESC]); if(llList2String(target1,0) == "firing"){return;}
    list items0 = llParseString2List(text, ["/"], []);
    if(skey == llGetOwner())
    {
          if(llList2String(items0,0) == "s"){search_music(llList2String(items0,1));}
          if(llList2String(items0,0) == "p"){dialog_songmenu((integer)llList2String(items0,1));}
          if(llList2String(items0,0) == "r")
          {
          llSetLinkPrimitiveParamsFast(radius_link,[PRIM_DESC,llDeleteSubString(check_output(llList2Float(items0,1)),4,100)]);
          llMessageLinked(LINK_THIS,0,"mainmenu_request","");
          llMessageLinked(speaker,0,"sound_range","");
          }
          if(llList2String(items0,0) == "v")
          {
          llSetLinkPrimitiveParamsFast(speaker,[PRIM_DESC,llDeleteSubString(check_output(llList2Float(items0,1)),4,100)]);
          llMessageLinked(LINK_THIS,0,"mainmenu_request","");
          llMessageLinked(speaker,0,"volume_change|"+(string)llList2Float(items0,1),"");
          }
          if(text == "[ main ]"){llMessageLinked(LINK_THIS, 0,"mainmenu_request","");}
          if(text == ">>>") dialog_songmenu(cur_page+1);
          if(text == "<<<") dialog_songmenu(cur_page-1);
          if(llToLower(llGetSubString(text,0,5)) == "play #")
          {
          integer pnum = (integer)llGetSubString(text, 6, -1); music_selection = llGetInventoryName(INVENTORY_NOTECARD,pnum);
          llMessageLinked(LINK_THIS,0,"erase_data","");llMessageLinked(LINK_THIS, 0,"fetch_note_rationed|"+llGetInventoryName(INVENTORY_NOTECARD,pnum),"");
          llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,checklist(music_selection)]);
          dialog_songmenu(cur_page);
    } } } }