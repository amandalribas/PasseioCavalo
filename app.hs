-- ghci app.hs   
-- main

import Data.List (sortBy)
import Data.Ord (comparing)

type Coordenada = (Int, Int)
type Caminho = [Coordenada]

total :: Int -> Int -> Int
total n m = n * m

movimentos :: Caminho
movimentos = [(2,1), (2,-1), (-2,1), (-2,-1), (1,2), (1,-2), (-1,2), (-1,-2)]

movCandidatos :: Coordenada -> Caminho
movCandidatos (i,j) = [ (i + x, j + y ) | (x, y) <- movimentos]

verificaPosicao :: Int -> Int -> Coordenada -> Bool
verificaPosicao n m (i, j) = (i >= 1) && (i <= n) && (j >= 1) && (j <= m) 

verificaCompleto :: Int -> Int -> Caminho -> Bool
verificaCompleto n m caminho = length caminho == total n m 

coordValida :: Int -> Int -> Coordenada -> Caminho -> Bool
coordValida n m candidato caminhoAtual = 
    verificaPosicao n m candidato && not (elem candidato caminhoAtual)

chegaNoInicio :: Coordenada -> Coordenada -> Bool
chegaNoInicio atual inicio = inicio `elem` movCandidatos atual

contaMovimentos :: Int -> Int -> Caminho -> Coordenada -> Int
contaMovimentos n m caminhoAtual pos =
    length (filter (\proxPos -> coordValida n m proxPos caminhoAtual) (movCandidatos pos))

candidatosComHeuristica :: Int -> Int -> Coordenada -> Caminho -> Caminho
candidatosComHeuristica n m coordAtual caminhoAtual =
    let 
        candidatosValidos = 
            let
                candidatos = movCandidatos coordAtual
            in
                filter (\posicao -> coordValida n m posicao caminhoAtual) candidatos
        
        candidatosComGrau= 
            [ (contaMovimentos n m caminhoAtual cv, cv) | cv <- candidatosValidos ]
            
        candidatosOrdenados = sortBy (comparing fst) candidatosComGrau
        
    in 
        map snd candidatosOrdenados


buscaHeuristica :: Int -> Int -> [Coordenada] -> Caminho -> Maybe Caminho
buscaHeuristica _ _ [] _ = Nothing
buscaHeuristica n m (c:cs) caminhoCompleto =
    case fazOLNVezes n m c caminhoCompleto of
       Just solucao -> Just solucao          
       Nothing -> buscaHeuristica n m cs caminhoCompleto

fazOLNVezes :: Int -> Int -> Coordenada -> Caminho -> Maybe Caminho
fazOLNVezes n m coordAtual caminhoAtual =
    let
        caminhoCompleto = coordAtual : caminhoAtual
    in 
        if verificaCompleto n m caminhoCompleto
            then
                let
                    inicio = last caminhoCompleto
                    fim = head caminhoCompleto
                in if not (chegaNoInicio fim inicio) 
                    then Just (reverse caminhoCompleto)
                    else Nothing
            else
                let
                    candidatos = candidatosComHeuristica n m coordAtual caminhoCompleto
                in
                    buscaHeuristica n m candidatos caminhoCompleto


resolveCavalo :: Int -> Int -> Int -> Int -> IO ()
resolveCavalo n m i j = do
    let inicio = (i,j)
    if verificaPosicao n m inicio && total n m /= 0
        then do
            putStrLn ("\nTabuleiro: " ++ show n ++ "x" ++ show m ++ " posicao inicial: " ++ show inicio )
            case fazOLNVezes n m inicio [] of 
                Just caminho -> do
                    print caminho
                Nothing -> putStrLn "Nenhuma solução encontrada."
        else 
            putStrLn ( "\nEntrada Inválida: " ++ show n ++ " " ++ show m ++ " " ++ show i ++ " " ++ show j)


acessaLinha :: [String] -> IO ()
acessaLinha [] = return ()
acessaLinha (atual: resto) = do
    let talvezLinha = map read (words atual) :: [Int]
    case talvezLinha of
        [n,m,i,j] -> do
            resolveCavalo n m i j
            acessaLinha resto
        _ -> do
            putStrLn "\nERRO! Formato de linha incorreto, formato esperado: n m i j"
            acessaLinha resto


main :: IO () 
main = do
    conteudoArquivo <- readFile "exemplo0.txt"
    let linhas = lines conteudoArquivo  
    acessaLinha linhas