#
# Author:: Enrico Stahn <mail@enricostahn.com>
#
# Copyright 2012-2015, Zanui <engineering@zanui.com.au>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'serverspec'
require 'infrataster/rspec'
require 'docker'
require 'fastimage'

# Configure docker through environment variables
Docker.url = ENV['DOCKER_HOST']
if ENV.has_key?('DOCKER_TLS_VERIFY')
  cert_path = File.expand_path ENV['DOCKER_CERT_PATH']
  Docker.options = {
    client_cert: File.join(cert_path, 'cert.pem'),
    client_key: File.join(cert_path, 'key.pem'),
    ssl_ca_file: File.join(cert_path, 'ca.pem'),
    scheme: 'https'
  }
end

# Configure RSpec/Serverspec backend
set :os, family: :debian
set :backend, :docker
set :docker_image, Docker::Image.build_from_dir('.').id
set :docker_container_create_options, {
  "AttachStdout" => true,
  "AttachStderr" => true,
  "PortBindings" => { "9000/tcp" => [{ "HostIp" => "0.0.0.0", "HostPort" => "9000" }]}
}
set :fail_fast, true

# Configure Infrataster
Infrataster::Server.define(:app, URI(Docker.url).host)
