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

testsuite FragmentationBigTest for Fragmentation(1500) {
    
     TupelT in;
     TupelT out1;
    
     ma.tcp.TransportFrame tIn;
     ma.tcp.TransportFrame tOut1;
        
     byte[] ip;
    
     byte[] plIn;
     byte[] plOut1;
    
    @Before {    
        in = new TupelT();
        out1 = new TupelT();
        
        tIn = new ma.tcp.TransportFrame();
        tOut1 = new ma.tcp.TransportFrame();
        
        ip = new byte[]{100,100,100,100};
        
        plIn = new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101};
        plOut1 = new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101};
        
        tIn.setPayload(plIn);
        in.setIp(ip);
        in.setPayload(tIn);
        
        tOut1.setPayload(plOut1);
        out1.setIp(ip);
        out1.setPayload(tOut1);
    }
    
    test empty{
        input{
            fromEncaps: <100*Tk>;
        }
        expect{
            toMainControl: <100*Tk>;
        }
    }
    
    test noFrag{
        input{
            fromEncaps: <in, Tk>;
        }
        expect{
            toMainControl: <out1, Tk>;
        }
    }
    
}