require "spec_helper"

describe Console::View do
  subject { Console::View }

  it { is_expected.to respond_to :introduction }
  it { is_expected.to respond_to :grading_scheme }
  it { is_expected.to respond_to :color_codes }
  it { is_expected.to respond_to :top_border }
  it { is_expected.to respond_to :bottom_border }
  it { is_expected.to respond_to :attempt_line }
  it { is_expected.to respond_to :feedback_line }
end
