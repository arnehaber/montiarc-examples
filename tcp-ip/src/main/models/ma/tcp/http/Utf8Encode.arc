package ma.tcp.http;

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
import ma.tcp.TupelBPort;

/**
 * @brief Component {@code Utf8Encode} encodes Strings to an utf8 byte array.
 *
 * Componente {@code Utf8Encode} encodes the String contained in a TupelS into a byte array by utf8-encoding it.
 * After packing it into an TupelBPort containing a byte array instead of a string, it gets passed on to the {@link ma.tcp.layer.TransportLayer}.
 *
 * @author Stefan Schubert
 * @date
 */
component Utf8Encode {
    port
        in TupelS fromGenerate,
        in TupelS fromResponse,
        out TupelBPort toTransport;        

}