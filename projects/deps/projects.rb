dep 'all projects' do
  requires 'open source'
  requires 'presentations'
  requires 'other'
end

dep 'open source' do
  requires 'funk.repo'
  requires 'matchbox.repo'
  requires 'referee.repo'
  requires 'dataschemer.repo'
  requires 'glot.repo'
  requires 'rosetta-jvm.repo'
end

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

dep 'dataschemer.repo' do
  source 'git@github.com:tobyclemson/dataschemer.git'
  path '~/Code/dataschemer'
end

dep 'glot.repo' do
  source 'git@github.com:tobyclemson/glot.git'
  path '~/Code/glot'
end

dep 'rosetta-jvm.repo' do
  source 'git@github.com:tobyclemson/rosetta-jvm'
  path '~/Code/rosetta-jvm'
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

dep 'other' do
  requires 'mfcom-dev.repo'
  requires 'prelude-personal.repo'
  requires 'language-implementation-patterns.repo'
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
