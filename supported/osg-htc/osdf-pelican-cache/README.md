# Pelican-Based Open Science Data Federation Cache

**TODO**


# Installation

**TODO**

### Usage

You will need to register your origin in OSG Topology first; enter the
resource name and FQDN of your registration in the `topologyResourceName` and
`topologyFQDN` parameters.

Set `hostCertKeySecret` to a Secret that contains `tls.crt` with the
public HTTPS cert and `tls.key` with the private HTTPS key.


### Configuration Options

**Required options**

| Parameter | Description | Default |
| --------  | ----------  | ------- |
| topologyResourceName | The resource name this origin is registered under in OSG Topology | "TestOrigin" |
| topologyFQDN | The FQDN used in the topology registration | "testorigin.example.net" |
| hostCertKeySecret | The Secret containing the HTTPS cert/key for the origin | null |

**Optional options**

| Parameter | Description | Default |
| --------  | ----------  | ------- |
| nameOverride | Overrides the name of the application | "" |
| fullnameOverride | Overrides the fully qualified app name | "" |
| resources | Resources and limits for the origin container in the deployment | |
| extraEnv | A list of name/value pairs for extra environment variables for the origin container | |
| nodeName | If set, lock the origin pod to the specified node | null |
| nodeSelector | A nodeSelector block for the deployment | |
| tolerations | A tolerations block for the deployment | |
| affinity | An affinity block for the deployment | |
| serviceAnnotations | an annotations block for the service | |
| hostNetwork | Enable hostNetwork mode | false |
| service.enabled | Use a service to access deployment | true |
| service.type | Service type | LoadBalancer |
| service.externalTrafficPolicy | Service external traffic policy | Local |
| service.clusterIP | Service cluster IP | "" |
| service.loadBalancerIP | Service load balancer IP | "" |

