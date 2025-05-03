# coding: utf-8
# frozen_string_literal: true

Gem::Specification.new do |spec|
    spec.name = "jekyll-hackclub"
    spec.version = "1.1.0"
    spec.authors = ["MathiasDPX"]
    spec.summary = "Jekyll plugin for HackClub"
    spec.licenses = ["MIT"]
    
    spec.require_paths= ['lib']
    spec.files = Dir["lib/**/*.rb"]

    spec.add_dependency 'jekyll', '>= 3.5.0'

    spec.add_development_dependency "bundler"
end