pipeline {
  agent {
    kubernetes {
      label 'sample-app'
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
    image: hillmerch/javaee-cafe:v2
    command:
    - cat
    tty: true
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    command:
    - cat
    tty: true
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
