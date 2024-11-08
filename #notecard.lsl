string notecardName = "!uuids";
string note_name;

integer ichannel = 07899;
integer cur_page = 1;
integer chanhandlr;
integer num;

integer slider3;
integer slider4;
integer intLine1;
integer particle2;

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
integer readnote(string notename,string page_info)
{
  llMessageLinked(LINK_THIS,5,page_info,"");
  if(llGetInventoryType(notename) == INVENTORY_SOUND)
  {
  llMessageLinked(LINK_THIS,0,"upload_note|idle_music=" +(string)llGetInventoryKey(notename),"");
  llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"1"]);
  llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"0"]);
  return 2;
  }
  if(llGetInventoryType(notename) == INVENTORY_NOTECARD)
  {
  note_name = notename; intLine1 = 0;
  keyConfigQueryhandle = llGetNotecardLine(notename, intLine1);
  keyConfigUUID = llGetInventoryKey(notename);
  llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"0"]);
  llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"1"]);
  return 1;
  }
  llMessageLinked(LINK_THIS,0,"upload_note|idle_music="+notename,"");    
  llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"1"]);
  llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"2"]);
  return 2;
}
startup()
{
slider3 = getLinkNum("slider3");
slider4 = getLinkNum("slider4"); 
particle2 = getLinkNum("particle2");
llLinksetDataDeleteFound("temp-","");
llSetLinkPrimitiveParamsFast(slider3,[PRIM_DESC,"1"]);
llSetLinkPrimitiveParamsFast(slider4,[PRIM_DESC,"0"]);
llRequestPermissions(llGetOwner(),PERMISSION_TAKE_CONTROLS);
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
integer slist_size = num;
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
llDialog(llGetOwner(),"result "+(string)num+"\n\n"+
llDumpList2String(snlist, "\n"),order_buttons(dbuf + ["<<<", "[ main ]", ">>>"]),ichannel);
}
list make_list(integer a,integer b) 
{
  list inventory; integer i;
  for(i = 0; i < b; ++i)
  {
  list items = llParseString2List(llLinksetDataRead("temp-"+(string)(a+i)),["|"],[]);
  string name = llDeleteSubString(llList2String(items,0),40,1000);
  if(name == notecardName){inventory += "null";}else{inventory += llDeleteSubString(name,40,1000);}
  }return inventory;
}
dialog0()
{
if (!num){llMessageLinked(LINK_THIS, 0,"mainmenu_request",""); llOwnerSay("Could not find anything"); return;}
ichannel = llFloor(llFrand(1000000) - 100000); llListenRemove(chanhandlr); chanhandlr = llListen(ichannel, "", NULL_KEY, ""); dialog_songmenu(cur_page);
}
match(string a,string b,string c,integer d){if(~llSubStringIndex(llToLower(b),llToLower(a))){llLinksetDataWrite("temp-"+(string)num,b+"|"+c+"|"+(string)d); num = num + 1;}}
search_engine(string search)
{
num=0;
llLinksetDataDeleteFound("temp-","");
integer x;
integer y0 = (integer)llLinksetDataRead("uuid");
integer y1 = llGetInventoryNumber(INVENTORY_SOUND);
integer y2 = llGetInventoryNumber(INVENTORY_NOTECARD);
for( ; x < y0; x += 1){match(search,llLinksetDataRead("m-"+(string)x),"u",x);} x=0;
for( ; x < y1; x += 1){match(search,llGetInventoryName(INVENTORY_SOUND,x),"s",x);} x=0;
for( ; x < y2; x += 1){match(search,llGetInventoryName(INVENTORY_NOTECARD,x),"n",x);} x=0;
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
    listen(integer chan, string sname, key skey, string text)
    {
    if(skey == llGetOwner()) 
    {
      if(text == "[ main ]"){llMessageLinked(LINK_THIS, 0,"mainmenu_request","");}
      else if(text == ">>>") dialog_songmenu(cur_page+1);
      else if(text == "<<<") dialog_songmenu(cur_page-1);
      else if(llToLower(llGetSubString(text,0,5)) == "play #")
      {
        string a = llLinksetDataRead("temp-"+llGetSubString(text,6,-1));  
        if(a == notecardName){ }else
        {
          list items = llParseString2List(a,["|"], []);
          llSetLinkPrimitiveParamsFast(particle2,[PRIM_DESC,llList2String(items,0)]);
          if(~llSubStringIndex(a,"|"))
          {
          if(readnote(llList2String(items,1),a) == 2){llMessageLinked(LINK_THIS,0,"music_changed","");}
          }else{
          if(readnote(a,a) == 2){llMessageLinked(LINK_THIS,0,"music_changed","");}
          }
        }
        dialog0();
        } 
      } 
    }
    link_message(integer sender_num, integer num, string msg, key id)
    {       
      list params = llParseString2List(msg, ["|"], []);
      if(llList2String(params, 0) == "fetch_note_rationed")
      {
        if(readnote(llList2String(params,1),"null") == 2)
        {
        llMessageLinked(LINK_THIS,0,"music_changed","");
        return;
        }
      }
      list item = llParseString2List(msg,["="],[]);
      if("search_engine"==llList2String(item,0)){ cur_page = 1; search_engine(llList2String(item,1)); dialog0(); }
      if(msg == "[ reset ]"){llResetScript();}
    }
    dataserver(key keyQueryId, string strData)
    {
    if (keyQueryId == keyConfigQueryhandle)
    {
          if (strData == EOF){llMessageLinked(LINK_THIS,0,"music_changed","");}else
          {
             keyConfigQueryhandle = llGetNotecardLine(note_name, ++intLine1);
             llMessageLinked(LINK_THIS,0,"upload_note|" + strData,"");
    }  }  }  }
