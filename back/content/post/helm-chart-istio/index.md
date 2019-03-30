+++
title = "Helm Chart Istio"
date = 2018-03-30T06:33:03+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = []
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++



```
helm install --debug install/kubernetes/helm/istio --name istio --namespace istio-system --set security.enabled=false --set ingress.enabled=false --set gateways.istio-ingressgateway.enabled=false --set gateways.istio-egressgateway.enabled=false --set galley.enabled=false --set mixer.enabled=false --set prometheus.enabled=false --set global.proxy.envoyStatsd.enabled=false --set pilot.sidecar=false --set sidecarInjectorWebhook.enabled=false
[debug] Created tunnel using local port: '44471'

[debug] SERVER: "127.0.0.1:44471"

[debug] Original chart version: ""
[debug] CHART PATH: /home/bigo/istio/install/kubernetes/helm/istio

NAME:   istio
REVISION: 1
RELEASED: Sat Mar 30 06:30:03 2019
CHART: istio-1.0.6
USER-SUPPLIED VALUES:
galley:
  enabled: false
gateways:
  istio-egressgateway:
    enabled: false
  istio-ingressgateway:
    enabled: false
global:
  proxy:
    envoyStatsd:
      enabled: false
ingress:
  enabled: false
mixer:
  enabled: false
pilot:
  sidecar: false
prometheus:
  enabled: false
security:
  enabled: false
sidecarInjectorWebhook:
  enabled: false

COMPUTED VALUES:
certmanager:
  enabled: false
  hub: quay.io/jetstack
  resources: {}
  tag: v0.3.1
galley:
  enabled: false
  image: galley
  replicaCount: 1
gateways:
  enabled: true
  global:
    arch:
      amd64: 2
      ppc64le: 2
      s390x: 2
    configValidation: true
    controlPlaneSecurityEnabled: false
    crds: true
    defaultResources:
      requests:
        cpu: 10m
    disablePolicyChecks: false
    enableTracing: true
    hub: gcr.io/istio-release
    hyperkube:
      hub: quay.io/coreos
      tag: v1.7.6_coreos.0
    imagePullPolicy: IfNotPresent
    imagePullSecrets: null
    k8sIngressHttps: false
    k8sIngressSelector: ingress
    meshExpansion: false
    meshExpansionILB: false
    mtls:
      enabled: false
    oneNamespace: false
    policyCheckFailOpen: false
    priorityClassName: ""
    proxy:
      accessLogFile: /dev/stdout
      autoInject: enabled
      concurrency: 0
      discoveryDomain: ""
      enableCoreDump: false
      envoyStatsd:
        enabled: false
        host: null
        port: null
      excludeIPRanges: ""
      excludeInboundPorts: ""
      image: proxyv2
      includeIPRanges: '*'
      includeInboundPorts: '*'
      privileged: false
      proxyDomain: ""
      readinessFailureThreshold: 30
      readinessInitialDelaySeconds: 1
      readinessPeriodSeconds: 2
      resources:
        requests:
          cpu: 10m
      stats:
        prometheusPort: 15090
      statusPort: 0
    proxy_init:
      image: proxy_init
    tag: release-1.0-latest-daily
  istio-egressgateway:
    autoscaleMax: 5
    autoscaleMin: 1
    cpu:
      targetAverageUtilization: 80
    enabled: false
    labels:
      app: istio-egressgateway
      istio: egressgateway
    ports:
    - name: http2
      port: 80
    - name: https
      port: 443
    replicaCount: 1
    secretVolumes:
    - mountPath: /etc/istio/egressgateway-certs
      name: egressgateway-certs
      secretName: istio-egressgateway-certs
    - mountPath: /etc/istio/egressgateway-ca-certs
      name: egressgateway-ca-certs
      secretName: istio-egressgateway-ca-certs
    serviceAnnotations: {}
    type: ClusterIP
  istio-ilbgateway:
    autoscaleMax: 5
    autoscaleMin: 1
    cpu:
      targetAverageUtilization: 80
    enabled: false
    labels:
      app: istio-ilbgateway
      istio: ilbgateway
    loadBalancerIP: ""
    ports:
    - name: grpc-pilot-mtls
      port: 15011
    - name: grpc-pilot
      port: 15010
    - name: tcp-citadel-grpc-tls
      port: 8060
      targetPort: 8060
    - name: tcp-dns
      port: 853
    replicaCount: 1
    resources:
      requests:
        cpu: 800m
        memory: 512Mi
    secretVolumes:
    - mountPath: /etc/istio/ilbgateway-certs
      name: ilbgateway-certs
      secretName: istio-ilbgateway-certs
    - mountPath: /etc/istio/ilbgateway-ca-certs
      name: ilbgateway-ca-certs
      secretName: istio-ilbgateway-ca-certs
    serviceAnnotations:
      cloud.google.com/load-balancer-type: internal
    type: LoadBalancer
  istio-ingressgateway:
    autoscaleMax: 5
    autoscaleMin: 1
    cpu:
      targetAverageUtilization: 80
    enabled: false
    labels:
      app: istio-ingressgateway
      istio: ingressgateway
    loadBalancerIP: ""
    ports:
    - name: http2
      nodePort: 31380
      port: 80
      targetPort: 80
    - name: https
      nodePort: 31390
      port: 443
    - name: tcp
      nodePort: 31400
      port: 31400
    - name: tcp-pilot-grpc-tls
      port: 15011
      targetPort: 15011
    - name: tcp-citadel-grpc-tls
      port: 8060
      targetPort: 8060
    - name: tcp-dns-tls
      port: 853
      targetPort: 853
    - name: http2-prometheus
      port: 15030
      targetPort: 15030
    - name: http2-grafana
      port: 15031
      targetPort: 15031
    replicaCount: 1
    resources: {}
    secretVolumes:
    - mountPath: /etc/istio/ingressgateway-certs
      name: ingressgateway-certs
      secretName: istio-ingressgateway-certs
    - mountPath: /etc/istio/ingressgateway-ca-certs
      name: ingressgateway-ca-certs
      secretName: istio-ingressgateway-ca-certs
    serviceAnnotations: {}
    type: LoadBalancer
global:
  arch:
    amd64: 2
    ppc64le: 2
    s390x: 2
  configValidation: true
  controlPlaneSecurityEnabled: false
  crds: true
  defaultResources:
    requests:
      cpu: 10m
  disablePolicyChecks: false
  enableTracing: true
  hub: gcr.io/istio-release
  hyperkube:
    hub: quay.io/coreos
    tag: v1.7.6_coreos.0
  imagePullPolicy: IfNotPresent
  imagePullSecrets: null
  k8sIngressHttps: false
  k8sIngressSelector: ingress
  meshExpansion: false
  meshExpansionILB: false
  mtls:
    enabled: false
  oneNamespace: false
  policyCheckFailOpen: false
  priorityClassName: ""
  proxy:
    accessLogFile: /dev/stdout
    autoInject: enabled
    concurrency: 0
    discoveryDomain: ""
    enableCoreDump: false
    envoyStatsd:
      enabled: false
      host: null
      port: null
    excludeIPRanges: ""
    excludeInboundPorts: ""
    image: proxyv2
    includeIPRanges: '*'
    includeInboundPorts: '*'
    privileged: false
    proxyDomain: ""
    readinessFailureThreshold: 30
    readinessInitialDelaySeconds: 1
    readinessPeriodSeconds: 2
    resources:
      requests:
        cpu: 10m
    stats:
      prometheusPort: 15090
    statusPort: 0
  proxy_init:
    image: proxy_init
  tag: release-1.0-latest-daily
grafana:
  accessMode: ReadWriteMany
  enabled: false
  image:
    repository: grafana/grafana
    tag: 5.2.3
  persist: false
  replicaCount: 1
  security:
    enabled: false
    passphraseKey: passphrase
    secretName: grafana
    usernameKey: username
  service:
    annotations: {}
    externalPort: 3000
    internalPort: 3000
    name: http
    type: ClusterIP
  storageClassName: ""
ingress:
  autoscaleMax: 5
  autoscaleMin: 1
  enabled: false
  replicaCount: 1
  service:
    annotations: {}
    loadBalancerIP: ""
    ports:
    - name: http
      nodePort: 32000
      port: 80
    - name: https
      port: 443
    selector:
      istio: ingress
    type: LoadBalancer
kiali:
  dashboard:
    passphraseKey: passphrase
    secretName: kiali
    usernameKey: username
  enabled: false
  hub: docker.io/kiali
  ingress:
    annotations: null
    enabled: false
    tls: null
  replicaCount: 1
  tag: v0.12
mixer:
  autoscaleMax: 5
  autoscaleMin: 1
  enabled: false
  env:
    GODEBUG: gctrace=2
  image: mixer
  istio-policy:
    autoscaleEnabled: true
    autoscaleMax: 5
    autoscaleMin: 1
    cpu:
      targetAverageUtilization: 80
  istio-telemetry:
    autoscaleEnabled: true
    autoscaleMax: 5
    autoscaleMin: 1
    cpu:
      targetAverageUtilization: 80
  prometheusStatsdExporter:
    hub: docker.io/prom
    tag: v0.6.0
  replicaCount: 1
pilot:
  autoscaleMax: 5
  autoscaleMin: 1
  cpu:
    targetAverageUtilization: 80
  enabled: true
  env:
    GODEBUG: gctrace=2
    PILOT_PUSH_THROTTLE_COUNT: 100
  global:
    arch:
      amd64: 2
      ppc64le: 2
      s390x: 2
    configValidation: true
    controlPlaneSecurityEnabled: false
    crds: true
    defaultResources:
      requests:
        cpu: 10m
    disablePolicyChecks: false
    enableTracing: true
    hub: gcr.io/istio-release
    hyperkube:
      hub: quay.io/coreos
      tag: v1.7.6_coreos.0
    imagePullPolicy: IfNotPresent
    imagePullSecrets: null
    k8sIngressHttps: false
    k8sIngressSelector: ingress
    meshExpansion: false
    meshExpansionILB: false
    mtls:
      enabled: false
    oneNamespace: false
    policyCheckFailOpen: false
    priorityClassName: ""
    proxy:
      accessLogFile: /dev/stdout
      autoInject: enabled
      concurrency: 0
      discoveryDomain: ""
      enableCoreDump: false
      envoyStatsd:
        enabled: false
        host: null
        port: null
      excludeIPRanges: ""
      excludeInboundPorts: ""
      image: proxyv2
      includeIPRanges: '*'
      includeInboundPorts: '*'
      privileged: false
      proxyDomain: ""
      readinessFailureThreshold: 30
      readinessInitialDelaySeconds: 1
      readinessPeriodSeconds: 2
      resources:
        requests:
          cpu: 10m
      stats:
        prometheusPort: 15090
      statusPort: 0
    proxy_init:
      image: proxy_init
    tag: release-1.0-latest-daily
  image: pilot
  replicaCount: 1
  resources:
    requests:
      cpu: 500m
      memory: 2048Mi
  sidecar: false
  traceSampling: 1
prometheus:
  enabled: false
  hub: docker.io/prom
  replicaCount: 1
  service:
    annotations: {}
    nodePort:
      enabled: false
      port: 32090
  tag: v2.3.1
security:
  enabled: false
  image: citadel
  replicaCount: 1
  selfSigned: true
servicegraph:
  enabled: false
  image: servicegraph
  ingress:
    annotations: null
    enabled: false
    hosts:
    - servicegraph.local
    tls: null
  prometheusAddr: http://prometheus:9090
  replicaCount: 1
  service:
    annotations: {}
    externalPort: 8088
    internalPort: 8088
    name: http
    type: ClusterIP
sidecarInjectorWebhook:
  enableNamespacesByDefault: false
  enabled: false
  image: sidecar_injector
  replicaCount: 1
telemetry-gateway:
  gatewayName: ingressgateway
  global:
    arch:
      amd64: 2
      ppc64le: 2
      s390x: 2
    configValidation: true
    controlPlaneSecurityEnabled: false
    crds: true
    defaultResources:
      requests:
        cpu: 10m
    disablePolicyChecks: false
    enableTracing: true
    hub: gcr.io/istio-release
    hyperkube:
      hub: quay.io/coreos
      tag: v1.7.6_coreos.0
    imagePullPolicy: IfNotPresent
    imagePullSecrets: null
    k8sIngressHttps: false
    k8sIngressSelector: ingress
    meshExpansion: false
    meshExpansionILB: false
    mtls:
      enabled: false
    oneNamespace: false
    policyCheckFailOpen: false
    priorityClassName: ""
    proxy:
      accessLogFile: /dev/stdout
      autoInject: enabled
      concurrency: 0
      discoveryDomain: ""
      enableCoreDump: false
      envoyStatsd:
        enabled: false
        host: null
        port: null
      excludeIPRanges: ""
      excludeInboundPorts: ""
      image: proxyv2
      includeIPRanges: '*'
      includeInboundPorts: '*'
      privileged: false
      proxyDomain: ""
      readinessFailureThreshold: 30
      readinessInitialDelaySeconds: 1
      readinessPeriodSeconds: 2
      resources:
        requests:
          cpu: 10m
      stats:
        prometheusPort: 15090
      statusPort: 0
    proxy_init:
      image: proxy_init
    tag: release-1.0-latest-daily
  grafanaEnabled: false
  prometheusEnabled: false
tracing:
  enabled: false
  ingress:
    annotations: null
    enabled: false
    hosts:
    - tracing.local
    tls: null
  jaeger:
    hub: docker.io/jaegertracing
    ingress:
      annotations: null
      enabled: false
      hosts:
      - jaeger.local
      tls: null
    memory:
      max_traces: 50000
    tag: 1.5
    ui:
      port: 16686
  provider: jaeger
  replicaCount: 1
  service:
    annotations: {}
    externalPort: 9411
    internalPort: 9411
    name: http
    type: ClusterIP

HOOKS:
---
# virtualservices.networking.istio.io
# 
# these CRDs only make sense when pilot is enabled
#
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: virtualservices.networking.istio.io
  annotations:
    "helm.sh/hook": crd-install
  labels:
    app: istio-pilot
spec:
  group: networking.istio.io
  names:
    kind: VirtualService
    listKind: VirtualServiceList
    plural: virtualservices
    singular: virtualservice
    categories:
    - istio-io
    - networking-istio-io
  scope: Namespaced
  version: v1alpha3
---
# destinationrules.networking.istio.io
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: destinationrules.networking.istio.io
  annotations:
    "helm.sh/hook": crd-install
  labels:
    app: istio-pilot
spec:
  group: networking.istio.io
  names:
    kind: DestinationRule
    listKind: DestinationRuleList
    plural: destinationrules
    singular: destinationrule
    categories:
    - istio-io
    - networking-istio-io
  scope: Namespaced
  version: v1alpha3
---
# serviceentries.networking.istio.io
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: serviceentries.networking.istio.io
  annotations:
    "helm.sh/hook": crd-install
  labels:
    app: istio-pilot
spec:
  group: networking.istio.io
  names:
    kind: ServiceEntry
    listKind: ServiceEntryList
    plural: serviceentries
    singular: serviceentry
    categories:
    - istio-io
    - networking-istio-io
  scope: Namespaced
  version: v1alpha3
---
# gateways.networking.istio.io
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: gateways.networking.istio.io
  annotations:
    "helm.sh/hook": crd-install
    "helm.sh/hook-weight": "-5"
  labels:
    app: istio-pilot
spec:
  group: networking.istio.io
  names:
    kind: Gateway
    plural: gateways
    singular: gateway
    categories:
    - istio-io
    - networking-istio-io
  scope: Namespaced
  version: v1alpha3
---
# envoyfilters.networking.istio.io
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: envoyfilters.networking.istio.io
  annotations:
    "helm.sh/hook": crd-install
  labels:
    app: istio-pilot
spec:
  group: networking.istio.io
  names:
    kind: EnvoyFilter
    plural: envoyfilters
    singular: envoyfilter
    categories:
    - istio-io
    - networking-istio-io
  scope: Namespaced
  version: v1alpha3
MANIFEST:

---
# Source: istio/templates/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: istio
  namespace: istio-system
  labels:
    app: istio
    chart: istio-1.0.6
    release: istio
    heritage: Tiller
data:
  mesh: |-
    # Set the following variable to true to disable policy checks by the Mixer.
    # Note that metrics will still be reported to the Mixer.
    disablePolicyChecks: false

    # Set enableTracing to false to disable request tracing.
    enableTracing: true

    # Set accessLogFile to empty string to disable access log.
    accessLogFile: "/dev/stdout"
    #
    # Deprecated: mixer is using EDS

    # Unix Domain Socket through which envoy communicates with NodeAgent SDS to get
    # key/cert for mTLS. Use secret-mount files instead of SDS if set to empty. 
    sdsUdsPath: ""
    
    # How frequently should Envoy fetch key/cert from NodeAgent.
    sdsRefreshDelay: 15s

    #
    defaultConfig:
      #
      # TCP connection timeout between Envoy & the application, and between Envoys.
      connectTimeout: 10s
      #
      ### ADVANCED SETTINGS #############
      # Where should envoy's configuration be stored in the istio-proxy container
      configPath: "/etc/istio/proxy"
      binaryPath: "/usr/local/bin/envoy"
      # The pseudo service name used for Envoy.
      serviceCluster: istio-proxy
      # These settings that determine how long an old Envoy
      # process should be kept alive after an occasional reload.
      drainDuration: 45s
      parentShutdownDuration: 1m0s
      #
      # The mode used to redirect inbound connections to Envoy. This setting
      # has no effect on outbound traffic: iptables REDIRECT is always used for
      # outbound connections.
      # If "REDIRECT", use iptables REDIRECT to NAT and redirect to Envoy.
      # The "REDIRECT" mode loses source addresses during redirection.
      # If "TPROXY", use iptables TPROXY to redirect to Envoy.
      # The "TPROXY" mode preserves both the source and destination IP
      # addresses and ports, so that they can be used for advanced filtering
      # and manipulation.
      # The "TPROXY" mode also configures the sidecar to run with the
      # CAP_NET_ADMIN capability, which is required to use TPROXY.
      #interceptionMode: REDIRECT
      #
      # Port where Envoy listens (on local host) for admin commands
      # You can exec into the istio-proxy container in a pod and
      # curl the admin port (curl http://localhost:15000/) to obtain
      # diagnostic information from Envoy. See
      # https://lyft.github.io/envoy/docs/operations/admin.html
      # for more details
      proxyAdminPort: 15000
      #
      # Set concurrency to a specific number to control the number of Proxy worker threads.
      # If set to 0 (default), then start worker thread for each CPU thread/core.
      concurrency: 0
      #
      # Zipkin trace collector
      zipkinAddress: zipkin.istio-system:9411
      #
      # Mutual TLS authentication between sidecars and istio control plane.
      controlPlaneAuthPolicy: NONE
      #
      # Address where istio Pilot service is running
      discoveryAddress: istio-pilot.istio-system:15007
---
# Source: istio/templates/sidecar-injector-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: istio-sidecar-injector
  namespace: istio-system
  labels:
    app: istio
    chart: istio-1.0.6
    release: istio
    heritage: Tiller
    istio: sidecar-injector
data:
  config: |-
    policy: enabled
    template: |-
      initContainers:
      - name: istio-init
        image: "gcr.io/istio-release/proxy_init:release-1.0-latest-daily"
        args:
        - "-p"
        - [[ .MeshConfig.ProxyListenPort ]]
        - "-u"
        - 1337
        - "-m"
        - [[ annotation .ObjectMeta `sidecar.istio.io/interceptionMode` .ProxyConfig.InterceptionMode ]]
        - "-i"
        - "[[ annotation .ObjectMeta `traffic.sidecar.istio.io/includeOutboundIPRanges`  "*"  ]]"
        - "-x"
        - "[[ annotation .ObjectMeta `traffic.sidecar.istio.io/excludeOutboundIPRanges`  ""  ]]"
        - "-b"
        - "[[ annotation .ObjectMeta `traffic.sidecar.istio.io/includeInboundPorts` (includeInboundPorts .Spec.Containers) ]]"
        - "-d"
        - "[[ excludeInboundPort (annotation .ObjectMeta `status.sidecar.istio.io/port`  0 ) (annotation .ObjectMeta `traffic.sidecar.istio.io/excludeInboundPorts`  "" ) ]]"
        imagePullPolicy: IfNotPresent
        securityContext:
          capabilities:
            add:
            - NET_ADMIN
          privileged: true
        restartPolicy: Always
      containers:
      - name: istio-proxy
        image: [[ annotation .ObjectMeta `sidecar.istio.io/proxyImage`  "gcr.io/istio-release/proxyv2:release-1.0-latest-daily"  ]]

        ports:
        - containerPort: 15090
          protocol: TCP
          name: http-envoy-prom

        args:
        - proxy
        - sidecar
        - --configPath
        - [[ .ProxyConfig.ConfigPath ]]
        - --binaryPath
        - [[ .ProxyConfig.BinaryPath ]]
        - --serviceCluster
        [[ if ne "" (index .ObjectMeta.Labels "app") -]]
        - [[ index .ObjectMeta.Labels "app" ]]
        [[ else -]]
        - "istio-proxy"
        [[ end -]]
        - --drainDuration
        - [[ formatDuration .ProxyConfig.DrainDuration ]]
        - --parentShutdownDuration
        - [[ formatDuration .ProxyConfig.ParentShutdownDuration ]]
        - --discoveryAddress
        - [[ annotation .ObjectMeta `sidecar.istio.io/discoveryAddress` .ProxyConfig.DiscoveryAddress ]]
        - --discoveryRefreshDelay
        - [[ formatDuration .ProxyConfig.DiscoveryRefreshDelay ]]
        - --zipkinAddress
        - [[ .ProxyConfig.ZipkinAddress ]]
        - --connectTimeout
        - [[ formatDuration .ProxyConfig.ConnectTimeout ]]
        - --proxyAdminPort
        - [[ .ProxyConfig.ProxyAdminPort ]]
        [[ if gt .ProxyConfig.Concurrency 0 -]]
        - --concurrency
        - [[ .ProxyConfig.Concurrency ]]
        [[ end -]]
        - --controlPlaneAuthPolicy
        - [[ annotation .ObjectMeta `sidecar.istio.io/controlPlaneAuthPolicy` .ProxyConfig.ControlPlaneAuthPolicy ]]
      [[- if (ne (annotation .ObjectMeta `status.sidecar.istio.io/port`  0 ) "0") ]]
        - --statusPort
        - [[ annotation .ObjectMeta `status.sidecar.istio.io/port`  0  ]]
        - --applicationPorts
        - "[[ annotation .ObjectMeta `readiness.status.sidecar.istio.io/applicationPorts` (applicationPorts .Spec.Containers) ]]"
      [[- end ]]
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: POD_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: INSTANCE_IP
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
        - name: ISTIO_META_POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: ISTIO_META_INTERCEPTION_MODE
          value: [[ or (index .ObjectMeta.Annotations "sidecar.istio.io/interceptionMode") .ProxyConfig.InterceptionMode.String ]]
        [[ if .ObjectMeta.Annotations ]]
        - name: ISTIO_METAJSON_ANNOTATIONS
          value: |
                 [[ toJson .ObjectMeta.Annotations ]]
        [[ end ]]
        [[ if .ObjectMeta.Labels ]]
        - name: ISTIO_METAJSON_LABELS
          value: |
                 [[ toJson .ObjectMeta.Labels ]]
        [[ end ]]
        imagePullPolicy: IfNotPresent
        [[ if (ne (annotation .ObjectMeta `status.sidecar.istio.io/port`  0 ) "0") ]]
        readinessProbe:
          httpGet:
            path: /healthz/ready
            port: [[ annotation .ObjectMeta `status.sidecar.istio.io/port`  0  ]]
          initialDelaySeconds: [[ annotation .ObjectMeta `readiness.status.sidecar.istio.io/initialDelaySeconds`  1  ]]
          periodSeconds: [[ annotation .ObjectMeta `readiness.status.sidecar.istio.io/periodSeconds`  2  ]]
          failureThreshold: [[ annotation .ObjectMeta `readiness.status.sidecar.istio.io/failureThreshold`  30  ]]
        [[ end -]]securityContext:
          
          readOnlyRootFilesystem: true
          [[ if eq (annotation .ObjectMeta `sidecar.istio.io/interceptionMode` .ProxyConfig.InterceptionMode) "TPROXY" -]]
          capabilities:
            add:
            - NET_ADMIN
          runAsGroup: 1337
          [[ else -]]
          runAsUser: 1337
          [[ end -]]
        restartPolicy: Always
        resources:
          [[ if (isset .ObjectMeta.Annotations `sidecar.istio.io/proxyCPU`) -]]
          requests:
            cpu: "[[ index .ObjectMeta.Annotations `sidecar.istio.io/proxyCPU` ]]"
            memory: "[[ index .ObjectMeta.Annotations `sidecar.istio.io/proxyMemory` ]]"
        [[ else -]]
          requests:
            cpu: 10m
          
        [[ end -]]
        volumeMounts:
        - mountPath: /etc/istio/proxy
          name: istio-envoy
        - mountPath: /etc/certs/
          name: istio-certs
          readOnly: true
      volumes:
      - emptyDir:
          medium: Memory
        name: istio-envoy
      - name: istio-certs
        secret:
          optional: true
          [[ if eq .Spec.ServiceAccountName "" -]]
          secretName: istio.default
          [[ else -]]
          secretName: [[ printf "istio.%s" .Spec.ServiceAccountName ]]
          [[ end -]]
---
# Source: istio/charts/pilot/templates/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: istio-pilot-service-account
  namespace: istio-system
  labels:
    app: istio-pilot
    chart: pilot-1.0.6
    heritage: Tiller
    release: istio
---
# Source: istio/charts/pilot/templates/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: istio-pilot-istio-system
  labels:
    app: istio-pilot
    chart: pilot-1.0.6
    heritage: Tiller
    release: istio
rules:
- apiGroups: ["config.istio.io"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["rbac.istio.io"]
  resources: ["*"]
  verbs: ["get", "watch", "list"]
- apiGroups: ["networking.istio.io"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["authentication.istio.io"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["apiextensions.k8s.io"]
  resources: ["customresourcedefinitions"]
  verbs: ["*"]
- apiGroups: ["extensions"]
  resources: ["thirdpartyresources", "thirdpartyresources.extensions", "ingresses", "ingresses/status"]
  verbs: ["*"]
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["create", "get", "list", "watch", "update"]
- apiGroups: [""]
  resources: ["endpoints", "pods", "services"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["namespaces", "nodes", "secrets"]
  verbs: ["get", "list", "watch"]
---
# Source: istio/charts/pilot/templates/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: istio-pilot-istio-system
  labels:
    app: istio-pilot
    chart: pilot-1.0.6
    heritage: Tiller
    release: istio
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: istio-pilot-istio-system
subjects:
  - kind: ServiceAccount
    name: istio-pilot-service-account
    namespace: istio-system
---
# Source: istio/charts/pilot/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: istio-pilot
  namespace: istio-system
  labels:
    app: istio-pilot
    chart: pilot-1.0.6
    release: istio
    heritage: Tiller
spec:
  ports:
  - port: 15010
    name: grpc-xds # direct
  - port: 15011
    name: https-xds # mTLS
  - port: 8080
    name: http-legacy-discovery # direct
  - port: 9093
    name: http-monitoring
  selector:
    istio: pilot
---
# Source: istio/charts/pilot/templates/deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: istio-pilot
  namespace: istio-system
  # TODO: default template doesn't have this, which one is right ?
  labels:
    app: istio-pilot
    chart: pilot-1.0.6
    release: istio
    heritage: Tiller
    istio: pilot
  annotations:
    checksum/config-volume: f8da08b6b8c170dde721efd680270b2901e750d4aa186ebb6c22bef5b78a43f9
spec:
  replicas: 1
  template:
    metadata:
      labels:
        istio: pilot
        app: pilot
      annotations:
        sidecar.istio.io/inject: "false"
        scheduler.alpha.kubernetes.io/critical-pod: ""
    spec:
      serviceAccountName: istio-pilot-service-account
      containers:
        - name: discovery
          image: "gcr.io/istio-release/pilot:release-1.0-latest-daily"
          imagePullPolicy: IfNotPresent
          args:
          - "discovery"
          - --secureGrpcAddr
          - ":15011"
          ports:
          - containerPort: 8080
          - containerPort: 15010
          - containerPort: 15011
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 30
            timeoutSeconds: 5
          env:
          - name: POD_NAME
            valueFrom:
              fieldRef:
                apiVersion: v1
                fieldPath: metadata.name
          - name: POD_NAMESPACE
            valueFrom:
              fieldRef:
                apiVersion: v1
                fieldPath: metadata.namespace
          - name: PILOT_CACHE_SQUASH
            value: "5"
          - name: GODEBUG
            value: "gctrace=2"
          - name: PILOT_PUSH_THROTTLE_COUNT
            value: "100"
          - name: PILOT_TRACE_SAMPLING
            value: "1"
          resources:
            requests:
              cpu: 500m
              memory: 2048Mi
            
          volumeMounts:
          - name: config-volume
            mountPath: /etc/istio/config
          - name: istio-certs
            mountPath: /etc/certs
            readOnly: true
      volumes:
      - name: config-volume
        configMap:
          name: istio
      - name: istio-certs
        secret:
          secretName: istio.istio-pilot-service-account
          optional: true   
      affinity:      
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - amd64
                - ppc64le
                - s390x
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 2
            preference:
              matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - amd64
          - weight: 2
            preference:
              matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - ppc64le
          - weight: 2
            preference:
              matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - s390x
---
# Source: istio/templates/crds.yaml
#

# these CRDs only make sense when security is enabled
#

#
#
---
# Source: istio/charts/pilot/templates/gateway.yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: istio-autogenerated-k8s-ingress
  namespace: istio-system
spec:
  selector:
    istio: ingress
  servers:
  - port:
      number: 80
      protocol: HTTP2
      name: http
    hosts:
    - "*"
---
# Source: istio/charts/pilot/templates/autoscale.yaml
apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
    name: istio-pilot
    namespace: istio-system
spec:
    maxReplicas: 5
    minReplicas: 1
    scaleTargetRef:
      apiVersion: apps/v1beta1
      kind: Deployment
      name: istio-pilot
    metrics:
    - type: Resource
      resource:
        name: cpu
        targetAverageUtilization: 80
LAST DEPLOYED: Sat Mar 30 06:30:03 2019
NAMESPACE: istio-system
STATUS: DEPLOYED

RESOURCES:
==> v1/ConfigMap
NAME                    DATA  AGE
istio                   1     4s
istio-sidecar-injector  1     4s

==> v1/Service
NAME         TYPE       CLUSTER-IP      EXTERNAL-IP  PORT(S)                                AGE
istio-pilot  ClusterIP  10.106.159.203  <none>       15010/TCP,15011/TCP,8080/TCP,9093/TCP  3s

==> v1beta1/Deployment
NAME         DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
istio-pilot  1        1        1           0          3s

==> v1alpha3/Gateway
NAME                             AGE
istio-autogenerated-k8s-ingress  2s

==> v2beta1/HorizontalPodAutoscaler
NAME         REFERENCE               TARGETS        MINPODS  MAXPODS  REPLICAS  AGE
istio-pilot  Deployment/istio-pilot  <unknown>/80%  1        5        0         2s

==> v1/Pod(related)
NAME                          READY  STATUS             RESTARTS  AGE
istio-pilot-754ccc994f-t7wg2  0/1    ContainerCreating  0         3s

==> v1/ServiceAccount
NAME                         SECRETS  AGE
istio-pilot-service-account  1        5s

==> v1beta1/ClusterRole
NAME                      AGE
istio-pilot-istio-system  4s

==> v1beta1/ClusterRoleBinding
NAME                      AGE
istio-pilot-istio-system  4s
```