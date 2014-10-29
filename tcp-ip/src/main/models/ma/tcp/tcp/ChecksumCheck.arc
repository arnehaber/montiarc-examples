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
 * @brief Component {@code ChecksumCheck} realises the checksum control on tcp level.
 *
 * Componente {@code ChecksumCheck} realises the tcp's checksum control.
 * fragments with correct checksum get send further, other ones are forgotten
 *
 * @author Stefan Schubert
 * @date
 * @hint {@code fragmentSize} is usually 1500 byte.
 * @param fragmentSize The size of fragments we expect. This is changeable for testing.
 */
component ChecksumCheck[int fragmentSize] {
    port
        in TupelT fromInternet,
        out TupelT toMainControl;

}