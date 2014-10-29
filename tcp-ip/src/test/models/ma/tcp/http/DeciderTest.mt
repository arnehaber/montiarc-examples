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

testsuite DeciderTest for Decider {
    //The Strings represent a typical Http-Response and a typical Http-Request
    //Note, that some of the Requests and Responses are taken from www.wikipedia.de, but only, because our main source "Conrads - Datenkommunikation" offers few examples
       
        TupelS in1;
        TupelS in2;
        TupelS in3;
        String sOut;
        TupelS tOut;
        TupelS tOut2;
       
    @Before {
        in1 = new TupelS();
        in1.setIp(new byte[]{10,11,12,13});
        in1.setPayload("GET /wiki/Katzen HTTP/1.1\nHost: de.wikipedia.org");
        
        in2 = new TupelS();
        in2.setIp(new byte[]{10,11,12,13});
        in2.setPayload("HTTP/1.0 200 OK\nDate: Fri, 13 Jan 2006 15:12:48 GMT\nLast-Modified: Tue, 10 Jan 2006 11:18:20 GMT\nContent-Language: de\nContent-Type: text/html; charset=utf-8\n\nDie Katzen (Felidae) sind eine Familie aus der Ordnung der Raubtiere (Carnivora)\ninnerhalb der Überfamilie der Katzenartigen (Feloidea).");
    
        in3 = new TupelS();
        in3.setIp(new byte[]{10,11,12,13});
        in3.setPayload("GET Test.html HTTP/1.1\nHost: www.bsp.de");
    
        sOut = "HTTP/1.0 200 OK\nDate: Fri, 13 Jan 2006 15:12:48 GMT\nLast-Modified: Tue, 10 Jan 2006 11:18:20 GMT\nContent-Language: de\nContent-Type: text/html; charset=utf-8\n\nDie Katzen (Felidae) sind eine Familie aus der Ordnung der Raubtiere (Carnivora)\ninnerhalb der Überfamilie der Katzenartigen (Feloidea).";
        
        tOut = new TupelS();
        tOut.setIp(new byte[]{10,11,12,13});
        tOut.setPayload("GET /wiki/Katzen HTTP/1.1\nHost: de.wikipedia.org");
        
        tOut2 = new TupelS();
        tOut2.setIp(new byte[]{10,11,12,13});
        tOut2.setPayload("GET Test.html HTTP/1.1\nHost: www.bsp.de");
    
    }
    
    test empty {
        input {
            fromUtf8Decode: <10*Tk>;
        }
        expect {
            toResponse: <10*Tk>;
            toInterpret: <10*Tk>;
        }
    }
    
    test sort {
        input {
            fromUtf8Decode: <in1, Tk, in1, Tk, in2, Tk, in1, Tk, in2, Tk, in2, Tk>;
        }
        expect {
            toResponse: <tOut, Tk, tOut, Tk, Tk, tOut, Tk, Tk, Tk>;
            toInterpret: <Tk, Tk, sOut, Tk, Tk, sOut, Tk, sOut, Tk>;
        }
    }
    
    test forHttp {
        input {
            fromUtf8Decode: <in3, Tk>;
        }
        expect {
            toResponse: <tOut2, Tk>;
            toInterpret: <Tk>;
        }
    }
}
