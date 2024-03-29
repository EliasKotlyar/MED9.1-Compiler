#include "common.h"


int main ()
{
    // Get Kwp Buffer:
    unsigned char* kwp_buffer;
    register struct kwp_input_struct* r4 asm("r4");
    kwp_buffer = ((unsigned char *)r4->element0);

    // Get Memory Address:
    uint32_t memory_address_var = (uint32_t)kwp_buffer[0] << 16 | (uint32_t)kwp_buffer[1] << 8 | (uint32_t)kwp_buffer[2];
    unsigned char* memory_address_pointer = ((unsigned char *)memory_address_var);
    uint8_t memory_len = (uint8_t)kwp_buffer[3];

    int i;
    for(i = 0; i < memory_len; i++ ){
        memory_address_pointer[i]=kwp_buffer[i+4];
    }

    // 1 means ok, 2 is bad request. Will be added to KWP output code.
    r4->ret_status = 0x1;
    // Msg Len
    r4->msg_len = 0;
    return r4->ret_status;
}