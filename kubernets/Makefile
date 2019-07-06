DOCKER_HOME = "/u01/docker"

all:
	@echo use specific target

app:
	kubectl run hostnames --image=francois/apache-hostname --labels=app=hostnames --port=80 --replicas=3
	kubectl apply -f nginx.yml
	kubectl apply -f ingress.yml

.PHONY: kubeless
kubeless:
	kubectl create ns kubeless
	kubectl apply -f kubeless/kubeless-non-rbac-v1.0.2.yaml

.PHONY: helm
helm:
	kubectl apply -f helm/helm.yaml
	kubectl apply -f helm/admin.yaml
	helm init --service-account helm

prometheus:
	helm install stable/prometheus-operator --namespace prometheus

nodes:
	kubectl get componentstatuses
	kubectl get nodes
dep:
	kubectl get deployments --all-namespaces
pods:
	kubectl get pod --all-namespaces
svc:
	kubectl get svc --all-namespaces
ing:
	kubectl get ing --all-namespaces

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
	ETCDCTL_API=2 etcdctl --endpoint=http://172.16.9.2:2379 set /coreos.com/network/config '{ "Network": "172.17.0.0/16", "Backend": {"Type": "vxlan"}}'
	docker-compose start master
	sleep 10
	docker-compose start dns
	sleep 3
	docker-compose up node1 node2
