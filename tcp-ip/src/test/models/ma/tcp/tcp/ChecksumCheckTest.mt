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

testsuite ChecksumCheckTest for ChecksumCheck(1500) {
    
     TupelT wrongCs;
     TupelT rightCs;
     ma.tcp.TransportFrame wrongPl;
     ma.tcp.TransportFrame rightPl;
     byte[] ip;
     byte[] bWrongPl;
     byte[] bRightPl;
    
    @Before {
        wrongCs = new TupelT();
        rightCs = new TupelT();
        wrongPl = new ma.tcp.TransportFrame();
        rightPl = new ma.tcp.TransportFrame();
        ip = new byte[]{10,11,12,13};
        bWrongPl = new byte[]{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,1,1,18,19,20,21,22,23,24};
        bRightPl = new byte[]{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,-2,-39,18,19,20,21,22,23,24};
        
        wrongPl.setPayload(bWrongPl);
        wrongCs.setIp(ip);
        wrongCs.setPayload(wrongPl);
        
        rightPl.setPayload(bRightPl);
        rightCs.setIp(ip);
        rightCs.setPayload(rightPl);
    }
    
    test empty{
        input{
            fromInternet: <100*Tk>;
        }
        expect{
            toMainControl: <100*Tk>;
        }
    }
    
    test allRight{
        input{
            fromInternet: <rightCs, Tk>;
        }
        expect{
            toMainControl: <rightCs, Tk>;
        }
    }
    
    test allWrong{
        input{
            fromInternet: <wrongCs, Tk>;
        }
        expect{
            toMainControl: <Tk>;
        }
    }
    
    test both{
        input{
            fromInternet: <rightCs, wrongCs, 2*Tk>;
        }
        expect{
            toMainControl: <rightCs, Tk, Tk>;
        }
    }
    
}

