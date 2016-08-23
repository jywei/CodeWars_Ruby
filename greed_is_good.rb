def score(dice)
  DiceCombination.new.score(dice)
end

class DiceCombination

  def score(dice_roll)
    rest, triplets_score = check_triplets(dice_roll)
    rest, ones_score = check_ones(rest)
    ones_score + triplets_score
  end

  private

    def check_triplets(dice_roll)
      (1..6).inject([dice_roll, 0]) do |(roll, score), number|
        combination = DiceCombination.define_triple(number).new
        has_in_roll, rest = combination.has_in_roll? roll
        score += has_in_roll ? combination.score : 0
        [rest, score]
      end
    end

    def check_ones(dice_roll)
      score = number = 0
      while dice_roll.size > 0 do
        combination = DiceCombination.define_one(number).new
        has_in_roll, dice_roll = combination.has_in_roll? dice_roll
        score += combination.score if has_in_roll
        number += 1 unless has_in_roll
      end
      [dice_roll, score]
    end

    def self.define_triple(number)
      class_name = 'Three' + number.to_s
      Object.const_get class_name
    rescue
      klass = Object.const_set class_name, Class.new
      klass.class_eval do
        define_method :score do
          return 1000 if number == 1
          100 * number
        end

        define_method :has_in_roll? do |dice_roll|
          has = dice_roll.count(number) >= 3
          return [has, dice_roll] unless has
          roll_clone = dice_roll.clone
          (0..2).each { |i| roll_clone.delete_at roll_clone.find_index number }
          [has, roll_clone]
        end
      end

      klass
    end

    def self.define_one(number)
      class_name = 'One' + number.to_s
      Object.const_get class_name
    rescue
      klass = Object.const_set class_name, Class.new
      klass.class_eval do
        define_method :score do
          return 100 if number == 1
          return 50 if number == 5
          0
        end

        define_method :has_in_roll? do |dice_roll|
          has = dice_roll.include?(number)
          return [has, dice_roll] unless has
          roll_clone = dice_roll.clone
          roll_clone.delete_at roll_clone.find_index number
          [has, roll_clone]
        end
      end

      klass
    end

end
