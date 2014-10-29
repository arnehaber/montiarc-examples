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


testsuite InterpreterTest for Interpreter {
       //The String represents a typical Http-Response and is taken from wikipedia: http://de.wikipedia.org/wiki/Hypertext_Transfer_Protocol
       //Note, that the main source is still "Conrads - Datenkommunikation".
       //We use wikipedia for the sole purpose of examples
       
        String in;
        String in2;
        String out;
        String out2;
       
    @Before {
        in = "HTTP/1.0 200 OK\nDate: Fri, 13 Jan 2006 15:12:48 GMT\nLast-Modified: Tue, 10 Jan 2006 11:18:20 GMT\nContent-Language: de\nContent-Type: text/html; charset=utf-8\n\nDie Katzen (Felidae) sind eine Familie aus der Ordnung der Raubtiere (Carnivora)\ninnerhalb der Überfamilie der Katzenartigen (Feloidea).";
        in2 = "HTTP/1.1 200 OK\nServer: Apache/1.3.29 (Unix) PHP/4.3.4\nContent-Length: 109\nContent-Language: de\nConnection: close\nContent-Type: test/html\n\n<!DOCTYPE HTML PUBLIC><html><head><title>Beispiel Head</title></head><body>Beispiel HTML Datei.</body></html>";
        out = "Die Katzen (Felidae) sind eine Familie aus der Ordnung der Raubtiere (Carnivora)\ninnerhalb der Überfamilie der Katzenartigen (Feloidea).";
        out2 = "<!DOCTYPE HTML PUBLIC><html><head><title>Beispiel Head</title></head><body>Beispiel HTML Datei.</body></html>";
    }
    
    test empty {
        input {
            inPort: <10*Tk>;
        }
        expect {
            outPort: <10*Tk>;
        }
    }
    
    test interpret {
        input {
            inPort: <10*in,10*Tk>;
        }
        expect {
            outPort: <10*(out,Tk)>;
        }
    }
    
    test forHttp {
        input {
            inPort: <10*in2,10*Tk>;
        }
        expect {
            outPort: <10*(out2,Tk)>;
        }
    }
}
