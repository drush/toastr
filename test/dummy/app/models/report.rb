class Report < ActiveRecord::Base
  augment Toastr::Cachable

  class << self
    def fetch(opts = {})
      where(key: opts.to_json).first_or_create()
    end
  end

  def expires
    1.hour
  end
end