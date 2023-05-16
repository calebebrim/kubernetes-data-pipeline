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

To integrate with other applications use the url: 

`data-mesh-kafka-bootstrap.kafka.svc.cluster.local`