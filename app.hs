import Control.Monad (when)
-- ghci app.hs   
--main

-- ASSINATURAS


--type Posicao :: (Int, Int)
--type Caminho :: [Posicao]


verificaEntrada :: Int -> Int -> Int -> Int -> Bool
verificaEntrada n m i j  = (i <= n) && (j <= m)

acessaLinha :: [String] -> IO ()
acessaLinha[] = return() --se vazio fim
acessaLinha(atual: resto) = do --senao percorre 1 por vez
    let linha = map read (words atual) :: [Int]
    case linha of
        [n,m,i,j] -> do
           putStrLn ("Dimensao: " ++ show n ++ " x " ++ show m)
           putStrLn ("Posicao Inicial do Cavalo: [" ++ show i ++ "," ++ show j ++ "]")
           when (verificaEntrada n m i j) $ do
            putStrLn "Entrada Válida"
            --- CODIGO DE EXECUCAO
            ----------
            ----------
           acessaLinha resto
        

main :: IO () 
main = do
    conteudoArquivo <- readFile "arquivo.txt" --todo conteúdo do arquivo
    --putStrLn conteudoArquivo

    let linhas = lines conteudoArquivo --separa em array de strings
    acessaLinha linhas

