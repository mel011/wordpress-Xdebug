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

    // Always post messages after build finishes, regardless of SCM changes
    post {
        always {
            script {
                def statusEmoji = currentBuild.currentResult == 'SUCCESS' ? '✅' : '❌'
                def statusText = currentBuild.currentResult == 'SUCCESS' ? 'Deployment succeeded' : 'Deployment failed'
                def message = "${statusEmoji} *${statusText}* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                
                sh """
                    curl -X POST -H 'Content-type: application/json' \
                      --data '{"text": "${message}"}' \
                      ${SLACK_WEBHOOK}
                """
            }
        }
    }
}