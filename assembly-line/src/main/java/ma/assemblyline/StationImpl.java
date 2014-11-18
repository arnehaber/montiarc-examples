package ma.assemblyline;

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


import java.util.LinkedList;
import java.util.Queue;

import ma.assemblyline.gen.AStation;
import ma.assemblyline.util.Job;

public class StationImpl extends AStation {
    // used to queue incoming jobs
    protected Queue<Job> jobQueue;
    // stores the job the station is currently working on
    protected Job currentJob;
    // stores the time remaining to work on the current job
    protected Integer jobTimeLeft;
    
    public StationImpl() {
        jobQueue = new LinkedList<Job>();
        jobTimeLeft = 0;
    }
    
    @Override
    public void treatJobIn(Job message) {
        if (jobTimeLeft > 0) {
            // The station is currently working on another job
            jobQueue.offer(message);
        }
        else {
            // The station is currently not working on another job
            jobTimeLeft = message.getNextServiceTime();
            if (jobTimeLeft == null || jobTimeLeft < 0) {
                jobTimeLeft = 0;
            }
            currentJob = message;
        }
        
    }

    /**
     * @see sim.generic.ATimedComponent#timeIncreased()
     */
    @Override
    protected void timeIncreased() {
        jobTimeLeft--;
        if (jobTimeLeft == 0) {
            // The job is done, relay it to the next station
            sendJobOut(currentJob);
            if (!jobQueue.isEmpty()) {
                // Check whether there are waiting jobs
                currentJob = jobQueue.poll();
                jobTimeLeft = currentJob.getNextServiceTime();
            }
        }
    }
    
}
