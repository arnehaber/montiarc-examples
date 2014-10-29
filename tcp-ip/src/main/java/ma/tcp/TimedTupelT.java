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
 * This represents the data type of a aging frame. It is needed in the Tcp component, were frames
 * are re-send after not getting acknowledged. <br>
 * <br>
 * Copyright (c) 2013 RWTH Aachen. All rights reserved.
 * 
 * @author Stefan Schubert
 * @version 25.03.2013<br>
 * 65
 */
public class TimedTupelT {
    private TupelT tupel;
    
    private long timer;
    
    public TimedTupelT(long t) {
        timer = t; // usually 3s = 3000ms = 3000000µs = 3000000000ns = 30000000 Ticks
    }
    
    public void update() {
        timer--;
    }
    
    public TupelT getTupel() {
        return tupel;
    }
    
    public void setTupel(TupelT tupel) {
        this.tupel = tupel;
    }
    
    public long getTimer() {
        return timer;
    }
    
    public void setTimer(long timer) {
        this.timer = timer;
    }
    
}
