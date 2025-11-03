pipeline {
  agent any

  environment {
    SLACK_CHANNEL = '#testing'
    SLACK_WEBHOOK = "${env.SLACK_WEBHOOK}"
  }

  stages {
    stage('Start') {
      steps {
        script {
          def branch = (env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'master').replaceFirst(/^origin\//, '')
          sh """
            curl -X POST -H 'Content-type: application/json' \
              --data '{"text": "🚀 *Deployment started* for *${env.JOB_NAME}* on branch `${branch}` (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"}' \
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

  post {
    success {
      sh """
        curl -X POST -H 'Content-type: application/json' \
          --data '{"text": "✅ *Deployment succeeded* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"}' \
          ${SLACK_WEBHOOK}
      """
    }

    failure {
      sh """
        curl -X POST -H 'Content-type: application/json' \
          --data '{"text": "❌ *Deployment failed* for *${env.JOB_NAME}* (<${env.BUILD_URL}|Build #${env.BUILD_NUMBER}>)"}' \
          ${SLACK_WEBHOOK}
      """
    }
  }
}
