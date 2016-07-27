require 'spec_helper'

describe 'validate_unbound_acl' do
  it { expect { should run.with_params(123) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([123]) }.to raise_error(/Requires either an array or string to work with/) }
  it { expect { should run.with_params([]) }.to raise_error(/Requires an array with at least 1 element/) }
  it { expect { should run.with_params('invalid') }.to raise_error(/is not a valid IP address/) }
  it { expect { should run.with_params(['invalid']) }.to raise_error(/is not a valid IP address/) }
  it { expect { should run.with_params('invalid@5678') }.to raise_error(/is not a valid IP address/) }
  it { expect { should run.with_params(['invalid@5678']) }.to raise_error(/is not a valid IP address/) }
  it { should run.with_params('1.2.3.4') }
  it { should run.with_params('1.2.3.4@5678') }
  it { should run.with_params(['1.2.3.4']) }
  it { should run.with_params(['1.2.3.4@5678']) }
  it { should run.with_params('dead::beef') }
  it { should run.with_params('dead::beef@5678') }
  it { should run.with_params(['dead::beef']) }
  it { should run.with_params(['dead::beef@5678']) }

  it { expect { should run.with_params('1.2.3.4/24') }.to raise_error(/is not a valid IP address/) }
  it { expect { should run.with_params('dead::beef/64') }.to raise_error(/is not a valid IP address/) }

  it { should run.with_params('1.2.3.4/24', [], true) }
  it { should run.with_params('1.2.3.4/0', [], true) }
  it { should run.with_params('dead::beef/64', [], true) }
  it { should run.with_params('dead::beef/0', [], true) }
  it { expect { should run.with_params('1.2.3.4/33', [], true) }.to raise_error(/is not a valid IP\/Prefix pair/) }
  it { expect { should run.with_params('dead::beef/129', [], true) }.to raise_error(/is not a valid IP\/Prefix pair/) }

  it { expect { should run.with_params(['1.2.3.4'], ['allow']) }.to raise_error(/An action is expected/) }
  it { should run.with_params(['1.2.3.4 allow'], ['allow']) }
end
