package ma.tcp.tcp;

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

import ma.tcp.TupelB;
import ma.tcp.TupelBPort;
import ma.tcp.TupelT;
import ma.sim.*;

/**
 * @brief Component {@code Tcp} represents the TCP protocol.
 *
 * Componente {@code Tcp} represents the TCP protocol with it's functionalities.
 * These include the 3Way-Handshake for save connections and the generating of checksums etc.
 * For that there are serveral subcomponents.
 * These are: {@link ChecksumCheck} {@link ChecksumGenerator} {@link Fragmentation} {@link MainControl} {@link PortChecker} {@link TcpEncaps} and {@link TcpDecaps}. 
 *
 * @author Stefan Schubert
 * @date
 */
component Tcp {
    autoconnect port;
    
    port
        in TupelBPort fromApp,
        in TupelT fromInternet,
        out TupelT toInternet,
        out TupelB toApp;
        
        component TcpEncaps encaps;
        component Fragmentation(1500) fragment;
        component ChecksumGenerator(1500) checksumGen;
        component MainControl(30000000) connectAndSend;
        component ChecksumCheck(1500) checksumCheck;
        component PortChecker portcheck;
        component TcpDecaps decaps;
        
        connect encaps.toFragment -> fragment.fromEncaps;
        connect fragment.toMainControl -> connectAndSend.fromFragment;
        connect connectAndSend.toCs -> checksumGen.fromMainControl;
        connect checksumCheck.toMainControl -> connectAndSend.fromCs;
        connect connectAndSend.toPortD -> portcheck.fromMainControl;
        connect portcheck.toDecaps -> decaps.fromPortChecker;
}