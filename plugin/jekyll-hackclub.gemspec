# coding: utf-8
# frozen_string_literal: true

Gem::Specification.new do |spec|
    spec.name = "jekyll-hackclub"
    spec.require_paths= ['lib']
    spec.version = "1.0.0"
    spec.authors = ["MathiasDPX"]
    spec.files = ["lib/jekyll-hackclub.rb"]
    spec.summary = "Jekyll plugin for HackClub"

    spec.add_dependency 'jekyll', '>= 3.5.0'

    spec.add_development_dependency "bundler"
end