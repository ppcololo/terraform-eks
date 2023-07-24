# Test task 

## Automate EKS cluster setup on AWS
You've joined a new and growing startup. The company wants to build its initial Kubernetes infrastructure on AWS.

They have asked you if you can help create the following:
* Terraform code that deploys an EKS cluster (whatever latest version is currently available) into an existing VPC
* The terraform code should also prepare anything needed for a pod to be able to assume an IAM role
* Include a short readme that explains how to use the Terraform repo and that also demonstrates how an end-user (a developer from the company) can run a pod on this new EKS cluster and also have an IAM role assigned that allows that pod to access an S3 bucket.

## HowTo deploy
Prerequisites 
* AWS account
    - access key / secret key for API access with proper permissions
    - aws-cli v2
* terraform >= v1.5
* kubectl >= v1.26

Steps:
* git clone this repo and deploy tf modules
```bash
terraform init
terraform apply
```
After everything was created - update k8s config and apply test-pod manifest (use your AWS account id instead placeholder, also replace it inside `test_pod.yaml`):
```bash
aws eks update-kubeconfig --region eu-west-1 --name test-eks-cluster
kubectl config use-context arn:aws:eks:eu-west-1:1111111111:cluster/test-eks-cluster
kubectl apply -f test_pod.yaml
```
After pod created you have to go inside and install `awscli` to check s3 access:
```bash
kubectl exec -it test-pod -- bash
```
Inside pod:
```bash
apt update
apt install -y awscli
aws s3 ls
```