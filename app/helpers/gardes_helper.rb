module GardesHelper
  CandidateCount = Struct.new(:count) do
    def get_css_class
      return "success" if count == 0
      return "warning" if is_lower_than(5)
      "danger"
    end

    def is_lower_than(number)
      count > 0 && count < number
    end
  end

  def cell_css(garde)
    return nil unless garde
    CandidateCount.new(garde.candidates_count).get_css_class
  end
end
