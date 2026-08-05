# frozen_string_literal: true

source "https://rubygems.org"

# This site is built by Cloudflare Pages, not GitHub Pages.
#
# `github-pages` used to sit here to mirror GitHub's own build. It also rewrites
# `url` and `baseurl` from PAGES_* environment variables — a namespace
# Cloudflare's build image populates too — which prefixed every generated URL,
# including <link rel="canonical">, with /pages/<owner>/<repo>/. The build stayed
# green; the site would simply have rendered unstyled under a canonical pointing
# at a URL that does not exist.
#
# These are the exact versions that gem was pinning, named directly, so the
# generated output is unchanged and the environment-derived rewriting is gone.
gem "jekyll", "3.10.0"
gem "jekyll-remote-theme", "0.4.3"
gem "jekyll-relative-links", "0.6.1"
gem "jekyll-seo-tag", "2.8.0"
gem "jekyll-sitemap", "1.4.0"
gem "jekyll-target-blank", "2.0.2"
gem "jekyll-github-metadata", "2.16.1"
gem "kramdown-parser-gfm", "1.1.0"


# Ruby 3.4 dropped base64 from the default gems and Jekyll 3.x still wants it.
# The Pages build pins 3.3.4 where it is present; this keeps local builds working
# too, and survives the day that pin moves.
gem "base64"
gem "bigdecimal"
gem "csv"
