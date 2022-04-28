curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash

sudo apt-get install gitlab-runner

sudo gitlab-runner register



pipeline {
    
    agent any 
    
    environment{
         #creating log ,downloads and uploads folder
         mkdir -p /mlops-app/logs
         mkdir -p /mlops-app/uploads
         mkdir -p /mlops-app/downloads
     }

cd /mlops-app

 stages{
         echo "node version..............."
         node --version
         echo "installing angular/cli ............."
         npm install -g @angular/cli > /dev/null


         echo "executing npm install ..................."
         npm install
         echo "executing ng build ...................."
         ng build --prod
         }

cd ..

stage('Build Dockerimage'){
            steps {
                script{
                     echo "ziping the files"
                     zip -r autoamtion-master.zip autoamtion-master
                     #tar cvzf autoamtion-master-$BUILD_NUMBER.tar.gz /autoamtion-master


                     ssh-copy-id-i .ssh/$Home.id_rsa.pub azureuser@10.10.164.4
                     ssh azureuser@10.10.164.4
                     ssh demo@10.0.8.4
                     ssh -i ~/.ssh/your-key azureuser@10.10.164.4
					}
                }
		    }		
stage('uploading Image'){
            steps{
                script{
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
                    }
				}
			}
		}	
