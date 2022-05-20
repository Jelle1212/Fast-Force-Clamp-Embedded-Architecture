/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <pid_parameters.h>
#include "platform.h"
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xuartps_hw.h"
#include "xplatform_info.h"
#include "xuartps.h"
#include "xil_io.h"
#include "xparameters.h"
#include "xil_types.h"
#include "xil_printf.h"


void readSerial(){
    int S,P,I,D,N;

	while(1){
	    printf("Setpoint: ");
	    // reads and stores input
	    scanf(" %d", &S);
	    // displays output
	    printf(" %d\n\r", S);  // printing data from hyperterminal
	    printf("P: ");
	    // reads and stores input
	    scanf(" %d", &P);
	    // displays output
	    printf(" %d\n\r", P);
	    printf("I: ");
	    // reads and stores input
	    scanf(" %d", &I);
	    // displays output
	    printf(" %d\n\r", I);  // printing data from hyperterminal
	    printf("D: ");
	    // reads and stores input
	    scanf(" %d", &D);
	    // displays output
	    printf(" %d\n\r", D);  // printing data from hyperterminal
	    printf("N: ");
	    // reads and stores input
	    scanf(" %d", &N);
	    // displays output
	    printf(" %d\n\r", N);  // printing data from hyperterminal
	    PID_PARAMETERS_mWriteReg(XPAR_PID_PARAMETERS_0_S_BASEADDR, PID_PARAMETERS_P_SLV_REG0_OFFSET, S);
	    PID_PARAMETERS_mWriteReg(XPAR_PID_PARAMETERS_0_P_BASEADDR, PID_PARAMETERS_P_SLV_REG0_OFFSET, P);
	    PID_PARAMETERS_mWriteReg(XPAR_PID_PARAMETERS_0_I_BASEADDR, PID_PARAMETERS_P_SLV_REG0_OFFSET, I);
	    PID_PARAMETERS_mWriteReg(XPAR_PID_PARAMETERS_0_D_BASEADDR, PID_PARAMETERS_P_SLV_REG0_OFFSET, D);
	    PID_PARAMETERS_mWriteReg(XPAR_PID_PARAMETERS_0_N_BASEADDR, PID_PARAMETERS_P_SLV_REG0_OFFSET, N);
	    printf("PID settings done\n\r");
	}
}

int main()
{
    init_platform();
    print("______________________PID settings interface______________________\n\r");
    readSerial();
    cleanup_platform();
    return 0;
}
