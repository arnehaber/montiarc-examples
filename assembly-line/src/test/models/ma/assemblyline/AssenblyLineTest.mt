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

testsuite AssenblyLineTest for AssemblyLine {
  Job job1;    
  Job job2;   
  Job job3;   
  Job job4;
  
  @Before {
    java.util.LinkedList<Integer> st;
    
    st = new java.util.LinkedList<Integer>();
    st.offer(4);
    st.offer(12);
    st.offer(2);
    job1 = new Job(st);
        
    st = new java.util.LinkedList<Integer>();
    st.offer(10);
    st.offer(15);
    st.offer(3);
    job2 = new Job(st);
    
    st = new java.util.LinkedList<Integer>();
    st.offer(1);
    st.offer(2);
    st.offer(1);
    job3 = new Job(st);
        
    st = new java.util.LinkedList<Integer>();
    st.offer(5);
    st.offer(7);
    st.offer(4);
    job4 = new Job(st);    
  }   
  
  /**
  * Test a scenario of incoming jobs having the service times 
  * as shown above and incoming in time units
  * 5, 7, 30 and 32
  */
  test scenarioAssemblyLineTest {
    input {
      jobIn: 
         <5*Tk, job1, 2*Tk, job2, 23*Tk, job3, 2*Tk, job4, 18*Tk>;
    } 
    expect {
      station1FinishedJob:
                  < 9*Tk, job1, 10*Tk, job2, 12*Tk, job3, 6*Tk, job4, 13*Tk >;
      station2FinishedJob: 
                   < 21*Tk, job1, 15*Tk, job2, 2*Tk, job3, 7*Tk, job4, 5*Tk >;
      station3FinishedJob: 
                   < 23*Tk, job1, 16*Tk, job2, Tk, job3, 9*Tk, job4, Tk >;
    }
  }

}
