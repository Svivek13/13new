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

stage('Build Dockerimage'){
            steps {
                script{
                     echo "ziping the files"
			ls
			pwd
                     #zip -r autoamtion-master.zip autoamtion-master
                     tar cvzf autoamtion-master-$BUILD_NUMBER.tar.gz /autoamtion-master
		}
       }
}		
stage('uploading Image'){
            steps{
                script{
                     scp -r azureuser@<10.10.164.4>:/home/var/lib/jenkins/workspace/autoamtion-master.zip demovm@10.0.8.4/tmp
			ssh demovm@10.0.8.4
                        cd /tmp
                        ssh azureuser@<10.10.164.4> "build=${BUILD_NUMBER}" bash -s <<'ENDSSH'
                        echo "............Deploying ${build}..........................."
                        cd /home/azueruser
                        pwd
                        rm -rf autoamtion-master
                        echo ".....................Listing Current files and dir......................"
                        ls -lart
                        mkdir autoamtion-master
                        echo ".......................Listing Current files and dir............................"
                        ls -lart
                        tar -xvf "/home/mlopsuser/autoamtion-master-${build}.tar.gz" -C "/home/azueruser/autoamtion-master"
                    }
		}
	}
}	
