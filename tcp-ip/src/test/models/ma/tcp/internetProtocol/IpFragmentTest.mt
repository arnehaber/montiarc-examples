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

testsuite IpFragmentTest for IpFragment {

     IpFrame ip;
     IpFrame ipO1;
     IpFrame ipO2;
     IpFrame ipO3;
    
     byte[] payload;
     byte[] out1;
     byte[] out2;
     byte[] out3;
    
    
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
    
        ip = new IpFrame();
        ipO1 = new IpFrame();
        ipO2 = new IpFrame();
        ipO3 = new IpFrame();
        
        payload = new byte[]{70,0,0,29,0,0,64,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        out1 = new byte[]{70,0,0,29,0,0,96,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        out2 = new byte[]{70,0,0,29,0,1,96,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        out3 = new byte[]{70,0,0,29,0,2,96,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        
        //Fill expected frame
        ip.setPayload(payload);
        ipO1.setPayload(out1);
        ipO2.setPayload(out2);
        ipO3.setPayload(out3);
        
        
        
        //For Stack Test -- Before fragmentation
        itcpFrame = new IpFrame();
        itcpFrame.setPayload(new byte[]{70,0,0,83,0,0,64,0,-1,6,0,102,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
    
        iSyn = new IpFrame();
        iSyn.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0});
        
           iSynAck = new IpFrame();
        iSynAck.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,1,0,18,0,0,-3,-49,0,0});
        
        iAck1 = new IpFrame();
        iAck1.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
           iFin = new IpFrame();
        iFin.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0});
        
        iFinAck = new IpFrame();
        iFinAck.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,1,0,17,0,0,-3,-48,0,0});
        
        iAck2 = new IpFrame();
        iAck2.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
        iAck = new IpFrame();
        iAck.setPayload(new byte[]{70,0,0,44,0,0,64,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
        //For Stack Test -- After fragmentation
        ftcpFrame = new IpFrame();
        ftcpFrame.setPayload(new byte[]{70,0,0,83,0,0,96,0,-1,6,0,102,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,-16,-2,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
    
        fSyn = new IpFrame();
        fSyn.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,80,2,0,1,-3,-113,0,0});
        
        fSynAck = new IpFrame();
        fSynAck.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,1,0,18,0,0,-3,-49,0,0});
        
        fAck1 = new IpFrame();
        fAck1.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
        fFin = new IpFrame();
        fFin.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,0,0,1,0,0,-3,-31,0,0});
        
        fFinAck = new IpFrame();
        fFinAck.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,0,0,1,0,17,0,0,-3,-48,0,0});
        
        fAck2 = new IpFrame();
        fAck2.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
        
        fAck = new IpFrame();
        fAck.setPayload(new byte[]{70,0,0,44,0,0,96,0,-1,6,0,-115,0,1,2,3,100,100,100,100,0,0,0,0,0,80,0,80,0,0,0,0,0,1,0,0,0,16,0,0,-3,-47,0,0});
    
            
    }
    
    test empty{
        input{
            fromEncaps: <5*Tk>;
        }
        expect{
            toDataLink: <5*Tk>;
        }
    }
    
    test fragment{
        input{
            fromEncaps: <3*(ip, Tk)>;
        }
        expect{
            toDataLink: <ipO1,Tk, ipO2,Tk, ipO3,Tk>;
        }
    }
    
    test fragmentFrame{
        input{
            fromEncaps: <itcpFrame,Tk>;
        }
        expect{
            toDataLink: <ftcpFrame,Tk>;
        }
    }
    
    test fragmentSyn{
        input{
            fromEncaps: <iSyn, Tk>;
        }
        expect{
            toDataLink: <fSyn, Tk>;
        }
    }
    
    test fragmentSynAck{
        input{
            fromEncaps: <iSynAck, Tk>;
        }
        expect{
            toDataLink: <fSynAck, Tk>;
        }
    }
    
    test fragmentAck1{
        input{
            fromEncaps: <iAck1, Tk>;
        }
        expect{
            toDataLink: <fAck1, Tk>;
        }
    }
    
    test fragmentFin{
        input{
            fromEncaps: <iFin, Tk>;
        }
        expect{
            toDataLink: <fFin, Tk>;
        }
    }
    
    test fragmentFinAck{
        input{
            fromEncaps: <iFinAck, Tk>;
        }
        expect{
            toDataLink: <fFinAck, Tk>;
        }
    }
    
    test fragmentAck2{
        input{
            fromEncaps: <iAck2, Tk>;
        }
        expect{
            toDataLink: <fAck2, Tk>;
        }
    }
    
    test fragmentAck{
        input{
            fromEncaps: <iAck, Tk>;
        }
        expect{
            toDataLink: <fAck, Tk>;
        }
    }
}