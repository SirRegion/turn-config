# "Prometheus Node Exporter" on dev.mdctec.local

## Installation Protocol

Based on https://prometheus.io/docs/guides/node-exporter/#installing-and-running-the-node-exporter

```shell
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz

tar xvfz node_exporter-*.*-amd64.tar.gz -C /opt
```

## Maintenance Notes

### Verify that it is running

```shell
ps  | grep node_exporter
```

### Restart

```shell
cd /opt/node_exporter-*
./node_exporter &
```

## Further Information

See the [Official Docs](https://prometheus.io/docs/guides/node-exporter/#installing-and-running-the-node-exporter)
