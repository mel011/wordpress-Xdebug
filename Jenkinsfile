// Fully scripted Jenkinsfile for reliable Slack notifications

node {
    // Determine branch name safely for manual builds
    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'manual'

    // --- Slack start message ---
    withCredentials([string(credentialsId: 'slack-webhook', variable: 'WEBHOOK')]) {
        def startMsg = "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
        sh """
            curl -X POST -H 'Content-type: application/json' \
              --data '{\"text\": \"${startMsg}\"}' \
              $WEBHOOK
        """
    }

    // --- Deploy stage ---
    stage('Deploy') {
        echo "Deploying ${env.JOB_NAME}..."
        // Add your deployment logic here
    }

    // --- Post-build Slack message ---
    withCredentials([string(credentialsId: 'slack-webhook', variable: 'WEBHOOK')]) {
        def statusEmoji = currentBuild.currentResult == 'SUCCESS' ? '✅' : '❌'
        def statusText = currentBuild.currentResult == 'SUCCESS' ? 'Deployment succeeded' : 'Deployment failed'
        def postMsg = "${statusEmoji} *${statusText}* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"

        sh """
            curl -X POST -H 'Content-type: application/json' \
              --data '{\"text\": \"${postMsg}\"}' \
              $WEBHOOK
        """
    }
}