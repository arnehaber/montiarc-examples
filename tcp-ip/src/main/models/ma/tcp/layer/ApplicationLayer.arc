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

import ma.tcp.http.*;
import ma.tcp.TupelB;
import ma.tcp.TupelBPort;

/**
 * @brief Component {@code ApplicationLayer} represents the Application Layer.
 *
 * The component {@code ApplicationLayer} represents the Application Layer and one of it's protocols, the HTTProtocol.
 * Until now the HTTProtocol is the only implemented protocol represented by {@link ma.tcp.http.Http} because it's the mostly used protocol.
 *
 * @author Stefan Schubert
 * @date
 */
component ApplicationLayer {
        autoconnect port;
        
        port
            in String fromBrowser,
            in TupelB fromTransport,
            out TupelBPort toTransport,
            out String toBrowser;
            
        component Http http;

}