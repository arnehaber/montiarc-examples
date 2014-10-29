package ma.tcp.tcp;

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
import ma.tcp.TransportFrame;
import ma.tcp.TupelT;
import ma.tcp.tcp.gen.APortChecker;

/**
 * This implementation belongs to the PortChecker component which is until now used to decide wether
 * an incoming frame should be forwarded to the http component or not. This has to be extended, when
 * there will be more Application protocols like TELNET. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class PortCheckerImpl extends APortChecker {
    private Queue<TupelT> queue;
    
    public PortCheckerImpl() {
        queue = new LinkedList<TupelT>();
    }
    
    @Override
    public void treatFromMainControl(TupelT message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelT tupel = queue.remove();
            TransportFrame frame = tupel.getPayload();
            byte[] destPort = new byte[2];
            destPort[0] = frame.getPayload()[2];
            destPort[1] = frame.getPayload()[3];
            String sDestPort = HelpCollection.convertToBinary(destPort);
            Integer iDestPort = Integer.parseInt(sDestPort, 2);
            if (iDestPort == 80) {
                sendToDecaps(tupel); // destination port 80 adresses http
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
