
_SPI_Ethernet_UserTCP:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;WebServer.c,26 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort,unsigned int localPort, unsigned int reqLength){
;WebServer.c,28 :: 		if(localPort!=80){
	LDI        R27, 0
	CP         R7, R27
	BRNE       L__SPI_Ethernet_UserTCP13
	LDI        R27, 80
	CP         R6, R27
L__SPI_Ethernet_UserTCP13:
	BRNE       L__SPI_Ethernet_UserTCP14
	JMP        L_SPI_Ethernet_UserTCP0
L__SPI_Ethernet_UserTCP14:
;WebServer.c,29 :: 		return 0;
	LDI        R16, 0
	LDI        R17, 0
	JMP        L_end_SPI_Ethernet_UserTCP
;WebServer.c,30 :: 		}
L_SPI_Ethernet_UserTCP0:
;WebServer.c,31 :: 		for(length=0;length<15;length++){
; length start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
; length end address is: 19 (R19)
L_SPI_Ethernet_UserTCP1:
; length start address is: 19 (R19)
	CPI        R20, 0
	BRNE       L__SPI_Ethernet_UserTCP15
	CPI        R19, 15
L__SPI_Ethernet_UserTCP15:
	BRLO       L__SPI_Ethernet_UserTCP16
	JMP        L_SPI_Ethernet_UserTCP2
L__SPI_Ethernet_UserTCP16:
;WebServer.c,32 :: 		getRequest[length] = SPI_Ethernet_getByte();
	LDI        R16, #lo_addr(_getRequest+0)
	LDI        R17, hi_addr(_getRequest+0)
	ADD        R16, R19
	ADC        R17, R20
	STD        Y+0, R16
	STD        Y+1, R17
	PUSH       R20
	PUSH       R19
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	CALL       _SPI_Ethernet_getByte+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	POP        R8
	POP        R9
	POP        R19
	POP        R20
	LDD        R17, Y+0
	LDD        R18, Y+1
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;WebServer.c,31 :: 		for(length=0;length<15;length++){
	MOV        R16, R19
	MOV        R17, R20
	SUBI       R16, 255
	SBCI       R17, 255
	MOV        R19, R16
	MOV        R20, R17
;WebServer.c,33 :: 		}
	JMP        L_SPI_Ethernet_UserTCP1
L_SPI_Ethernet_UserTCP2:
;WebServer.c,34 :: 		getRequest[length] = 0;
	LDI        R16, #lo_addr(_getRequest+0)
	LDI        R17, hi_addr(_getRequest+0)
	MOV        R30, R19
	MOV        R31, R20
	ADD        R30, R16
	ADC        R31, R17
; length end address is: 19 (R19)
	LDI        R27, 0
	ST         Z, R27
;WebServer.c,35 :: 		if(memcmp(getRequest, "GET /", 5)) return(0);
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 5
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(?lstr1_WebServer+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_WebServer+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_getRequest+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_getRequest+0)
	MOV        R3, R27
	CALL       _memcmp+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__SPI_Ethernet_UserTCP17
	JMP        L_SPI_Ethernet_UserTCP4
L__SPI_Ethernet_UserTCP17:
	LDI        R16, 0
	LDI        R17, 0
	JMP        L_end_SPI_Ethernet_UserTCP
L_SPI_Ethernet_UserTCP4:
;WebServer.c,36 :: 		if(!memcmp(getRequest+11, "ON", 2))
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 2
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(?lstr2_WebServer+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_WebServer+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_getRequest+11)
	MOV        R2, R27
	LDI        R27, hi_addr(_getRequest+11)
	MOV        R3, R27
	CALL       _memcmp+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__SPI_Ethernet_UserTCP18
	JMP        L_SPI_Ethernet_UserTCP5
L__SPI_Ethernet_UserTCP18:
;WebServer.c,37 :: 		PORTA.F0 = 1;
	IN         R27, PORTA+0
	SBR        R27, 1
	OUT        PORTA+0, R27
	JMP        L_SPI_Ethernet_UserTCP6
L_SPI_Ethernet_UserTCP5:
;WebServer.c,39 :: 		if(!memcmp(getRequest+11, "OFF", 3))
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 3
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(?lstr3_WebServer+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr3_WebServer+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_getRequest+11)
	MOV        R2, R27
	LDI        R27, hi_addr(_getRequest+11)
	MOV        R3, R27
	CALL       _memcmp+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__SPI_Ethernet_UserTCP19
	JMP        L_SPI_Ethernet_UserTCP7
L__SPI_Ethernet_UserTCP19:
;WebServer.c,40 :: 		PORTA.F0 = 0;
	IN         R27, PORTA+0
	CBR        R27, 1
	OUT        PORTA+0, R27
L_SPI_Ethernet_UserTCP7:
L_SPI_Ethernet_UserTCP6:
;WebServer.c,41 :: 		if (PORTA.F0){
	IN         R27, PORTA+0
	SBRS       R27, 0
	JMP        L_SPI_Ethernet_UserTCP8
;WebServer.c,42 :: 		memcpy(indexPage+340, "#FFFF00", 6);
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 6
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(?lstr4_WebServer+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr4_WebServer+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_IndexPage+340)
	MOV        R2, R27
	LDI        R27, hi_addr(_IndexPage+340)
	MOV        R3, R27
	CALL       _memcpy+0
;WebServer.c,43 :: 		memcpy(indexPage+431, "#4974E2", 6);
	LDI        R27, 6
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(?lstr5_WebServer+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_WebServer+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_IndexPage+431)
	MOV        R2, R27
	LDI        R27, hi_addr(_IndexPage+431)
	MOV        R3, R27
	CALL       _memcpy+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
;WebServer.c,44 :: 		}
	JMP        L_SPI_Ethernet_UserTCP9
L_SPI_Ethernet_UserTCP8:
;WebServer.c,46 :: 		memcpy(indexPage+340, "#4974E2", 6);
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 6
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(?lstr6_WebServer+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr6_WebServer+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_IndexPage+340)
	MOV        R2, R27
	LDI        R27, hi_addr(_IndexPage+340)
	MOV        R3, R27
	CALL       _memcpy+0
;WebServer.c,47 :: 		memcpy(indexPage+431, "#FFFF00", 6);
	LDI        R27, 6
	MOV        R6, R27
	LDI        R27, 0
	MOV        R7, R27
	LDI        R27, #lo_addr(?lstr7_WebServer+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr7_WebServer+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_IndexPage+431)
	MOV        R2, R27
	LDI        R27, hi_addr(_IndexPage+431)
	MOV        R3, R27
	CALL       _memcpy+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
;WebServer.c,48 :: 		}
L_SPI_Ethernet_UserTCP9:
;WebServer.c,50 :: 		length = SPI_Ethernet_putConstString(httpHeader);
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(_httpHeader+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_httpHeader+0)
	MOV        R3, R27
	CALL       _SPI_Ethernet_putConstString+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	POP        R8
	POP        R9
; length start address is: 18 (R18)
	MOVW       R18, R16
;WebServer.c,51 :: 		length += SPI_Ethernet_putConstString(httpMimeTypeHTML);
	PUSH       R19
	PUSH       R18
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(_httpMimeTypeHTML+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_httpMimeTypeHTML+0)
	MOV        R3, R27
	CALL       _SPI_Ethernet_putConstString+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	POP        R8
	POP        R9
	POP        R18
	POP        R19
	ADD        R16, R18
	ADC        R17, R19
	MOVW       R18, R16
;WebServer.c,52 :: 		length += SPI_Ethernet_putString(indexPage);
	PUSH       R19
	PUSH       R18
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(_IndexPage+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_IndexPage+0)
	MOV        R3, R27
	CALL       _SPI_Ethernet_putString+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	POP        R8
	POP        R9
	POP        R18
	POP        R19
	ADD        R16, R18
	ADC        R17, R19
; length end address is: 18 (R18)
;WebServer.c,53 :: 		return length;
;WebServer.c,54 :: 		}
L_end_SPI_Ethernet_UserTCP:
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _SPI_Ethernet_UserTCP

_SPI_Ethernet_UserUDP:

;WebServer.c,56 :: 		unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort,unsigned int destPort, unsigned int reqLength){
;WebServer.c,57 :: 		return 0;
	LDI        R16, 0
	LDI        R17, 0
;WebServer.c,58 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RET
; end of _SPI_Ethernet_UserUDP

_TimerFunction:

;WebServer.c,66 :: 		void TimerFunction()
;WebServer.c,68 :: 		TIMSK=(1<<TOIE0);
	LDI        R27, 1
	OUT        TIMSK+0, R27
;WebServer.c,69 :: 		TCNT0=0x00;
	LDI        R27, 0
	OUT        TCNT0+0, R27
;WebServer.c,70 :: 		TCCR0 |= (0<<CS02) | (1<<CS00) | (0<<CS01);
	IN         R16, TCCR0+0
	ORI        R16, 1
	OUT        TCCR0+0, R16
;WebServer.c,71 :: 		}
L_end_TimerFunction:
	RET
; end of _TimerFunction

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;WebServer.c,73 :: 		void main() {
;WebServer.c,74 :: 		SREG.SREG_I = 1; // enable interupt
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	IN         R27, SREG+0
	SBR        R27, 128
	OUT        SREG+0, R27
;WebServer.c,75 :: 		TimerFunction();
	CALL       _TimerFunction+0
;WebServer.c,76 :: 		PORTA0_bit = 0;
	IN         R27, PORTA0_bit+0
	CBR        R27, BitMask(PORTA0_bit+0)
	OUT        PORTA0_bit+0, R27
;WebServer.c,77 :: 		DDRA.F0 = 1;
	IN         R27, DDRA+0
	SBR        R27, 1
	OUT        DDRA+0, R27
;WebServer.c,78 :: 		SPI1_Init_Advanced(_SPI_MASTER, _SPI_FCY_DIV4, _SPI_CLK_LO_LEADING);
	CLR        R4
	CLR        R3
	LDI        R27, 16
	MOV        R2, R27
	CALL       _SPI1_Init_Advanced+0
;WebServer.c,79 :: 		Spi_Rd_Ptr = SPI1_Read;
	LDI        R27, #lo_addr(_SPI1_Read+0)
	STS        _SPI_Rd_Ptr+0, R27
	LDI        R27, hi_addr(_SPI1_Read+0)
	STS        _SPI_Rd_Ptr+1, R27
;WebServer.c,80 :: 		SPI_Ethernet_Init(myMacAddress, myIpAddress, SPI_Ethernet_FULLDUPLEX);
	LDI        R27, 1
	MOV        R6, R27
	LDI        R27, #lo_addr(_myIpAddress+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_myIpAddress+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_myMacAddress+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_myMacAddress+0)
	MOV        R3, R27
	CALL       _SPI_Ethernet_Init+0
;WebServer.c,81 :: 		SPI_Ethernet_confNetwork(subnetMask, gatewayIpAddress, DNSIpAddress);
	LDI        R27, #lo_addr(_DNSIpAddress+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_DNSIpAddress+0)
	MOV        R7, R27
	LDI        R27, #lo_addr(_gatewayIpAddress+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_gatewayIpAddress+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_subnetMask+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_subnetMask+0)
	MOV        R3, R27
	CALL       _SPI_Ethernet_confNetwork+0
;WebServer.c,82 :: 		while(1){
L_main10:
;WebServer.c,83 :: 		SPI_Ethernet_doPacket();
	CALL       _SPI_Ethernet_doPacket+0
;WebServer.c,84 :: 		}
	JMP        L_main10
;WebServer.c,85 :: 		}
L_end_main:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
