require 'spec_helper'

haproxyConfigFile = '/etc/haproxy/haproxy.cfg'

describe 'webapp::lb' do
  let(:chef_run) { ChefSpec::SoloRunner.new(step_into: ["haproxy_lb"]).converge(described_recipe) }

  it 'Includes the HAProxy recipe' do
    expect(chef_run).to include_recipe 'haproxy::default'
  end

  it 'Creates the HAProxy config file' do
    expect(chef_run).to create_template haproxyConfigFile
  end

  it 'Tells the HAProxy process to reload the config' do
    resource = chef_run.template(haproxyConfigFile)
    expect(resource).to notify('service[haproxy]').to(:reload).delayed
  end

  it 'Contains the myapp frontend' do
    expect(chef_run).to render_file(haproxyConfigFile).with_content('frontend myapp')
  end

  it 'Contains the myapp backend' do
    expect(chef_run).to render_file(haproxyConfigFile).with_content('backend myapp-backend')
  end

  it 'Uses round-robin load balancing' do
    expect(chef_run).to render_file(haproxyConfigFile).with_content('balance roundrobin')
  end

end
