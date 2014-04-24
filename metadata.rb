name             'webapp'
maintainer       'Digital Window Limited'
maintainer_email 'james.cohen@affiliatewindow.com'
license          'All rights reserved'
description      'Installs/Configures webapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'haproxy', '~> 1.6'
depends 'apache2', '~> 1.10'
