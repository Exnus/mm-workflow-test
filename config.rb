# config[:server_name] = "jivosite.netgear.com"

config[:js_dir] = 'assets/js'
config[:css_dir] = 'assets/styles'
config[:images_dir] = "assets/images"
config[:fonts_dir] = "assets/fonts"

# config[:data_dir] = "data"
config[:layouts_dir] = "layouts"
config[:helpers_dir] = "helpers"

activate :i18n do |i18n|
 # i18n.locales = [:en, :ru, :br, :es]
 # i18n.data = "locales"
 i18n.templates_dir = "multilingual"
 i18n.mount_at_root = false
end

activate :minify_html do |html|
  html.remove_multi_spaces        = true   # Remove multiple spaces
  html.remove_comments            = true   # Remove comments
  html.remove_intertag_spaces     = false  # Remove inter-tag spaces
  html.remove_quotes              = true   # Remove quotes
  html.simple_doctype             = false  # Use simple doctype
  html.remove_script_attributes   = true   # Remove script attributes
  html.remove_style_attributes    = true   # Remove style attributes
  html.remove_link_attributes     = true   # Remove link attributes
  html.remove_form_attributes     = false  # Remove form attributes
  html.remove_input_attributes    = true   # Remove input attributes
  html.remove_javascript_protocol = true   # Remove JS protocol
  html.remove_http_protocol       = false  # Remove HTTP protocol
  html.remove_https_protocol      = false  # Remove HTTPS protocol
  html.preserve_line_breaks       = false  # Preserve line breaks
  html.simple_boolean_attributes  = true   # Use simple boolean attributes
  html.preserve_patterns          = nil    # Patterns to preserve
end
activate :minify_css
activate :minify_javascript
activate :gzip
activate :automatic_image_sizes
activate :automatic_alt_tags


# using markdown for contentful stuff
set :markdown_engine, :kramdown

###
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Compass options
# REF: https://gist.github.com/1246187
compass_config do |config|
  config.output_style = :compressed
  config.sass_options = { :line_comments => false }
end

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

page "/bower_components/**", :directory_index => false
page "/components/**", :directory_index => false

site = Sprockets::Environment.new
site.append_path 'bower_components'
site.append_path 'components'

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

configure :development do
  activate :livereload
  activate :directory_indexes
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
 helpers do
   def nav_active(page)
       current_page.url == page ? "active" : ''
   end
 end


# Blog
activate :blog do |blog|
  blog.sources = "blog/posts/{lang}/{title}.html"
  blog.layout = "layouts/blog"
  blog.permalink = "blog/{title}.html"
  blog.summary_separator = /SPLIT_SUMMARY_BEFORE_THIS/
  blog.paginate = true
  blog.per_page = 20
end

activate :contentful do |f|
  f.space = {jivosite: 'nk1xo29v4xh0'}
  f.access_token = '9e4fca6dc0b14d54c82990e00b951d170b02c5422c4e6d23220af60d4065e3a7'
  f.content_types = {
    blog_post: '2wKn6yEnZewu2SCCkus4as',
    page: 'page'
  }
end

activate :contentful_pages do |extension|
  extension.data      = 'jivosite.page'
  # extension.prefix    = '/'
  extension.template  = 'page.html.erb'
  extension.permalink = '{slug}.html'
end

activate :contentful_pages do |extension|
  extension.data      = 'jivosite.blog_post'
  extension.prefix    = 'blog'
  extension.template  = 'post.html.erb'
  extension.permalink = '{slug}.html'
end

# page '/sitemap.xml', layout: false


# Build-specific configuration
configure :build do

end
