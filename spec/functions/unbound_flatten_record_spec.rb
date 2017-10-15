require 'spec_helper'

describe 'unbound::flatten_record' do
  it { should run.with_params({'name' => 'www.example.com.', 'type' => 'A', 'ip' => '192.0.2.1'}).and_return('"www.example.com. A 192.0.2.1"') }
  it { should run.with_params({'name' => 'www.example.com.', 'type' => 'TXT', 'value' => 'example'}).and_return("'www.example.com. TXT \"example\"'") }
  it { expect { should run.with_params([]) }.to raise_error(/parameter 'value' /) }
  it { expect { should run.with_params('invalid') }.to raise_error(/parameter 'value' /) }
end
