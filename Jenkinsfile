pipeline {
    
    agent any 
    
    environment{
         mkdir -p /mlops-app/logs
     }

cd /mlops-app

 stages{
         sudo apt install jre
	 echo "node version..............."
         java -version
         echo "installing angular/cli ............."
         sudo apt install jdk
         echo "executing npm install ..................."
         javac -version
         }

cd ..

stage('Zip'){
        steps {
                script{
			echo "ziping the files"
			ls
			pwd
			zip -r autoamtion-master.zip automation-master
			tar cvzf autoamtion-master-$BUILD_NUMBER.tar.gz /autoamtion-master
			}
		}
	}
}		
