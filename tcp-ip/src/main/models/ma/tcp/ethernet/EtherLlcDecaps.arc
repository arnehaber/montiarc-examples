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

import ma.tcp.DataLinkFrame;
import ma.tcp.EtherFrame;

/**
 * @brief Component {@code EtherLlcDecaps} takes of the Ethernet-Frame from a datagram.
 *
 * Componente {@code EtherLlcDecaps} takes the ethernet specific frame away from a datagram.
 * Afterwards the contained IP-datagram gets passed on.
 *
 * @author Stefan Schubert
 * @date
 */
component EtherLlcDecaps {
    /*
     * Atomic component
     * It realises the decapsulation of EtherFrame to IpFrame.
     */
     
     port
         in EtherFrame fromFrameCheck,
         out DataLinkFrame toIp;

}