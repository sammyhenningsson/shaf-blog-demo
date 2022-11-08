workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = 3
threads threads_count, threads_count

preload_app!

rackup      Puma::Configuration::DEFAULTS[:rackup]
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'production'
