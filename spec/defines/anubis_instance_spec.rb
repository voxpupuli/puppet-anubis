# frozen_string_literal: true

require 'spec_helper'

describe 'anubis::instance' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:title) { 'test' }
      let(:params) do
        {
          'target' => 'http://localhost:1234',
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_service('anubis@test') }
      it { is_expected.to contain_file('/etc/anubis/test.env').with_content(%r{^TARGET=http://localhost:1234}) }
    end
  end
end
