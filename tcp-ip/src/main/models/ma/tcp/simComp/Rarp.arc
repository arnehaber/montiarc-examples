package ma.tcp.simComp;

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

import ma.tcp.DataLinkFrame;

/**
 * @brief Component {@code Rasp} simulates the Reverse Address Resulution Protocol.
 *
 * The component {@code Rarp} is a reduction of the RARP functionalities and
 * translates MAC-Addresses into IP-Addresses.
 *
 * {@sideEffects the MAC-Address-Table is expected in file addresstable.txt 
 *               that is loaded from the classpath.}
 *
 * @author Stefan Schubert
 * @date
 */
component Rarp {
    port
        in DataLinkFrame inPort,
        out DataLinkFrame outPort;

}