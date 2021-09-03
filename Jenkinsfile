pipeline {
  agent any
  environment {
    GIT_REPO_NAME = env.GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1')
    SOME_SECRET_KEY = credentials('some-secret-key')
    IMAGE_NAME = env.GIT_REPO_NAME
  }
  stages {
    stage('Package Docker container') {
      steps {
        sh 'echo ${SOME_SECRET_KEY}'
        sh 'docker build . -t "localhost:5000/${IMAGE_NAME}:${GIT_REPO_NAME}.${BRANCH_NAME}"'
        sh 'docker push localhost:5000/${IMAGE_NAME}:${GIT_REPO_NAME}.${BRANCH_NAME}'
        sh 'docker stop ${IMAGE_NAME} || true'
        sh 'docker run -d --rm --name ${IMAGE_NAME} -p 8080 localhost:5000/${IMAGE_NAME}:${GIT_REPO_NAME}.${BRANCH_NAME}'
        sh '''
          JENKINS_IMAGE_PORT=`docker port ${IMAGE_NAME} | egrep [0-9]+$ -o | head -1`
          echo "localhost:$JENKINS_IMAGE_PORT"
        '''
      }
    }

  }
}
