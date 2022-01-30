#define SPI_Ethernet_HALFDUPLEX 0x00
#define SPI_Ethernet_FULLDUPLEX 0x01


sfr sbit SPI_Ethernet_RST at PORTA.B6;
sfr sbit SPI_Ethernet_CS at PORTA.B5;
sfr sbit SPI_Ethernet_RST_Direction at DDRA.B6;
sfr sbit SPI_Ethernet_CS_Direction at DDRA.B5;

typedef struct {
        unsigned canCloseTCP: 1;
        unsigned isBroadcast: 1;
}  TEthPktFlags;

const char httpHeader[] = "HTTP/1.1 200 OK\nContent-type:";
const char httpMimeTypeHTML[] = "text/html\n\n";
const char httpMimeTypeScript[] = "text/plain\n\n";


char IndexPage[]= "<!DOCTYPE html><html><head><title>Tacno vreme</title></head><body>\
<h1>Tacno vreme: </h1><div id='clock'>HOURS : MINUTES</div><script>\
setInterval(showTime,1000);\
function showTime(){\
let date = new Date();\
let hh = date.getHours();\
let mm = date.getMinutes();     \
let ss = date.getSeconds(); \
let currentTime = hh + ':' + mm + ':' + ss;\
document.getElementById('clock').innerHTML = currentTime;\
};         \
showTime();\
\</script></body></html>";

char myMacAddress[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f};
char myIpAddress[4] = {192, 168, 20, 60};
char gatewayIpAddress[4] = {192, 168, 20, 1};
char DNSIpAddress[4] = {192, 168, 20, 1};
char subnetMask[4] = {255, 255, 255, 0};

unsigned char getRequest[20];

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags){
         unsigned int length = 0;
         if(localPort!=80){
            return 0;
         }
         for(length=0;length<15;length++){
            getRequest[length] = SPI_Ethernet_getByte();
         }
         getRequest[length] = 0;
         if(memcmp(getRequest, "GET /", 5)) {return(0);}
         else{
                      length = SPI_Ethernet_putConstString(httpHeader);
                      length += SPI_Ethernet_putConstString(httpMimeTypeHTML);
                      length += SPI_Ethernet_putString(indexPage);
         }

         return length;
}

unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort,unsigned int localPort, unsigned int reqLength,TEthPktFlags *flags){
         return 0;
}



void main() {
      PORTC.B0 = 0;
      PORTA.B1 = 1;
      DDRC = 1;
      SPI1_Init_Advanced(_SPI_MASTER, _SPI_FCY_DIV8, _SPI_CLK_LO_LEADING);
      Spi_Rd_Ptr = SPI1_Read;
      SPI_Ethernet_Init(myMacAddress, myIpAddress, SPI_Ethernet_FULLDUPLEX);
      SPI_Ethernet_confNetwork(subnetMask, gatewayIpAddress, DNSIpAddress);
      while(1){
               SPI_Ethernet_doPacket();
      }
}