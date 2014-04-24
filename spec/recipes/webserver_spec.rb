require 'spec_helper'

describe 'webapp::webserver' do
  let(:chef_run) { ChefSpec::Runner.new(step_into: ["apache2_web_app"]).converge(described_recipe) }

  it 'Includes the Apache2 recipe' do
    expect(chef_run).to include_recipe 'apache2::default'
  end

  it 'Creates the Apache config file' do
    expect(chef_run).to create_template '/etc/httpd/conf/httpd.conf' 
  end

  it 'Tells the httpd process to reload the config' do
    resource = chef_run.template('/etc/httpd/conf/httpd.conf')
    expect(resource).to notify('service[httpd]').to(:reload).delayed
  end

  it 'Creates a virtualhost' do
    expect(chef_run).to render_file('/etc/httpd/sites-available/webapp.conf')
  end

end
