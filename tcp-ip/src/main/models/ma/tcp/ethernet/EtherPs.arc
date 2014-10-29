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

import ma.tcp.EtherMsg;
import ma.tcp.ManchesterSignal;

/**
 * @brief Component {@code EtherPs} represents the PS-Layer.
 *
 * Componente {@code EtherPs} holds the functionalities of the Physical Signaling Layer of the Ethernet Protocol.
 * These are {@link ManchesterEncode} and {@link ManchesterDecode}.
 *
 * @author Stefan Schubert
 * @date
 */
component EtherPs {
    autoconnect port;

    port
        in ManchesterSignal fromBus,
        out EtherMsg toMac,
        in EtherMsg fromMac,
        out ManchesterSignal toBus;
        
        component ManchesterDecode decoder;
        component ManchesterEncode encoder;
        
        connect fromMac -> encoder.fromMac;
        connect encoder.toBus -> toBus;
        connect fromBus -> decoder.fromBus;
        connect decoder.toMac -> toMac;

}