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

require 'spec_helper'

webp     = ['webp']
gifsicle = ['gifsicle']
webm     = ['libvpx1']
opencv   = ['python-opencv']
jpeg     = []
graphicsmagick = ['python-pgmagick', 'python-pycurl']
optimizers     = ['jpegoptim']

packages = webp + gifsicle + webm + opencv + jpeg + graphicsmagick + optimizers
packages.each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

describe package('thumbor') do
  it { should be_installed.by('pip').with_version('') }
end
