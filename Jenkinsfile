pipeline {
  agent any
  stages {

    stage('Docker build and push') {
      steps {
		   sh '''
		     whoami
		     aws configure set aws_access_key_id $ACCESS_KEY
		     aws configure set aws_secret_access_key $ACCESS_SECRET_KEY
		     aws configure set default.region ap-southeast-1
         	     aws ecr get-login-password -- aregionp-southeast-1 | docker login --username AWS --password-stdin 933542948767.dkr.ecr.ap-southeast-1.amazonaws.com
                     docker build -t shivaproject . 
                     docker tag shivaproject:latest 933542948767.dkr.ecr.ap-southeast-1.amazonaws.com/shivaproject:$(BUILD_NUMBER)
                     docker push 933542948767.dkr.ecr.ap-southeast-1.amazonaws.com/shivaproject:$(BUILD_NUMBER)
            	  '''
	     }	         
	   }

    stage('Deploy docker'){
      steps {
		     sh '''
                         ssh -i /var/lib/jenkins/.ssh/application.pem -o StrickHostKeyChecking=no ubuntu@ec2-3-0-19-69.ap-southeast-1.compute.amazonaws.com 'bash-s'< ./deploy.sh \$(BUILD_NUMBER)
            	        '''
      		}
		}		    

}

 }
