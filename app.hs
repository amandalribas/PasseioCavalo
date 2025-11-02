-- ghci app.hs   
--main

type Coordenada = (Int, Int)

type Caminho = [Coordenada]


movimentos :: Caminho
movimentos = [(2,1), (2,-1), (-2,1), (-2,-1), (1,2), (1,-2), (-1,2), (-1,-2)]

movCandiadatos :: Coordenada -> Caminho
movCandiadatos (i,j) = [ (i + x, j + y ) | (x, y) <- movimentos]

verificaPosicao :: Int -> Int -> Coordenada -> Bool
verificaPosicao n m (i, j)  = (i <= n) && (j <= m)

total :: Int -> Int -> Int
total n m = n * m

verificaCompleto :: Int -> Int -> Caminho -> Bool
verificaCompleto n m caminho = length caminho == total n m 

candidatosPossiveis :: Int -> Int -> Coordenada -> Caminho
candidatosPossiveis n m coord = 

acessaLinha :: [String] -> IO ()
acessaLinha[] = return() --se vazio fim
acessaLinha(atual: resto) = do --senao percorre 1 por vez
    let linha = map read (words atual) :: [Int]
    case linha of
        [n,m,i,j] -> do
        
           if ((verificaPosicao n m (i,j)) && (total n m /= 0))
            then do
                putStrLn ("A linha com os parametros " ++ show n ++ " " ++ show m ++  " " ++ show i ++ " " ++ show j ++ " é VÁLIDA.")
                
                --putStrLn ("Executando...")


            else putStrLn ("A linha com os parametros " ++ show n ++ " " ++ show m ++  " " ++ show i ++ " " ++ show j ++ " é INVÁLIDA.")
         
           acessaLinha resto
        

main :: IO () 
main = do
    conteudoArquivo <- readFile "arquivo.txt" --todo conteúdo do arquivo
    --putStrLn conteudoArquivo

    let linhas = lines conteudoArquivo --separa em array de strings
    acessaLinha linhas

