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

import ma.assemblyline.util.Job;

component AssemblyLine {
  port
    in  Job jobIn,
    out Job station1FinishedJob,
    out Job station2FinishedJob,
    out Job station3FinishedJob;
    
    component Station station1, station2, station3;
    
    connect jobIn -> station1.jobIn;
    connect station1.jobOut -> station2.jobIn, station1FinishedJob;
    connect station2.jobOut -> station3.jobIn, station2FinishedJob;
    connect station3.jobOut -> station3FinishedJob;  
}