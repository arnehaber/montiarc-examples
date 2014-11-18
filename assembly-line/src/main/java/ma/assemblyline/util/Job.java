package ma.assemblyline.util;

/*
 * #%L
 * assembly-line
 * %%
 * Copyright (C) 2013 - 2014 Software Engineering, RWTH
 *                             Aachen University
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


import java.util.*;

public class Job {
    private Queue<Integer> serviceTimes;
    
//    public Job(Integer... serciveTimes) {
//        this.serviceTimes = new LinkedList<Integer>();
//        
//        for (Integer serviceTime : serviceTimes) {
//            this.serviceTimes.offer(serviceTime);
//        }
//    }
    
    public Job(Queue<Integer> serviceTimes) {
        this.serviceTimes = serviceTimes;
    }
    
    public int getNextServiceTime() {
        Integer nextServiceTime = serviceTimes.poll();
        if (nextServiceTime != null) {
            return nextServiceTime;
        }
        else {
            return 0;
        }
    }
    
}