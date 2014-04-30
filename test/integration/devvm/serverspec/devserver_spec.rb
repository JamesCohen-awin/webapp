require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end


# Apache
describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
end

describe port(82) do
    it { should be_listening }
end


# haproxy
describe service('haproxy') do
    it { should be_enabled }
    it { should be_running }
end

describe port(80) do
    it { should be_listening }
end

# requesting a PHP page via haproxy -> Apache
describe command('curl -H "Header: webapp" http://localhost/phpinfo.php') do
    it { should match /PHP Version 5.3/ }
end
