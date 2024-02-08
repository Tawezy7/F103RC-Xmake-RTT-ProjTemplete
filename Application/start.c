#include "start.h"
#include "main.h"
#include "rtthread.h"

int start()
{
    //rt_kprintf("UART TEST\n");
    while (1)
    {
        HAL_GPIO_TogglePin(GPIOC,GPIO_PIN_0);
        rt_thread_mdelay(1000);
    }
}
