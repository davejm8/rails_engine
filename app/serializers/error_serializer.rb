class ErrorSerializer
  def self.no_matches_found(error)
    {
      "data": {
				"error": error
			}
    }
  end

  def self.invalid_parameters(error) 
    {
      "data": {
				"error": error
			}
    }
  end
end