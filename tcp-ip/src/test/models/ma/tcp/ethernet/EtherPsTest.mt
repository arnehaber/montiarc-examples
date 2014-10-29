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

testsuite EtherPsTest for EtherPs {

     EtherMsg p;
     ManchesterSignal d;
     ManchesterSignal u;
     byte[] x;
    
    @Before {
        p = new EtherMsg();        
        x = new byte[]{0,1,2};
        p.setPayload(x);
        d = ManchesterSignal.FALLING;
        u = ManchesterSignal.RISING;
    }
    
    test empty {
        input {
            fromBus: <10*Tk>;
            fromMac: <10*Tk>;
        }
        expect {
            toBus:<10*Tk>;
            toMac: <10*Tk>;
        }
    }
    
    test ipToBusOnly {
        input {
            fromBus: <10*Tk>;
            fromMac: <10*(p, Tk)>;
        }
        expect {
            toBus:<10*(8*d,7*d,u,6*d,u,d,Tk)>;
            toMac: <10*Tk>;
        }
    }
    
    test busToIpOnly {
        input {
            fromBus: <10*(8*d,7*d,u,6*d,u,d,Tk)>;
            fromMac: <10*Tk>;
        }
        expect {
            toBus:<10*Tk>;
            toMac: <10*(p,Tk)>;
        }
    }
    
    test mixed {
        input {
            fromBus: <10*(8*d,7*d,u,6*d,u,d,Tk)>;
            fromMac: <10*(p, Tk)>;
        }
        expect {
            toBus:<10*(8*d,7*d,u,6*d,u,d,Tk)>;
            toMac: <10*(p,Tk)>;
        }
    }
}
