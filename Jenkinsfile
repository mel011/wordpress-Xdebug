pipeline {
  agent any

  environment {
    SLACK_CHANNEL = '#testing'
    GITHUB_REPO = 'mel011/wordpress-Xdebug.git'
  }

  options {
    ansiColor('xterm')
  }

  stages {
    stage('Start') {
      steps {
        script {
          def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
          slackSend(
            channel: SLACK_CHANNEL,
            message: "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Open Build #${env.BUILD_NUMBER}>)"
          )
        }
      }
    }

    stage('Deploy') {
      steps {
        echo "Deploying ${env.JOB_NAME} build ${env.BUILD_NUMBER}..."
        // your deployment steps here
      }
    }

    stage('Info') {
      steps {
        sh 'git rev-parse HEAD'
      }
    }
  }

  post {
    success {
      script {
        def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
        slackSend(
          channel: SLACK_CHANNEL,
          message: "✅ *Deployment succeeded* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
        )
      }
    }

    failure {
      script {
        def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
        slackSend(
          channel: SLACK_CHANNEL,
          message: "❌ *Deployment failed* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"
        )
      }
    }
  }
}

