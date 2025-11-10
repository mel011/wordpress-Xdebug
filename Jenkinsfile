pipeline {
    agent any

    environment {
        // Uses the credential ID you added via Groovy (slack-webhook)
        SLACK_WEBHOOK = credentials('slack-webhook')
    }

    stages {
        stage('Start') {
            steps {
                script {
                    def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
                    def message = "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"

                    // Send Slack message
                    sh """
                        curl -s -X POST -H 'Content-type: application/json' \
                          --data '{"text": "${message.replaceAll('"', '\\\\"')}"}' \
                          "${SLACK_WEBHOOK}"
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying ${env.JOB_NAME}..."
                // Add deployment steps here, e.g. build scripts, SSH deploy, etc.
            }
        }
    }

    post {
        success {
            script {
                def message = "✅ *Deployment succeeded* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                sh """
                    curl -s -X POST -H 'Content-type: application/json' \
                      --data '{"text": "${message.replaceAll('"', '\\\\"')}"}' \
                      "${SLACK_WEBHOOK}"
                """
            }
        }

        failure {
            script {
                def message = "❌ *Deployment failed* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                sh """
                    curl -s -X POST -H 'Content-type: application/json' \
                      --data '{"text": "${message.replaceAll('"', '\\\\"')}"}' \
                      "${SLACK_WEBHOOK}"
                """
            }
        }
    }
}
