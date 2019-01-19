require_relative '../../../spec_helper'

describe Admin::Views::Posts::Create do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/posts/create.html.erb') }
  let(:view)      { Admin::Views::Posts::Create.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
