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
import java.util.zip.CRC32;

import ma.tcp.EtherFrame;
import ma.tcp.HelpCollection;
import ma.tcp.IpFrame;
import ma.tcp.ethernet.gen.AEtherLlcEncaps;

/**
 * This is the implementation of the EtherLlcEncaps component. Is takes an IpFrame and surrounds it
 * with the Ethernet Header <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class EtherLlcEncapsImpl extends AEtherLlcEncaps {
    private Queue<IpFrame> queue;
    
    /**
     * This method calculates the ethernet preamble
     * 
     * @return The preamble. This is a 7 byte sequence of 10101010 bytes
     */
    private byte[] generatePreamble() {
        byte[] b = new byte[7];
        for (int i = 0; i < 7; i++) {
            b[i] = -86;
        }
        return b;
    }
    
    /**
     * This method calculates the length of an IpFrame as a byte array
     * 
     * @param ip The IpFrame, we want to generate the length for
     * @return The length of the IpFrames payload as a byte array of length 2
     */
    private byte[] generateLength(IpFrame ip) {
        byte[] length = HelpCollection
                .convertToByteArray(Integer.toBinaryString(ip.getPayload().length));
        if (length.length > 2) { // Fragmentation Fail
            return HelpCollection.convertToByteArray("0000000000000000");
        }
        else if (length.length < 2) { // if smaller than two byte, generate a padding array temp
            byte[] temp = new byte[2 - length.length];
            for (int i = 0; i < temp.length; i++) {
                temp[i] = HelpCollection.convertToByte("00000000");
            }
            byte[] merge = new byte[temp.length + length.length]; // now we merge temp and length
            for (int i = 0; i < temp.length; i++) {
                merge[i] = temp[i];
            }
            for (int i = 0; i < length.length; i++) {
                merge[i + temp.length] = length[i];
            }
            return merge;
        }
        return length;
    }
    
    /**
     * This method generates the padding bits. These are as much 0-bytes as the payload is smaller
     * than 46.
     * 
     * @param ip The IpFrame for which we want to get the padding array
     * @return The padding array. An array of 0s as long as the IpFrames length is smaller than 46.
     */
    private byte[] generatePaddingBits(IpFrame ip) { // we need as much padding bytes, as the
                                                     // payloadsize is smaller than 46
        byte[] padding;
        if (ip.getPayload().length < 46) {
            padding = new byte[46 - ip.getPayload().length];
        }
        else {
            padding = new byte[0];
        }
        for (int i = 0; i < padding.length; i++) {
            padding[i] = (byte) 0;
        }
        return padding;
    }
    
    /**
     * Helping method for merging a set of bytes and byte arrays. This is needed, because we
     * generate the parts of the frame seperately and merge them in the end.
     * 
     * @param pre The preamble.
     * @param start The starting byte.
     * @param dest The destinaton mac-address.
     * @param source The source mac-address.
     * @param len The frames length.
     * @param llc The frames data.
     * @param pad The padding sequence.
     * @param check The framecheck sequence.
     * @return The array resulting from merging all parameters one after another into one array.
     */
    private byte[] generatePayload(byte[] pre, byte start, byte[] dest, byte[] source, byte[] len,
            byte[] llc, byte[] pad, byte[] check) {
        byte[] merge = new byte[pre.length + 1 + dest.length + source.length + len.length
                + llc.length + pad.length + check.length];
        for (int i = 0; i < pre.length; i++) {
            merge[i] = pre[i];
        }
        merge[pre.length] = start;
        for (int i = 0; i < dest.length; i++) {
            merge[i + pre.length + 1] = dest[i];
        }
        for (int i = 0; i < source.length; i++) {
            merge[i + pre.length + dest.length + 1] = source[i];
        }
        for (int i = 0; i < len.length; i++) {
            merge[i + pre.length + dest.length + source.length + 1] = len[i];
        }
        for (int i = 0; i < llc.length; i++) {
            merge[i + pre.length + dest.length + source.length + len.length + 1] = llc[i];
        }
        for (int i = 0; i < pad.length; i++) {
            merge[i + pre.length + dest.length + source.length + len.length + llc.length + 1] = pad[i];
        }
        for (int i = 0; i < check.length; i++) {
            merge[i + pre.length + dest.length + source.length + len.length + llc.length
                    + pad.length + 1] = check[i];
        }
        return merge;
    }
    
    public EtherLlcEncapsImpl() {
        queue = new LinkedList<IpFrame>();
    }
    
    @Override
    public void treatFromIp(IpFrame message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            IpFrame ip = queue.remove();
            // Generate the 7byte praemble
            byte[] preamble = generatePreamble();
            // generate the starting frame delimeter = 10101011
            byte startingFrameDel = -85;
            // fetch the dest and source mac adress from the ipFrame
            byte[] destination = new byte[6];
            byte[] source = new byte[6];
            for (int i = 0; i < 6; i++) {
                source[i] = ip.getPayload()[12 + i];
                destination[i] = ip.getPayload()[18 + i];
            }
            // calculate the length of the data field
            byte[] length = generateLength(ip); // binary representation of number of bytes in
                                                // llcInformation
            // set the data field as the whole payload from the ip frame
            byte[] llcInformation = ip.getPayload();
            // generate the bits for guaranteeing, that the datagram is at least 64 byte big
            byte[] paddingBits = generatePaddingBits(ip);
            // calculate the frame check
            byte[] frameCheckSequence = new byte[] { 0, 0, 0, 0 }; // 4 byte
            byte[] payload = generatePayload(preamble, startingFrameDel, destination, source,
                    length, llcInformation, paddingBits, frameCheckSequence);
            
            // Generate Checksum
            CRC32 c = new CRC32();
            c.update(payload);
            byte[] cs = HelpCollection.convertToByteArray(HelpCollection.convertToBinary(c
                    .getValue()));
            
            byte[] pay = new byte[payload.length];
            for (int i = 0; i < pay.length; i++) {
                if (i < payload.length - 4) {
                    pay[i] = payload[i];
                }
                else {
                    pay[i] = cs[i - payload.length + 4];
                }
            }
            
            EtherFrame e = new EtherFrame();
            e.setPayload(pay);
            sendToMac(e);
        }
    }
    
    /**
     * @see sim.generic.ATimedComponent#timeIncreased()
     */
    @Override
    protected void timeIncreased() {
        
    }
    
}
