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
 * @brief Component {@code ManchesterDecode} realises translation of Manchester-Signals into a datagram.
 *
 * Componente {@code ManchesterDecode} translates Manchester-Signals that are received from the physical medium into datagrams.
 * This is done by interpreting each Falling-Edge as a 0 and each Rising-Edge as a 1.
 * The resulting list of binary values then gets converted into a byte-array.
 *
 * @author Stefan Schubert
 * @date
 * @hint Manchester-Signals are represented by the Enum ManchesterSignal.
 */
component ManchesterDecode {
     
     port
         out EtherMsg toMac,
         in ManchesterSignal fromBus;
}