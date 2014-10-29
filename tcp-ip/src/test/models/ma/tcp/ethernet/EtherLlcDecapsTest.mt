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
import ma.tcp.DataLinkFrame;

testsuite EtherLlcDecapsTest for EtherLlcDecaps {

     EtherFrame withFrame1;
     EtherFrame withFrame2;
     DataLinkFrame withoutFrame1;
     DataLinkFrame withoutFrame2;
     byte[] x;
     byte[] y;
     byte[] z;
     byte[] p;
    
    @Before {
        withFrame1 = new EtherFrame();
        withFrame2 = new EtherFrame();
        withoutFrame1 = new DataLinkFrame();
        withoutFrame2 = new DataLinkFrame();        
        x = new byte[]{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,0,8,1,1,1,1,1,1,1,1,0,0,0,0,0,0};
        y = new byte[]{1,1,1,1,1,1,1,1};
        z = new byte[]{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,0,20,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,0,0,0,0,0,0};
        p = new byte[]{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
        withFrame1.setPayload(x);
        withFrame2.setPayload(z);
        withoutFrame1.setPayload(y);
        withoutFrame2.setPayload(p);
    }
    
    test empty {
        input {
            fromFrameCheck: <10*Tk>;
        }
        expect {
            toIp: <10*Tk>;
        }
    }
    
    test single {
        input {
            fromFrameCheck: <withFrame1, Tk, withFrame2, Tk>;
        }
        expect {
            toIp: <withoutFrame1, Tk, withoutFrame2, Tk>;
        }
    }
    
    test multiple {
        input {
            fromFrameCheck: <10*(withFrame1, withFrame2, 2* Tk)>;
        }
        expect {
            toIp: <10*(withoutFrame1, Tk, withoutFrame2, Tk)>;
        }
    }
    
}
