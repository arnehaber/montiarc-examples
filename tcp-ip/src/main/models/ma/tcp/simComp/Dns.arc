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

import ma.tcp.TupelS;

/**
 * @brief Component {@code Dns} simulates the DNS Protocol.
 *
 * The component {@code Dns} simulates the reduced behavior of the DNS Protocol.
 * If a name is found, the ip gets returned, else nothing gets returned.
 *
 * {@sideEffects the IP-Address lookup table is expected in file dns.txt 
 *               that is loaded from the classpath.}
 *
 * @hint The fact that nothing gets returned if no name is found calls for carefull programming, because if a component requests a wrong name and waits afterwards, it won't terminate. 
 * @author Stefan Schubert
 * @date
 */
component Dns {

    port
        in String url,
        out TupelS toGenerate;

}