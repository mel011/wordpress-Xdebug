// Multibranch-friendly scripted pipeline with reliable Slack notifications

node {
    stage('Notify Slack (Start)') {
        script {
            // Determine branch safely, fallback to 'manual'
            def branch = env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'manual'

            // Send Slack message
            withCredentials([string(credentialsId: 'slack-webhook', variable: 'WEBHOOK')]) {
                def startMsg = "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                sh """
                    curl -X POST -H 'Content-type: application/json' \
                      --data '{\"text\": \"${startMsg}\"}' \
                      $WEBHOOK
                """
            }
        }
    }

    // --- Deploy stage ---
    stage('Deploy') {
        echo "Deploying ${env.JOB_NAME}..."
        // Your deployment logic here
    }

    // --- Post-build Slack message ---
    stage('Notify Slack (Post)') {
        script {
            def branch = env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'manual'
            def statusEmoji = currentBuild.currentResult == 'SUCCESS' ? '✅' : '❌'
            def statusText = currentBuild.currentResult == 'SUCCESS' ? 'Deployment succeeded' : 'Deployment failed'

            withCredentials([string(credentialsId: 'slack-webhook', variable: 'WEBHOOK')]) {
                def postMsg = "${statusEmoji} *${statusText}* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
                sh """
                    curl -X POST -H 'Content-type: application/json' \
                      --data '{\"text\": \"${postMsg}\"}' \
                      $WEBHOOK
                """
            }
        }
    }
}