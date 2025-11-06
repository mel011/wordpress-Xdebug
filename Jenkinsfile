pipeline {
    agent any

    // Add a parameter to allow forcing the Slack notifications
    parameters {
        booleanParam(name: 'FORCE_SLACK', defaultValue: true, description: 'Always send Slack messages even if no SCM changes')
    }

    stages {
        stage('Notify Slack (Start)') {
            when {
                expression { 
                    // Fire if there are SCM changes OR FORCE_SLACK is true
                    return params.FORCE_SLACK || currentBuild.changeSets.size() > 0 
                }
            }
            steps {
                script {
                    def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'manual')
                    def message = "🚀 Deployment started for ${env.JOB_NAME} on branch ${branch} (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"

                    // Trigger preconfigured Slack notifier job
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
                // Your deployment logic goes here
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

                // Trigger Slack notifier job for post-build message
                build job: 'Slack_Notifier', parameters: [
                    string(name: 'BRANCH', value: branch),
                    string(name: 'MESSAGE', value: message)
                ]
            }
        }
    }
}