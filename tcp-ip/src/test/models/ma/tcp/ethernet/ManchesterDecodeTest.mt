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


import ma.tcp.EtherMsg;
import ma.tcp.ManchesterSignal;

testsuite ManchesterDecodeTest for ManchesterDecode {

     EtherMsg p;
     EtherMsg q;
     ManchesterSignal d;
     ManchesterSignal u;
     byte[] x;
     byte[] y;
    
    @Before {
        p = new EtherMsg();
        q = new EtherMsg();
                       
        x = new byte[]{0,1,2};
        y = new byte[]{-86, -86, -86, -86, -86, -86, -86, -85, 5, 4, 3, 2, 1, 0, 0, 1, 2, 3, 4, 5, 0, 24, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, -37, 22, -115};
        p.setPayload(x);
        q.setPayload(y);
        d = ManchesterSignal.FALLING;
        u = ManchesterSignal.RISING;
    }
    
    test empty {
        input {
            fromBus: <10*Tk>;
        }
        expect {
            toMac: <10*Tk>;
        }
    }
    
    test single {
        input {
            fromBus: <8*d,7*d,u,6*d,u,d,Tk>;
        }
        expect {
            toMac:<p, Tk>;
        }
    }
    
    test multiple {
        input {
            fromBus: <2*(8*d,7*d,u,6*d,u,d,Tk)>;
        }
        expect {
            toMac:<2*(p, Tk)>;
        }
    }
    
    test forEthernet{
        input{
            fromBus: <u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,d,u,u,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,u,u,d,d,d,d,d,u,d,d,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,u,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,u,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,u,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,u,d,d,u,u,u,u,u,u,d,u,u,d,u,u,d,d,d,u,d,u,u,d,u,d,d,d,u,u,d,u,Tk>;
        }
        expect{
            toMac: <q,Tk>;
        }
    }
}
