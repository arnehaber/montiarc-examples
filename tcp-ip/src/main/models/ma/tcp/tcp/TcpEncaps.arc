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

import ma.tcp.TupelT;
import ma.tcp.TupelBPort;

/**
 * @brief Component {@code TcpEncaps} encapsulates a datagramm in the TCP-Frame.
 *
 * Componente {@code TcpEncaps} encapsultes a datagram in the TCP-specific frame.
 * Checksum and Fragmentation values in the frame are set later on in the {@link ChecksumGenerator} componente and the {@link Fragmentation} component.
 *
 * @author Stefan Schubert
 * @date
 */
component TcpEncaps {
    port
        in TupelBPort fromApp,
        out TupelT toFragment;

}