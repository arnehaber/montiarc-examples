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
 * @brief Component {@code MainControl} realisies the connecting, sending, receiving and disconnecting for a TCP-connection.
 *
 * Componente {@code MainControl} is the heart componente of the {@link Tcp} component.
 * When sending, it checks, wether or not we have a save connection and establishes one via 3Way-Handshake if nessesary.
 * Also it handles generating Acknowledges for received datagrams and disconnects a save connection again via 3Way-Heandshake.
 * Furthermore it reacts to incoming connection or disconnection attememps by generating a fitting answer and passing it on.
 * If datagrams that have been sended don't get acknowledged, it resends them after a given time.
 *
 * @author Stefan Schubert
 * @date
 * @hint {@code resendtime} is usually 3 Secounds = 30000000 Ticks.
 * @param resendTime The number of ticks the componenn should wait to resend a datagram which has noch been acknowledged.
 */
component MainControl[long resendTime] {
    port
        in TupelT fromFragment,
        in TupelT fromCs,
        out TupelT toCs,
        out TupelT toPortD;

}