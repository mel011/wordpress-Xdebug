pipeline {
  agent any

  environment {
    SLACK_CHANNEL = '#testing'
    SLACK_WEBHOOK = credentials('slack-token') // if using CASC secret
  }

  stages {
    stage('Start') {
      steps {
        script {
          def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
          slackSend(
            channel: SLACK_CHANNEL,
            message: "🚀 Deployment started for ${env.JOB_NAME} on branch ${branch} (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)",
            webhookUrl: env.SLACK_WEBHOOK
          )
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
      slackSend(
        channel: SLACK_CHANNEL,
        message: "✅ Deployment succeeded for ${env.JOB_NAME} (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)",
        webhookUrl: env.SLACK_WEBHOOK
      )
    }

    failure {
      slackSend(
        channel: SLACK_CHANNEL,
        message: "❌ Deployment failed for ${env.JOB_NAME} (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)",
        webhookUrl: env.SLACK_WEBHOOK
      )
    }
  }
}
