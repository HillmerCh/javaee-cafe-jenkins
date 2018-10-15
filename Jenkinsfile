pipeline {
  agent {
    kubernetes {
      defaultContainer 'jnlp'
      yaml """
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: javaee-cafe
  namespace: default
spec:
  replicas: 2
  template:
    metadata:
      name: javaee-cafe
      labels:
        app: javaee-cafe
    spec:
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
        image: javaee-cafe
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
					sh 'mvn clean package'
			}
		}

		stage ('Deploy') {

			steps {
					sh 'mvn deploy'
			}
		}
	}
}
