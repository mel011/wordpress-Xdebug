pipeline {
    agent any

    // Pull the Slack webhook from Jenkins credentials (Secret Text)
    environment {
        SLACK_WEBHOOK = credentials('slack-webhook') 
    }

    stages {
        stage('Start') {
            steps {
                script {
                    def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
                    def message = "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                    sh """
                        curl -X POST -H 'Content-type: application/json' \
                          --data '{"text": "${message}"}' \
                          ${SLACK_WEBHOOK}
                    """
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
        success {
            script {
                def message = "✅ *Deployment succeeded* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                sh """
                    curl -X POST -H 'Content-type: application/json' \
                      --data '{"text": "${message}"}' \
                      ${SLACK_WEBHOOK}
                """
            }
        }

        failure {
            script {
                def message = "❌ *Deployment failed* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                sh """
                    curl -X POST -H 'Content-type: application/json' \
                      --data '{"text": "${message}"}' \
                      ${SLACK_WEBHOOK}
                """
            }
        }
    }
}