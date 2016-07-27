require 'spec_helper'

describe 'unbound::local' do
  let(:title) do
    'example.com.'
  end

  let(:params) do
    {
      :type => 'static',
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
        it { should contain_concat__fragment('unbound local example.com.') }
        it { should contain_unbound__local('example.com.') }
      end
    end
  end
end
