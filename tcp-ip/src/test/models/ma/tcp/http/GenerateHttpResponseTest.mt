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

testsuite GenerateHttpResponseTest for GenerateHttpResponse {
       
        TupelS notFound;
        TupelS found;
        TupelS in;
       
        TupelS out1;
        TupelS out2;
        TupelS out3;
       
    @Before {
    
        notFound = new TupelS();
        found = new TupelS();
        out1 = new TupelS();
        out2 = new TupelS();
        out3 = new TupelS();
        
        in = new TupelS();
        in.setIp(new byte[]{10,11,12,13});
        in.setPayload("GET Test.html HTTP/1.1\nHost: www.bsp.de");
        
        notFound.setIp(new byte[]{10,11,12,13});
        found.setIp(new byte[]{10,11,12,13});
        
        notFound.setPayload("GET notExisting.html HTTP/1.1\nHost: www.example.net");
        found.setPayload("GET Test.html HTTP/1.1\nHost: www.example.net");
        
        out1.setIp(new byte[]{10,11,12,13});
        out2.setIp(new byte[]{10,11,12,13});
        out3.setIp(new byte[]{10,11,12,13});
        
        out1.setPayload("HTTP/1.1 404 Not Found\nServer: Apache/1.3.29 (Unix) PHP/4.3.4\nContent-Length: 0\nContent-Language: de\nConnection: close\nContent-Type: test/html\n\n");
        out2.setPayload("HTTP/1.1 200 OK\nServer: Apache/1.3.29 (Unix) PHP/4.3.4\nContent-Length: 109\nContent-Language: de\nConnection: close\nContent-Type: test/html\n\n<!DOCTYPE HTML PUBLIC><html><head><title>Beispiel Head</title></head><body>Beispiel HTML Datei.</body></html>");
        out3.setPayload("HTTP/1.1 200 OK\nServer: Apache/1.3.29 (Unix) PHP/4.3.4\nContent-Length: 109\nContent-Language: de\nConnection: close\nContent-Type: test/html\n\n<!DOCTYPE HTML PUBLIC><html><head><title>Beispiel Head</title></head><body>Beispiel HTML Datei.</body></html>");
    
    }
    
    test empty {
        input {
            fromDecider: <10*Tk>;
        }
        expect {
            toEncode: <10*Tk>;
        }
    }
    
    test generateNotFound {
        input {
            fromDecider: <notFound, Tk>;
        }
        expect {
            toEncode: <out1, Tk>;
        }
    }
    
    test generateFound {
        input {
            fromDecider: <found, Tk>;
        }
        expect {
            toEncode: <out2, Tk>;
        }
    }
    
    test forHttp {
        input {
            fromDecider: <in, Tk>;
        }
        expect {
            toEncode: <out3, Tk>;
        }
    }
}
