pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                // Ensure we have a branch name even for manual runs
                script {
                    // Do a checkout to populate env variables properly
                    checkout scm
                    env.BUILD_BRANCH = env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'manual'
                }
            }
        }

        stage('Start') {
            steps {
                script {
                    // Send Slack start message
                    sendSlack("🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${env.BUILD_BRANCH}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)")
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying ${env.JOB_NAME}..."
            }
        }
    }

    post {
        always {
            script {
                // Send Slack post-build message
                def statusEmoji = currentBuild.currentResult == 'SUCCESS' ? '✅' : '❌'
                def statusText = currentBuild.currentResult == 'SUCCESS' ? 'Deployment succeeded' : 'Deployment failed'
                sendSlack("${statusEmoji} *${statusText}* for *${env.JOB_NAME}* on branch `${env.BUILD_BRANCH}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)")
            }
        }
    }
}

// Helper function to send Slack messages using credentials
def sendSlack(String message) {
    withCredentials([string(credentialsId: 'slack-webhook', variable: 'WEBHOOK')]) {
        sh """
            curl -X POST -H 'Content-type: application/json' \
              --data '{"text": "${message}"}' \
              $WEBHOOK
        """
    }
}