criaMatriz :: Int -> Int -> a -> [[a]]
criaMatriz n m v = replicate n (replicate m v)


printaMatriz :: Show a => [[a]] -> IO ()
printaMatriz matriz = do
    let linhasParaImprimir = map (unwords . map show) matriz
    mapM_ putStrLn linhasParaImprimir


acessaLinha :: [String] -> IO ()
acessaLinha[] = return()
acessaLinha(atual: resto) = do
    let linha = map read (words atual) :: [Int]
    case linha of
        [n,m,i,j] -> do
           putStrLn ("Dimensao: " ++ show n ++ " x " ++ show m)
           putStrLn ("Posicao Inicial do Cavalo: [" ++ show i ++ "," ++ show j ++ "]")
           
           let matriz = criaMatriz n m 0
           printaMatriz matriz
           putStrLn ""
           acessaLinha resto