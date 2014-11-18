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

testsuite StationTest for Station {
  Job job1;    
  Job job2;
  Job job3;
  
  /**
  * Incoming jobs at time units: 5, 7, 19.
  * Correspoding service times:  4, 10, 1
  */
  test scenarioTest {
    @Before {
      java.util.LinkedList<Integer> st;
  
      st = new java.util.LinkedList<Integer>();
      st.offer(4);
      job1 = new Job(st);
    
      st = new java.util.LinkedList<Integer>();
      st.offer(10);
      job2 = new Job(st);
        
      st = new java.util.LinkedList<Integer>();
      st.offer(1);
      job3 = new Job(st);
    }   
  
    input {
      jobIn: <5*Tk, job1, 2*Tk, job2, 12*Tk, job3, 5*Tk >;
    } 
    expect {
      jobOut: <9*Tk, job1, 10*Tk, job2, Tk, job3, 4*Tk >;
    }
  }
  
  /**
  * Incoming jobs at time unit: 1.
  * Correspoding service times: 4, 10, 1
  * All incoming messages buffered.
  */
  test allJobsAtSameTimeTest {
    @Before {
      java.util.LinkedList<Integer> st;
  
      st = new java.util.LinkedList<Integer>();
      st.offer(4);
      job1 = new Job(st);
    
      st = new java.util.LinkedList<Integer>();
      st.offer(10);
      job2 = new Job(st);
        
      st = new java.util.LinkedList<Integer>();
      st.offer(1);
      job3 = new Job(st);
    }   
  
    input {
      jobIn: <Tk, job1, job2, job3, 16*Tk >;
    } 
    expect {
      jobOut: <5*Tk, job1, 10*Tk, job2, Tk, job3, Tk>;
    }
  }  

  /**
  * Incoming jobs at time unit: 1, 6, 17
  * Correspoding service times: 4, 10, 1
  * Buffer is never used.
  */  
    test BufferAlwaysEmptyTest {
    @Before {
      java.util.LinkedList<Integer> st;
  
      st = new java.util.LinkedList<Integer>();
      st.offer(4);
      job1 = new Job(st);
    
      st = new java.util.LinkedList<Integer>();
      st.offer(10);
      job2 = new Job(st);
        
      st = new java.util.LinkedList<Integer>();
      st.offer(1);
      job3 = new Job(st);
    }   
  
    input {
      jobIn: <Tk, job1, 5*Tk, job2, 11*Tk, job3, 2*Tk >;
    } 
    expect {
      jobOut: <5*Tk, job1, 11*Tk, job2, 2*Tk, job3, Tk>;
    }
  }
  
}
