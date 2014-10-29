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
import ma.tcp.TupelB;

/**
 * @brief Component {@code Utf8Decode} decodes a utf8-encoded byte array into a string.
 *
 * Componente {@code Utf8Decode} decodes a received TupelB containing a byte array into a TupelS, where the byte array is replaced by a string.
 * This string will contain the readable decoding of the utf8-encoded byte array from the received TupelB.
 *
 * @author Stefan Schubert
 * @date
 */
component Utf8Decode {
    port
        in TupelB fromTransport,
        out TupelS toDecide;

}