package ma.tcp.simComp;

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

/**
 * @brief Component {@code Arp} simulates the Address Resulution Protocol.
 *
 * The component {@code Arp} is a reduction of the ARP functionalities
 * and translates IP- to MAC-Addresses.
 * 
 * {@sideEffects the MAC-Address-Table is expected in file addresstable.txt 
 *               that is loaded from the classpath.}
 *
 * @author Stefan Schubert
 * @date
 */
component Arp {
    port
        in IpFrame inPort,
        out IpFrame outPort;

}