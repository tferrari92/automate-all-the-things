# Networking Notes

## EKS

For the creation of the AWS VPC we followed the [recommended VPC for EKS guidelines by Amazon](https://docs.aws.amazon.com/eks/latest/userguide/creating-a-vpc.html) for the "Public and private subnets" option. If you don't like reading [watch this](https://www.youtube.com/watch?v=nIIxexG7_a8&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=1&ab_channel=AntonPutra).

<p title="Diagram" align="center"> <img img width="600" src="https://i.imgur.com/8WJ03GV.jpg"> </p>

The VPC has two public and two private subnets. A public subnet's associated route table has a route to an internet gateway. However, the route table of a private subnet doesn't have a route to an internet gateway. One public and one private subnet are deployed to the same Availability Zone. The other public and private subnets are deployed to a second Availability Zone in the same AWS Region.

The nodes will run in private subnets. The public subnets are there only for the load balancers that will forward traffic to Pods that run on nodes in the private subnets.
There's one NAT Gateway in each private subnet in each AZ for high availability, if something happens goes wrong in one Availability Zone we still have the other.

The nodes in private subnets can communicate with the cluster and other AWS services. Pods can communicate to the internet through the NAT gateways. A security group is deployed that has rules that deny all inbound traffic from sources other than the cluster or nodes but allows all outbound traffic. The subnets are tagged so that Kubernetes can deploy load balancers to them.

## Other

There's an extra pair of private and public subnets for other resources. Both of these are deployed in a third Availability Zone, separate from the EKS cluster.

The private subnet is for the ElastiCache databases. The public subnet is for the EC2 instance.
