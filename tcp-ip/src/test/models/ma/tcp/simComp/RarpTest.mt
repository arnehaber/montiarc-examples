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


import ma.tcp.DataLinkFrame;

testsuite RarpTest for Rarp {
    
     DataLinkFrame j;
     DataLinkFrame i;
        
    @Before {
        j = new DataLinkFrame();
        j.setPayload(new byte[]{0,0,0,0,0,0,0,0,0,0,0,0,10,27,44,61,78,95,95,78,61,44,27,10,0,0,0,0});
        i = new DataLinkFrame();
        i.setPayload(new byte[]{0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0});
        
    }
    
    test empty{
        input{
            inPort: <5*Tk>;
        }
        expect{
            outPort: <5*Tk>;
        }
    }
    
    test rarp{
        input{
            inPort: <5*j, 5*Tk>;
        }
        expect{
            outPort: <5*(i,Tk)>;
        }
    }
    
}