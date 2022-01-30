#line 1 "D:/ProjektiVezbe/MIPS/WebServer/WebServer.c"




sfr sbit SPI_Ethernet_RST at PORTB.B0;
sfr sbit SPI_Ethernet_CS at PORTB.B1;
sfr sbit SPI_Ethernet_RST_Direction at DDRB.B0;
sfr sbit SPI_Ethernet_CS_Direction at DDRB.B1;

const char httpHeader[] = "HTTP/1.1 200 OK\nContent-type:";
const char httpMimeTypeHTML[] = "text/html\n\n";
const char httpMimeTypeScript[] = "text/plain\n\n";
#line 16 "D:/ProjektiVezbe/MIPS/WebServer/WebServer.c"
char IndexPage[]= "<html><head><title>Tacno vreme</title></head><body><h1>Tacno vreme: </h1><div>SATI : MINUTI</div></body></html>";

char myMacAddress[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f};
char myIpAddress[4] = {192, 168, 20, 60};
char gatewayIpAddress[4] = {192, 168, 20, 6};
char DNSIpAddress[4] = {192, 168, 20, 1};
char subnetMask[4] = {255, 255, 255, 0};

unsigned char getRequest[20];

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort,unsigned int localPort, unsigned int reqLength){
 unsigned int length;
 if(localPort!=80){
 return 0;
 }
 for(length=0;length<15;length++){
 getRequest[length] = SPI_Ethernet_getByte();
 }
 getRequest[length] = 0;
 if(memcmp(getRequest, "GET /", 5)) return(0);
 if(!memcmp(getRequest+11, "ON", 2))
 PORTA.F0 = 1;
 else
 if(!memcmp(getRequest+11, "OFF", 3))
 PORTA.F0 = 0;
 if (PORTA.F0){
 memcpy(indexPage+340, "#FFFF00", 6);
 memcpy(indexPage+431, "#4974E2", 6);
 }
 else{
 memcpy(indexPage+340, "#4974E2", 6);
 memcpy(indexPage+431, "#FFFF00", 6);
 }

 length = SPI_Ethernet_putConstString(httpHeader);
 length += SPI_Ethernet_putConstString(httpMimeTypeHTML);
 length += SPI_Ethernet_putString(indexPage);
 return length;
}

unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort,unsigned int destPort, unsigned int reqLength){
 return 0;
}

static volatile int SEC =0;

static volatile int MINU =0;

static volatile int HOUR =0;

void TimerFunction()
{
TIMSK=(1<<TOIE0);
TCNT0=0x00;
TCCR0 |= (0<<CS02) | (1<<CS00) | (0<<CS01);
}

void main() {
 SREG.SREG_I = 1;
 TimerFunction();
 PORTA0_bit = 0;
 DDRA.F0 = 1;
 SPI1_Init_Advanced(_SPI_MASTER, _SPI_FCY_DIV4, _SPI_CLK_LO_LEADING);
 Spi_Rd_Ptr = SPI1_Read;
 SPI_Ethernet_Init(myMacAddress, myIpAddress,  0x01 );
 SPI_Ethernet_confNetwork(subnetMask, gatewayIpAddress, DNSIpAddress);
 while(1){
 SPI_Ethernet_doPacket();
 }
}
