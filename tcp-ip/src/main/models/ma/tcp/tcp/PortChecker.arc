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

/**
 * @brief Component {@code PortChecker} decides where datagram will be send accoring to their port.
 *
 * Componente {@code PortChecker} functions a a shunt for datagrams.
 * Here their port id gets read and accoring to this id, they get passed on.
 * For example a TELNET datagramm should leave the component over another port than HTTP components do.
 *
 * @author Stefan Schubert
 * @date
 * @hint Until now the only application protocol is HTTP, so this component only decides, if a datagramm belongs to HTTP or not.
 * If not it gets dropped, if so it gets delivered to HTTP.
 * If there are going to be more application protocols, this component need more out ports to deliver datagrams to these protocols.
 */
component PortChecker {
    port
        in TupelT fromMainControl,
        out TupelT toDecaps;

}