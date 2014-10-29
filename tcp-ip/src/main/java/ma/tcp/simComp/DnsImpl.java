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
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.TupelS;
import ma.tcp.simComp.gen.ADns;

/**
 * This is a very basic component implementation to provide DNS-service features. While the real DNS
 * server system consists of a much more complex systems based on a tree structure of communications
 * servers, we only need the functionality to translate an url into an Ip adress, which we do by
 * searching a table of urls and associated IPs. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class DnsImpl extends ADns {
    private Queue<String> queue;
    
    public DnsImpl() {
        queue = new LinkedList<String>();
    }
    
    @Override
    public void treatUrl(String message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            String url = queue.remove();
            
            String urlSplit = url.split("/")[0];
            
            String[] tupel;
            String ip = "";
            boolean found = false;
            try {
                // Read the dns.txt
                BufferedReader in = new BufferedReader(new FileReader(
                        "src/main/java/ma/tcp/simComp/dns.txt"));
                String line = null;
                while ((line = in.readLine()) != null) {
                    // Split the found line at the tab
                    tupel = line.split("\t");
                    if (tupel[0].equals(urlSplit)) {
                        // if the first entry matches the url, the secound is the ip
                        ip = tupel[1];
                        found = true;
                        break;
                    }
                }
            }
            catch (IOException e) {
                e.printStackTrace();
            }
            if (found) {
                // if we have found an ip, we split it at the dots
                String[] temp = ip.split("\\.");
                if (temp.length == 4) {
                    byte[] bIp = new byte[4];
                    // we now convert the ip to a byte array with 4 entrys
                    for (int i = 0; i < temp.length; i++) {
                        bIp[i] = Byte.parseByte(temp[i]);
                    }
                    // now we generate a new TupelS, with the ip and the url as payload
                    TupelS tFrame = new TupelS();
                    tFrame.setIp(bIp);
                    tFrame.setPayload(url);
                    // send the Tupel back
                    sendToGenerate(tFrame);
                }
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
