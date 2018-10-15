pipeline {
  agent {
    kubernetes {
      label 'javaee-app2'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: cd-jenkins
  containers:
  - name: javaee-cafe
    env:
      - name: POSTGRES_USER
        valueFrom:
          configMapKeyRef:
            name: postgres-config
            key: postgres_user
      - name: POSTGRES_PASSWORD
        valueFrom:
          configMapKeyRef:
            name: postgres-config
            key: postgres_password
      - name: POSTGRES_HOST
        valueFrom:
          configMapKeyRef:
            name: hostname-config
            key: postgres_host
    image: hillmerch/javaee-cafe:v2
    command:
    - cat
    tty: true
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    command:
    - cat
    tty: true
---
apiVersion: v1
kind: Service
metadata:
  name: javaee-cafe
spec:
  type: LoadBalancer
  ports:
    - port: 9080
  selector:
    app: javaee-cafe
"""
}
  }



	tools {
		// Get the Maven tool.
		// ** NOTE: This 'maven_3_5_4' Maven tool must be configured
		// ** in the global configuration.
		maven 'maven_3_5_4'
	}

	stages {

		stage ('Build') {
			steps {
                    container('javaee-cafe') {
					    sh 'mvn clean package'
                    }
			}
		}


	}
}
