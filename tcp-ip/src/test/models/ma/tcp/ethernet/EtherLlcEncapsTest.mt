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

testsuite EtherLlcEncapsTest for EtherLlcEncaps {

     IpFrame withoutFrame;
     EtherFrame withFrame;
     byte[] x;
     byte[] y;
    
    @Before {
        x = new byte[]{1,1,1,1,1,1,1,1,1,1,1,1,0,1,2,3,4,5,5,4,3,2,1,0};
        y = new byte[]{-86, -86, -86, -86, -86, -86, -86, -85, 5, 4, 3, 2, 1, 0, 0, 1, 2, 3, 4, 5, 0, 24, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, -37, 22, -115};
        withoutFrame = new IpFrame();
        withFrame = new EtherFrame();
        withoutFrame.setPayload(x);
        withFrame.setPayload(y);
    
    }
    
    test empty {
        input {
            fromIp: <10*Tk>;
        }
        expect {
            toMac: <10*Tk>;
        }
    }
    
    test single {
        input {
            fromIp: <withoutFrame, Tk>;
        }
        expect {
            toMac: <withFrame, Tk>;
        }
    }
    
    test multiple {
        input {
            fromIp: <10*(withoutFrame, Tk)>;
        }
        expect {
            toMac: <10*(withFrame, Tk)>;
        }
    }
    
}
