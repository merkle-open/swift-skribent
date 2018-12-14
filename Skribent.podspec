Pod::Spec.new do |s|
  s.name        = 'Skribent'
  s.version     = '0.0.1'
  s.authors     = 'Namics AG'
  s.license     = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage    = 'https://github.com/namics/swift-skribent'
  s.source      = { :git => 'https://github.com/namics/swift-skribent.git', :tag => s.version }
  s.summary     = 'Easy and extendable logger for swift'
  s.description = <<-DESC

  Skribent is an easy zero config logger which still can be extended and is typesafe.
                     DESC

  s.ios.deployment_target  = '8.0'
  s.osx.deployment_target  = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.swift_version = '4.2'

  s.module_name = 'Skribent'
  s.source_files = "Sources/#{s.module_name}/*.{swift}"
end
