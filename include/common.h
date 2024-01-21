#include <stdint.h>
#define READ_RAM_BYTE(address) (*((uint8_t *)(address)))
#define WRITE_RAM_BYTE(address, value) (*((uint8_t *)(address)) = (value))
#define READ_RAM_SHORT(address) (*((uint16_t *)(address)))
#define WRITE_RAM_SHORT(address, value) (*((uint16_t *)(address)) = (value))
#define READ_RAM_INT(address) (*((uint32_t *)(address)))
#define WRITE_RAM_INT(address, value) (*((uint32_t *)(address)) = (value))



// Used by Ramreader
struct kwp_input_struct {
    uint32_t element0;
    uint8_t element4;
    uint8_t element5;
    uint8_t element6;
    uint8_t element7;
    uint16_t msg_len;  // Offset 0x8
    uint8_t  ret_status;  // Offset 0xA
};