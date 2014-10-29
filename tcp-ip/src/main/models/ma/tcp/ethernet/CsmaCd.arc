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

import ma.tcp.EtherFrame;
import ma.tcp.EtherMsg;

/**
 * @brief Component {@code CsmaCd} realises the collision detection.
 *
 * Componente {@code CsmaCd} realises the collision detection functionality of the ethernet protocol.
 * This is done by listening for {@code listenTime} ticks for incoming messages.
 * After that, it sends one datagram and waits for another {@code sendTime} ticks for a collision.
 *
 * @author Stefan Schubert
 * @date
 * @hint {@code listenTime} is usually 96 and {@code sendTime} is usually 521. This is just a parameter because it makes testing easier.
 * @param listenTime the number of ticks, we want to listen to
 * @param sendTime the number of ticks, we need to wait after sending one datagram. This is two times the time, a signal needs for traveling.
 */
component CsmaCd[int listenTime, int sendTime] {

    port
        in EtherFrame fromLlc,
         out EtherMsg toPs,
         in    EtherMsg fromPs,
         out EtherFrame toLlc;

}