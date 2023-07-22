float rate = 0.01;
list pattern1 
=[
<0,2,0>,
<0,0,0>
];
integer patternnum1 = 0;
integer step_pattern1 = 5;
integer index_pattern1 = 0;
movement_pattern2()
{
        float percent = (float)index_pattern1 / step_pattern1;
        vector from = llList2Vector (pattern1, patternnum1 - 1) * (1.0 - percent);
        vector to = llList2Vector (pattern1, patternnum1) * percent;
        llSetLinkPrimitiveParamsFast(4, [ PRIM_POS_LOCAL,-(from + to)]);
        index_pattern1 = index_pattern1 + 1;
        if (index_pattern1 >= step_pattern1)
        {
            index_pattern1 = 0;
            patternnum1 = patternnum1 + 1;
            if ( patternnum1 >= llGetListLength (pattern1) )
            patternnum1 = 0;
        }    
}
list pattern 
=[
<0,.5,1.5>,
<0,0,0>
];
integer patternnum = 0;
integer step_pattern = 5;
integer index_pattern = 0;
movement_pattern1()
{
        float percent = (float)index_pattern / step_pattern;
        vector from = llList2Vector (pattern, patternnum - 1) * (1.0 - percent);
        vector to = llList2Vector (pattern, patternnum) * percent;
        llSetLinkPrimitiveParamsFast(2, [ PRIM_POS_LOCAL,-(from + to)]);
        index_pattern = index_pattern + 1;
        if (index_pattern >= step_pattern)
        {
            index_pattern = 0;
            patternnum = patternnum + 1;
            if ( patternnum >= llGetListLength (pattern) )
            patternnum = 0;
        }    
}
list pattern0 
=[
<0,0,0>,
<0,0,2>
];
integer pattern0num = 0;
integer step_pattern0 = 5;
integer index_pattern0 = 0;
movement_pattern0()
{
        float percent = (float)index_pattern0 / step_pattern0;
        vector from = llList2Vector (pattern0, pattern0num - 1) * (1.0 - percent);
        vector to = llList2Vector (pattern0, pattern0num) * percent;
        llSetLinkPrimitiveParamsFast(3, [ PRIM_POS_LOCAL,from + to]);
        index_pattern0 = index_pattern0 + 1;
        if (index_pattern0 >= step_pattern0)
        {
            index_pattern0 = 0;
            pattern0num = pattern0num + 1;
            if ( pattern0num >= llGetListLength (pattern0) )
            pattern0num = 0;
        }    
}
default 
{
    on_rez(integer start_param)
    {   
        if (start_param)
        { 
        llSetLinkPrimitiveParamsFast(LINK_ALL_OTHERS, [ PRIM_POS_LOCAL,<0,0,0>]);
        llSetTimerEvent(rate);
        }
    }
    timer() 
    {
    movement_pattern2();    
    movement_pattern1();
    movement_pattern0();
    }
}