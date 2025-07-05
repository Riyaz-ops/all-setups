#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
mv kops /usr/local/bin/kops

export KOPS_STATE_STORE=s3://riyaz.flm.k8s
kops create cluster --name kuber.k8s.local --zones us-east-1a,us-east-1b --master-count=1 --master-size t2.medium --master-volume-size 30 --node-count=2 --node-size t2.micro --node-volume-size 30 --image ami-020cba7c55df1f615 --yes
kops update cluster --name kuber.k8s.local --yes --admin
