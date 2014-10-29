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

testsuite EtherFrameCheckTest for EtherFrameCheck {

     EtherFrame correct;
     EtherFrame incorrect;
     byte[] x;
     byte[] y;
    
    @Before {
        correct = new EtherFrame();
        incorrect = new EtherFrame();        
        x = new byte[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, -118, 106, 80, 113};
        y = new byte[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, -118, 106, 80, 0};
        correct.setPayload(x);
        incorrect.setPayload(y);
    }
    
    test empty {
        input {
            fromMac: <10*Tk>;
        }
        expect {
            toDecaps: <10*Tk>;
        }
    }
    
    test onlyCorrects {
        input {
            fromMac: <10*correct, 10*Tk>;
        }
        expect {
            toDecaps: <10*(correct, Tk)>;
        }
    }
    
    test onlyIncorrects {
        input {
            fromMac: <10*incorrect, 10*Tk>;
        }
        expect {
            toDecaps: <10*Tk>;
        }
    }
    
    test mixed {
        input {
            fromMac: <5*(correct, incorrect), 10*Tk>;
        }
        expect {
            toDecaps: <5*(correct,Tk,Tk)>;
        }
    }
    
}
