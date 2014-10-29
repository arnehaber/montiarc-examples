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

import ma.tcp.tcp.*;
import ma.tcp.TupelBPort;
import ma.tcp.TupelT;
import ma.tcp.TupelB;

/**
 * @brief Component {@code TransportLayer} represents the Transport Layer.
 *
 * The component {@code TransportLayer} simulates the Transport Layer with the TCProtocol.
 * Until now only the TCProtocol {@link ma.tcp.tcp.Tcp} is implemented because it is one of the to most used protocols on this layer.
 * The other one is UDP which is basically TCP without the 3-Way-Handshake and without acknowledges. 
 *
 * @author Stefan Schubert
 * @date
 */
component TransportLayer {
    autoconnect port;
    
    port
        in TupelBPort fromApp,
        in TupelT fromInternet,
        out TupelT toInternet,
        out TupelB toApp;
        
    component Tcp tcp;

}