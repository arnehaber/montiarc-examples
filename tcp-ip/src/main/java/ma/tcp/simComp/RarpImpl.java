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
import java.util.List;
import java.util.Queue;

import com.google.common.collect.Lists;

import ma.tcp.DataLinkFrame;
import ma.tcp.simComp.gen.ARarp;

/**
 * This is a basic simulation of the RARP-service. While the "real" RARP-service
 * is more complex, we just need the feature, to translate mac adresses into
 * IPs. This is implemented by getting a mac address and looking the belonging
 * IP address in a table up. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class RarpImpl extends ARarp {
    Queue<DataLinkFrame> queue;
    
    public RarpImpl() {
        queue = new LinkedList<DataLinkFrame>();
    }
    
    @Override
    public void treatInPort(DataLinkFrame message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            DataLinkFrame frame = queue.remove();
            byte[] sourceMac = new byte[6];
            byte[] destMac = new byte[6];
            byte[] sourceIp = new byte[4];
            byte[] destIp = new byte[4];
            
            boolean foundSMac = false;
            boolean foundDMac = false;
            
            String sSourceMac = "";
            String sDestMac = "";
            String sSourceIp = "";
            String sDestIp = "";
            
            // Read macs und save them as Strings
            for (int i = 0; i < sourceMac.length; i++) {
                sourceMac[i] = frame.getPayload()[12 + i];
                sSourceMac += Integer.toString(frame.getPayload()[12 + i], 16);
                
                destMac[i] = frame.getPayload()[18 + i];
                sDestMac += Integer.toString(frame.getPayload()[18 + i], 16);
                
                // Insert the double dots, after every byte except the last
                if (i < sourceMac.length - 1) {
                    sSourceMac += ":";
                    sDestMac += ":";
                }
            }
            
            List<String> lines = Lists.newArrayList();
            try {
                // Read the addresstable.txt
                InputStream is = getClass().getClassLoader().getResourceAsStream("addresstable.txt");
                BufferedReader in = new BufferedReader(new InputStreamReader(is));
                String line = null;
                while ((line = in.readLine()) != null) {
                    lines.add(line);
                }
                in.close();
                is.close();
            }
            catch (IOException e) {
                getErrorHandler().getLogger().error("Failed to load IP/MAC mapping", e);
            }
            
            for (int i = 0; i < 2; i++) {
                for (String line : lines) {
                    
                    String[] splitLine;
                    
                    // Split the found line at the tab
                    splitLine = line.split("-");
                    if (i == 0) {
                        if (splitLine[1].equals(sSourceMac)) {
                            // if second entry matches the MAC, the first corresponds to the IP address.
                            sSourceIp = splitLine[0];
                            foundSMac = true;
                            break;
                        }
                    }
                    else {
                        if (splitLine[1].equals(sDestMac)) {
                            // if second entry matches the MAC, the first corresponds to the IP address.
                            sDestIp = splitLine[0];
                            foundDMac = true;
                            break;
                        }
                    }
                }
            }
            
            // if we found both entrys, we now have them as ip-adress in string
            // format. now we convert them back to byte[]
            if (foundSMac && foundDMac) {
                String[] splittedSourceIp = sSourceIp.split("\\.");
                String[] splittedDestIp = sDestIp.split("\\.");
                if (splittedSourceIp.length == 4 && splittedDestIp.length == 4) { // just
                                                                                  // to
                                                                                  // be
                                                                                  // sure
                    for (int i = 0; i < splittedSourceIp.length; i++) {
                        sourceIp[i] = Byte.parseByte(splittedSourceIp[i], 10);
                        destIp[i] = Byte.parseByte(splittedDestIp[i], 10);
                    }
                }
                
                // Create the new DataLinkFrame by copying everything, except
                // the old
                // ips. The length is now 4 greater, because both source and
                // dest lost 2
                // bytes
                byte[] payload = new byte[frame.getPayload().length - 4];
                for (int i = 0; i < payload.length; i++) {
                    if (i < 12) {
                        payload[i] = frame.getPayload()[i];
                    }
                    else if (i >= 12 && i < 16) {
                        payload[i] = sourceIp[i - 12];
                    }
                    else if (i >= 16 && i < 20) {
                        payload[i] = destIp[i - 16];
                    }
                    else {
                        payload[i] = frame.getPayload()[i + 4];
                    }
                }
                DataLinkFrame dataWithIp = new DataLinkFrame();
                dataWithIp.setPayload(payload);
                // Send frame
                sendOutPort(dataWithIp);
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
