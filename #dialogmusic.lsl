string notecardName = "&uuids";
integer dialog_select_switch = FALSE;
integer gun_power_state = FALSE;
integer switch_mode = FALSE;
integer ichannel = 978461;
integer cur_page0 = 1;
integer cur_page = 1;
integer radius_link;
integer chanhandlr;
integer particle1;
integer particle2;
integer animated1;
integer slider3;
integer speaker;

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
string gun_power()
{
list a = llGetLinkPrimitiveParams(particle2,[PRIM_DESC]);
if(llList2String(a,0) == "none"){return"[ ♫ P̶l̶a̶y̶ ]";}if(gun_power_state == FALSE){return"[ ♫ Play ]";}else{return"[ ♫ Pause ]";
}}
string sound_type_0()
{
list c = llGetLinkPrimitiveParams(slider3,[PRIM_DESC]); string a = llList2String(c,0);
if(a == "0"){return"sound";}if(a == "1"){return"notecard";}if(a == "2"){return"uuid";}
return"null";
}
string sound_type_mode(){if(switch_mode == FALSE){return"[ ♫ Type ○ ]";}else{return"[ ♫ Type ● ]";}}
type_option()
{
list target1 =llGetLinkPrimitiveParams(particle2,[PRIM_DESC]);
llDialog(llGetOwner(),
"Music = "+llList2String(target1,0)+"\n"+
"Sound Type = "+sound_type_0()+"\n"
,["[ ♫ sound ]","[ ♫ note ]","[ ♫ uuid ]",sound_type_mode(),gun_power(),"[ ♫ random ]","[ ✖️ exit ]","...","[ ← main ]"],ichannel);
}
string check_output(float A){if(.01<=A){return(string)A;}return"OFF";}
dialog_songmenu(integer page,integer inventory_type)
{
    integer slist_size = llGetInventoryNumber(inventory_type);
    integer pag_amt = llCeil((float)slist_size / 9.0);
    if(page > pag_amt) page = 1;
    if(page < 1) page = pag_amt; if(dialog_select_switch == FALSE){cur_page = page;}else{cur_page0 = page;}
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
    list target1 =llGetLinkPrimitiveParams(particle2,[PRIM_DESC]);
    list snlist = numerizelist(make_list(fspnum,i,inventory_type), fspnum, ". ");
    llDialog(llGetOwner(),"Music = "+llList2String(target1,0)+"\n\n"+ llDumpList2String(snlist, "\n"),order_buttons(dbuf + ["<<<", "[ ♫ songs ]", ">>>"]),ichannel);
}
list make_list(integer a,integer b,integer B) 
{
  list inventory;integer i;for (i = 0; i < b; ++i)
  {
  string name = llGetInventoryName(B,a+i);
  if(name == notecardName){inventory += "null";}else{inventory += llDeleteSubString(name,40,1000);}
  }return inventory;
}
option_topmenu()
{
list target=llGetLinkPrimitiveParams(speaker,[PRIM_DESC]);
list item=llGetLinkPrimitiveParams(radius_link,[PRIM_DESC]); 
integer music_list=(llGetInventoryNumber(INVENTORY_NOTECARD)-1)+llGetInventoryNumber(INVENTORY_SOUND)+(integer)llLinksetDataRead("uuid");
llTextBox(llGetOwner(),
"\n"+"[ Status ]"+"\n\n"+
"Memory = "+(string)llLinksetDataAvailable()+"\n"+
"Sound Radius = "+(string)llDeleteSubString(llList2String(item,0),4,300)+"\n"+
"Volume = "+(string)llDeleteSubString(llList2String(target,0),4,300)+"\n"+
"Musics = "+(string)music_list+"\n\n"+
"[ Command Format ]"+"\n\n"+
"Search > ( s/music )"+"\n"+
"Volume > ( v/0.5 )"+"\n"+
"Radius > ( r/0 )"+"\n",ichannel);
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
    animated1 = getLinkNum("gif2");  
    slider3 = getLinkNum("slider3");
    speaker = getLinkNum("speaker");
    radius_link = getLinkNum("starget");
    particle1 = getLinkNum("particle1");
    particle2 = getLinkNum("particle2");
    llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"1"]);
    llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,"none"]);
    llRequestPermissions(llGetOwner(),PERMISSION_TAKE_CONTROLS);
    }
    run_time_permissions(integer perm)
    {
    if(PERMISSION_TAKE_CONTROLS & perm){llTakeControls( CONTROL_BACK|CONTROL_FWD, TRUE, TRUE );}
    }
    link_message(integer source, integer num, string str, key id)
    {
      list params = llParseString2List(str, ["|"], []);
      if(str == "song_request"){random_channel(); type_option();}
      if(str == "option_request"){random_channel(); option_topmenu();}
      if(str == "[ Pause ]"){gun_power_state = FALSE;}      
      if(str == "[ Play ]"){gun_power_state = TRUE;}
      if(str == "[ Reset ]"){llResetScript();}
      if(str == "random_music")
      {
        list c = llGetLinkPrimitiveParams(slider3,[PRIM_DESC]);
        if(llList2String(c,0) == "0")
        {   
        integer x = llFloor(llFrand(llGetInventoryNumber(INVENTORY_SOUND)));
        string music_selection = llGetInventoryName(INVENTORY_SOUND,x);
        llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,music_selection]);llMessageLinked(LINK_THIS,0,"erase_data","");
        llMessageLinked(LINK_THIS,0,"fetch_note_rationed|"+music_selection,"");
        llMessageLinked(LINK_THIS, 0,"mainmenu_request","");cur_page0 = (x/9)+1;
        }
        if(llList2String(c,0) == "1")
        {   
        integer x = llFloor(llFrand(llGetInventoryNumber(INVENTORY_NOTECARD)));
        string music_selection = llGetInventoryName(INVENTORY_NOTECARD,x);
        llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,music_selection]);llMessageLinked(LINK_THIS,0,"erase_data","");
        llMessageLinked(LINK_THIS, 0,"fetch_note_rationed|"+music_selection,"");
        llMessageLinked(LINK_THIS, 0,"mainmenu_request","");cur_page = (x/9)+1;
    } } }
    listen(integer chan, string sname, key skey, string text)
    {
    list target1 =llGetLinkPrimitiveParams(particle1,[PRIM_DESC]); if(llList2String(target1,0) == "shoot"){return;} 
    list items0 = llParseString2List(text, ["/"], []);
    if(skey == llGetOwner())
    {
          if(text == "[ ♫ random ]")
          {
            list c = llGetLinkPrimitiveParams(slider3,[PRIM_DESC]); string a = llList2String(c,0);
            if(a == "0")
            {
            integer x = llFloor(llFrand(llGetInventoryNumber(INVENTORY_SOUND)));
            string music_selection = llGetInventoryName(INVENTORY_SOUND,x);
            llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,music_selection]);llMessageLinked(LINK_THIS,0,"erase_data","");
            llMessageLinked(LINK_THIS,0,"fetch_note_rationed|"+music_selection,"");
            random_channel(); type_option(); cur_page0 = (x/9)+1;
            }
            if(a == "1")
            {
            integer x = llFloor(llFrand(llGetInventoryNumber(INVENTORY_NOTECARD)));
            string music_selection = llGetInventoryName(INVENTORY_NOTECARD,x);
            llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,music_selection]);llMessageLinked(LINK_THIS,0,"erase_data","");
            llMessageLinked(LINK_THIS, 0,"fetch_note_rationed|"+music_selection,"");
            random_channel(); type_option(); cur_page = (x/9)+1;
            }
            if(a == "2")
            {
            llMessageLinked(LINK_THIS, 0,"random_music_uuid_T","");
            }return;
          }
          if(text == "[ ♫ note ]")
          {
            if(switch_mode == FALSE)
            {
            dialog_select_switch = FALSE; random_channel(); dialog_songmenu(cur_page,INVENTORY_NOTECARD);
            }else{
            llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"1"]); random_channel(); type_option();
          } }
          if(text == "[ ♫ sound ]")
          {
            if(switch_mode == FALSE)
            {
            dialog_select_switch = TRUE; random_channel(); dialog_songmenu(cur_page0,INVENTORY_SOUND);
            }else{
            llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"0"]); random_channel(); type_option();
          } }
          if(text == "[ ♫ uuid ]")
          {
            if(switch_mode == FALSE)
            {
            llMessageLinked(LINK_THIS,0,"[ uuid ]","");
            }else{
            llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"2"]); random_channel(); type_option();
          } }
          if(text == "[ ♫ Pause ]"){gun_power_state = FALSE; llMessageLinked(LINK_THIS,0,"[ Pause ]_00",""); type_option();}
          if(text == "[ ♫ Play ]"){gun_power_state = TRUE; llMessageLinked(LINK_THIS,0,"[ Play ]_00",""); type_option();}
          if(text == "[ ♫ Type ● ]"){switch_mode = FALSE; random_channel(); type_option();}
          if(text == "[ ← main ]"){llMessageLinked(LINK_THIS, 0,"mainmenu_request","");}
          if(text == "[ ♫ Type ○ ]"){switch_mode = TRUE; random_channel(); type_option();}
          if(text == "[ ♫ songs ]"){random_channel(); type_option();}
          if(text == "[ ♫ P̶l̶a̶y̶ ]"){random_channel(); type_option();}
          if(text == "..."){random_channel(); type_option();}
          if(llList2String(items0,0) == "s"){llMessageLinked(LINK_THIS, 0,"search_engine="+llList2String(items0,1),"");}
          if(llList2String(items0,0) == "r")
          {
          llSetLinkPrimitiveParamsFast(radius_link,[PRIM_DESC,llDeleteSubString(check_output(llList2Float(items0,1)),4,300)]);
          llMessageLinked(LINK_THIS,0,"mainmenu_request","");
          llMessageLinked(speaker,0,"sound_range","");
          }
          if(llList2String(items0,0) == "v")
          {
          llSetLinkPrimitiveParamsFast(speaker,[PRIM_DESC,llDeleteSubString(check_output(llList2Float(items0,1)),4,300)]);
          llMessageLinked(LINK_THIS,0,"mainmenu_request","");
          llMessageLinked(speaker,0,"volume_change|"+(string)llList2Float(items0,1),"");
          }
          if(dialog_select_switch == TRUE)
          {
            if(text == ">>>") dialog_songmenu(cur_page0+1,INVENTORY_SOUND);
            if(text == "<<<") dialog_songmenu(cur_page0-1,INVENTORY_SOUND);
            if(llToLower(llGetSubString(text,0,5)) == "play #")
            {
            integer pnum = (integer)llGetSubString(text, 6, -1); string music_selection = llGetInventoryName(INVENTORY_SOUND,pnum);
            llMessageLinked(LINK_THIS,0,"erase_data","");llMessageLinked(LINK_THIS,0,"fetch_note_rationed|"+music_selection,"");
            llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,music_selection]);
            llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"0"]);
            dialog_songmenu(cur_page0,INVENTORY_SOUND);
          } }
          if(dialog_select_switch == FALSE)
          {
            if(text == ">>>") dialog_songmenu(cur_page+1,INVENTORY_NOTECARD);
            if(text == "<<<") dialog_songmenu(cur_page-1,INVENTORY_NOTECARD);
            if(llToLower(llGetSubString(text,0,5)) == "play #")
            {
              integer pnum = (integer)llGetSubString(text, 6, -1); 
              string music_selection = llGetInventoryName(INVENTORY_NOTECARD,pnum); llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,music_selection]);
              if(music_selection == notecardName){dialog_songmenu(cur_page,INVENTORY_NOTECARD);}else
              {    
              llMessageLinked(LINK_THIS,0,"erase_data",""); llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"1"]);
              llMessageLinked(LINK_THIS,0,"fetch_note_rationed|"+music_selection,"");  
              dialog_songmenu(cur_page,INVENTORY_NOTECARD);
    } } } } } }
