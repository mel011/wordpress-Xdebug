pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out repo...'
                git branch: 'main', url: 'git@github.com:mel011/wordpress-Xdebug.git'
            }
        }
        stage('Test') {
            steps {
                echo 'Repo checkout successful!'
            }
        }
    }
}

