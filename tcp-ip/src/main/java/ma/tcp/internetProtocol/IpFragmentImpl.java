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
import ma.tcp.internetProtocol.gen.AIpFragment;

/**
 * This is the implementation of the IpFragment component. It should be used to split a large
 * IpFrame into fragments. Since fragmented IpFrames only sums up at about 0.06% of all data
 * transfer (cite " Analysis of Internet Backbone Traffic and Header Anomalies observed"), we only
 * implement the correct setting of the flags and the frame id. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class IpFragmentImpl extends AIpFragment {
    private Queue<IpFrame> queue;
    
    private static byte frameId;
    
    public IpFragmentImpl() {
        queue = new LinkedList<IpFrame>();
        frameId = 0;
    }
    
    private void incId() {
        if (frameId >= Byte.MAX_VALUE) {
            frameId = 0;
        }
        else {
            frameId++;
        }
    }
    
    @Override
    public void treatFromEncaps(IpFrame message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            IpFrame ip = queue.remove();
            // since we only scrape at the top of the fragmentation, we just update id and flag
            byte[] payload = ip.getPayload();
            // set id
            byte[] fragmentId = HelpCollection.convertToByteArray(
                    HelpCollection.convertToBinary(frameId), 2);
            
            payload[4] = fragmentId[0];
            payload[5] = fragmentId[1];
            incId();
            // update flag
            String flag = HelpCollection.convertToBinary(ip.getPayload()[6]).substring(0, 2);
            flag += "1";
            byte[] flagOff = new byte[2];
            flagOff[0] = ip.getPayload()[6];
            flagOff[1] = ip.getPayload()[7];
            String fullFlag = flag + HelpCollection.convertToBinary(flagOff).substring(3);
            payload[6] = HelpCollection.convertToByteArray(fullFlag, 2)[0];
            payload[7] = HelpCollection.convertToByteArray(fullFlag, 2)[1];
            
            IpFrame newIp = new IpFrame();
            byte[] pl = new byte[payload.length];
            for (int i = 0; i < payload.length; i++) {
                pl[i] = payload[i];
            }
            newIp.setPayload(pl);
            // send it
            sendToDataLink(newIp);
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
