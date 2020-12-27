require 'docker'
require 'json'
require 'serverspec'

project = Docker::Container.get(ENV['HOSTNAME']).info['Config']['Labels']['com.docker.compose.project']
target  = Docker::Container.all(
  filters: {
    label: [
      'com.docker.compose.project=' + project,
      'com.docker.compose.service=target'
    ]
  }.to_json).first

set :backend, :docker
set :docker_container, target.id
