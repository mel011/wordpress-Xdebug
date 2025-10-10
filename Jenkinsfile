pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out repo...'
                git branch: 'master', url: 'git@github.com:mel011/wordpress-Xdebug.git'
            }
        }
        stage('Build/Test') {
            steps {
                echo 'Running a test command...'
                sh 'ls -l'          // List repo files to confirm checkout
            }
        }
    }
}

