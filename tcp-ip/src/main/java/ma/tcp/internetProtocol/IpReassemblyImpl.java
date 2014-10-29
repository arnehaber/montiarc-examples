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
import ma.tcp.IpFrame;
import ma.tcp.internetProtocol.gen.AIpReassembly;

/**
 * This is the implementation of the IpReassembly component. If should reconstruct IP-fragmented
 * frames, but since fragmented IpFrames only make out 0.06% of data transfer (cite
 * " Analysis of Internet Backbone Traffic and Header Anomalies observed"), and because it's a lot
 * to implement, we reduced it to a basic component for future working on. Until now it only passes
 * frames on. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class IpReassemblyImpl extends AIpReassembly {
    private Queue<IpFrame> queue;
    
    byte[] mergeId;
    
    public IpReassemblyImpl() {
        queue = new LinkedList<IpFrame>();
        mergeId = new byte[2];
    }
    
    @Override
    public void treatFromCheck(IpFrame message) {
        queue.offer((IpFrame) message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            sendToDecaps(queue.remove());
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
