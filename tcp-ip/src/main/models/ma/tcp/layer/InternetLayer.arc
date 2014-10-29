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

import ma.tcp.internetProtocol.*;
import ma.tcp.TupelT;
import ma.tcp.DataLinkFrame;
import ma.tcp.IpFrame;

/**
 * @brief Component {@code InternetLayer} represents the Internet Layer of the TCP/IP-Stack.
 *
 * The component {@code InternetLayer} simultes the functionalities of the Internet Layer and it's protocols.
 * Until now {@link ma.tcp.internetProtocol.Ip} is the only simulated protocol, because it is the most used.
 *
 * @author Stefan Schubert
 * @date
 */
component InternetLayer {
    autoconnect port;

    port
        in TupelT fromTransport,
        in DataLinkFrame fromDataLink,
        out TupelT toTransport,
        out IpFrame toDataLink;
        
        component Ip ip;

}