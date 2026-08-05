# frozen_string_literal: true

# Put `viewBox` back.
#
# jekyll-target-blank parses each rendered page with Nokogiri's HTML4 parser and
# serialises it back out, which lowercases attribute names — SVG's `viewBox`
# ships as `viewbox`, 20 times on the home page alone.
#
# Browsers recover: the HTML5 parser has a case-adjustment table for foreign
# attributes and maps it back. But the served markup then disagrees with the
# source, and anywhere the case genuinely matters — a fragment served as
# image/svg+xml, an XML parser, anything reading the attribute literally — it is
# simply wrong.
#
# This runs at :post_write, on the files as written, because ordering against
# another plugin's :post_render hook is not something to rely on: registered on
# :post_render this ran BEFORE jekyll-target-blank and saw markup that had not
# been mangled yet. After the write there is nothing left to run.
#
# `_plugins/` is read at all only because the `github-pages` gem is gone — it set
# `safe: true`, which disables this directory along with every non-whitelisted
# gem plugin.
Jekyll::Hooks.register :site, :post_write do |site|
  fixed_files = 0
  fixed_attrs = 0

  Dir.glob(File.join(site.dest, "**", "*.html")).each do |path|
    # Read and write as UTF-8 explicitly. The build machine's default external
    # encoding is US-ASCII, so a bare File.read raises "invalid byte sequence"
    # on the first © or em dash — while passing locally, where the default is
    # UTF-8. The pages are UTF-8; say so rather than inherit a locale.
    html = File.read(path, encoding: "UTF-8")
    count = html.scan(/\bviewbox=(["'])/).size
    next if count.zero?

    File.write(path, html.gsub(/\bviewbox=(["'])/, 'viewBox=\1'), encoding: "UTF-8")
    fixed_files += 1
    fixed_attrs += count
  end

  next if fixed_files.zero?

  Jekyll.logger.info "viewBox:", "restored #{fixed_attrs} attribute(s) across #{fixed_files} file(s)"
end
