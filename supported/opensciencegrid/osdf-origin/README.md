# Open Science Data Federation Origin

This chart sets up an origin for the [Open Science Data Federation](https://osg-htc.org/docs/data/stashcache/overview/);
see that page for more details.

Before installation, you will need to register your origin in OSG Topology first;
See the [registration instructions](https://osg-htc.org/docs/data/stashcache/install-origin/#registering-the-origin).


## Installation via the Helm command line
**TODO**


## Installation via the Helm Kubernetes Operator

Create a HelmRelease object starting with
```
apiVersion: helm.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: osdf-origin
spec:
  chart:
    repository: https://hub.opensciencegrid.org/chartrepo/opensciencegrid
    name: osdf-origin
    version: "1.0"
  values:
```
(replace the version as appropriate)

If using cert-manager, create a `Certificate` object for the HTTPS cert/key.
If using secrets directly, create a `Secret` of type `tls`.
(Not required if serving only public data via plain HTTP)

Under `values:`, fill out the required configuration options listed below.


## Usage

You will need to register your origin in OSG Topology first; enter the
resource name and FQDN of your registration in the `topologyResourceName` and
`topologyFQDN` parameters.

Set `hostCertKeySecret` to a Secret that contains `tls.crt` with the
public HTTPS cert and `tls.key` with the private HTTPS key.
(Not required if serving only public data via plain HTTP)

Enable either the `publicOrigin` or `authOrigin` or both.
For each of those that are enabled, add at least one namespace to the
`export` list.  For example:

```
publicOrigin:
  enabled: true
  exports: 
    - "/VONAME/PUBLIC"

authOrigin:
  enabled: true
  exports: 
    - "/VONAME/PROTECTED"
```

Define at least one data volume (see "specifying data volumes" below).

### Specifying data volumes

The data that the origin serves usually comes from a data volume.  This is either a PVC or a hostPath.
You list data volumes in the `dataVolumes` parameter, with the following options:

| Parameter | Description | Default |
| --------  | ----------  | ------- |
| name | A name to use in the deployment | xcache-namespace |
| mountPath | Where the volume should be mounted, relative to `/xcache/namespace` (the root dir of the service) | / |
| claimName | The name of the PVC to use for the volume; mutually exclusive with hostPath | |
| hostPath | The path on the Kubernetes node to use for the volume; mutually exclusive with claimName | |

If your data is served externally (e.g. with the experimental S3 plugin) then you may not have any dataVolumes;
explictly set `dataVolumes` to `[]`.

### Configuration Options

**Required options**

| Parameter | Description | Default |
| --------  | ----------  | ------- |
| Instance | A label for your application instance | "" |
| topologyResourceName | The resource name this origin is registered under in OSG Topology | "TestOrigin" |
| topologyFQDN | The FQDN used in the topology registration | "testorigin.example.net" |
| hostCertKeySecret | The Secret containing the HTTPS cert/key for the origin | null |
| publicOrigin.enabled | Whether the public instance of the origin should be run | false |
| publicOrigin.port | The port the public instance listens on | 1094 |
| publicOrigin.export | A list of namespaces to export in the public interface | [] |
| authOrigin.enabled | Whether the public instance of the origin should be run | false |
| authOrigin.port | The port the auth instance listens on | 1095 |
| authOrigin.export | A list of namespaces to export in the auth interface | [] |
| dataVolumes | A list of data volume definitions -- see "specifying data volumes" below | |

**Optional options**

| Parameter | Description | Default |
| --------  | ----------  | ------- |
| nameOverride | Overrides the name of the application | "" |
| fullnameOverride | Overrides the fully qualified app name | "" |
| publicOrigin.authfileLocal | Arbitrary additions to the end of the public origin Authfile |  |
| authOrigin.authfileLocal | Arbitrary additions to the end of the auth origin Authfile |  |
| authOrigin.scitokensConfLocal | Arbitrary additions to the end of the auth origin scitokens.conf |  |
| extraXrootdConfigBefore | Arbitrary xrootd config lines added before the OSG-provided config |  |
| extraXrootdConfigAfter | Arbitrary xrootd config lines added after the OSG-provided config | |
| livenessProbeEnabled | Enables the liveness probe (note 1) | true |
| xrootdLogVolumeClaimName | A PVC for persisting /var/log/xrootd | null |
| image.registry | The image registry to pull from | hub.opensciencegrid.org |
| image.organization | The organization to pull the "stash-origin" image from for the origin container | opensciencegrid |
| image.tag | The tag of the "$ORGANIZATION/stash-origin" image to use for the origin container | 3.6-release |
| image.pullPolicy | The imagePullPolicy for the origin container | Always |
| resources | Resources and limits for the origin container in the deployment | |
| extraEnv | A list of name/value pairs for extra environment variables for the origin container | |
| nodeName | If set, lock the origin pod to the specified node | null |
| nodeSelector | A nodeSelector block for the deployment | |
| tolerations | A tolerations block for the deployment | |
| affinity | An affinity block for the deployment | |
| serviceAnnotations | an annotations block for the service | |
| s3KeysSecret | A secret containing the S3 keys for the experimental S3 plugin | |

- Note 1: The liveness probe tests the auth origin instance if it's enabled, or the public origin instance if the auth origin is not enabled;
  turn off the probe if you are debugging so the pod doesn't get killed mid-debug
