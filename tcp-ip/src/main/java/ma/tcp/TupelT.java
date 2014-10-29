package ma.tcp;

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


import ma.tcp.TransportFrame;

/**
 * This represents a Tupel af a TransportFrame and an IP address. This is needed, because the IP is
 * determined in the application layer but encapsulated in a frame only in the internetlayer. So we
 * need a possibility to pass it between the seperated components. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class TupelT {
    private byte[] ip;
    
    private TransportFrame payload;
    
    public byte[] getIp() {
        return ip;
    }
    
    public void setIp(byte[] ip) {
        this.ip = ip;
    }
    
    public TransportFrame getPayload() {
        return payload;
    }
    
    public void setPayload(TransportFrame payload) {
        this.payload = payload;
    }
    
    @Override
    public boolean equals(Object obj) {
        for (int i = 0; i < ip.length; i++) {
            if (ip[i] != ((TupelT) obj).getIp()[i]) {
                System.out.println("Ip false");
                return false;
            }
        }
        return payload.equals(((TupelT) obj).getPayload());
    }
    
}
