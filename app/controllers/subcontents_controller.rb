class SubcontentsController < ApplicationController

  def subcontent2
		@subcontent = Subcontent.find('subcontent2')
    render "show"
  end

  def testsubcontent
		@subcontent = Subcontent.find('test-subcontent')
    render "show"
  end

end
