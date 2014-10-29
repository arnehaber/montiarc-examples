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

import ma.tcp.TupelT;
import ma.tcp.IpFrame;

/**
 * @brief Component {@code IpDecaps} is used for dropping the ip specific frame.
 *
 * Component {@code IpDecaps} is used for dropping the ip specific frame, that the {@link IpEncaps} component previously generated.
 * This is done by calculating the where the header ends and the data begins and extracting the data into a new datagram. 
 *
 * @author Stefan Schubert
 * @date
 */
component IpDecaps {

    port
        in IpFrame fromReassembly,
        out TupelT toTransport;

}