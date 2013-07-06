module RulesList
  def rules_list
    {
      /[*\w]/ => 0,
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

