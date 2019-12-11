Pod::Spec.new do |s|
  s.name = 'HumanString'
  s.version = '0.0.1'
  s.summary = 'Makes substrings in Swift for human again.'
  s.description = <<-DESC
Sometimes you just want an easier way to work on substrings, so I made this.
                       DESC

  s.homepage = 'https://xddd.kkbox.io/kkpartnerplayer/'
  s.license = {:type => 'MIT', :file => 'LICENSE'}
  s.author = {'zonble' => 'zonble@gmail.com'}
  s.source = {:git => 'https://github.com/zonble/HumanString.git', :tag => s.version.to_s}
  s.swift_versions = ['4.2', '5.0', '5.1']
  s.source_files = 'Sources/HumanString/**/*'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
end
