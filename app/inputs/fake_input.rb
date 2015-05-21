class FakeInput < SimpleForm::Inputs::Base
  def input
    @builder.object.send(attribute_name)
  end
end