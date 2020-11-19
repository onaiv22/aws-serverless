pipeline {
    agent any
    //parameters {
        //string(name: 'branch', defaultValue: 'master', description: 'branch to deploy')
    //}
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY_ID = credentials('aws_secret_access')
        TF_IN_AUTOMATION      = "TRUE"
        TF_INPUT              = "0"
        TF_LOG                = "WARN"
    }
    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '6'))

    }

    stages {
        stage('Cleanup workspace') {
            steps {
                cleanWs deleteDirs: true, disableDeferredWipeout: true
            }
        }
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM',
                branches: [[name: '*/master' ]],
                doGenerateSubmoduleConfigurations: false,
                extensions: [], submoduleCfg: [],
                userRemoteConfigs: [[
                    url: 'https://github.com/onaiv22/aws-serverless.git'
                    ]]
                ])
            }
        }
        stage('Run terraform init') {
            steps {
                dir('aws-serverless') {
                    sh """
                        echo "initializing terraform"
                        terrafom init
                    """
                }
            }
        }
        stage('Run terraform plan') {
            steps {
                dir('aws-serverless') {
                    sh"""
                        echo "running terraform plan"
                        terraform plan
                    """
                }
            }
        }
        stage('prompt to apply') {
           steps {
               input message: "Do you want to deploy this?", ok: "Yes"
           }
        }
        stage('run terraform apply') {
            steps {
                dir('aws-serverless') {
                    sh"""
                        echo "running terraform apply"
                        terraform apply
                """
                }
            }
        }
    }
    post {
        success {
            mail bcc: '', body: 'This terraform infrastructure was successful', cc: '', from: '', replyTo: '', subject: 'success build', to: 'onaiv22@gmail.com'
        }
        failure {
            mail bcc: '', body: 'This terraform infrastructure was successful', cc: '', from: '', replyTo: '', subject: 'build failed', to: 'onaiv22@gmail.com'
        }
    }

}
