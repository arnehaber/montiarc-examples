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

testsuite FragmentationTest for Fragmentation(3) {
    /*    Attention:
     *    for this test, we reduced the size of a fragment to 3 byte of data,
     *    because working with the original 1500 bytes of data would not change the component at all,
         but would destroy the purpose of this test
     */    
    
     TupelT in;
     TupelT out1;
     TupelT out2;
     TupelT out3;
     TupelT out4;
    
     ma.tcp.TransportFrame tIn;
     ma.tcp.TransportFrame tOut1;
     ma.tcp.TransportFrame tOut2;
     ma.tcp.TransportFrame tOut3;
     ma.tcp.TransportFrame tOut4;
        
     byte[] ip;
    
     byte[] plIn;
     byte[] plOut1;
     byte[] plOut2;
     byte[] plOut3;
     byte[] plOut4;
    
    @Before {    
        in = new TupelT();
        out1 = new TupelT();
        out2 = new TupelT();
        out3 = new TupelT();
        out4 = new TupelT();
        
        tIn = new ma.tcp.TransportFrame();
        tOut1 = new ma.tcp.TransportFrame();
        tOut2 = new ma.tcp.TransportFrame();
        tOut3 = new ma.tcp.TransportFrame();
        tOut4 = new ma.tcp.TransportFrame();
        
        ip = new byte[]{10,11,12,13};
        
        plIn = new byte[]{0,100,0,100,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1};
        plOut1 = new byte[]{0,100,0,100,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,1,1,1};
        plOut2 = new byte[]{0,100,0,100,0,0,0,1,0,0,0,0,80,0,0,1,0,0,0,0,1,1,1};
        plOut3 = new byte[]{0,100,0,100,0,0,0,2,0,0,0,0,80,0,0,1,0,0,0,0,1,1,1};
        plOut4 = new byte[]{0,100,0,100,0,0,0,3,0,0,0,0,80,0,0,1,0,0,0,0,1};
        
        tIn.setPayload(plIn);
        in.setIp(ip);
        in.setPayload(tIn);
        
        tOut1.setPayload(plOut1);
        out1.setIp(ip);
        out1.setPayload(tOut1);
        
        tOut2.setPayload(plOut2);
        out2.setIp(ip);
        out2.setPayload(tOut2);
        
        tOut3.setPayload(plOut3);
        out3.setIp(ip);
        out3.setPayload(tOut3);
        
        tOut4.setPayload(plOut4);
        out4.setIp(ip);
        out4.setPayload(tOut4);
            
    }
    
    test empty{
        input{
            fromEncaps: <100*Tk>;
        }
        expect{
            toMainControl: <100*Tk>;
        }
    }
    
    test fragmentSize3{
        input{
            fromEncaps: <in, Tk>;
        }
        expect{
            toMainControl: <out1, out2, out3, out4, Tk>;
        }
    }
    
}