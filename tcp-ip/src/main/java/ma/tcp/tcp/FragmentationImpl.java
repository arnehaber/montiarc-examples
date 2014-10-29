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
import ma.tcp.TupelT;
import ma.tcp.tcp.gen.AFragmentation;

/**
 * This is the implementation of the Fragmentation component which handels the fragmentation of
 * frames on the transport layer. Given a fragmentsize, this component splits everything larger than
 * the given fragmentsize into smaller fragments and passes them on. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class FragmentationImpl extends AFragmentation {
    Queue<TupelT> queue;
    
    byte[] sequenceNumber;
    
    int fragmentL;
    
    public static final int MIN_FRAGMENTSIZE = 1;
    
    public FragmentationImpl(int fragmentSize) {
        super(fragmentSize);
        if (fragmentSize <= MIN_FRAGMENTSIZE) {
            fragmentL = MIN_FRAGMENTSIZE;
        }
        else {
            fragmentL = fragmentSize; // Usual fragment length 1500
        }
        queue = new LinkedList<TupelT>();
        sequenceNumber = new byte[] { 0, 0, 0, 0 };
    }
    
    @Override
    public void treatFromEncaps(TupelT message) {
        queue.offer(message);
    }
    
    /**
     * This is a helping method, to increment the sequence number. This can't be done by a simple
     * "++", because the sequence number is a byte array. Also we want it to by cyclic, meaning it
     * should start with 0 after having reached 2^32.
     */
    private void incSeqNr() {
        long seq = Long.parseLong(HelpCollection.convertToBinary(sequenceNumber), 2);
        if (seq >= Math.pow(2, 32)) {
            sequenceNumber = new byte[] { 0, 0, 0, 0 };
        }
        else {
            seq++;
            String sSeq = Long.toBinaryString(seq);
            sequenceNumber = HelpCollection.convertToByteArray(sSeq, 4);
        }
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelT tupel = queue.remove();
            byte[] payload = tupel.getPayload().getPayload();
            byte[] ip = tupel.getIp();
            
            // Initialising of the header
            byte headerL = (byte) (4 * (Byte.parseByte(HelpCollection.convertToBinary(payload[12])
                    .substring(0, 4), 2)));
            byte[] header = new byte[headerL];
            for (int i = 0; i < headerL; i++) {
                header[i] = payload[i];
            }
            
            // Initialising of the data
            byte[] data = new byte[payload.length - headerL];
            for (int i = 0; i < data.length; i++) {
                data[i] = payload[headerL + i];
            }
            
            // Calculation number of fragments
            long nrOfFragments = data.length / fragmentL;
            if (data.length % fragmentL > 0) {
                nrOfFragments++;
            }
            
            // Generating of fragments
            for (int i = 0; i < nrOfFragments; i++) {
                byte[] fragment;
                if (i < nrOfFragments - 1) {
                    // Generating of the first Length-1 fragments
                    fragment = new byte[fragmentL];
                }
                else {
                    // Generating of the last fragment
                    fragment = new byte[data.length % fragmentL];
                }
                for (int j = 0; j < fragment.length; j++) {
                    fragment[j] = data[i * fragmentL + j];
                }
                
                // Modifying of the specific headers: change only sequence number, because ack
                // number and checksum are set later
                byte[] specHeader = new byte[header.length];
                for (int j = 0; j < specHeader.length; j++) {
                    specHeader[j] = header[j];
                }
                
                for (int j = 0; j < sequenceNumber.length; j++) {
                    specHeader[4 + j] = sequenceNumber[j];
                }
                incSeqNr();
                
                byte[] fullFragment = new byte[specHeader.length + fragment.length];
                for (int j = 0; j < fullFragment.length; j++) {
                    if (j < specHeader.length) {
                        fullFragment[j] = specHeader[j];
                    }
                    else {
                        fullFragment[j] = fragment[j - specHeader.length];
                    }
                }
                
                // At this point out fragment is ready, so caps it into the TupelT and send it
                TupelT tFragment = new TupelT();
                TcpFrame frame = new TcpFrame();
                frame.setPayload(fullFragment);
                tFragment.setIp(ip);
                tFragment.setPayload(frame);
                // Send it
                sendToMainControl(tFragment);
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
