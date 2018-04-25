require "exercise/version"

module Exercise
  InvalidAnswer = Class.new(StandardError)

  module_function
  def question(sentence, &block)
    Question.new(sentence, &block)
  end

  class Question
    attr_reader :right
    def initialize(sentence, &block)
      instance_eval(&block)
      if right.nil? || !@alternatives.include?(right)
        raise InvalidAnswer.new
      end
    end

    def valid_answer? answer
      right == answer
    end

    def consider_alternatives alternatives
      @alternatives = alternatives
    end

    def the_right_answer_is right
      @right = right
    end

    def method_missing(name, *args, &block)
      @extra_info ||= {}
      if args.any?
        @extra_info[name] = args.first
      elsif @extra_info.has_key?(name)
        @extra_info[name] 
      else
        super
      end
    end
  end
end
