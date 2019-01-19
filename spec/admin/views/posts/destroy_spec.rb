require_relative '../../../spec_helper'

describe Admin::Views::Posts::Destroy do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/posts/destroy.html.erb') }
  let(:view)      { Admin::Views::Posts::Destroy.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
