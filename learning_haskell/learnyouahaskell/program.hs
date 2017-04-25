hypotenuse a b = sqrt (a ^ 2 + b ^ 2)

identifyCamel humps = if humps == 1
  then "dromedary"
  else "Bactrian"

noVowels :: [Char] -> [Char]
noVowels word = if word == ""
  then ""
  else if head word `elem` "aeiouAEIOU"
  then noVowels (tail word)
  else
  (head word) : noVowels (tail word)
