# avendesora
#
# Copyright (c) 2015 Eric Will <rakaur@malkier.net>
# Rights to this code are documented in LICENSE.

# Require our spec helper
require_relative '../spec_helper'

describe Avendesora do
  let(:out) { MiniTest::Mock.new }

  before { @app = nil }

  it 'starts up' do
    out.expect(:puts, nil, [String])

    @app = Avendesora.new out

    @app.must_be_instance_of Avendesora

    assert out.verify
  end
end
