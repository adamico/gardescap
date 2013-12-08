require 'spec_helper'

describe Period do
  describe "#mois" do
    it "should return an array of month numbers for each month in period" do
      Period.new(starts_at: "2014-05-01", ends_at: "2014-08-31").mois.should == (5..8).to_a
    end
  end

  describe "#days" do
    it "should return an array of dates between #starts_at and #ends_at" do
      start_date = "2014-05-01".to_date
      end_date = "2014-06-01".to_date
      Period.new(starts_at: start_date, ends_at: end_date).days.should == (start_date..end_date).to_a
    end
    it "should only include dates in month if provided" do
      start_date = "2014-05-01".to_date
      end_date = "2014-06-01".to_date
      Period.new(starts_at: start_date, ends_at: end_date).days(5).should == (start_date..(start_date + 1.month - 1.day)).to_a
    end
  end
end
