## Amazon AWS setup

As stated in the readme, the selected EC2 instance is an x86 t3.micro deployment with Ubuntu 20.04LTS server selected as the OS. Other deployments are of course possible. 

### AWS firewall settings
The ports need to be allowed for ingress:
 - (SSH port 22 - this is enabled by default)
 - TCP port 80
 - TCP port 443
 - UDP ports 51610-65535
