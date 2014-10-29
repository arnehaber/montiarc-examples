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


import ma.tcp.EtherFrame;
import ma.tcp.IpFrame;
import ma.tcp.DataLinkFrame;

testsuite EtherLlcTest for EtherLlc {

    //IpFrame withoutFrame in should result in EtherFrame withFrame out
     IpFrame iWithoutFrame;
     EtherFrame withFrame;   
    
    //EtherFrame correct in should result in DataLinkFrame dWithoutFrame
    //EtherFrame incorrect in should not result in an output  
     EtherFrame correct;
     EtherFrame incorrect;
     DataLinkFrame dWithoutFrame;
    
     byte[] x;
     byte[] y;
     byte[] z;

    @Before {
        x = new byte[]{1,1,1,1,1,1,1,1,1,1,1,1,0,1,2,3,4,5,5,4,3,2,1,0};
        y = new byte[]{-86, -86, -86, -86, -86, -86, -86, -85, 5, 4, 3, 2, 1, 0, 0, 1, 2, 3, 4, 5, 0, 24, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, -37, 22, -115};
        z = new byte[]{-86,-86,-86,-86,-86,-86,-86,-85,5,4,3,2,1,0,0,1,2,3,4,5,0,24,1,1,1,1,1,1,1,1,1,1,1,1,0,1,2,3,4,5,5,4,3,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-101,-10,81,0};
        
        iWithoutFrame = new IpFrame();
        iWithoutFrame.setPayload(x);
        
        withFrame = new EtherFrame();
        withFrame.setPayload(y);
        
        correct = new EtherFrame();
        correct.setPayload(y);
        
        incorrect = new EtherFrame();
        incorrect.setPayload(z);
        
        dWithoutFrame = new DataLinkFrame();
        dWithoutFrame.setPayload(x);    
    
    }
    
    test empty {
        input {
            fromIp: <10*Tk>;
            fromMac: <10*Tk>;
        }
        expect {
            toIp: <10*Tk>;
            toMac: <10*Tk>;
        }
    }
    
    
    test forward {
        input {
            fromIp: <100*(iWithoutFrame,Tk)>;
            fromMac: <100*Tk>;
        }
        expect {
            toIp: <100*Tk>;
            toMac: <100*(withFrame, Tk)>;
        }
    }
    
    test backwards {
        input {
            fromIp: <100*Tk>;
            fromMac: <100*(correct,Tk)>;
        }
        expect {
            toIp: <100*(dWithoutFrame,Tk)>;
            toMac: <100*Tk>;
        }
    }

}