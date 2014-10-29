package ma.tcp.internetProtocol;

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


import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.HelpCollection;
import ma.tcp.IpFrame;
import ma.tcp.TransportFrame;
import ma.tcp.TupelT;
import ma.tcp.internetProtocol.gen.AIpDecaps;

/**
 * This is the implementation of the IpDecaps component. It works by dropping the ip-specific
 * elements of the frame and then passing the rest onwards. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class IpDecapsImpl extends AIpDecaps {
    private Queue<IpFrame> queue;
    
    public IpDecapsImpl() {
        queue = new LinkedList<IpFrame>();
    }
    
    @Override
    public void treatFromReassembly(IpFrame message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            IpFrame ip = queue.remove();
            // get the headerlength to know, which part to cut off
            byte iHeaderL = HelpCollection.convertToByte(HelpCollection.convertToBinary(
                    ip.getPayload()[0]).substring(4));
            // get the source ip
            byte[] sourceIp = new byte[4];
            for (int i = 0; i < 4; i++) { // in the ip frame from i=12-15 stands the source ip
                sourceIp[i] = ip.getPayload()[12 + i];
            }
            TransportFrame tp = new TransportFrame();
            byte[] payload = new byte[ip.getPayload().length - iHeaderL * 4];
            for (int i = 0; i < payload.length; i++) {
                payload[i] = ip.getPayload()[i + iHeaderL * 4];
            }
            tp.setPayload(payload);
            TupelT tFrame = new TupelT();
            tFrame.setIp(sourceIp);
            tFrame.setPayload(tp);
            sendToTransport(tFrame);
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
