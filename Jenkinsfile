node("master") {
    withFolderProperties{
        stage('Checkout') {
            checkout([
                $class: 'GitSCM',
                branches: scm.branches,
                doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
                extensions: [[$class: 'CloneOption', noTags: false, shallow: false, depth: 0, reference: '']],
                userRemoteConfigs: scm.userRemoteConfigs,
            ])
        }
        stage('AWS login') {
           sh """export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY} && \
           export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY}
           export AWS_DEFAULT_REGION='eu-central-1' && \
           chmod +x ./login_aws.sh && ./login_aws.sh
           """
        }
        stage('Build and push') {
               sh 'docker build -t ${REGISTRY_PATH}/golang .'
               sh 'docker push ${REGISTRY_PATH}/golang'
        }
    }
}
