#include "common.h"
void mapswitch (void)
{
    int B_fgr = 0xDEADBEEF;
    int vkKraQu = 0xDEADBEEF;
    uint8_t cruise_enabled = READ_RAM_BYTE(B_fgr);
    if(cruise_enabled == 1){
        WRITE_RAM_BYTE(vkKraQu,1);
    }else{
        WRITE_RAM_BYTE(vkKraQu,0);
    }
}
