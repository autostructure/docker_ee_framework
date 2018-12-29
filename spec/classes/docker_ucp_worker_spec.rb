require 'spec_helper'

describe 'docker_ee_framework::docker_ucp_worker' do
  let(:facts) { { is_virtual: false } }

  context "Compile with no parameters" do
    it { is_expected.to compile.with_all_deps }
  end
end
