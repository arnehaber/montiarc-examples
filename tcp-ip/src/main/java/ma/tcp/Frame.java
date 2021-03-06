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
 * This is the superclass for all data frames. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public abstract class Frame {
    private byte[] payload;
    
    public byte[] getPayload() {
        return payload;
    }
    
    public void setPayload(byte[] payload) {
        this.payload = payload;
    }
    
    @Override
    public boolean equals(Object obj) {
        for (int i = 0; i < payload.length; i++) {
            if (payload[i] != ((Frame) obj).getPayload()[i]) {
                return false;
            }
        }
        return true;
    }
    
    public String toString() {
        String res = getClass().getSimpleName() + " payload: " + HelpCollection.convertToBinary(getPayload());
        return res;
    }
    
}
