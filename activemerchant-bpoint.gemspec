# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "activemerchant/bpoint/version"

Gem::Specification.new do |s|
  s.name        = "activemerchant-bpoint"
  s.version     = ActiveMerchant::Bpoint::VERSION
  s.authors     = ["Mario Visic"]
  s.email       = ["mario@mariovisic.com"]
  s.homepage    = ""
  s.summary     = 'ActiveMerchant BPOINT Plugin'
  s.description = 'An ActiveMerchant plugin that provides a full featured BPOINT gateway'

  s.rubyforge_project = "activemerchant-bpoint"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'activemerchant', '>= 1.20.0'
end
