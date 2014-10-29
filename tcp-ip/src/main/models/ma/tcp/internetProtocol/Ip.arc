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

import ma.tcp.IpFrame;
import ma.tcp.DataLinkFrame;
import ma.tcp.TupelT;

/**
 * @brief Component {@code Ip} represents the Internet Protocol (IP).
 *
 * The component {@code Ip} realises the functionalities of IP by using the subcomponents {@link IpEncaps}, {@link IpDecaps}, {@link IpFragment}, {@link IpReassembly} and {@link IpFrameCheck}.
 * This way received TupelT containing a TCP-Frame get encapsulated in an IP-Frame with correct flags and checksum.
 * Afterwards this IP-Frame gets passed on to the {@link ma.tcp.layer.DataLinkLayer} component.
 *
 * @author Stefan Schubert
 * @date
 */
component Ip {
    autoconnect port;

    port
        in TupelT fromTransport,
        in DataLinkFrame fromDataLink,
        out TupelT toTransport,
        out IpFrame toDataLink;

    component IpEncaps encaps;
    component IpDecaps decaps;
    component IpFragment fragment;
    component IpReassembly reassembly;
    component IpFrameCheck check;
    
    connect check.toReassembly -> reassembly.fromCheck;
    connect reassembly.toDecaps -> decaps.fromReassembly;
    connect encaps.toFragment -> fragment.fromEncaps;

}