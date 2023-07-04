# terraform-aws

Building this architecture: [https://docs.aws.amazon.com/whitepapers/latest/web-application-hosting-best-practices/an-aws-cloud-architecture-for-web-hosting.html](https://docs.aws.amazon.com/whitepapers/latest/web-application-hosting-best-practices/an-aws-cloud-architecture-for-web-hosting.html)

Likely swapping out the EC2 instances with ECS and using Fargate as the provider.

Then, I will create a GitHub actions workflow to build and deploy containers onto the platform and create a GitHub actions workflow to manage the terraform changes. 

The goal is to understand everything I am building and why, read all of the different attributes for each Terraform resource I'm using and decide whether it's relevant.
