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

testsuite IpDecapsTest for IpDecaps {

     TupelT tupel;
     IpFrame encapsed;
    
     ma.tcp.TransportFrame decapsed;
     byte[] sourceIp;
     byte[] payload;
     byte[] encapsedPayload;
    
    @Before {
    
        tupel = new TupelT();
        encapsed = new IpFrame();
        decapsed = new ma.tcp.TransportFrame();
        
        sourceIp = new byte[]{0,1,2,3};
        payload = new byte[]{1,1,1,1,1};
        
        //Fill the transportframe
        decapsed.setPayload(payload);
        
        //Fill the tupel
        tupel.setIp(sourceIp);
        tupel.setPayload(decapsed);
        
        //Fill expected frame
        encapsedPayload = new byte[]{70,0,0,29,0,0,64,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        encapsed.setPayload(encapsedPayload);
            
    }
    
    test empty{
        input{
            fromReassembly: <5*Tk>;
        }
        expect{
            toTransport: <5*Tk>;
        }
    }
    
    test decaps{
        input{
            fromReassembly: <encapsed,Tk>;
        }
        expect{
            toTransport: <tupel,Tk>;
        }
    }
    
    test multiple{
        input{
            fromReassembly: <10*encapsed,10*Tk>;
        }
        expect{
            toTransport: <10*(tupel,Tk)>;
        }
    }
    
}