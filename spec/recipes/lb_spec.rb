require 'spec_helper'

describe 'webapp::lb' do
  let(:chef_run) { ChefSpec::Runner.new(step_into: ["haproxy_lb"]).converge(described_recipe) }

  it 'Includes the HAProxy recipe' do
    expect(chef_run).to include_recipe 'haproxy::default'
  end

  it 'Creates the HAProxy config file' do
    expect(chef_run).to create_template '/etc/haproxy/haproxy.cfg'
  end

  it 'Contains the myapp frontend' do
    expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content('frontend myapp')
  end

  it 'Contains the myapp backend' do
    expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content('backend myapp')
  end

  it 'Uses round-robin load balancing' do
    expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content('balance roundrobin')
  end

end
