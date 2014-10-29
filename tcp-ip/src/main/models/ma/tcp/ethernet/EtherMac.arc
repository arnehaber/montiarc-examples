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
import ma.tcp.EtherFrame;

/**
 * @brief Component {@code EtherMac} represents the MAC-Layer.
 *
 * Componente {@code EtherMac} holds the components which realise the functionalities of the Ethernet-MAC-Layer.
 * These are only {@link CsmaCd}, which realisies the Collision Detection.
 *
 * @author Stefan Schubert
 * @date
 * @hint Although {@link CsmaCd} is the only subcomponent, we want this structure to make it simpler to add other Collision Detections.
 */
component EtherMac {
    autoconnect port;

    port
        in EtherFrame fromLlc,
        out EtherFrame toLlc,
        out EtherMsg toPs,
        in EtherMsg fromPs;        
        
        component CsmaCd(96, 521) collisionDet;

}