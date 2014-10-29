package ma.tcp.ethernet;

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


import ma.tcp.EtherMsg;
import ma.tcp.ManchesterSignal;

testsuite ManchesterDecodeForStackTest for ManchesterDecode {

     EtherMsg eSyn;
     EtherMsg eAck1;
     EtherMsg eFrame;
     EtherMsg eFin;
     EtherMsg eAck2; 

     ManchesterSignal d;
     ManchesterSignal u;
    
    @Before {
        
        eSyn = new EtherMsg();
        eSyn.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0,0,0,-35,-121,95,-74});
        
        eAck1 = new EtherMsg();
        eAck1.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,1,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0,0,0,113,-7,33,-111});
        
        eFrame = new EtherMsg();
        eFrame.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,83,70,0,0,83,0,2,96,0,-1,6,0,102,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101,-126,-126,109,57});
        
        eFin = new EtherMsg();
        eFin.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,3,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0,0,0,45,-94,3,-122});
        
        eAck2 = new EtherMsg();
        eAck2.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,4,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0,0,0,49,-92,-94,46});
        
    
        d = ManchesterSignal.FALLING;
        u = ManchesterSignal.RISING;
    }
    
    test testSyn {
        input {
            fromBus: <u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,u,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,u,u,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,u,d,d,d,u,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,u,d,u,u,d,d,d,u,u,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,d,u,u,u,d,u,u,d,d,d,d,u,u,u,d,u,d,u,u,u,u,u,u,d,u,u,d,u,u,d,Tk>;
        }            
        expect {
            toMac: <eSyn,Tk>;
        }
    }
    
    test testAck1 {
        input {
            fromBus: <u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,u,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,u,u,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,u,d,d,d,u,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,d,u,u,u,d,u,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,d,d,d,u,u,u,u,u,u,d,d,u,d,d,u,d,d,d,d,u,u,d,d,u,d,d,d,u,Tk>;
        }
        expect {
            toMac: <eAck1,Tk>;
        }
    }
    
    test testFrame {
        input {
            fromBus: <u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,u,u,d,u,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,u,u,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,u,u,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,d,d,d,d,u,u,u,u,u,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,u,u,u,d,u,d,d,d,u,d,u,d,u,d,u,d,u,d,d,d,d,u,d,d,d,d,d,d,u,u,u,d,u,d,d,d,u,u,d,d,u,d,u,d,u,u,u,d,d,u,u,d,u,u,u,d,u,d,d,d,d,u,d,u,u,u,d,d,u,u,d,u,d,d,d,d,u,u,u,d,u,d,d,d,u,u,d,u,u,d,u,d,u,u,d,u,u,d,d,d,d,u,d,d,d,d,d,d,u,d,d,u,d,d,d,d,u,d,u,d,u,d,d,d,u,d,u,d,u,d,d,d,u,d,u,d,d,d,d,d,d,u,d,u,u,u,u,d,d,u,u,d,d,d,u,d,d,u,d,u,u,u,d,d,d,u,u,d,d,d,u,d,d,d,d,u,d,u,d,d,u,d,d,u,d,d,d,d,u,u,d,u,u,u,u,d,u,u,u,d,d,u,u,d,u,u,u,d,u,d,d,d,d,u,u,u,d,u,d,d,d,u,d,d,d,d,d,d,u,u,u,d,u,u,u,d,u,u,u,d,u,u,u,d,u,u,u,d,u,u,u,d,d,u,d,u,u,u,d,d,u,u,d,d,d,u,d,d,u,u,u,d,d,u,u,d,u,u,u,d,d,d,d,d,d,u,d,u,u,u,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,u,u,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,d,u,u,d,u,u,d,u,d,d,u,u,u,d,d,u,Tk>;
        }
        expect {
            toMac: <eFrame,Tk>;
        }
    }
    
    test testFin {
        input {
            fromBus: <u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,u,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,u,u,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,u,d,d,d,u,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,d,u,u,u,u,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,u,u,d,u,d,d,d,u,d,d,d,d,d,d,d,u,u,u,d,d,d,d,u,u,d,Tk>;
        }
        expect {
            toMac: <eFin,Tk>;
        }
    }
    
    test testAck2 {
        input {
            fromBus: <u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,u,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,u,u,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,u,d,d,d,u,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,u,u,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,u,u,u,u,d,u,u,u,d,u,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,u,d,d,d,u,u,d,u,d,d,u,d,d,u,d,u,d,d,d,u,d,d,d,u,d,u,u,u,d,Tk>;
        }
        expect {
            toMac: <eAck2,Tk>;
        }
    }   
}
