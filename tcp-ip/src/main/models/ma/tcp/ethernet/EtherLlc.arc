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

import ma.tcp.EtherFrame;
import ma.tcp.IpFrame;
import ma.tcp.DataLinkFrame;

/** 
 * Componente {@code EtherLlc} realises the functionalities of the LLC-Layer of the TCP/IP-Stack.
 * 
 * @author Stefan Schubert
 * @date
 * @hint Until now, this only contains the Ethernet-Protocol-Component.
 */
component EtherLlc {
    autoconnect port;

    port    
        in IpFrame fromIp,
        out EtherFrame toMac,
        out DataLinkFrame toIp,
        in EtherFrame fromMac;
        
        component EtherFrameCheck frameCheck;
        component EtherLlcEncaps encaps;
        component EtherLlcDecaps decaps;
        
        //Inter-component
        connect frameCheck.toDecaps -> decaps.fromFrameCheck;            
        
        

}