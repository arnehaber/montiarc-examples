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


import ma.tcp.TupelT;
import ma.tcp.IpFrame;
import ma.tcp.TransportFrame;
import ma.tcp.DataLinkFrame;

testsuite IpTest for Ip {
    
    //Tupels are the object coming from and going to the ip side
     TupelT tupelIn;
     TupelT tupelOut;
    
    //ips O1-O3 are the ones going out on the DataLink side
     IpFrame ipO1;
     IpFrame ipO2;
     IpFrame ipO3;
    
    //DataLinkFrames going in on the DataLink side
     DataLinkFrame correct;
     DataLinkFrame incorrect;
    
    //Transportframes from the tupels
     ma.tcp.TransportFrame tpIn;
     ma.tcp.TransportFrame tpOut;
    
    //DestIp is the ip in the incoming, sourceIp the one in the outgoing
     byte[] sourceIp;
     byte[] destIp;
    
    //Payloads are the data of the transportframes
     byte[] payloadIn;
     byte[] payloadOut;        
    
    //Payloads of the outgoing IpFrames
     byte[] out1;
     byte[] out2;
     byte[] out3;
    
    //Payload of the incoming DataLinkFrames
     byte[] cPay;
     byte[] iPay;
    
    
   @Before {
    
        //Initialize
        tupelIn = new TupelT();
        tupelOut = new TupelT();;
    
        ipO1 = new IpFrame();
        ipO2 = new IpFrame();
        ipO3 = new IpFrame();
        
        correct = new DataLinkFrame();
        incorrect = new DataLinkFrame();
        
        tpIn = new ma.tcp.TransportFrame();
        tpOut = new ma.tcp.TransportFrame();
        
        sourceIp = new byte[]{0,1,2,3};
        destIp = new byte[]{10,11,12,13};
        
        //Redundant, but helps keep an ordner in here
        payloadIn = new byte[]{1,1,1,1,1};
        payloadOut = new byte[]{1,1,1,1,1};        
        
        out1 = new byte[]{70,0,0,29,0,0,96,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        out2 = new byte[]{70,0,0,29,0,1,96,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        out3 = new byte[]{70,0,0,29,0,2,96,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        
        cPay = new byte[]{70,0,0,29,0,0,64,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        iPay = new byte[]{70,0,0,29,0,0,64,0,-1,6,55,55,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        
        
        //Fill the complex datatypes with payloads
        tupelIn.setIp(destIp);
        tpIn.setPayload(payloadIn);
        tupelIn.setPayload(tpIn);
        
        tupelOut.setIp(sourceIp);
        tpOut.setPayload(payloadOut);
        tupelOut.setPayload(tpOut);
        
        ipO1.setPayload(out1);
        ipO2.setPayload(out2);
        ipO3.setPayload(out3);
        
        correct.setPayload(cPay);
        incorrect.setPayload(iPay);
            
    }    
    
    
    test empty{
        input{
            fromTransport: <5*Tk>;
            fromDataLink: <5*Tk>;
        }
        expect{
            toTransport: <5*Tk>;
            toDataLink: <5*Tk>;
        }
    }
    
    test sendOnly{
        input{
            fromTransport: <3*(tupelIn, Tk)>;
            fromDataLink: <3*Tk>;
        }
        expect{
            toTransport: <3*Tk>;
            toDataLink: <ipO1,Tk, ipO2, Tk, ipO3, Tk>;
        }
    }
    
    test receiveOnly{
        input{
            fromTransport: <5*Tk>;
            fromDataLink: <correct,Tk, incorrect, Tk>;
        }
        expect{
            toTransport: <tupelOut,Tk,Tk>;
            toDataLink: <5*Tk>;
        }
    }
    
    test mixed{
        input{
            fromTransport: <3*(tupelIn, Tk)>;
            fromDataLink: <correct,Tk, incorrect, Tk>;
        }
        expect{
            toTransport: <tupelOut,Tk,Tk>;
            toDataLink: <ipO1,Tk, ipO2, Tk, ipO3, Tk>;
        }
    }
    
}