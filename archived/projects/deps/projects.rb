dep 'funk.repo' do
  source 'git@github.com:javafunk/funk'
  path '~/Code/funk'
end

dep 'matchbox.repo' do
  source 'git@github.com:javafunk/matchbox'
  path '~/Code/funk'
end

dep 'referee.repo' do
  source 'git@github.com:javafunk/referee.git'
  path '~/Code/referee'
end

dep 'configurati.repo' do
  source 'git@github.com:tobyclemson/configurati.git'
  path '~/Code/configurati'
end

dep 'confidante.repo' do
  source 'git@github.com:tobyclemson/confidante.git'
  path '~/Code/confidante'
end

dep 'dataschemer.repo' do
  source 'git@github.com:tobyclemson/dataschemer.git'
  path '~/Code/dataschemer'
end

dep 'exegesis.repo' do
  source 'git@github.com:tobyclemson/exegesis.git'
  path '~/Code/exegesis'
end

dep 'glot.repo' do
  source 'git@github.com:tobyclemson/glot.git'
  path '~/Code/glot'
end

dep 'lino.repo' do
  source 'git@github.com:tobyclemson/lino.git'
  path '~/Code/lino'
end

dep 'rosetta-jvm.repo' do
  source 'git@github.com:tobyclemson/rosetta-jvm'
  path '~/Code/rosetta-jvm'
end

dep 'open source' do
  requires 'funk.repo'
  requires 'matchbox.repo'
  requires 'referee.repo'
  requires 'configurati.repo'
  requires 'confidante.repo'
  requires 'dataschemer.repo'
  requires 'exegesis.repo'
  requires 'glot.repo'
  requires 'lino.repo'
  requires 'rosetta-jvm.repo'
end

dep 'builder-pattern-presentation.repo' do
  source 'git@github.com:tobyclemson/builder-pattern-presentation'
  path '~/Code/presentations/builder-pattern-presentation'
end

dep 'testing-micro-service-architecture-presentation.repo' do
  source 'git@github.com:tobyclemson/testing-micro-service-architecture-presentation'
  path '~/Code/presentations/testing-micro-service-architecture-presentation'
end

dep 'deployment-as-a-service-presentation.repo' do
  source 'git@github.com:tobyclemson/deployment-as-a-service-presentation'
  path '~/Code/presentations/deployment-as-a-service-presentation'
end

dep 'scala-full-stack-dev-presentation.repo' do
  source 'git@github.com:tobyclemson/scala-full-stack-dev-presentation'
  path '~/Code/presentations/scala-full-stack-dev-presentation'
end

dep 'test-data-generation-and-verification-presentation.repo' do
  source 'git@github.com:tobyclemson/test-data-generation-and-verification-presentation'
  path '~/Code/presentations/test-data-generation-and-verification-presentation'
end

dep 'tor-presentation.repo' do
  source 'git@github.com:tobyclemson/tor-presentation'
  path '~/Code/presentations/tor-presentation'
end

dep 'net-neutrality-presentation.repo' do
  source 'git@github.com:tobyclemson/net-neutrality-presentation'
  path '~/Code/presentations/net-neutrality-presentation'
end

dep 'presentations' do
  requires 'builder-pattern-presentation.repo'
  requires 'testing-micro-service-architecture-presentation.repo'
  requires 'deployment-as-a-service-presentation.repo'
  requires 'scala-full-stack-dev-presentation.repo'
  requires 'test-data-generation-and-verification-presentation.repo'
  requires 'tor-presentation.repo'
  requires 'net-neutrality-presentation.repo'
end

dep 'mfcom-dev.repo' do
  source 'git@github.com:ThoughtWorksInc/mfcom-dev'
  path '~/Code/mfcom-dev'
end

dep 'prelude-personal.repo' do
  source 'git@github.com:tobyclemson/prelude-personal.git'
  path '~/Code/prelude-personal'
end

dep 'language-implementation-patterns.repo' do
  source 'git@github.com:tobyclemson/language-implementation-patterns.git'
  path '~/Code/language-implementation-patterns'
end

dep 'other' do
  requires 'mfcom-dev.repo'
  requires 'prelude-personal.repo'
  requires 'language-implementation-patterns.repo'
end

dep 'infrablocks.io.repo' do
  source 'git@github.com:infrablocks/infrablocks.io.git'
  path '~/Code/infrablocks/infrablocks.io'
end

dep 'end-to-end-concourse-ci.repo' do
  source 'git@github.com:infrablocks/end-to-end-concourse-ci.git'
  path '~/Code/infrablocks/end-to-end-concourse-ci'
end

dep 'concourse.js.repo' do
  source 'git@github.com:infrablocks/concourse.js.git'
  path '~/Code/infrablocks/concourse.js'
end

dep 'rake-dependencies.repo' do
  source 'git@github.com:infrablocks/rake_dependencies.git'
  path '~/Code/infrablocks/rake-dependencies'
end

dep 'rake-docker.repo' do
  source 'git@github.com:infrablocks/rake_docker.git'
  path '~/Code/infrablocks/rake-docker'
end

dep 'rake-fly.repo' do
  source 'git@github.com:infrablocks/rake_fly.git'
  path '~/Code/infrablocks/rake-fly'
end

dep 'ruby-fly.repo' do
  source 'git@github.com:infrablocks/ruby_fly.git'
  path '~/Code/infrablocks/ruby-fly'
end

dep 'rake-terraform.repo' do
  source 'git@github.com:infrablocks/rake_terraform.git'
  path '~/Code/infrablocks/rake-terraform'
end

dep 'ruby-terraform.repo' do
  source 'git@github.com:infrablocks/ruby_terraform.git'
  path '~/Code/infrablocks/ruby-terraform'
end

dep 'terraform-aws-base-networking.repo' do
  source 'git@github.com:infrablocks/terraform-aws-base-networking.git'
  path '~/Code/infrablocks/terraform-aws-base-networking'
end

dep 'terraform-aws-bastion.repo' do
  source 'git@github.com:infrablocks/terraform-aws-bastion.git'
  path '~/Code/infrablocks/terraform-aws-bastion'
end

dep 'terraform-aws-classic-load-balancer.repo' do
  source 'git@github.com:infrablocks/terraform-aws-classic-load-balancer.git'
  path '~/Code/infrablocks/terraform-aws-classic-load-balancer'
end

dep 'terraform-aws-dns-zones.repo' do
  source 'git@github.com:infrablocks/terraform-aws-dns-zones.git'
  path '~/Code/infrablocks/terraform-aws-dns-zones'
end

dep 'terraform-aws-ecr-repository.repo' do
  source 'git@github.com:infrablocks/terraform-aws-ecr-repository.git'
  path '~/Code/infrablocks/terraform-aws-ecr-repository'
end

dep 'terraform-aws-ecs-cluster.repo' do
  source 'git@github.com:infrablocks/terraform-aws-ecs-cluster.git'
  path '~/Code/infrablocks/terraform-aws-ecs-cluster'
end

dep 'terraform-aws-ecs-route53-registration.repo' do
  source 'git@github.com:infrablocks/terraform-aws-ecs-route53-registration.git'
  path '~/Code/infrablocks/terraform-aws-ecs-route53-registration'
end

dep 'terraform-aws-ecs-service.repo' do
  source 'git@github.com:infrablocks/terraform-aws-ecs-service.git'
  path '~/Code/infrablocks/terraform-aws-ecs-service'
end

dep 'terraform-aws-ecs-load-balancer.repo' do
  source 'git@github.com:infrablocks/terraform-aws-ecs-load-balancer.git'
  path '~/Code/infrablocks/terraform-aws-ecs-load-balancer'
end

dep 'terraform-aws-encrypted-bucket.repo' do
  source 'git@github.com:infrablocks/terraform-aws-encrypted-bucket.git'
  path '~/Code/infrablocks/terraform-aws-encrypted-bucket'
end

dep 'terraform-aws-infrastructure-events.repo' do
  source 'git@github.com:infrablocks/terraform-aws-infrastructure-events.git'
  path '~/Code/infrablocks/terraform-aws-infrastructure-events'
end

dep 'terraform-aws-rds-postgres.repo' do
  source 'git@github.com:infrablocks/terraform-aws-rds-postgres.git'
  path '~/Code/infrablocks/terraform-aws-rds-postgres'
end

dep 'terraform-aws-vpc-auto-peering.repo' do
  source 'git@github.com:infrablocks/terraform-aws-vpc-auto-peering.git'
  path '~/Code/infrablocks/terraform-aws-vpc-auto-peering'
end

dep 'infrablocks' do
  requires 'infrablocks.io.repo'
  requires 'end-to-end-concourse-ci.repo'
  requires 'concourse.js.repo'
  requires 'rake-dependencies.repo'
  requires 'rake-docker.repo'
  requires 'rake-fly.repo'
  requires 'ruby-fly.repo'
  requires 'rake-terraform.repo'
  requires 'ruby-terraform.repo'
  requires 'terraform-aws-base-networking.repo'
  requires 'terraform-aws-bastion.repo'
  requires 'terraform-aws-classic-load-balancer.repo'
  requires 'terraform-aws-dns-zones.repo'
  requires 'terraform-aws-ecr-repository.repo'
  requires 'terraform-aws-ecs-cluster.repo'
  requires 'terraform-aws-ecs-route53-registration.repo'
  requires 'terraform-aws-ecs-service.repo'
  requires 'terraform-aws-ecs-load-balancer.repo'
  requires 'terraform-aws-encrypted-bucket.repo'
  requires 'terraform-aws-infrastructure-events.repo'
  requires 'terraform-aws-rds-postgres.repo'
  requires 'terraform-aws-vpc-auto-peering.repo'
end

dep 'aws-ardor-node.repo' do
  source 'git@github.com:clemkor/aws-ardor-node.git'
  path '~/Code/clemkor/aws-ardor-node'
end

dep 'aws-cert-manager-image.repo' do
  source 'git@github.com:clemkor/aws-cert-manager-image.git'
  path '~/Code/clemkor/aws-cert-manager-image'
end

dep 'aws-environment.repo' do
  source 'git@github.com:clemkor/aws-environment.git'
  path '~/Code/clemkor/aws-environment'
end

dep 'aws-global.repo' do
  source 'git@github.com:clemkor/aws-global.git'
  path '~/Code/clemkor/aws-global'
end

dep 'aws-neo-node.repo' do
  source 'git@github.com:clemkor/aws-neo-node.git'
  path '~/Code/clemkor/aws-neo-node'
end

dep 'aws-nxt-node.repo' do
  source 'git@github.com:clemkor/aws-nxt-node.git'
  path '~/Code/clemkor/aws-nxt-node'
end

dep 'aws-price-calculator.repo' do
  source 'git@github.com:clemkor/aws-price-calculator.git'
  path '~/Code/clemkor/aws-price-calculator'
end

dep 'clemkor' do
  requires 'aws-ardor-node.repo'
  requires 'aws-cert-manager-image.repo'
  requires 'aws-environment.repo'
  requires 'aws-global.repo'
  requires 'aws-neo-node.repo'
  requires 'aws-nxt-node.repo'
  requires 'aws-price-calculator.repo'
end

dep 'all projects' do
  requires 'infrablocks'
  requires 'clemkor'
  requires 'open source'
  requires 'presentations'
  requires 'other'
end

