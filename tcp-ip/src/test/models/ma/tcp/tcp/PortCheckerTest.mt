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

testsuite PortCheckerTest for PortChecker {
    
     TupelT tupel80;
     TupelT tupelNot80;
    
     ma.tcp.TransportFrame frame80;
     ma.tcp.TransportFrame frameNot80;
    
     byte[] ip;
     byte[] pl80;
     byte[] plNot80;
    
    @Before {
          ip = new byte[]{10,11,12,13};
          pl80 = new byte[]{0,0,0,80,0};
          plNot80 = new byte[]{0,0,0,79,0};
          
          frame80 = new ma.tcp.TransportFrame();
          frameNot80 = new ma.tcp.TransportFrame();
          
          frame80.setPayload(pl80);
          frameNot80.setPayload(plNot80);
          
          tupel80 = new TupelT();
          tupelNot80 = new TupelT();
          
          tupel80.setIp(ip);
          tupelNot80.setIp(ip);         
          
          tupel80.setPayload(frame80);
          tupelNot80.setPayload(frameNot80);
    }
    
    test empty{
        input{
            fromMainControl: <5*Tk>;
        }
        expect{
            toDecaps: <5*Tk>;
        }
    }
    
    test sort{
        input{
            fromMainControl: <tupel80, Tk, tupelNot80, Tk>;
        }
        expect{
            toDecaps: <tupel80, Tk, Tk>;
        }
    }
    
}