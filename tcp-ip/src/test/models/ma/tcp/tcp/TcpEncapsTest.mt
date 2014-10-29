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


import ma.tcp.TupelBPort;
import ma.tcp.TupelT;
import ma.tcp.TransportFrame;

testsuite TcpEncapsTest for TcpEncaps {
    
     TupelBPort decapsed;
     TupelBPort decapsed2;
     TupelT encapsed;
     TupelT encapsed2;
     ma.tcp.TransportFrame tEncapsed;
     ma.tcp.TransportFrame tEncapsed2; 
    
    @Before {
        decapsed = new TupelBPort();
        decapsed.setPort(100);
        decapsed.setIp(new byte[]{10,11,12,13});
        decapsed.setPayload(new byte[]{1,1,1,1,1,1,1,1,1,1});
        
        decapsed2 = new TupelBPort();
        decapsed2.setPort(80);
        decapsed2.setIp(new byte[]{100,100,100,100});
        decapsed2.setPayload(new byte[]{71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101}); 
    
        encapsed = new TupelT();
        encapsed.setIp(new byte[]{10,11,12,13});
        tEncapsed = new ma.tcp.TransportFrame();
        tEncapsed.setPayload(new byte[]{0,100,0,100,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1});
        encapsed.setPayload(tEncapsed);
        
        encapsed2 = new TupelT();
        encapsed2.setIp(new byte[]{100,100,100,100});
        tEncapsed2 = new ma.tcp.TransportFrame();
        tEncapsed2.setPayload(new byte[]{0,80,0,80,0,0,0,0,0,0,0,0,80,0,0,1,0,0,0,0,71,69,84,32,116,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
        encapsed2.setPayload(tEncapsed2);        
        
    }
    
    test empty{
        input{
            fromApp: <100*Tk>;
        }
        expect{
            toFragment: <100*Tk>;
        }
    }
    
    test encapsTest{
        input{
            fromApp: <decapsed, Tk>;
        }
        expect{
            toFragment: <encapsed, Tk>;
        }
    }
    
    test multiple{
        input{
            fromApp: <5*(decapsed,Tk)>;
        }
        expect{
            toFragment: <5*(encapsed,Tk)>;
        }
    }
    
    test forTcpIp{
        input{
            fromApp: <5*(decapsed2,Tk)>;
        }
        expect{
            toFragment: <5*(encapsed2,Tk)>;
        }
    }
    
}