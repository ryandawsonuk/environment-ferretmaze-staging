CHART_REPO := http://jenkins-x-chartmuseum:8080
DIR := "env"
NAMESPACE := "jx-staging"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm version
	helm init
	helm repo add releases ${CHART_REPO}
	helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
	helm repo add activiti-cloud-charts https://activiti.github.io/activiti-cloud-charts/
	helm repo add jenkins-x http://chartmuseum.build.cd.jenkins-x.io
	helm dependency build ${DIR}
	helm lint ${DIR}

install:
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --dry-run --debug
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:


