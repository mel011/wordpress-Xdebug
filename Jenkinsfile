pipeline {
    agent any

    stages {
        stage('Notify Slack (Start)') {
            steps {
                script {
                    // Determine branch safely for manual builds
                    def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'manual')
                    def message = "🚀 Deployment started for ${env.JOB_NAME} on branch ${branch} (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"

                    // Trigger Slack_Notifier job inside Jenkins
                    build job: 'Slack_Notifier', parameters: [
                        string(name: 'BRANCH', value: branch),
                        string(name: 'MESSAGE', value: message)
                    ]
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying ${env.JOB_NAME}..."
                // Place your actual deployment logic here
            }
        }
    }

    post {
        always {
            script {
                def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'manual')
                def statusEmoji = currentBuild.currentResult == 'SUCCESS' ? '✅' : '❌'
                def statusText = currentBuild.currentResult == 'SUCCESS' ? 'Deployment succeeded' : 'Deployment failed'
                def message = "${statusEmoji} ${statusText} for ${env.JOB_NAME} on branch ${branch} (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"

                // Trigger Slack_Notifier job for post-build message
                build job: 'Slack_Notifier', parameters: [
                    string(name: 'BRANCH', value: branch),
                    string(name: 'MESSAGE', value: message)
                ]
            }
        }
    }
}