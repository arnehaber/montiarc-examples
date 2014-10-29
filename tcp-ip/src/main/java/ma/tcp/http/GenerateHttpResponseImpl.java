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


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

import ma.tcp.TupelS;
import ma.tcp.http.gen.AGenerateHttpResponse;

/**
 * This is the implementation of the GenerateHttpResponse component. It generates a response for an
 * incoming Http-GET, depending on wether it knows the requested html-data or not. If the data is
 * known, it gets translated into an Http-Response. If the data is unknown, it responses with a
 * Http-Response containing the "404 - Not Found" html-data. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */

public class GenerateHttpResponseImpl extends AGenerateHttpResponse {
    private Queue<TupelS> queue;
    
    public GenerateHttpResponseImpl() {
        queue = new LinkedList<TupelS>();
    }
    
    @Override
    public void treatFromDecider(TupelS message) {
        queue.offer(message);
    }
    
    @Override
    public void preTimeIncreased() {
        if (!queue.isEmpty()) {
            TupelS tupel = queue.remove();
            byte[] ip = tupel.getIp();
            String payload = tupel.getPayload();
            String[] splitted = payload.split(" ");
            String requested = "NotFound.html";
            
            // We search the incoming GET until we found the part where the requested html-data is
            // specified
            for (int i = 0; i < splitted.length; i++) {
                if (splitted[i].equals("GET")) {
                    requested = splitted[i + 1];
                    break;
                }
            }
            
            String data = "";
            long filesize = 0;
            int code = 404;
            String codeM = "Not Found";
            // We now try to open the requested html-file and read it.
            // if this succeeds, we send the data, the file contains
            // if it fails, we send the value of the NotFound.html, represention the 404-Error
            File file = new File("src/main/java/ma/tcp/http/" + requested);
            if (file.exists()) {
                code = 200;
                codeM = "OK";
                filesize = file.length();
                try {
                    BufferedReader in = new BufferedReader(new FileReader(
                            "src/main/java/ma/tcp/http/" + requested));
                    String line = null;
                    while ((line = in.readLine()) != null) {
                        data += line;
                    }
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
            }
            
            String header = "HTTP/1.1 " + code + " " + codeM
                    + "\nServer: Apache/1.3.29 (Unix) PHP/4.3.4\nContent-Length: " + filesize
                    + "\nContent-Language: de\nConnection: close\nContent-Type: test/html";
            String message = header + "\n\n" + data;
            
            TupelS response = new TupelS();
            response.setIp(ip);
            response.setPayload(message);
            sendToEncode(response);
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
