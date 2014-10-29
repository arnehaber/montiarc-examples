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
import ma.tcp.TupelB;
import ma.tcp.TransportFrame;

testsuite TcpDecapsTest for TcpDecaps {
    
     TupelT encapsed;
     TupelB decapsed;    
     ma.tcp.TransportFrame tEncapsed;    
    
    @Before {
        encapsed = new TupelT();
        encapsed.setIp(new byte[]{10,11,12,13});
        tEncapsed = new ma.tcp.TransportFrame();
        tEncapsed.setPayload(new byte[]{0,100,0,100,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1});
        encapsed.setPayload(tEncapsed);    
    
        decapsed = new TupelB();
        decapsed.setIp(new byte[]{10,11,12,13});
        decapsed.setPayload(new byte[]{1,1,1,1,1,1,1,1,1,1});    
            
    }
    
    test empty{
        input{
            fromPortChecker: <100*Tk>;
        }
        expect{
            toApp: <100*Tk>;
        }
    }
    
    test single{
        input{
            fromPortChecker: <encapsed,Tk>;
        }
        expect{
            toApp: <decapsed,Tk>;
        }
    }
    
    test decapsTest{
        input{
            fromPortChecker: <5*(encapsed,Tk)>;
        }
        expect{
            toApp: <5*(decapsed,Tk)>;
        }
    }
    
}