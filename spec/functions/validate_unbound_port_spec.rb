require 'spec_helper'

describe 'validate_unbound_port' do
  it { expect { should run.with_params(123) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([123]) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([]) }.to raise_error(/Requires an array with at least 1 element/) }
  it { expect { should run.with_params('invalid invalid') }.to raise_error(/is not a valid port/) }
  it { expect { should run.with_params(['invalid invalid']) }.to raise_error(/is not a valid port/) }
  it { expect { should run.with_params('permit 1000-65536') }.to raise_error(/is not a valid port/) }
  it { expect { should run.with_params('permit 2000-1000') }.to raise_error(/is not a valid port/) }
  it { should run.with_params('permit 1000') }
  it { should run.with_params(['permit 1000-2000']) }
  it { should run.with_params('avoid 1000') }
  it { should run.with_params(['avoid 1000-2000']) }
end
