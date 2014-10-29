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
import ma.tcp.TransportFrame;
import ma.tcp.TupelT;
import ma.tcp.internetProtocol.gen.AIpEncaps;

/**
 * This represents the implementation of the IpEncaps component, that is used to surround a block of
 * data from the transport layer with the ip-specific header. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class IpEncapsImpl extends AIpEncaps implements WithChecksum {
    
    private Queue<TupelT> queue;
    
    private final byte ipVersion = 4;
    
    private byte[] sourceAdress;
    
    @Override
    public byte[] calculateHeaderCs(IpFrame ip) {
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
    
    public IpEncapsImpl() {
        queue = new LinkedList<TupelT>();
        sourceAdress = new byte[] { 0, 1, 2, 3 }; // We know our own ip. if this is changed, it has
                                                  // to be changed in the
                                                  // ma.tcp.tcp.ChecksumGeneratorImpl and
                                                  // ma.tcp.tcp.ChecksumCheckImpl component to,
                                                  // because there are variables that scope reaches
                                                  // over components
    }
    
    @Override
    public void treatFromTransport(TupelT message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelT tupel = queue.remove();
            TransportFrame transport = tupel.getPayload();
            byte[] destinationAdress = tupel.getIp();
            
            // we let the options stay 0 for now because it is way to much work for a bachelor to
            // include this
            byte[] options = new byte[4];
            for (byte i = 0; i < options.length; i++) {
                options[i] = 0;
            }
            
            // calculate the header length
            byte iHeaderL = (byte) ((20 + options.length) / 4);
            byte[] data = transport.getPayload();
            
            String length = Integer.toBinaryString(iHeaderL * 4 + data.length);
            byte[] totalL = HelpCollection.convertToByteArray(length, 2);
            
            byte tos = HelpCollection.convertToByte("00000000");
            // we leave the id 0 for now, because we set it in the fragmentation
            byte[] id = new byte[2];
            id[0] = 0;
            id[1] = 0;
            
            // we just set the "do not fragment" bit, because fragmentation isn't done in about 99%
            // of the time and it is to time consuming to do.
            // The "last fragment" bit is set in the fragmentation
            byte flag = HelpCollection.convertToByte("010");
            
            // this is done, because the "real" offset is set in the fragmentation
            byte[] offset = new byte[2];
            offset[0] = 0;
            offset[1] = 0;
            
            // we set ttl to max for now
            byte ttl = HelpCollection.convertToByte("11111111");
            
            // 6 is the protocol id for tcp
            byte protocol = 6;
            IpFrame ip = new IpFrame();
            
            // We set the header checksum to 0 for now, to calculate the real checksum later
            byte[] headerCs = new byte[2];
            for (int i = 0; i < headerCs.length; i++) {
                headerCs[i] = (byte) 0;
            }
            
            // calculate the byte with the version and the header lenght
            byte[] payload = new byte[totalL[0] * (2 ^ 8) + totalL[1]];
            String versionHeaderL = HelpCollection.convertToBinary(ipVersion).substring(4, 8)
                    + HelpCollection.convertToBinary(iHeaderL).substring(4, 8);
            payload[0] = HelpCollection.convertToByte(versionHeaderL);
            payload[1] = tos;
            payload[2] = totalL[0];
            payload[3] = totalL[1];
            payload[4] = id[0];
            payload[5] = id[1];
            
            // calculate the byte with the flag and the frame offset
            String flagFrameO = HelpCollection.convertToBinary(flag).substring(5)
                    + HelpCollection.convertToBinary(offset).substring(3);
            byte[] flagOffset = HelpCollection.convertToByteArray(flagFrameO);
            payload[6] = flagOffset[0];
            payload[7] = flagOffset[1];
            payload[8] = ttl;
            payload[9] = protocol;
            payload[10] = headerCs[0];
            payload[11] = headerCs[1];
            // insert the source adress and the destination adress
            for (int i = 0; i < sourceAdress.length; i++) {
                payload[12 + i] = sourceAdress[i];
            }
            for (int i = 0; i < destinationAdress.length; i++) {
                payload[12 + sourceAdress.length + i] = destinationAdress[i];
            }
            for (int i = 0; i < options.length; i++) {
                payload[12 + sourceAdress.length + destinationAdress.length + i] = options[i];
            }
            // insert the data bytes
            for (int i = 0; i < data.length; i++) {
                payload[12 + sourceAdress.length + destinationAdress.length + options.length + i] = data[i];
            }
            
            ip.setPayload(payload);
            
            // calculate the real checksum now and insert it
            byte[] checksum = calculateHeaderCs(ip);
            payload[10] = checksum[0];
            payload[11] = checksum[1];
            
            ip.setPayload(payload);
            
            sendToFragment(ip);
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
