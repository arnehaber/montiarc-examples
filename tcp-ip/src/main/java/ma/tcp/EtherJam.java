package ma.tcp;

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
 * Represents the Jam-Signal The Jam-Signal is a 32Bit "10"-sequence <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class EtherJam extends EtherMsg {
    
    public EtherJam() {
        byte[] jam = new byte[4];
        for (int i = 0; i < 4; i++) {
            jam[i] = HelpCollection.convertToByte("10101010");
        }
        this.setPayload(jam);
    }
    
}
