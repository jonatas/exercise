RSpec.describe Exercise do
  it "has a version number" do
    expect(Exercise::VERSION).not_to be nil
  end

  describe described_class::Question do
    subject do
      Exercise.question( "how much is 2 + 2?") do
        consider_alternatives  [1,2,3,4]
        the_right_answer_is 4
      end
    end

    it "validates answer" do
      expect(subject).to be_valid_answer(4)
    end

    context 'when omit answer' do
      it "fails with exception" do
        expect do
          Exercise.question( "how much is 2 + 2?") do
            consider_alternatives  [1,2,3,4]
          end
        end.to raise_exception(Exercise::InvalidAnswer)
      end
    end

    context 'when the right_answer is not in the alternatives' do
      it "fails with exception" do
        expect do
          Exercise.question( "how much is 2 + 2?") do
            consider_alternatives  [1,2,3,4]
            the_right_answer_is 5
          end
        end.to raise_exception(Exercise::InvalidAnswer)
      end
    end
    context 'when passing extra info ' do
      subject do
        Exercise.question( "how much is 2 + 2?") do
          consider_alternatives  [1,2,3,4]
          the_right_answer_is 4
          author "Jonatas"
          level "Hard"
        end
      end

      it "can access extra info" do
        expect(subject.author).to eq("Jonatas")
        expect(subject.level).to eq("Hard")
      end
    end

  end
end
