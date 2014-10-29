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


import ma.tcp.IpFrame;
import ma.tcp.DataLinkFrame;
import ma.tcp.ManchesterSignal;

testsuite EthernetTest for Ethernet {
    
    //IpFrame withoutFrame in should result in EtherFrame withFrame out
     IpFrame inFrame;
     DataLinkFrame outFrame;
     ManchesterSignal d;
     ManchesterSignal u;  
    
    //Payload for IpFrame inFrame
     byte[] x;
    
    @Before {
    
        x = new byte[]{1,1,1,1,1,1,1,1,1,1,1,1,0,1,2,3,4,5,5,4,3,2,1,0};;
        
        inFrame = new IpFrame();
        inFrame.setPayload(x);
        
        outFrame = new DataLinkFrame();
        outFrame.setPayload(x);
        
        d = ManchesterSignal.FALLING;
        u = ManchesterSignal.RISING;
            
    }
    
    test empty{
        input{
            fromIp: <100*Tk>;
            fromBus: <100*Tk>;
        }
        expect{
            toBus: <102*Tk>;
            toIp: <102*Tk>;
        }
    }
    
    test send{
        input{
            fromIp: <inFrame,99*Tk>;
            fromBus: <97*Tk>;
        }
        expect{
            toBus: <98*Tk,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,u,u,u,u,u,u,d,u,u,d,u,u,d,d,d,u,d,u,u,d,u,d,d,d,u,u,d,u, Tk>;
            toIp: <99*Tk>;
        }
    }
    
    test receive{
        input{
            fromIp: <Tk,Tk>;
            fromBus: <u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,u,u,u,u,u,u,d,u,u,d,u,u,d,d,d,u,d,u,u,d,u,d,d,d,u,u,d,u, Tk, Tk>;
            
        }
        expect{
            toBus: <4*Tk>;
            toIp: <3*Tk, outFrame, Tk>;
        }
    }
            
    
}