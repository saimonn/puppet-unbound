require 'spec_helper'

describe 'unbound::view' do
  let(:title) do
    'test'
  end

  let(:params) do
    {
      :local_data => [
        {
          'name'  => 'www.example.com.',
          'type'  => 'A',
          'ip'    => '192.0.2.1',
          'class' => 'IN',
        },
        {
          'name'  => 'www.example.com.',
          'type'  => 'TXT',
          'value' => 'example',
          'ttl'   => 3600,
        },
      ],
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'without unbound class included' do
        it { expect { should compile }.to raise_error(/must include the unbound base class/) }
      end

      context 'with unbound class included', :compile do
        let(:pre_condition) do
          'include ::unbound'
        end

        it { should contain_class('unbound') }
        it { should contain_concat__fragment('unbound view test').with_content(<<-EOS.gsub(/^ +/, ''))

          view:
          	name: "test"
          	local-data: "www.example.com. IN A 192.0.2.1"
          	local-data: 'www.example.com. 3600 TXT "example"'
          EOS
        }
        it { should contain_unbound__view('test') }
      end
    end
  end
end
