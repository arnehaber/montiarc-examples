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


import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.TupelS;
import ma.tcp.http.gen.AReplyBroker;

/**
 * This is the implementation of the Decider component. The decider component checks, wether the
 * incoming TupelS is a Http-GET or Http-Response. If it's a GET, it gets passed on to the
 * Responsegenerator, else it gets passed on to the Browser. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class ReplyBrokerImpl extends AReplyBroker {
    private Queue<TupelS> queue;
    
    public ReplyBrokerImpl() {
        queue = new LinkedList<TupelS>();
    }
    
    @Override
    public void treatFromUtf8Decode(TupelS message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelS tupel = queue.remove();
            String payload = tupel.getPayload();
            // Check the payload for the GET-command
            if (payload.contains("GET")) {
                sendToResponse(tupel);
            }
            else {
                sendToInterpret(payload);
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
