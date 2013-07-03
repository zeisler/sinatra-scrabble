module RulesList
  def rules_list
    {
      /[\s]/ => 0,
      /[aeioulnrst]/ => 1,
      /[dg]/ => 2,
      /[bcmp]/ => 3,
      /[fhvwy]/ => 4,
      /[k]/ => 5,
      /[jx]/ => 8,
      /[qz]/ => 10
    }
  end
end

# class Test
#   include ScrabbleRules

#   def bools
#     rules
#   end
# end

# puts Test.new.bools.class
