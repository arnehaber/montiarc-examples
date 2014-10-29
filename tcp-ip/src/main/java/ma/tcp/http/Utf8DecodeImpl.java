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

import ma.tcp.TupelS;
import ma.tcp.TupelB;
import ma.tcp.http.gen.AUtf8Decode;

/**
 * This is the implementation of the Utf8Decode component. It decodes a byte array in utf8
 * representation into the string which it formally was. This is done by using javas String
 * constructor with the ASCII option. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class Utf8DecodeImpl extends AUtf8Decode {
    private Queue<TupelB> queue;
    
    public Utf8DecodeImpl() {
        queue = new LinkedList<TupelB>();
    }
    
    @Override
    public void treatFromTransport(TupelB message) {
        queue.offer(message);
    }
    
    /**
     * @param encoded the byte array in utf8-encoding
     * @return the string which was encoded into the byte array
     * @throws UnsupportedEncodingException
     */
    public String utf8Decode(byte[] encoded) throws UnsupportedEncodingException {
        String decoded = new String(encoded, "US-ASCII");
        return decoded;
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelB tupel = queue.remove();
            byte[] sourceIp = tupel.getIp();
            byte[] payload = tupel.getPayload();
            String decoded = "Error";
            // We try to decode the byte array
            try {
                decoded = utf8Decode(payload);
            }
            catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            TupelS decodedTupel = new TupelS();
            decodedTupel.setIp(sourceIp);
            decodedTupel.setPayload(decoded);
            sendToDecide(decodedTupel);
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
