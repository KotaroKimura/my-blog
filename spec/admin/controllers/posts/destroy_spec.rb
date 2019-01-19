require_relative '../../../spec_helper'

describe Admin::Controllers::Posts::Destroy do
  let(:action) { Admin::Controllers::Posts::Destroy.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
