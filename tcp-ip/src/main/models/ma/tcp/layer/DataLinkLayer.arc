package ma.tcp.layer;

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

import ma.tcp.IpFrame;
import ma.tcp.DataLinkFrame;
import ma.tcp.ManchesterSignal;
import ma.tcp.ethernet.*;
import ma.tcp.simComp.*;

/**
 * @brief Component {@code DataLinkLayer} simulates the Data Link Layer.
 *
 * The component {@code DataLinkLayer} represents the Data Link Layer of the TCP/IP-Stack.
 * Using it's subcomponents {@link ma.tcp.simComp.Arp}, {@link ma.tcp.simComp.Rarp} and {@link ma.tcp.ethernet.Ethernet}, it provides the ethernet functionalities.
 *
 * @hint Note, that {@link ma.tcp.simComp.Arp} and {@link ma.tcp.simComp.Rarp} are very basic simulation components, that exist for the sole purpose to support {@link ma.tcp.ethernet.Ethernet}. Their behavior was drastically simplified.
 * @author Stefan Schubert
 * @date
 */
component DataLinkLayer {
    autoconnect port;
    
    port
        in IpFrame fromIp,
        out DataLinkFrame toIp,        
         out ManchesterSignal toBus,
         in ManchesterSignal fromBus;
         
     component Ethernet ethernet;
     component Arp arp;
     component Rarp rarp;
     
     connect fromIp -> arp.inPort;
     connect arp.outPort -> ethernet.fromIp;
     connect ethernet.toIp -> rarp.inPort;
     connect rarp.outPort -> toIp;

}