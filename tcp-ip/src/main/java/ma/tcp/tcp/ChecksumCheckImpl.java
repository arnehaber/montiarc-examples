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
import ma.tcp.tcp.gen.AChecksumCheck;

/**
 * This is the implementation of the ChecksumGenerator counterpart, the ChecksumCheck component.
 * Here incoming frames get checked for their framecheck sequence. If the sequence is correct, they
 * get passed on, else they will be forgotten. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class ChecksumCheckImpl extends AChecksumCheck {
    private Queue<TupelT> queue;
    
    private byte[] myIp;
    
    private int fragmentL;
    
    public static final int MIN_FRAGMENTSIZE = 1;
    
    public ChecksumCheckImpl(int fragmentSize) {
        super(fragmentSize);
        
        queue = new LinkedList<TupelT>();
        myIp = new byte[] { 0, 1, 2, 3 }; // We know our own ip. if this is changed, it has to be
                                          // changed in the ma.tcp.internetProtocol.IpEncaps and
                                          // ChecksumGeneratorImpl component too, because there are
                                          // variables that scope reaches over components
        
        if (fragmentSize <= MIN_FRAGMENTSIZE) {
            fragmentL = MIN_FRAGMENTSIZE;
        }
        else {
            fragmentL = fragmentSize; // Usual fragment length is 1500 byte. if you change this,
                                      // change it in the FragmentationImpl and ChecksumCheckImpl
                                      // too
        }
    }
    
    @Override
    public void treatFromInternet(TupelT message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            byte[] receivedCs = new byte[2];
            
            TupelT tupel = queue.remove();
            TransportFrame frame = tupel.getPayload();
            byte[] sourceIp = tupel.getIp();
            
            // Calculate the pseudo header
            byte[] pHeader = new byte[12];
            for (int i = 0; i < sourceIp.length; i++) {
                pHeader[i] = sourceIp[i];
            }
            for (int i = 0; i < myIp.length; i++) {
                pHeader[sourceIp.length + i] = myIp[i];
            }
            pHeader[8] = 0;
            pHeader[9] = 6; // Tcp protocol number is 6
            
            byte[] tcpSegL = HelpCollection
                    .convertToByteArray(Integer.toBinaryString(fragmentL), 2);
            pHeader[10] = tcpSegL[0];
            pHeader[11] = tcpSegL[1];
            
            byte[] payload = frame.getPayload();
            
            // Collect the checksum
            receivedCs[0] = payload[16];
            receivedCs[1] = payload[17];
            
            // set the Checksum to 0
            payload[16] = 0;
            payload[17] = 0;
            
            // Calculate sum over pseudo header and payload
            long sum = 0;
            for (int i = 0; i < pHeader.length; i++) {
                sum += pHeader[i];
            }
            for (int i = 0; i < payload.length; i++) {
                sum += payload[i];
            }
            // invert binary representation of sum
            String sSum = HelpCollection.convertToBinary(sum);
            String cs = "";
            for (int i = 0; i < sSum.length(); i++) {
                if (sSum.charAt(i) == '0') {
                    cs = cs + "1";
                }
                else {
                    cs = cs + "0";
                }
            }
            
            byte[] calculatedCs = HelpCollection.convertToByteArray(cs, 2);
            // if calculated checksum and received checksum match, we relay the tuple
            if (calculatedCs[0] == receivedCs[0] && calculatedCs[1] == receivedCs[1]) { 
                sendToMainControl(tupel);
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
