package ma.tcp.tcp;

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


import ma.tcp.TupelT;
import ma.tcp.TransportFrame;

testsuite ChecksumGeneratorForTcpIpTest for ChecksumGenerator(1500) {
    
    //Without Checksum
     TupelT encapsed;
     TupelT syn;
     TupelT synAck;
     TupelT ack1;
     TupelT fin;
     TupelT finAck;
     TupelT ack2;
     TupelT ack;
    
     ma.tcp.TransportFrame tEncapsed;
     ma.tcp.TransportFrame tSyn;
     ma.tcp.TransportFrame tSynAck;
     ma.tcp.TransportFrame tAck1;
     ma.tcp.TransportFrame tFin;
     ma.tcp.TransportFrame tFinAck;
     ma.tcp.TransportFrame tAck2;
     ma.tcp.TransportFrame tAck;
    
    //With Checksum
     TupelT encapsedC;
     TupelT synC;
     TupelT synAckC;
     TupelT ack1C;
     TupelT finC;
     TupelT finAckC;
     TupelT ack2C;
     TupelT ackC;
    
     ma.tcp.TransportFrame tEncapsedC;
     ma.tcp.TransportFrame tSynC;
     ma.tcp.TransportFrame tSynAckC;
     ma.tcp.TransportFrame tAck1C;
     ma.tcp.TransportFrame tFinC;
     ma.tcp.TransportFrame tFinAckC;
     ma.tcp.TransportFrame tAck2C;
     ma.tcp.TransportFrame tAckC;
    
    
    @Before {
    //Without Checksum
        encapsed = new TupelT();
        encapsed.setIp(new byte[]{100,100,100,100});
        tEncapsed = new ma.tcp.TransportFrame();
        tEncapsed.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
        encapsed.setPayload(tEncapsed); 
        
        syn = new TupelT();
        tSyn = new ma.tcp.TransportFrame();
        tSyn.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,0,0,0,0});
        syn.setIp(new byte[]{100,100,100,100});
        syn.setPayload(tSyn);
        
        synAck = new TupelT();
        tSynAck = new ma.tcp.TransportFrame();
        tSynAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,18,0,0,0,0,0,0});
        synAck.setIp(new byte[]{100,100,100,100});
        synAck.setPayload(tSynAck);
        
        ack1 = new TupelT();
        tAck1 = new ma.tcp.TransportFrame();
        tAck1.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0});
        ack1.setIp(new byte[]{100,100,100,100});
        ack1.setPayload(tAck1);
        
        fin = new TupelT();
        tFin = new ma.tcp.TransportFrame();
        tFin.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0});
        fin.setIp(new byte[]{100,100,100,100});
        fin.setPayload(tFin);
        
        finAck = new TupelT();
        tFinAck = new ma.tcp.TransportFrame();
        tFinAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,17,0,0,0,0,0,0});
        finAck.setIp(new byte[]{100,100,100,100});
        finAck.setPayload(tFinAck);
        
        ack2 = new TupelT();
        tAck2 = new ma.tcp.TransportFrame();
        tAck2.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0});
        ack2.setIp(new byte[]{100,100,100,100});
        ack2.setPayload(tAck2);
        
        ack = new TupelT();
        tAck = new ma.tcp.TransportFrame();
        tAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0});
        ack.setIp(new byte[]{100,100,100,100});
        ack.setPayload(tAck);
        
        //With Checksum
        encapsedC = new TupelT();
        encapsedC.setIp(new byte[]{100,100,100,100});
        tEncapsedC = new ma.tcp.TransportFrame();
        tEncapsedC.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
        encapsedC.setPayload(tEncapsedC); 
        
        synC = new TupelT();
        tSynC = new ma.tcp.TransportFrame();
        tSynC.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0});
        synC.setIp(new byte[]{100,100,100,100});
        synC.setPayload(tSynC);
        
        synAckC = new TupelT();
        tSynAckC = new ma.tcp.TransportFrame();
        tSynAckC.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,18,0,0,-3,-49,0,0});
        synAckC.setIp(new byte[]{100,100,100,100});
        synAckC.setPayload(tSynAckC);
        
        ack1C = new TupelT();
        tAck1C = new ma.tcp.TransportFrame();
        tAck1C.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        ack1C.setIp(new byte[]{100,100,100,100});
        ack1C.setPayload(tAck1C);
        
        finC = new TupelT();
        tFinC = new ma.tcp.TransportFrame();
        tFinC.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0});
        finC.setIp(new byte[]{100,100,100,100});
        finC.setPayload(tFinC);
        
        finAckC = new TupelT();
        tFinAckC = new ma.tcp.TransportFrame();
        tFinAckC.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,17,0,0,-3,-48,0,0});
        finAckC.setIp(new byte[]{100,100,100,100});
        finAckC.setPayload(tFinAckC);
        
        ack2C = new TupelT();
        tAck2C = new ma.tcp.TransportFrame();
        tAck2C.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        ack2C.setIp(new byte[]{100,100,100,100});
        ack2C.setPayload(tAck2C);
        
        ackC = new TupelT();
        tAckC = new ma.tcp.TransportFrame();
        tAckC.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        ackC.setIp(new byte[]{100,100,100,100});
        ackC.setPayload(tAckC);
        
    }
    
    test empty{
        input{
            fromMainControl: <100*Tk>;
        }
        expect{
            toInternet: <100*Tk>;
        }
    }
    
    test checksum{
        input{
            fromMainControl: <encapsed, syn, synAck, ack1, fin, finAck, ack2, ack, 8*Tk>;
        }
        expect{
            toInternet: <encapsedC, Tk, synC, Tk, synAckC, Tk, ack1C, Tk, finC, Tk, finAckC, Tk, ack2C, Tk, ackC, Tk>;
        }
    }
    
}

