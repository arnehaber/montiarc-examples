# MontiArc TCP/IP-Stack Models and Simulation

Created by Stefan Schubert in his Bachelor Thesis:
**Entwicklung und Implementierung des TCP/IP Stacks in MontiArc**
carried out at the 
[Software Engineering Group, RWTH Aachen University](http://www.se-rwth.de/).

This project represents the TCP/IP-Stack, divided into the four layers:
* network layer
* internet layer
* transport layer
* application layer

It simulates a distributed network with hosts connected over a network or the Internet.
Each layer is decomposed into the corresponding services.


The project has the following structure:

* src/main/model  contains the MontiArc models
* src/main/java   contains the implementation of atomic components as well as data structures
* src/test/models contains I/O test models

The generated component documentation can be found in directory 
*target/madoc*.
