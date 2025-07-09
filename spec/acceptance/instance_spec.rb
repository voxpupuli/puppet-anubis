# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'anubis::instance' do
  describe 'with defaults' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        anubis::instance { 'test':
          target => 'http://localhost:1234'
        }
        PUPPET
      end
    end
  end
end
