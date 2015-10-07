begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

require 'pathname'
namespace :react do
  task :update do
    FileUtils.rm_f('vendor/react/.bower.json')
    `bower install react`
    assets_path = Pathname.new(File.dirname(__FILE__)).join('lib/assets/')
    copy_react_asset('react.js', assets_path.join('react-source/development/react.js'))
    copy_react_asset('react.min.js', assets_path.join('react-source/production/react.js'))
    copy_react_asset('react-with-addons.js', assets_path.join('react-source/development-with-addons/react.js'))
    copy_react_asset('react-with-addons.min.js', assets_path.join('react-source/production-with-addons/react.js'))

    copy_react_asset('react-dom.js', assets_path.join('react-source/development/react-dom.js'))
    copy_react_asset('react-dom.min.js', assets_path.join('react-source/production/react-dom.js'))
    # Make sure it's also present when addons: true
    copy_react_asset('react-dom.js', assets_path.join('react-source/development-with-addons/react-dom.js'))
    copy_react_asset('react-dom.min.js', assets_path.join('react-source/production-with-addons/react-dom.js'))

  end

  def copy_react_asset(source, destination)
    vendor_path = Pathname.new(File.dirname(__FILE__)).join('vendor/react')
    FileUtils.mkdir_p(destination.dirname.to_s)
    FileUtils.cp(vendor_path.join(source), destination.to_s)
  end
end

require 'appraisal'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = ENV['TEST_PATTERN'] || 'test/**/*_test.rb'
  t.verbose = ENV['TEST_VERBOSE'] == '1'
end

task default: :test
