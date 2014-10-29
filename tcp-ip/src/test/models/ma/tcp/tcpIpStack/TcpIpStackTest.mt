package ma.tcp.tcpIpStack;

/*
 * #%L
 * tcp-ip
 * %%
 * Copyright (C) 2013 - 2014 Software Engineering, RWTH Aachen University
 * %%
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Lesser Public License for more details.
 * 
 * You should have received a copy of the GNU General Lesser Public
 * License along with this program.  If not, see
 * <http://www.gnu.org/licenses/lgpl-3.0.html>.
 * #L%
 */


testsuite TcpIpStackTest for TcpIpStack {
    
    /*
     * Like in the http test, we insert the String a.
     * http delivers an TupelBPort with Port 80, ip 100.100.100.100 and payload 71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101
     * this is going in tcp.
     * 1 Tk delay
     * Tcp then generates the syns, etz and passes "syn, Tk, ack1, Tk, encapsed, Tk, fin, Tk, ack2, Tk" on.
     * This will go into IP.
     * 1 Tk delay
     * Ip will encap all this into ip frames and pass "synIP, Tk, ack1IP, Tk, encapsedIP, Tk, finIP, Tk, ack2IP, Tk" on, where xIP means Tcp Package x in an IP Frame
     * 1 Tk delay
     * in ethernet these ip frames will be encapsed into etherframes
     * 1 Tk delay
     * now, in the etherMac, there will be 96 Tks of waiting, and after each frame 521 Tks of checking time.
     * this will now pass on into the manchester decode
     * 1 Tk delay
     * here everything is translated into manchestercode and transmitted
     */
    
    
    
    
    
     String a; 
    
    @Before {
    
        a = "www.bsp.de/test.html";
    
    }
    
}