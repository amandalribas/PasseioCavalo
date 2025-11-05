
Implementação em Linguagem Funcional -- Linguagens de Programação 2025.2
Bruno Lopes
Passeio do Cavalo


Integrantes: Amanda Lemos Ribas, Lais Ferreira Nazareth, Maria Eduarda D'Angelo.

    As três integrantes do grupo, inicialmente participaram da discussão sobre implementação, discutindo se seria válido o uso de matrizes, ou usar vetores auxiliares, compostos de posições (coordenadas),levando ao inicio da implementação do projeto, Amanda fez a implementação da leitura de arquivo (main, acessaLinha, resolveCavalo), enquanto Maria Eduarda e Lais realizaram a criação das primeiras funções auxiliares (Ex: total, movimentos,  movCandidatos, verificaPosicao, verificaCompleto, coordValida).
    
    Após a criação inicial do projeto, as integrantes, em conjunto, fizeram uma função principal recurssiva, porém, que era ineficaz para tabuleiros próximos a 8x8. Com os estudos a partir do vídeo Chapter 2 | The Knight's Tour Problem - CC Academy, foi decidido o uso mais eficaz do backtracking com o uso da Heurística de Warnsdorff. 
    
    A partir dos estudos, foram feitas as funções relacionadas a heurística. O projeto completo foi feito em conjunto simultaneamente, a partir da extensão Live Share do VS Code.


Para Executar, abra o terminal e digite as duas linhas separadamente:

ghci app.hs
main

Para mudar o arquivo de exemplo, em app.hs, altere as aspas, que contem exemplo0.txt pelo nome do arquivo desejado dentro da pasta.

main :: IO () 
main = do
    conteudoArquivo <- readFile "exemplo0.txt"
    let linhas = lines conteudoArquivo  
    acessaLinha linhas