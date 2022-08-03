# Open Science Data Federation Origin (public instance)

**TODO**


# Installation

**TODO**

###Deployment
```console
$ slate app get-conf osdf-origin-public > osdf-origin-public.yaml
$ slate app install osdf-origin-public --group <group-name> --cluster <cluster-name> --conf osdf-origin-public.yaml
```

### Usage

**TODO**

### Configuration Options
| Parameter | Description | Default |
| --------  | ----------  | ------- |
| Instance | A label for your application instance | "" |
| HostCredentials.HostCertKeySecret | The name of a SLATE secret which contains the host certificate and key this server should use to secure its communications | null |
| Topology.Resource | The resource name this origin is registered under in OSG Topology | "" |
| Topology.FQDN | The FQDN used in the topology registration | "" |
| Origin.DataVolume | A PVC to serve data from, mounted at /xcache/namespace | |
| Origin.MainExport | A directory under /xcache/namespace to export | /VO |"
| Origin.ExtraExports | A list of extra directories to export | |
| Resources.CPU | CPUs to request | 2 |
| Resources.Memory | Memory to request | 1Gi |
| Containers.Origin.Image | The image to use for the origin container | hub.opensciencegrid.org/opensciencegrid/stash-origin:3.6-release |
| Containers.Origin.ImagePullPolicy | The imagePullPolicy for the origin container | Always |

