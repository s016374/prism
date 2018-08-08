pipeline {
  parameters {
    string(defaultValue: 'N', description: 'DISTRIBUTE_VERSION', name: 'DISTRIBUTE_VERSION')
    string(defaultValue: '1', description: 'REPLICATION', name: 'REPLICATION')
    string(defaultValue: 'qa', description: 'STAGE', name: 'STAGE')
    string(defaultValue: '', description: 'HARBOR', name: 'HARBOR')
    string(defaultValue: '', description: 'IMAGE_SIDECAR', name: 'IMAGE_SIDECAR')
  }

  agent {
    node {
      label "docker"
      customWorkspace "workspace/${env.JOB_NAME}"
    }
  }

  stages {
    stage("Package") {
      steps {
        writeFile file: 'Dockerfile',
        text: """FROM ${params.HARBOR}/${params.IMAGE_SIDECAR}
ADD . ."""
        sh "docker build -t ${params.HARBOR}/test/prism:${env.BUILD_NUMBER} ${env.WORKSPACE}"
        sh "docker push ${params.HARBOR}/test/prism:${env.BUILD_NUMBER}"
      }
    }
    stage("Deploy") {
      when {
        expression { params.DISTRIBUTE_VERSION == 'N' }
      }
      steps {
        writeFile file: "prism.yaml",
        text: """apiVersion: batch/v1
kind: Job
metadata:
  name: prism
  namespace: qa
  labels:
    project: prism
    own: dgg
    environment: ${params.STAGE}
    tier: backend
    run: capybara
spec:
  template:
    metadata:
      labels:
        project: prism
        own: dgg
        environment: ${params.STAGE}
        tier: backend
        run: capybara
    spec:
      nodeSelector:
        kubernetes.io/hostname: viking
      imagePullSecrets:
        - name: dm-registry-secret
      restartPolicy: Never
      containers:
      - name: prism
        image: ${params.HARBOR}/test/prism:${env.BUILD_NUMBER}
        env:
        - name: CAPYBARA_BROWSER
          value: "selenium_headless_chrome"
        - name: CAPYBARA_SELENIUM_HUB
          value: "http://selenium-hub.qa.svc/wd/hub"
        - name: CAPYBARA_MAX_WAIT_TIME
          value: "3"
        - name: BASE_URL
          value: "https://w.x.com"
        - name: COOKIE_UID
          value: "1111"
        - name: TEST_USERNAME
          value: "username"
        - name: TEST_PASSWORD
          value: "password"
        - name: FIREMAN_REPORT
          value: "active"
        - name: FIREMAN_HOST
          value: "http://fireman.qa.svc"
        - name: FIREMAN_USER
          value: "username"
        - name: FIREMAN_PASSWORD
          value: "password"
        - name: JENKINS_REPORT
          value: "active"
        resources:
          requests:
            memory: "100Mi"
            cpu: "60m"
          limits:
            memory: "600Mi"
            cpu: "600m"
        command: ["sh","-c","bundle && bundle exec cucumber"]"""
        sh "kubectl create -f prism.yaml"
      }
    }
  }
}
