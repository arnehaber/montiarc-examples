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
 * @brief Component {@code IpReassembly} is used for reassembling ip-fragments but is not fully implemented yet.
 *
 * Componente {@code IpReassembly} is used for reassembling previously fragmented ip datagrams.
 * Because of the complexity of the ip fragmentation, we did not implement the {@link IpFragment} component fully.
 * This results in the missing of the functionality of the {@code IpReassembly} component, so this component servers as a chairholder for future implementations.
 *
 * @hint This component is only a chairholder for future implementations. It does nothing but pass received datagrams on.
 * @author Stefan Schubert
 * @date
 */
component IpReassembly {

    port
        in IpFrame fromCheck,
        out IpFrame toDecaps;

}