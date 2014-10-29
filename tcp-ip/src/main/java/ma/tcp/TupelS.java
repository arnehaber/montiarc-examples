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


/**
 * This represents a Tupel of a String and an P address. It is needed after the DNS protocol. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class TupelS {
    private byte[] ip;
    
    private String payload;
    
    public byte[] getIp() {
        return ip;
    }
    
    public void setIp(byte[] ip) {
        this.ip = ip;
    }
    
    public String getPayload() {
        return payload;
    }
    
    public void setPayload(String payload) {
        this.payload = payload;
    }
    
    @Override
    public boolean equals(Object obj) {
        for (int i = 0; i < ip.length; i++) {
            if (ip[i] != ((TupelS) obj).getIp()[i]) {
                System.out.println("Ips ungleich");
                return false;
            }
        }
        if (!payload.equals(((TupelS) obj).getPayload())) {
            System.out.println("payload ungleich");
            return false;
        }
        return true;
    }
    
}
