# Mapping Manuscript Migrations Knowledge Graph Fuseki container

Docker container for running Fuseki triplestore with Mapping Manuscript Migrations Knowledge Graph.

The data is downloaded from [Zenodo](https://doi.org/10.5281/zenodo.3632944) and loaded into Fuseki TDB.

## Build

`docker build -t mmm-fuseki`

## Run

`docker run -it --rm -p 3030:3030 --name mmm-fuseki mmm-fuseki`

## Query with SPARQL

`wget http://localhost:3030/ds/sparql?query=SELECT%20*%20{?s%20?p%20?o}%20LIMIT%201`

Further information for using the Fuseki container: https://github.com/SemanticComputing/fuseki-docker.
