default
{
    state_entry()
    {
    llSensorRepeat("", "",( AGENT | ACTIVE ),10, PI,.1);
    }
    no_sensor()
    {
    llLinkParticleSystem(LINK_THIS,[]); 
    }
    sensor( integer detected )
    {
        integer i;
        for (i = 0; i < detected; i++)
        {
            key k = llDetectedKey(i);   
            if(k==llGetOwner()){}else
            {
            llRezObjectWithParams("damage",[REZ_FLAGS,REZ_FLAG_TEMP|REZ_FLAG_NO_COLLIDE_FAMILY|REZ_FLAG_NO_COLLIDE_OWNER,
            REZ_POS,llDetectedPos(i)+(llDetectedVel(i)*0.1)+<0,0,2>,FALSE,FALSE,REZ_VEL,<0,0,-100>,
            FALSE,FALSE,REZ_ROT,ZERO_ROTATION,FALSE,REZ_PARAM,1]);
            }
        }
    }
}
