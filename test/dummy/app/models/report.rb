class Report < ActiveRecord::Base
  augment Toastr::Cachable

  def build!(params = {})
    raise NotImplementedError, 'Report is an abstract class.  You must implement a custom build!() method in subclasses.'
  end

  def expires
    1.hour
  end
end