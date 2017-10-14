require 'spec_helper'

describe 'unbound::forward' do
  let(:title) do
    'example.com.'
  end

  let(:params) do
    {
      :forward_addr => [
        '1.2.3.4',
        ['5.6.7.8', 5353],
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
        it { should contain_concat__fragment('unbound forward example.com.').with_content(<<-EOS.gsub(/^ +/, ''))

          forward-zone:
          	name: "example.com."
          	forward-addr: 1.2.3.4
          	forward-addr: 5.6.7.8@5353
          EOS
        }
        it { should contain_unbound__forward('example.com.') }
      end
    end
  end
end
