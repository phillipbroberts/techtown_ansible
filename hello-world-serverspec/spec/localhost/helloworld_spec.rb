require 'spec_helper'

describe package('nodejs') do
  it { should be_installed }
end

describe package('npm') do
  it { should be_installed }
end

describe file('/opt/webapps') do
  it { should be_directory }
end

describe port(8080) do
  it { should be_listening }
end
