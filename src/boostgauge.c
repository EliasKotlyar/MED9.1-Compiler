#include "common.h"
int main (void)
{
    int boostGaugeAddress =  0xDEADBEEF;
    int boostGauge = READ_RAM_SHORT(boostGaugeAddress);
    if(boostGauge < 0x8000){
        boostGauge >>= 8;
        boostGauge *= 200;
    }else{
        boostGauge >>= 7;
        boostGauge *= 100;
    }
    boostGauge /= 10;
    boostGauge /= 20;
    return boostGauge;
}