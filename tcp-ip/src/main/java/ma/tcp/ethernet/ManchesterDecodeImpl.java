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
import ma.tcp.EtherMsg;
import ma.tcp.HelpCollection;
import ma.tcp.ManchesterSignal;
import ma.tcp.ethernet.gen.AManchesterDecode;

/**
 * This is the implementation of the ManchesterDecode component. It decodes a Manchestersignal to an
 * EtherFrame. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class ManchesterDecodeImpl extends AManchesterDecode {
    private Queue<ManchesterSignal> signals = new LinkedList<ManchesterSignal>();
    
    @Override
    public void treatFromBus(ManchesterSignal message) {
        signals.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!signals.isEmpty()) {
            String payload = "";
            for (ManchesterSignal m : signals) {
                if (m == ManchesterSignal.RISING) {
                    payload += '1';
                }
                else {
                    payload += '0';
                }
            }
            signals.clear();
            EtherMsg ether = new EtherMsg();
            ether.setPayload(HelpCollection.convertToByteArray(payload));
            sendToMac(ether);
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
