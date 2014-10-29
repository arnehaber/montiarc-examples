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

testsuite GenerateHttpRequestTest for GenerateHttpRequest {
       
        TupelS in;
        TupelS out;
       
    @Before {
        in = new TupelS();
        in.setIp(new byte[]{10,11,12,13});
        in.setPayload("www.bsp.de");
        
        out = new TupelS();
        out.setIp(new byte[]{10,11,12,13});
        out.setPayload("GET www.bsp.de HTTP/1.1\nHost: www.bsp.de");
    }
    
    test empty {
        input {
            fromDns: <10*Tk>;
        }
        expect {
            toUtf8Encode: <10*Tk>;
        }
    }
    
    test generate {
        input {
            fromDns: <10*in, 10*Tk>;
        }
        expect {
            toUtf8Encode: <10*(out,Tk)>;
        }
    }
}
