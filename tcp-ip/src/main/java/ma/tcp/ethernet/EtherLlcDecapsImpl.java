package ma.tcp.ethernet;

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

import ma.tcp.DataLinkFrame;
import ma.tcp.EtherFrame;
import ma.tcp.HelpCollection;
import ma.tcp.ethernet.gen.AEtherLlcDecaps;

/**
 * This is the implementation of the atomic behavior of the EtherLlcDecaps Component This component
 * receives a EtherFrame and generates an IpFrame by dropping the EtherFrame-specific parts. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class EtherLlcDecapsImpl extends AEtherLlcDecaps {
    private Queue<EtherFrame> queue;
    
    public EtherLlcDecapsImpl() {
        queue = new LinkedList<EtherFrame>();
    }
    
    @Override
    public void treatFromFrameCheck(EtherFrame message) { // Extract the IpFrame from the EtherFrame
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            EtherFrame frame = queue.remove();
            // Calculate the length of the data
            byte[] dataLength = new byte[2];
            dataLength[0] = frame.getPayload()[20];
            dataLength[1] = frame.getPayload()[21];
            byte[] payload = new byte[Integer.parseInt(HelpCollection.convertToBinary(dataLength),
                    2)];
            // Get the data
            for (int i = 0; i < payload.length; i++) {
                payload[i] = frame.getPayload()[22 + i];
            }
            // Generate a new DataLinkFrame containing the data from the EtherFrame and pass it on
            DataLinkFrame data = new DataLinkFrame();
            data.setPayload(payload);
            sendToIp(data);
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
