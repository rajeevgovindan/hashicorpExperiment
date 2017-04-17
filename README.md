# hashicorpExperiment

#
# Author : Rajeev Govindan
# Date   : 4/17/2017
#

Notes about the software:
-------------------------
1. This software uses Packer to create a EC2 AMI which has redis and consul installed on it. 

2. The consul cluster is going to be deployed in an Amazon VPC, which has two subnets. The consul cluster
   would have 3 nodes running consul servers on them. The consul cluster will be front ended with an 
   Amazon ELB. 

3. Along with the consul cluster, the terraform script also deploys a Redis instance from the EC2 AMI 
   that was created in step 1. The redis server will be started automatically during the deployment. 

4. The final service registration of the redis service to the consul cluster is done manually by
   logging into the Redis instance and then running the service registration. 


Steps to use the script:
------------------------
1. Download all of the files from github. 
2. Update vars.tf with your AWS access key and secret key. 
3. From the parent directory, run "packer build -var 'aws_access_key=$accesskey' -var 'aws_secret_key=$secret_key' packer.json
   Replace $access_key and $secret_key with your aws access_key and secret_key before running the above command.
4. Replace vars.tf with the redis_ami variable with the above AMI name that was created in step 3. 
5. From the parent directory, run "terraform apply". That will deploy the consul cluster and redis server. 
   The above command will output the consul's ELB DNS name at the very end. 
6. You will see the consul cluster coming up with an ELB in front of it. You can login to the http://ELB:8500/ui
   and check out the consul cluster. Notice that no services are registered yet. 
7. You can then ssh into the Redis ec2 instance and then in the home directory, you will see a script called 
   "startredis.sh". Invoke that script with a command line parameter of the dns name of one of the EC2 instance
   in the consul cluster. Something like - ./startredis.sh ec2-52-90-63-216.compute-1.amazonaws.com
8. Now if you login to the consul UI, you will see the registered service redis. 
