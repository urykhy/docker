DOCKER_HOME = "/u01/docker"
export ETCDCTL_API=2
export ETCDCTL_ENDPOINT=http://172.16.9.2:2379

all:
	@echo use specific target

app:
	kubectl run hostnames --image=francois/apache-hostname --labels=app=hostnames --port=80 --replicas=3

.PHONY: kubeless
kubeless:
	kubectl create ns kubeless
	kubectl apply -f kubeless/kubeless-non-rbac-v1.0.2.yaml
	kubeless function deploy hello --runtime python2.7 --from-file kubeless/test.py --handler test.hello
	kubeless trigger http create hello --function-name hello --hostname function.com

prometheus:
	# kubectl delete crd prometheuses.monitoring.coreos.com prometheusrules.monitoring.coreos.com servicemonitors.monitoring.coreos.com alertmanagers.monitoring.coreos.com
	helm install sweet-bumblebee stable/prometheus-operator --namespace prometheus \
		--set kubeDns.enabled=false \
		--set coreDns.enabled=false \
		--set kubeControllerManager.enabled=false \
		--set kubeEtcd.enabled=false \
		--set kubeProxy.enabled=false \
		--set kubeScheduler.enabled=false \
		--set alertmanager.enabled=false \
		--set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
		--set prometheus.prometheusSpec.ruleSelectorNilUsesHelmValues=false

nginx:
	helm install loitering-dragon stable/nginx-ingress --namespace kube-system \
		--set controller.stats.enabled=true                   \
		--set controller.metrics.serviceMonitor.enabled=true  \
		--set controller.metrics.serviceMonitor.namespace=prometheus \
		--set controller.metrics.enabled=true           	  \
		--set controller.service.type=NodePort 				  \
		--set controller.service.nodePorts.http=30080
	kubectl apply -f ingress.yml

.PHONY: nfs
nfs:
	helm install calling-tarsier stable/nfs-client-provisioner --namespace kube-system \
		--set nfs.server=10.103.10.3 \
		--set nfs.path=/u01/common \
		--set nfs.mountOptions="{nolock}"
	kubectl apply -f nfs/deployment.yml

.PHONY: web-view
web-view:
	kubectl apply -f web-view/deployment.yaml
	kubectl apply -f web-view/rbac.yaml
	kubectl apply -f web-view/service.yaml

.PHONY: filebeat
filebeat:
	kubectl apply -f filebeat/deployment.yaml

.PHONY: metrics
metrics:
	helm install rude-chipmunk stable/metrics-server \
		--namespace kube-system \
		--set args="{--v=4,--kubelet-insecure-tls,--kubelet-preferred-address-types=InternalIP\,Hostname\,InternalDNS\,ExternalDNS\,ExternalIP}"
	helm install fair-ladybird stable/prometheus-adapter \
		--namespace kube-system \
		--set prometheus.url="http://sweet-bumblebee-prometheus-prometheus.prometheus.svc.k8s." \
		--set resources.limits.cpu=200m \
		-f metrics/custom
	kubectl apply -f metrics/hpa

.PHONY: sentry
sentry:
	helm install adoring-carson incubator/sentry-kubernetes \
		--namespace kube-system \
		--set sentry.dsn=http://7267c0b2b79f4fd7b819cb8e7bcfc063:d99d52b6b6a54f5fb80e0e8cf73d6860@web.sentry.docker:9000/3

.PHONY: rclone
rclone:
	kubectl apply -f rclone/deployment.yml

nodes:
	kubectl get componentstatuses
	kubectl get nodes
dep:
	helm list --all --all-namespaces
	kubectl get deployments --all-namespaces
pods:
	kubectl get pod --all-namespaces
svc:
	kubectl get svc --all-namespaces
ing:
	kubectl get ing --all-namespaces
end:
	kubectl get endpoints --all-namespaces
axfr:
	dig axfr k8s @dns.kubernets.docker
top:
	kubectl top pod --all-namespaces=true
hpa:
	kubectl describe hpa hostnames
sm:
	kubectl get servicemonitor --all-namespaces=true


create:
	docker-compose stop
	docker-compose rm -f
	sudo bash -c "rm -rf $(DOCKER_HOME)/volumes/kube-etcd/_data/*"
	sudo bash -c "rm -rf $(DOCKER_HOME)/volumes/kube-node*/_data/*"
	docker-compose build
	docker-compose create
start:
	docker-compose start etcd
	sleep 1
	etcdctl set /coreos.com/network/config '{ "Network": "172.17.0.0/16", "Backend": {"Type": "vxlan"}}'
	docker-compose start master
	sleep 10
	docker-compose start dns
	sleep 3
	docker-compose up node1 node2
define subnet_script =
	for x in `etcdctl ls /coreos.com/network/subnets/`; do n=`basename $x`; echo -n "$n\t"; etcdctl get $x; done
endef
subnet: ; @$(value subnet_script)
