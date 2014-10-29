package ma.tcp.internetProtocol;

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


import ma.tcp.IpFrame;

testsuite IpFragmentIdsTest for IpFragment {
    
    
    //For Stack test Input
     IpFrame itcpFrame;
     IpFrame iSyn;
     IpFrame iSynAck;
     IpFrame iAck1;
     IpFrame iFin;
     IpFrame iFinAck;
     IpFrame iAck2;
     IpFrame iAck;
    
    //For Stack Test output
     IpFrame ftcpFrame;
     IpFrame fSyn;
     IpFrame fSynAck;
     IpFrame fAck1;
     IpFrame fFin;
     IpFrame fFinAck;
     IpFrame fAck2;
     IpFrame fAck;
    
    
    @Before {
        //For Stack Test -- Before fragmentation
        itcpFrame = new IpFrame();
        itcpFrame.setPayload(new byte[]{70,0,0,83,0,0,64,0,-1,6,0,102,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
    
        iSyn = new IpFrame();
        iSyn.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0});
        
        iAck1 = new IpFrame();
        iAck1.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
           iFin = new IpFrame();
        iFin.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0});
        
        iAck2 = new IpFrame();
        iAck2.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
        //For Stack Test -- After fragmentation
        ftcpFrame = new IpFrame();
        ftcpFrame.setPayload(new byte[]{70,0,0,83,0,2,96,0,-1,6,0,102,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
    
        fSyn = new IpFrame();
        fSyn.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0});
        
        fAck1 = new IpFrame();
        fAck1.setPayload(new byte[]{70,0,0,44,0,1,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
        fFin = new IpFrame();
        fFin.setPayload(new byte[]{70,0,0,44,0,3,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0});
        
        fAck2 = new IpFrame();
        fAck2.setPayload(new byte[]{70,0,0,44,0,4,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
                    
    }
    
    //here we check if the sequence numbers rise.
    //fSyn => 0, fAck1 => 1, ftcpFrame => 2, fFin => 3, fAck2 =>4
    test fragmentIds{
        input{
            fromEncaps: <iSyn, Tk, iAck1, Tk, itcpFrame, Tk, iFin, Tk, iAck2, Tk>;
        }
        expect{
            toDataLink: <fSyn, Tk, fAck1, Tk, ftcpFrame, Tk, fFin, Tk, fAck2, Tk>;
        }
    }
}