pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                script {
                    // Read Slack webhook at runtime
                    withCredentials([string(credentialsId: 'slack-webhook', variable: 'WEBHOOK')]) {
                        def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
                        def message = "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"

                        sh """
                            curl -X POST -H 'Content-type: application/json' \
                              --data '{"text": "${message}"}' \
                              $WEBHOOK
                        """
                    }
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
                withCredentials([string(credentialsId: 'slack-webhook', variable: 'WEBHOOK')]) {
                    def statusEmoji = currentBuild.currentResult == 'SUCCESS' ? '✅' : '❌'
                    def statusText = currentBuild.currentResult == 'SUCCESS' ? 'Deployment succeeded' : 'Deployment failed'
                    def message = "${statusEmoji} *${statusText}* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"

                    sh """
                        curl -X POST -H 'Content-type: application/json' \
                          --data '{"text": "${message}"}' \
                          $WEBHOOK
                    """
                }
            }
        }
    }
}
