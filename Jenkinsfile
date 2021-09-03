pipeline {
  agent any
  environment {
    GIT_REPO_NAME = env.GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1')
    SOME_SECRET_KEY = credentials('some-secret-key')
  }
  stages {
    stage('Package Docker container') {
      steps {
        sh 'echo ${SOME_SECRET_KEY}'
        sh 'docker build . -t "localhost:5000/${GIT_REPO_NAME}-${BRANCH_NAME}"'
        sh 'docker push localhost:5000/${GIT_REPO_NAME}-${BRANCH_NAME}'
        sh 'docker stop ${GIT_REPO_NAME}-${BRANCH_NAME} || true'
        sh 'docker run -d --rm --name ${GIT_REPO_NAME}-${BRANCH_NAME} -p 8080 localhost:5000/${GIT_REPO_NAME}-${BRANCH_NAME}'
        sh '''
          JENKINS_IMAGE_PORT=`docker port ${GIT_REPO_NAME}-${BRANCH_NAME} | egrep [0-9]+$ -o | head -1`
          echo "localhost:$JENKINS_IMAGE_PORT"
        '''
      }
    }

  }
}
