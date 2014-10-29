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


import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.HelpCollection;
import ma.tcp.TupelS;
import ma.tcp.TupelBPort;
import ma.tcp.http.gen.AUtf8Encode;

/**
 * This is the implementation of the Utf8Encode component. It encodes a string into an byte array
 * using javas String.getByte("UTF-8"). <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class Utf8EncodeImpl extends AUtf8Encode {
    private Queue<TupelS> queue;
    
    public Utf8EncodeImpl() {
        queue = new LinkedList<TupelS>();
    }
    
    @Override
    public void treatFromGenerate(TupelS message) {
        queue.offer(message);
    }
    
    @Override
    public void treatFromResponse(TupelS message) {
        queue.offer(message);
        
    }
    
    /**
     * @param unencoded the string in ASCII representation
     * @return the byte array in which the string gets utf8-encoded
     * @throws UnsupportedEncodingException
     */
    public byte[] utf8Encode(String unencoded) throws UnsupportedEncodingException {
        byte[] b = unencoded.getBytes("UTF-8");
        return b;
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelS tupel = queue.remove();
            byte[] destIp = tupel.getIp();
            String unencoded = tupel.getPayload();
            byte[] encoded = new byte[1];
            encoded[0] = HelpCollection.convertToByte("11111111");
            // try encoding to utf8
            try {
                encoded = this.utf8Encode(unencoded);
            }
            catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            TupelBPort encodedTupel = new TupelBPort();
            encodedTupel.setIp(destIp);
            encodedTupel.setPayload(encoded);
            encodedTupel.setPort(80);
            sendToTransport(encodedTupel);
        }
    }
    
    /**
     * @see sim.generic.ATimedComponent#timeIncreased()
     */
    @Override
    protected void timeIncreased() {
        // TODO Auto-generated method stub
        
    }
    
}
