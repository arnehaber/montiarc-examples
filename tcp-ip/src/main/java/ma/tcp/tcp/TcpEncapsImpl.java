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
import ma.tcp.TcpFrame;
import ma.tcp.TupelBPort;
import ma.tcp.TupelT;
import ma.tcp.tcp.gen.ATcpEncaps;

/**
 * This is the implementation of the TcpEncaps component. In this subcomponent of the Tcp component
 * incoming data gets encapsulated into an Tcpframe. The tcpframe gets passed on as a TupelT, which
 * represents a Transportframe and a destination ip. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class TcpEncapsImpl extends ATcpEncaps {
    private Queue<TupelBPort> queue;
    
    public TcpEncapsImpl() {
        queue = new LinkedList<TupelBPort>();
    }
    
    @Override
    public void treatFromApp(TupelBPort message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelBPort tupel = queue.remove();
            int port = tupel.getPort();
            byte[] dest = tupel.getIp();
            byte[] payload = tupel.getPayload();
            // Generate TCPFrame
            byte offset = 5; // since options are of length 0 in our case its 5*32 bit
            byte[] tcpPayload = new byte[offset * 4 + payload.length];
            
            tcpPayload[0] = HelpCollection.convertToByteArray(Integer.toBinaryString(port), 2)[0];
            tcpPayload[1] = HelpCollection.convertToByteArray(Integer.toBinaryString(port), 2)[1];
            tcpPayload[2] = tcpPayload[0]; // since the ports are equal in our case
            tcpPayload[3] = tcpPayload[1];
            for (byte i = 0; i < 4; i++) {
                tcpPayload[4 + i] = 0; // Seq.Nr-Field: we set the real number in the fragmentation
                tcpPayload[8 + i] = 0; // Ack-Field: also a 4 byte long array with zeros, because we
                                       // set the acks later
            }
            byte offsAndReserved = HelpCollection.convertToByte((HelpCollection.convertToBinary(
                    offset).substring(4) + "0000")); // 4 Zeros because of the first 4 reserved bits
            byte reservedandFlags = 0; // 00 from reserved and 000000 from flags. we set the flags
                                       // later
            tcpPayload[12] = offsAndReserved;
            tcpPayload[13] = reservedandFlags;
            
            byte[] window = HelpCollection.convertToByteArray(HelpCollection.convertToBinary(1), 2); // we
                                                                                                     // want
                                                                                                     // an
                                                                                                     // ack
                                                                                                     // after
                                                                                                     // each
                                                                                                     // frame
            tcpPayload[14] = window[0];
            tcpPayload[15] = window[1];
            
            tcpPayload[16] = 0; // Checksum field: we generate that later, so we set it 0 for now
            tcpPayload[17] = 0;
            
            tcpPayload[18] = 0; // Urgent Pointer field: we ignore that for now, because it would
                                // become to complex.
            tcpPayload[19] = 0;
            
            for (int i = 0; i < payload.length; i++) {
                tcpPayload[20 + i] = payload[i];
            }
            
            TcpFrame tcp = new TcpFrame();
            tcp.setPayload(tcpPayload);
            TupelT tupelT = new TupelT();
            tupelT.setIp(dest);
            tupelT.setPayload(tcp);
            
            sendToFragment(tupelT);
            
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
