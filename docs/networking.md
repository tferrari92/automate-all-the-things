# AWS Networking 

For the creation of the AWS VPC we followed the [recommended VPC for EKS guidelines by Amazon](https://docs.aws.amazon.com/eks/latest/userguide/creating-a-vpc.html) for the "Public and private subnets" option. If you don't like reading [watch this](https://www.youtube.com/watch?v=nIIxexG7_a8&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=1&ab_channel=AntonPutra).

<p title="Diagram" align="center"> <img img width="800" src="https://i.imgur.com/8WJ03GV.jpg"> </p>

This VPC has two public and two private subnets. One public and one private subnet are deployed to the same Availability Zone. The other public and private subnets are deployed to a second Availability Zone in the same AWS Region. We recommend this option for most deployments.

The nodes will run in private subnets  THE PUBLIC SUBNETS ARE ONLY TO DEPLOT PUBLIC LOAD BALANCERS. NOT ANY NODES
One NAT Gatewasy in each private sn in each AZ for high availability, if something happens to one AZ we still have the other


With this option, you can deploy your nodes to private subnets. This option allows Kubernetes to deploy load balancers to the public subnets that can load balance traffic to Pods that run on nodes in the private subnets. Public IPv4 addresses are automatically assigned to nodes that are deployed to public subnets, but public IPv4 addresses aren't assigned to nodes deployed to private subnets.

The nodes in private subnets can communicate with the cluster and other AWS services. Pods can communicate to the internet through a NAT gateway using IPv4 addresses or outbound-only Internet gateway using IPv6 addresses deployed in each Availability Zone. A security group is deployed that has rules that deny all inbound traffic from sources other than the cluster or nodes but allows all outbound traffic. The subnets are tagged so that Kubernetes can deploy load balancers to them.

To all of this we added a private subnet for the databases and a public subnet EC2 instance, both of these in Availability Zone C.