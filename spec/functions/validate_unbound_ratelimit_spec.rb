require 'spec_helper'

describe 'validate_unbound_ratelimit' do
  it { expect { should run.with_params(123) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([123]) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([]) }.to raise_error(/Requires an array with at least 1 element/) }
  it { expect { should run.with_params('invalid invalid') }.to raise_error(/is not a valid ratelimit/) }
  it { expect { should run.with_params(['invalid invalid']) }.to raise_error(/is not a valid ratelimit/) }
  it { expect { should run.with_params('example.123 1000') }.to raise_error(/is not a valid ratelimit/) }
  it { should run.with_params('example.com 1000') }
  it { should run.with_params(['example.com 1000']) }
end
