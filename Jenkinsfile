
mkdir -p /mlops-app/logs
mkdir -p /mlops-app/uploads
mkdir -p /mlops-app/downloads


cd /mlops-app

sudo apt install -y jre
echo "node version..............."
java -version
echo "installing angular/cli ............."
sudo apt install jdk
javac -version





cd ..


echo "zipping the files"
zip -r autoamtion-master.zip autoamtion-master
#tar cvzf autoamtion-master-$BUILD_NUMBER.tar.gz /autoamtion-master

ssh key-gen -t id-rsa
ssh-copy-id-i $Home/.ssh.id_rsa.pub azureuser@10.10.164.4
ssh azureuser@10.10.164.4
ssh demovm@10.0.8.4
ssh -i ~/.ssh/your-key azureuser@10.10.164.4


scp -r azureuser@<10.10.164.4>:/home/var/lib/jenkins/workspace/autoamtion-master.zip demovm@10.0.8.4/tmp
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


echo "...................stopping pm2 instances..............."
pm2 stop mlops

echo "...................deleting existing pm2 instances .............."
pm2 delete mlops
sleep 10

cd /home/mlopsuser/mlops-app/var/lib/jenkins/workspace/mlops-app

echo "....................starting pm2.............."
pm2 start npm --name mlops -- run start:server

echo "....................saving pm2 to latest version .............."
sudo pm2 startup
sudo systemctl start pm2-root.service

pm2 save --force
echo "....................pm2 list............"
pm2 list

ENDSSH





pipeline {
    
    agent any 
    
    environment{
        dockerImage = ''
        registry = 'vivek13s/java_app'
        credentialsId = 'docker_hub'
    }
    
    stages{
        stage('Checkout'){
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Svivek13/13new']]]) }
            }
        
        stage('Build Dockerimage'){
            steps {
                script{
                    dockerImage =  docker.build registry
                }
            }
        }
        
        stage('uploading Image'){
            steps{
                script{
                    docker.withRegistry(credentialsId: 'docker_hub', url: 'https://hub.docker.com/'){
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
