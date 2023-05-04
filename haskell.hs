import Data.List (intercalate)
import Data.Char (isSpace)

formatLines :: [String] -> [String]
formatLines = map formatLine . alignEquals . map stripLine

stripLine :: String -> String
stripLine = reverse . dropWhile isSpace . reverse

alignEquals :: [String] -> [(String, String)]
alignEquals = map splitLine
            . filter (elem '=')
            . map stripLine

splitLine :: String -> (String, String)
splitLine str = let (left, _:right) = break (== '=') str
                in (left, '=' : right)

formatLine :: (String, String) -> String
formatLine (left, right) = left ++ padding ++ right
  where padding = replicate (maxLen - length left) ' '

maxLen :: Int
maxLen = maximum . map (length . fst) . alignEquals
