pipeline {
    
    agent any 
    
    environment{
         mkdir -p /mlops-app/logs
     }

cd /mlops-app
sudo apt install jre
echo "node version..............."
java -version
echo "installing angular/cli ............."
sudo apt install jdk
echo "executing npm install ..................."
javac -version

cd ..

stage('Zip'){
        steps {
                script{
			echo "ziping the files"
			ls
			pwd
			}
		}
	}
}		
