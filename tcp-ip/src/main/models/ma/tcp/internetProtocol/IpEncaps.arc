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
import ma.tcp.TupelT;

/**
 * @brief Component {@code IpEncaps} is used for putting a datagram in the ip specific frame.
 *
 * Componente {@code IpEncaps} generates the ip specific frame and fills in the data value by putting the TCP fragment in it.
 * The resulting ip datagram gets passed on to the {@link IpFragment} component.
 *
 * @author Stefan Schubert
 * @date
 */
component IpEncaps {

    port
        in TupelT fromTransport,
        out IpFrame toFragment;

}