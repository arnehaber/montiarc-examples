package ma.tcp.simComp;

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

testsuite DnsTest for Dns {
    
     String a;
     String b;
     String c;
     String d;
    
     TupelS tA;
     TupelS tB;
     TupelS tC;
    
    @Before {
        a = "www.bsp.de/a.html";
        b = "www.test.com/b.html";
        c = "www.zumBsp.de/c.html";
        d = "www.notExisiting.com";
        
        tA = new TupelS();
        tB = new TupelS();
        tC = new TupelS();
        
        tA.setPayload(a);
        tB.setPayload(b);
        tC.setPayload(c);
        
        tA.setIp(new byte[]{100,100,100,100});
        tB.setIp(new byte[]{50,50,50,50});
        tC.setIp(new byte[]{75,75,75,75});
    }
    
    test empty{
        input{
            url: <5*Tk>;
        }
        expect{
            toGenerate: <5*Tk>;
        }
    }
    
    test existing{
        input{
            url: <a, Tk, b, Tk, c, Tk>;
        }
        expect{
            toGenerate: <tA, Tk, tB, Tk, tC, Tk>;
        }
    }
    
    test notExisting{
        input{
            url: <d, 5*Tk>;
        }
        expect{
            toGenerate: <5*Tk>;
        }
    }
    
}