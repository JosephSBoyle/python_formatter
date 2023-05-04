alignEquals :: [String] -> [String]
alignEquals lines = map formatLine (groupVariables lines)

formatLine :: String -> String
formatLine line = case break (== '=') line of
    (var, '=':value) ->
        let padding = replicate (maxVarLength - length var) ' '
        in var ++ padding ++ " = " ++ value
    _ -> line

groupVariables :: [String] -> [[String]]
groupVariables lines = go lines []
  where
    go [] acc = reverse acc
    go (l:ls) [] = go ls [[l]]
    go (l:ls) acc@(g:gs)
        | isVariable l = go ls ((l:g):gs)
        | otherwise    = go ls ([l]:acc)

isVariable :: String -> Bool
isVariable line = '=' `elem` line && "==" `notElem` line

maxVarLength :: Int
maxVarLength = 1 + maximum (map (length . takeWhile (== ' ') . fst . break (== '='))
                                (filter isVariable lines))
