Bundler.require

Dir.glob('actions/**')do |path|
  require_relative path
end

Dir.glob('handlers/**') do |path|
  require_relative path
end
