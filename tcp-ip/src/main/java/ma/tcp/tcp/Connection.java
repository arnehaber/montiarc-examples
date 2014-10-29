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


/**
 * This Enum represents the state, that we can be in, while connecting to another tcp-component.
 * NOT_CONNECTED means, we are not connected. WAITING_FOR_CONNECTION means, we have recently send an
 * SYN-Frame an are now waiting for the SYN-ACK response from the communication partner. CONNECTED
 * means, we got the SYN-ACK-Frame after haveing waited for a connection and are now ready to send
 * data. WAIT_FOR_DISCONNECT means, we finished sending data and have recently send a FIN-Frame and
 * are now waiting for the FIN-ACK response. After having received the FIN-ACK, we switch back into
 * the NOT_CONNECTED state. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public enum Connection {
    NOT_CONNECTED,
    WAITING_FOR_CONNECTION,
    CONNECTED,
    WAIT_FOR_DISCONNECT;
    
}
