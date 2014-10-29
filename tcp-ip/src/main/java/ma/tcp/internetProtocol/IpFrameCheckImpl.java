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

import ma.tcp.DataLinkFrame;
import ma.tcp.HelpCollection;
import ma.tcp.IpFrame;
import ma.tcp.internetProtocol.gen.AIpFrameCheck;

/**
 * Here we implemented the behavior of the IpFrameCheck component. It reads incoming frames and
 * checks their framecheck sequence for correctness. If the framecheck isn't correct, the frame is
 * not passed on. Otherwise it is. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class IpFrameCheckImpl extends AIpFrameCheck implements WithChecksum {
    private Queue<DataLinkFrame> queue;
    
    public IpFrameCheckImpl() {
        queue = new LinkedList<DataLinkFrame>();
    }
    
    @Override
    public void treatFromDataLink(DataLinkFrame message) {
        queue.offer(message);
    }
    
    @Override
    public byte[] calculateHeaderCs(IpFrame ip) { // calculates the 2byte one's complement checksum
        byte[] checksum;
        byte headerL = HelpCollection.convertToByte(HelpCollection.convertToBinary(
                ip.getPayload()[0]).substring(4));
        byte[] header = new byte[headerL];
        long sum = 0;
        for (int i = 0; i < header.length; i++) {
            header[i] = ip.getPayload()[i];
            sum += header[i];
        }
        String check = HelpCollection.convertToBinary(sum);
        String cs = "";
        for (int i = 0; i < check.length(); i++) {
            if (check.charAt(i) == '0') {
                cs = cs + "1";
            }
            else {
                cs = cs + "0";
            }
        }
        checksum = HelpCollection.convertToByteArray(cs, 2);
        return checksum;
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            DataLinkFrame ip = queue.remove();
            // collect the delivered framecheck sequence
            byte[] foundCs = new byte[2];
            foundCs[0] = ip.getPayload()[10];
            foundCs[1] = ip.getPayload()[11];
            
            byte[] payloadToCheck = ip.getPayload();
            payloadToCheck[10] = 0;
            payloadToCheck[11] = 0;
            IpFrame checkIp = new IpFrame();
            checkIp.setPayload(payloadToCheck);
            
            // calculate the framecheck by ourself and check it with the received framecheck
            // sequence
            byte[] checksum = calculateHeaderCs(checkIp);
            if (foundCs[0] == checksum[0] && foundCs[1] == checksum[1]) {
                IpFrame iIp = new IpFrame();
                iIp.setPayload(ip.getPayload());
                sendToReassembly(iIp);
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
