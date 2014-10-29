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

testsuite ChecksumGeneratorTest for ChecksumGenerator(1500) {
    
     TupelT withoutCs;
     TupelT withCs;
     ma.tcp.TransportFrame tupelPlWithout;
     ma.tcp.TransportFrame tupelPlWith;
     byte[] ip;
     byte[] plWithout;
     byte[] plWith;
    
    @Before {
        withoutCs = new TupelT();
        withCs = new TupelT();
        tupelPlWithout = new ma.tcp.TransportFrame();
        tupelPlWith = new ma.tcp.TransportFrame();
        ip = new byte[]{10,11,12,13};
        plWithout = new byte[]{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0,0,18,19,20,21,22,23,24};
        plWith = new byte[]{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,-2,-39,18,19,20,21,22,23,24};
        
        tupelPlWithout.setPayload(plWithout);
        withoutCs.setIp(ip);
        withoutCs.setPayload(tupelPlWithout);
        
        tupelPlWith.setPayload(plWith);
        withCs.setIp(ip);
        withCs.setPayload(tupelPlWith);
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
            fromMainControl: <5*withoutCs, 5*Tk>;
        }
        expect{
            toInternet: <5*(withCs,Tk)>;
        }
    }
    
}

