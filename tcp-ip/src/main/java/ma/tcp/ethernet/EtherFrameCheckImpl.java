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
import java.util.zip.CRC32;

import ma.tcp.EtherFrame;
import ma.tcp.HelpCollection;
import ma.tcp.ethernet.gen.AEtherFrameCheck;

/**
 * This class represents the implementation of the EtherFrameCheck component. Here incoming
 * EtherFrames are checked for their checksum. If the checksum is correct, the frames are passed on.
 * Otherwise, they aren't passed on and get forgotten. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class EtherFrameCheckImpl extends AEtherFrameCheck {
    private Queue<EtherFrame> queue;
    
    public EtherFrameCheckImpl() {
        queue = new LinkedList<EtherFrame>();
    }
    
    @Override
    public void treatFromMac(EtherFrame message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            EtherFrame e = queue.remove();
            // get the transmitted framecheck-sequence, it's the last 4 byte of the frame
            byte[] frameCheck = new byte[4];
            for (int i = 0; i < frameCheck.length; i++) {
                frameCheck[i] = e.getPayload()[e.getPayload().length - (4 - i)];
            }
            
            // calculate own frame check
            byte[] frame = new byte[e.getPayload().length];
            for (int i = 0; i < frame.length; i++) {
                if (i < frame.length - 4) {
                    frame[i] = e.getPayload()[i];
                }
                else {
                    frame[i] = 0;
                }
            }
            CRC32 crc = new CRC32();
            crc.update(frame);
            long checksum = crc.getValue();
            
            // if the received and calculated checksums match, we send the frame further, else we
            // forget it
            if (HelpCollection.convertToBinary(checksum).equals(
                    HelpCollection.convertToBinary(frameCheck))) {
                sendToDecaps(e);
            }
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
