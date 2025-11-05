# ==============================================================================
# VARIÁVEIS DO PROJETO
# ==============================================================================

# O nome do arquivo Haskell principal
SOURCE = app.hs

# O nome do executável que será gerado (removendo a extensão .hs)
TARGET = app

# O arquivo de entrada que o 'main' lê
INPUT_FILE = exemplo.txt

# ==============================================================================
# ALVOS PRINCIPAIS
# ==============================================================================

.PHONY: all build run clean repl help

# Alvo padrão: constrói e executa
all: run


build:
	@echo "🛠️ Compilando $(SOURCE) com GHC..."
	# -o $(TARGET) define o nome do arquivo executável de saída
	ghc --make $(SOURCE) -o $(TARGET)



run: build
	@echo "▶️ Executando $(TARGET), lendo do arquivo $(INPUT_FILE)..."
	./$(TARGET)


repl:
	@echo "🚀 Iniciando GHCi..."
	ghci $(SOURCE)



clean:
	@echo "🧹 Limpando artefatos de build..."
	# Remove o executável, o arquivo .o (objeto) e o arquivo .hi (interface)
	rm -f $(TARGET) *.o *.hi


help:
	@echo "Comandos disponíveis:"
	@echo "  make (ou make all) : Constrói e executa o programa."
	@echo "  make build         : Compila o arquivo app.hs."
	@echo "  make run           : Executa o programa (requer 'make build')."
	@echo "  make repl          : Abre o GHCi interativo."
	@echo "  make clean         : Remove os arquivos gerados (executável, .o, .hi)."