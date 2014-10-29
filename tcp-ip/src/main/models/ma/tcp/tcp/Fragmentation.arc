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
 * @brief Component {@code Fragmentation} fragments a TCP-Frame into smaller TCP frames.
 *
 * Componente {@code ChecksumGenerator} fragments TCP-Frames into smaller ones by splitting them up into
 * parts of given size.
 * This is done by copying the frame and splitting the data inside it into more parts, surrounding them with the frame agian.
 * The frames of the resulting list of datagrams then gets updated so that their size etc fits.
 * Afterwards they get passed on. 
 *
 * @author Stefan Schubert
 * @date
 * @hint {@code fragmentSize} is usually 1500 Byte. When fragmentating a datagramm with size x and x modulo {@code fragmentSize} != 0, there is always one more datagramm carring the rest. 
 * @param fragmentSize The size of the TCP fragments. This is changeable for testing.
 */
component Fragmentation[int fragmentSize] {
    port
        in TupelT fromEncaps,
        out TupelT toMainControl;
}