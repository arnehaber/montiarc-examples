package ma.tcp.internetProtocol;

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
 * @brief Component {@code IpFragment} is used for fragmentation of ip datagrams, but is not fully implemented yet.
 *
 * Componente {@code IpFragment} is used for fragmentation of ip datagrams, but because of the complexity of this function and the fact, is is rarely used
 * in real life applications, we decided to reduce it so far, that datagrams don't get fragmentated, but the flag gets changed, so it indicated, that 
 * the datagram isn't fragmented.
 *
 * @author Stefan Schubert
 * @date
 */
component IpFragment {

    port
        in IpFrame fromEncaps,
        out IpFrame toDataLink;

}