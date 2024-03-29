require_relative '../../../spec_helper'

describe Admin::Views::Posts::Edit do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/admin/templates/posts/edit.html.erb') }
  let(:view)      { Admin::Views::Posts::Edit.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
