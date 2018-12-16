# frozen_string_literal: true

require_relative './RandomSearch/objectable'
require_relative './RandomSearch/randomable'
require_relative './RandomSearch/spaceable'

module Algorithmically
  module Stochastic
    # ##########################################################################
    #
    # Algorithm Pseudocode
    #
    # ##########################################################################
    # ##########################################################################
    # ##########################################################################
    #
    # Input: NumIterations, ProblemSize, SearchSpace
    # Output: Best
    # Best ← ∅;
    # foreach iter i ∈ NumIterations do
    #   candidate i ← RandomSolution(ProblemSize, SearchSpace);
    #   if Cost(candidate i ) < Cost(Best) then
    #     Best ← candidate i ;
    #   end
    # end
    # return Best;
    #
    # ##########################################################################
    # ##########################################################################
    # ##########################################################################
    class RandomSearch
      include Algorithmically::Stochastic::Objectable
      include Algorithmically::Stochastic::Randomable
      include Algorithmically::Stochastic::Spaceable

      attr_accessor :problem_size, :maximum_iterations, :negative_space, :positive_space

      def initialize
        yield self if block_given?
        self.singleton_class.send :perform, @problem_size, @maximum_iterations, @negative_space, @positive_space
      end

      class << self
        def best_solution
          @best_solution
        end

        private

        def perform(*args)
          problem_size, maximum_iterations, negative_space, positive_space = *args
          @best_solution = nil
          maximum_iterations.to_i.times do |iterate|
            search_candidate = {}
            search_candidate[:v] = Randomable.perform(Spaceable.perform(problem_size, negative_space, positive_space))
            search_candidate[:c] = Objectable.perform(search_candidate[:v])
            @best_solution = search_candidate if best_solution.nil? || (search_candidate[:c] < best_solution[:c])
          end
          @best_solution
        end
      end
    end
  end
end
