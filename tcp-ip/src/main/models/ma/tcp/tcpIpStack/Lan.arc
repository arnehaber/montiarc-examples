package ma.tcp.tcpIpStack;
import ma.tcp.tcpIpStack.TcpIpStack;

component Lan {

    port 
        in String from1, 
        in String from2,
        out String to1,
        out String to2;
    
    component TcpIpStack s1, s2;
    
    
    connect from1 -> s1.fromBrowser;
    connect from2 -> s2.fromBrowser;
    
    connect s1.toBus -> s2.fromBus;
    connect s2.toBus -> s1.fromBus;
    
    connect s1.toBrowser -> to1;
    connect s2.toBrowser -> to2;
    
}
