import * as cdk from '@aws-cdk/core';
import * as ecr from '@aws-cdk/aws-ecr';
import * as ecs from '@aws-cdk/aws-ecs';
import * as ec2 from '@aws-cdk/aws-ec2';
import * as elbv2 from '@aws-cdk/aws-elasticloadbalancingv2';

export class InfraStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const cidr = '10.0.0.0/16';
    const vpc = new ec2.Vpc(this, 'VPC', {
      cidr,
    });

    const securityGroup = new ec2.SecurityGroup(this, 'SecurityGroup', {
      securityGroupName: 'develop-sg',
      vpc,
    });
    securityGroup.addIngressRule(securityGroup, ec2.Port.allTraffic());
    securityGroup.addIngressRule(ec2.Peer.anyIpv4(), ec2.Port.tcp(80));

    const repository = new ecr.Repository(this, 'colorful-line', {
      repositoryName: 'colorful-line',
      lifecycleRules: [{ maxImageCount: 10 }]
    });

    const cluster = new ecs.Cluster(this, 'ColorfulLineCluster', {
      clusterName: 'colorful-line-cluster',
      vpc,
    });

    const fargateTaskDefinition = new ecs.FargateTaskDefinition(this, 'ColorfulLineTaskDef', {
      memoryLimitMiB: 512,
      cpu: 256
    });
    fargateTaskDefinition.addContainer('AppContainer', {
      image: ecs.ContainerImage.fromEcrRepository(repository, 'd4602248bcbe64022263e178dffacbed8b92bfa0'),
      portMappings: [{ containerPort: 5000 }]
    });

    const fargateService = new ecs.FargateService(this, 'ColorfulLineService', {
      cluster,
      taskDefinition: fargateTaskDefinition,
      vpcSubnets: vpc.selectSubnets({ subnetType: ec2.SubnetType.PRIVATE }),
      securityGroups: [securityGroup]
    });

    const lb = new elbv2.ApplicationLoadBalancer(this, 'ColorfulLineLB', {
      vpc,
      securityGroup,
      internetFacing: true
    });
    const listener = lb.addListener('ColorfulLineListener', { port: 80 });
    listener.addTargets('ECS1', {
      port: 80,
      targets: [fargateService]
    });
  }
}
