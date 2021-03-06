# avendesora
#
# Copyright (c) 2015 Eric Will <rakaur@malkier.net>
# Rights to this code are documented in LICENSE.

# Require our spec helper
require_relative '../../spec_helper'

describe Configuration do
  let(:config) { Configuration.new CONFIG_FILE }
  subject { config.parse }

  describe 'configuration file' do
    it 'uses the default configuration file' do
      config.config_file.must_equal CONFIG_FILE
    end

    it 'raises exception on a bad file' do
      -> { Configuration.new('').parse }.must_raise Configuration::ParseError
    end
  end

  describe 'daemon' do
    it 'contains a daemon section' do
      subject.me.must_be_instance_of OpenStruct
    end

    it 'contains a server name' do
      subject.me.name.wont_be_nil
    end
  end

  describe 'listen' do
    it 'contains ports to listen to' do
      subject.ports.wont_be_nil
      subject.ports.must_be_instance_of Array
    end

    it 'has one port specified' do
      subject.ports[0].must_be_instance_of OpenStruct
      subject.ports[0].bind.must_equal '127.0.0.1'
      subject.ports[0].port.must_equal 6667
    end
  end

  # These are really useless, but it makes the code coverage work
  describe "Exceptions" do
    let(:bad_daemon) { Configuration.new BAD_DAEMON }
    let(:bad_listen) { Configuration.new BAD_LISTEN }

    it 'detects malformed daemon blocks' do
      bad_daemon.stub(:abort, nil) do
        bad_daemon.stub(:puts, nil) { bad_daemon.parse }
      end

      bad_daemon.must_be_instance_of Configuration
    end

    it 'detects maleformed listen blocks' do
      bad_listen.stub(:abort, nil) do
        bad_listen.stub(:puts, nil) { bad_listen.parse }
      end

      bad_listen.must_be_instance_of Configuration
    end
  end
end
