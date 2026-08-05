# jekyll-hackclub
![Gem Downloads](https://img.shields.io/gem/dt/jekyll-hackclub?label=downloads)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MathiasDPX/jekyll-hackclub/gem-push.yml?label=gem%20push)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MathiasDPX/jekyll-hackclub/jekyll-gh-pages.yml?label=demo%20deployment)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MathiasDPX/jekyll-hackclub/push-image.yml?label=docker%20image)


The repository is split in 3 folders:
- `site` is a template site for displaying jekyll-hackclub possibilities, it uses the plugin from the plugin folder and not the plugin from RubyGems
- `plugin` is the plugin that will be used by user in their jekyll site
- `server` is a Flask server for resolving id to name without needing user to have their own bot

Better documentation can be found in their respective folders

## Installing the plugin

Add the gem to your `Gemfile`:

```ruby
# Gemfile
gem "jekyll-hackclub"
```

Then enable it in `_config.yml`:

```yml
# _config.yml
plugins:
  - jekyll-hackclub
```