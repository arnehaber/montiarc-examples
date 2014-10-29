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


import ma.tcp.EtherFrame;
import ma.tcp.EtherMsg;

testsuite CsmaCdForStackTest for CsmaCd(10,100) {

    //We reduced the sendTime, to check the whole stream from tcp
    
     EtherFrame eSyn;
     EtherFrame eAck1;
     EtherFrame eFrame;
     EtherFrame eFin;
     EtherFrame eAck2;
    
     EtherMsg syn;
     EtherMsg ack1;
     EtherMsg frame;
     EtherMsg fin;
     EtherMsg ack2;
    
    @Before {
    
        eSyn = new EtherFrame();
        eSyn.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0,0,0,-35,-121,95,-74});
        
        eAck1 = new EtherFrame();
        eAck1.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,1,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0,0,0,113,-7,33,-111});
        
        eFrame = new EtherFrame();
        eFrame.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,83,70,0,0,83,0,2,96,0,-1,6,0,102,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101,-126,-126,109,57});
        
        eFin = new EtherFrame();
        eFin.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,3,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0,0,0,45,-94,3,-122});
        
        eAck2 = new EtherFrame();
        eAck2.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,4,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0,0,0,49,-92,-94,46});
        
        
        syn = new EtherMsg();
        syn.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0,0,0,-35,-121,95,-74});
        
        ack1 = new EtherMsg();
        ack1.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,1,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0,0,0,113,-7,33,-111});
        
        frame = new EtherMsg();
        frame.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,83,70,0,0,83,0,2,96,0,-1,6,0,102,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101,-126,-126,109,57});
        
        fin = new EtherMsg();
        fin.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,3,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0,0,0,45,-94,3,-122});
        
        ack2 = new EtherMsg();
        ack2.setPayload(new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,100,100,0,0,0,0,0,1,2,3,100,100,0,44,70,0,0,44,0,4,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0,0,0,49,-92,-94,46});
        
    }
        
    test send {
        input {
            fromLlc: <eSyn, Tk, eAck1, Tk, eFrame, Tk, eFin, Tk, eAck2, Tk, 510*Tk>;
            fromPs:  <515*Tk>;
        }
        expect {
            toPs: <10*Tk, eSyn, Tk, 100*Tk, eAck1, Tk, 100*Tk, eFrame, Tk, 100*Tk, eFin, Tk, 100*Tk, eAck2, Tk, 100*Tk>;
            toLlc: <515*Tk>;
        }    
    }
    
    test receive {
        input {
            fromLlc: <6*Tk>;
            fromPs:  <syn, Tk, ack1, Tk, frame, Tk, fin, Tk, ack2, Tk, Tk>;
        }
        expect {
            toPs: <6*Tk>;
            toLlc: <Tk, eSyn, Tk, eAck1, Tk, eFrame, Tk, eFin, Tk, eAck2, Tk>;
        }    
    }
    
}