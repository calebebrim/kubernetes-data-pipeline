# Data Mesh

## Requirements
- helm
- kubectl

## Installation Instructions

### Install Strimzi Kafka Operator

To install Strimzi Kafka Operator run the following command: 

``` bash
make install
```

### Install Kafka Cluster

``` bash
make deploy-kafka-cluster
make show-kafka-cluster

```