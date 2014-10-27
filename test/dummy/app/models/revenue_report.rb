class RevenueReport < Report

  def build!(params = {})
    return { 
      total: 1_000_000
    }
  end

end
