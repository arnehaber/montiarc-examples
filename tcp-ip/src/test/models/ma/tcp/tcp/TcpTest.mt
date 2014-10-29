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
import ma.tcp.TupelB;
import ma.tcp.TupelBPort;

testsuite TcpTest for Tcp {
    
    /*
     * Since we tested, if the MainControl works appropriately, we only need to check, if the whole TCP component
     * correctly takes a TupelBPort which represents bytes from the Application Layer and puts them out as the
     * expected TupelT.
     * Since we know, encaps, fragmentation etc work, we just test a single input frame for its output.
     * Also we test a single TupelT from the IP layer on its journey to the application layer.
     */
    
    
     TupelBPort decapsed;
     TupelB decapsed2;
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
    
    @Before {
        decapsed = new TupelBPort();
        decapsed.setPort(80);
        decapsed.setIp(new byte[]{100,100,100,100});
        decapsed.setPayload(new byte[]{71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101}); 
        
        decapsed2 = new TupelB();
        decapsed2.setIp(new byte[]{100,100,100,100});
        decapsed2.setPayload(new byte[]{71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101}); 
        
        encapsed = new TupelT();
        encapsed.setIp(new byte[]{100,100,100,100});
        tEncapsed = new ma.tcp.TransportFrame();
        tEncapsed.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
        encapsed.setPayload(tEncapsed);
        
        syn = new TupelT();
        tSyn = new ma.tcp.TransportFrame();
        tSyn.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0});
        syn.setIp(new byte[]{100,100,100,100});
        syn.setPayload(tSyn);
        
        synAck = new TupelT();
        tSynAck = new ma.tcp.TransportFrame();
        tSynAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,18,0,0,-3,-49,0,0});
        synAck.setIp(new byte[]{100,100,100,100});
        synAck.setPayload(tSynAck);
        
        ack1 = new TupelT();
        tAck1 = new ma.tcp.TransportFrame();
        tAck1.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        ack1.setIp(new byte[]{100,100,100,100});
        ack1.setPayload(tAck1);
        
        fin = new TupelT();
        tFin = new ma.tcp.TransportFrame();
        tFin.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0});
        fin.setIp(new byte[]{100,100,100,100});
        fin.setPayload(tFin);
        
        finAck = new TupelT();
        tFinAck = new ma.tcp.TransportFrame();
        tFinAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,1,0,17,0,0,-3,-48,0,0});
        finAck.setIp(new byte[]{100,100,100,100});
        finAck.setPayload(tFinAck);
        
        ack2 = new TupelT();
        tAck2 = new ma.tcp.TransportFrame();
        tAck2.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        ack2.setIp(new byte[]{100,100,100,100});
        ack2.setPayload(tAck2);
        
        ack = new TupelT();
        tAck = new ma.tcp.TransportFrame();
        tAck.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        ack.setIp(new byte[]{100,100,100,100});
        ack.setPayload(tAck);
    }
    
    test empty{
        input{
            fromApp: <100*Tk>;
            fromInternet: <100*Tk>;
        }
        expect{
            toInternet: <100*Tk>;
            toApp: <100*Tk>;
        }
    }
    
    test threeWayHandshake{
        input{
            fromApp: <decapsed, 5*Tk>;
            fromInternet: <Tk, synAck, Tk, Tk, Tk, finAck, Tk>;
        }
        expect{
            toInternet: <syn, Tk, ack1, Tk, encapsed, Tk, fin, Tk, ack2, Tk>;
            toApp: <5*Tk>;
        }
    }
    
    test Receive{
        input{
            fromApp: <5*Tk>;
            fromInternet: <encapsed, 5*Tk>;
        }
        expect{
            toInternet: <ack, 5*Tk>;
            toApp: <decapsed2, 5*Tk>;
        }
    }
    
}