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
import ma.tcp.EtherMsg;

testsuite EtherMacTest for EtherMac { 
    
     EtherFrame frame1;
     EtherFrame frame2;
     EtherFrame frame3;
     EtherFrame frame4;
    
     EtherMsg msg1;
     EtherMsg msg2;
     EtherMsg msg3;
     EtherMsg msg4;
    
     EtherMsg jam;
    
     byte[] f1;
     byte[] f2;
     byte[] f3;
     byte[] f4;
    
     byte[] m1;
     byte[] m2;
     byte[] m3;
     byte[] m4;
    
     byte[] j;
    
    @Before {
        frame1 = new ma.tcp.EtherFrame();
        frame2 = new ma.tcp.EtherFrame();
        frame3 = new ma.tcp.EtherFrame();
        frame4 = new ma.tcp.EtherFrame();
        
        msg1 = new ma.tcp.EtherMsg();
        msg2 = new ma.tcp.EtherMsg();
        msg3 = new ma.tcp.EtherMsg();
        msg4 = new ma.tcp.EtherMsg();
        
        jam = new ma.tcp.EtherMsg();
                        
        f1 = new byte[]{1};
        f2 = new byte[]{2};
        f3 = new byte[]{3};
        f4 = new byte[]{4};
        
        j = new byte[]{-86,-86,-86,-86};
        
        frame1.setPayload(f1);
        frame2.setPayload(f2);
        frame3.setPayload(f3);
        frame4.setPayload(f4);
        
        msg1.setPayload(f1);
        msg2.setPayload(f2);
        msg3.setPayload(f3);
        msg4.setPayload(f4);
        
        jam.setPayload(j);
    }    
    
    test send1receive0 {
        input {
            fromLlc: <frame1, frame2, 619*Tk>;
            fromPs:  <619*Tk>;
        }
        expect {
            toPs: <96*Tk, msg1, Tk, 521*Tk, msg2, Tk>;
            toLlc: <619*Tk>;
        }    
    }
    
    test send0receive1 {
        input {
            fromLlc: <Tk, Tk, Tk, Tk>;
            fromPs:  <msg1, msg2, msg3 ,Tk, Tk, Tk, Tk>;
        }
        expect {
            toPs: <Tk, Tk, Tk, Tk>;
            toLlc: <Tk, frame1, Tk, frame2, Tk, frame3, Tk>;
        }    
    }        
    
    test send0receive0 {
        input {
            fromLlc: <10*Tk>;
            fromPs:  <10*Tk>;
        }
        expect {
            toPs: <10*Tk>;
            toLlc: <10*Tk>;
        }    
    }
    
    test send1receive1NoJam {
        input {
            fromLlc: <frame1, frame2, 622*Tk>;
            fromPs:  <msg3, msg4, 622*Tk>;
        }
        expect {
            toPs: <Tk, Tk, 96*Tk, msg1, Tk, 521*Tk, msg2, Tk, Tk>;
            toLlc: <Tk, frame3, Tk, frame4, Tk, 619*Tk>;
        }    
    }
    
    test receiveJam {
        input {
            fromLlc: <Tk, Tk>;
            fromPs:  <msg1, jam, Tk, Tk>;
        }
        expect {
            toPs: <Tk, Tk>;
            toLlc: <Tk, Tk>;
        }    
    }
    
    test send1receive1WithJam {
        input {
            fromLlc: <frame1, 196*Tk>;
            fromPs:  <97*Tk, msg3, 99*Tk>;
        }
        expect {
            toPs: <96*Tk, msg1, Tk, jam, Tk, Tk, 96*Tk, msg1, Tk>;
            toLlc: <196*Tk>;
        }    
    }
    
}