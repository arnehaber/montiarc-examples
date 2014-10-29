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

import ma.tcp.IpFrame;
import ma.tcp.ManchesterSignal;
import ma.tcp.EtherFrame;
import ma.tcp.EtherMsg;
import ma.tcp.DataLinkFrame;
import ma.sim.FixDelay;

/**
 * @brief Component {@code Ethernet} represents the Ethernet protocol .
 *
 * Componente {@code Ethernet} represents the only subcomponent of the {@link ma.tcp.layer.DataLinkLayer} component.
 * It is used to simulate the functionalities of the Ethernet Protocol with it's three sublayers {@link EtherLlc}, {@link EtherMac} and {@link EtherPs}.
 *
 * @author Stefan Schubert
 * @date
 */
component Ethernet {    
    autoconnect port;
    //Ip-Side und Bus-Side Autoconnected
    
    port
        in IpFrame fromIp,
        out DataLinkFrame toIp,        
         out ManchesterSignal toBus,
         in ManchesterSignal fromBus;
         
     component EtherLlc llc;
     component EtherMac mac;
     component EtherPs ps;
     
     component FixDelay<EtherFrame>(1) fd1, fd2;
     component FixDelay<EtherMsg>(1) fd3, fd4; 
     
     
     //Intern
     connect llc.toMac -> fd1.portIn;
     connect fd1.portOut -> mac.fromLlc;
     
     connect mac.toLlc -> fd2.portIn;
     connect fd2.portOut -> llc.fromMac;
     
     connect mac.toPs -> fd3.portIn;
     connect fd3.portOut -> ps.fromMac;
     
     connect ps.toMac -> fd4.portIn;
     connect fd4.portOut -> mac.fromPs;

}