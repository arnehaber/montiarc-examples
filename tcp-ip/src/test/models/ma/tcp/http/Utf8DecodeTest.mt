package ma.tcp.http;

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


import ma.tcp.TupelS;
import ma.tcp.TupelB;

testsuite Utf8DecodeTest for Utf8Decode {
     TupelB in1;
     TupelB in2;
     TupelB in3;
     TupelB in4;
     TupelS out1;
     TupelS out2;
     TupelS out3;
     TupelS out4;
         
    @Before {
           in1 = new TupelB();
           in2 = new TupelB();
           in3 = new TupelB();
           in4 = new TupelB();
           out1 = new TupelS();
           out2 = new TupelS();
           out3 = new TupelS();
           out4 = new TupelS();
           
           in1.setIp(new byte[]{10,11,12,13});
           in2.setIp(new byte[]{10,11,12,13});
           in3.setIp(new byte[]{10,11,12,13});
           in4.setIp(new byte[]{10,11,12,13});
           out1.setIp(new byte[]{10,11,12,13});
           out2.setIp(new byte[]{10,11,12,13});
           out3.setIp(new byte[]{10,11,12,13});
           out4.setIp(new byte[]{10,11,12,13});
           
           in1.setPayload(new byte[]{101,110,99,111,100,101,32,109,101});
           in2.setPayload(new byte[]{116,104,105,115,32,115,101,101,109,115,32,116,111,32,119,111,114,107});
           in3.setPayload(new byte[]{71,69,84,32,84,101,115,116,46,104,116,109,108,32,72,84,84,80,47,49,46,49,10,72,111,115,116,58,32,119,119,119,46,98,115,112,46,100,101});
           in4.setPayload(new byte[]{72,84,84,80,47,49,46,49,32,50,48,48,32,79,75,10,83,101,114,118,101,114,58,32,65,112,97,99,104,101,47,49,46,51,46,50,57,32,40,85,110,105,120,41,32,80,72,80,47,52,46,51,46,52,10,67,111,110,116,101,110,116,45,76,101,110,103,116,104,58,32,49,48,57,10,67,111,110,116,101,110,116,45,76,97,110,103,117,97,103,101,58,32,100,101,10,67,111,110,110,101,99,116,105,111,110,58,32,99,108,111,115,101,10,67,111,110,116,101,110,116,45,84,121,112,101,58,32,116,101,115,116,47,104,116,109,108,10,10,60,33,68,79,67,84,89,80,69,32,72,84,77,76,32,80,85,66,76,73,67,62,60,104,116,109,108,62,60,104,101,97,100,62,60,116,105,116,108,101,62,66,101,105,115,112,105,101,108,32,72,101,97,100,60,47,116,105,116,108,101,62,60,47,104,101,97,100,62,60,98,111,100,121,62,66,101,105,115,112,105,101,108,32,72,84,77,76,32,68,97,116,101,105,46,60,47,98,111,100,121,62,60,47,104,116,109,108,62});
           out1.setPayload("encode me");
           out2.setPayload("this seems to work");
           out3.setPayload("GET Test.html HTTP/1.1\nHost: www.bsp.de");
           out4.setPayload("HTTP/1.1 200 OK\nServer: Apache/1.3.29 (Unix) PHP/4.3.4\nContent-Length: 109\nContent-Language: de\nConnection: close\nContent-Type: test/html\n\n<!DOCTYPE HTML PUBLIC><html><head><title>Beispiel Head</title></head><body>Beispiel HTML Datei.</body></html>");
    }
    
    test empty {
        input {
            fromTransport: <10*Tk>;
        }
        expect {
            toDecide: <10*Tk>;
        }
    }
    
    test decoding {
        input {
            fromTransport: <10*in1,10*Tk>;
        }
        expect {
            toDecide: <10*(out1,Tk)>;
        }
    }
    
    test decoding2 {
        input {
            fromTransport: <10*in2,10*Tk>;
        }
        expect {
            toDecide: <10*(out2,Tk)>;
        }
    }
    
    test decoding3 {
        input {
            fromTransport: <10*in3,10*Tk>;
        }
        expect {
            toDecide: <10*(out3,Tk)>;
        }
    }
    
    test forHttp {
        input {
            fromTransport: <10*in4,10*Tk>;
        }
        expect {
            toDecide: <10*(out4,Tk)>;
        }
    }
}
