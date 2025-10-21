pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t sieve-docker .'
            }
        }

        stage('Test 1') {
            steps {
                sh 'echo "1" | docker run --rm -i sieve-docker'
            }
        }

        stage('Test 100') {
            steps {
                sh 'echo "100" | docker run --rm -i sieve-docker'
            }
        }

        stage('Test 84') {
            steps {
                sh 'echo "84" | docker run --rm -i sieve-docker'
            }
        }

        stage('Test a') {
            steps {
                script {
                    try {
                        sh 'echo "a" | docker run --rm -i sieve-docker'
                    } catch (Exception e) {
                        echo "Test failed as expected for invalid input 'a'"
                    }
                }
            }
        }

        stage('Test -1') {
            steps {
                script {
                    try {
                        sh 'echo "-1" | docker run --rm -i sieve-docker'
                    } catch (Exception e) {
                        echo "Test failed as expected for invalid input -1"
                    }
                }
            }
        }

        stage('Package') {
            steps {
                sh 'docker tag sieve-docker sieve-docker:latest'
                // Add push to registry if needed, e.g., sh 'docker push sieve-docker:latest'
            }
        }
    }
}
