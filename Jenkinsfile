pipeline {

    agent any

    parameters{
        choice(name: 'ENV', choices: ['dev','staging','prod'], description: 'Select environment')
        choice(name: 'terraformAction', choices: ['apply','destroy'], description: 'Choose terraform action')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages{

        stage ('Git Checkout') {
            steps{
                checkout scm
            }
        }

        stage ('Terraform Init') {
            steps{
                sh """
                cd env/${params.ENV}
                terraform init
                """
            }
        }

        stage ('Terraform Plan') {
            steps{
                sh """
                cd env/${params.ENV}
                terraform plan -out tfplan
                terraform show -no-color tfplan > tfplan.txt
                """
            }
        }

        stage('Approval'){
            steps{
                script{
                    def plan = readFile "env/${params.ENV}/tfplan.txt"
                    input(
                        message: "Proceed with Terraform ${params.ENV}?",
                        parameters: [
                            text(name: 'Plan', description: 'Review the plan before proceeding', defaultValue: plan)
                        ]
                    )
                }
            }
        }

        stage('Apply or Destroy'){
            steps{
                script{
                    if (params.terraformAction == 'apply'){
                        sh """
                        cd env/${params.ENV}
                        terraform apply -input=false tfplan
                        """
                    } else {
                        sh """
                        cd env/${params.ENV}
                        terraform destroy -auto-approve
                        """
                    }
                }
            }
        }
    }
}
