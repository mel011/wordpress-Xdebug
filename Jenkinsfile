pipeline {
  agent any

  environment {
    SLACK_CHANNEL = '#testing'
  }

  stages {
    stage('Start') {
      steps {
        script {
          def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'main').replaceFirst(/^origin\//, '')
          slackSend(
            channel: SLACK_CHANNEL,
            color: '#439FE0',
            message: "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
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
        color: 'good',
        message: "✅ *Deployment succeeded* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
      )
    }

    failure {
      slackSend(
        channel: SLACK_CHANNEL,
        color: 'danger',
        message: "❌ *Deployment failed* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
      )
    }
  }
}
