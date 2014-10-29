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


import ma.tcp.DataLinkFrame;
import ma.tcp.IpFrame;

testsuite IpFrameCheckTest for IpFrameCheck {
    
     DataLinkFrame correct;
     DataLinkFrame incorrect;
     IpFrame ip;
    
     byte[] cPay;
     byte[] iPay;
    
    @Before {
        correct = new DataLinkFrame();
        incorrect = new DataLinkFrame();
        ip = new IpFrame();
        cPay = new byte[]{70,0,0,29,0,0,64,0,-1,6,0,-100,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        iPay = new byte[]{70,0,0,29,0,0,64,0,-1,6,55,55,0,1,2,3,10,11,12,13,0,0,0,0,1,1,1,1,1};
        
        correct.setPayload(cPay);
        incorrect.setPayload(iPay);
        ip.setPayload(cPay);
          
    }
    
    test empty{
        input{
            fromDataLink: <5*Tk>;
        }
        expect{
            toReassembly: <5*Tk>;
        }
    }
    
    test sort{
        input{
            fromDataLink: <correct,Tk, incorrect,Tk>;
        }
        expect{
            toReassembly: <ip, Tk,Tk>;
        }
    }
    
}