package ma.tcp.simComp;

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


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.IpFrame;
import ma.tcp.simComp.gen.AArp;

/**
 * This is a basic simulation of the ARP-service. While the "real" ARP-service is more complex, we
 * just need the feature, to translate IPs into mac adresses. This is implemented by getting an Ip
 * and looking the belonging mac address in a table up. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class ArpImpl extends AArp {
    Queue<IpFrame> queue;
    
    public ArpImpl() {
        queue = new LinkedList<IpFrame>();
    }
    
    @Override
    public void treatInPort(IpFrame message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            IpFrame frame = queue.remove();
            byte[] sourceIp = new byte[4];
            byte[] destIp = new byte[4];
            byte[] sourceMac = new byte[6];
            byte[] destMac = new byte[6];
            
            boolean foundSIp = false;
            boolean foundDIp = false;
            
            String sIp = "";
            String dIp = "";
            String sSourceMac = "";
            String sDestMac = "";
            
            // Read ips und save them as Strings
            for (int i = 0; i < sourceIp.length; i++) {
                sourceIp[i] = frame.getPayload()[12 + i];
                sIp += frame.getPayload()[12 + i];
                
                destIp[i] = frame.getPayload()[16 + i];
                dIp += frame.getPayload()[16 + i];
                
                // Insert the dots, after every byte except the last
                if (i < sourceIp.length - 1) {
                    sIp += ".";
                    dIp += ".";
                }
            }
            
            for (int i = 0; i < 2; i++) {
                String[] splitLine;
                try {
                    // Read the adressTable.txt
                    InputStream is = getClass().getClassLoader().getResourceAsStream("adressTable.txt");
                    BufferedReader in = new BufferedReader(new InputStreamReader(is));
                    String line = null;
                    while ((line = in.readLine()) != null) {
                        // Split the found line at the tab
                        splitLine = line.split("\t");
                        if (i == 0) {
                            if (splitLine[0].equals(sIp)) {
                                // if the first entry matches the sourceIp, save the secound entry
                                sSourceMac = splitLine[1];
                                foundSIp = true;
                                break;
                            }
                        }
                        else {
                            if (splitLine[0].equals(dIp)) {
                                // if the first entry matches the destinationIp, save the secound
                                // entry
                                sDestMac = splitLine[1];
                                foundDIp = true;
                                break;
                            }
                        }
                    }
                    in.close();
                    is.close();
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
            }
            
            // if we found both entrys, we now have them as mac-adress in string format. now we
            // convert them back to byte[]
            if (foundSIp && foundDIp) {
                String[] splittedSourceMac = sSourceMac.split(":");
                String[] splittedDestMac = sDestMac.split(":");
                if (splittedSourceMac.length == 6 && splittedDestMac.length == 6) { // just to be
                                                                                    // sure
                    for (int i = 0; i < splittedSourceMac.length; i++) {
                        sourceMac[i] = Byte.parseByte(splittedSourceMac[i], 16);
                        destMac[i] = Byte.parseByte(splittedDestMac[i], 16);
                    }
                }
                
                // Create the new IpFrame by copying everything, except the old ips. The length is
                // now 4 greater, because both source and dest grew 2 bytes
                byte[] payload = new byte[frame.getPayload().length + 4];
                for (int i = 0; i < payload.length; i++) {
                    if (i < 12) {
                        payload[i] = frame.getPayload()[i];
                    }
                    else if (i >= 12 && i < 18) {
                        payload[i] = sourceMac[i - 12];
                    }
                    else if (i >= 18 && i < 24) {
                        payload[i] = destMac[i - 18];
                    }
                    else {
                        payload[i] = frame.getPayload()[i - 4];
                    }
                }
                IpFrame ipWithMac = new IpFrame();
                ipWithMac.setPayload(payload);
                // Send frame
                sendOutPort(ipWithMac);
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
