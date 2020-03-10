require_relative 'ui'
require_relative 'heroi'

def encontra_jogador(mapa)
    caracter_do_heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna_do_heroi = linha_atual.index caracter_do_heroi
        if coluna_do_heroi
            heroi = Heroi.new
            heroi.linha = linha
            heroi.coluna = coluna_do_heroi
            return heroi
        end
    end
    nil
end

def jogador_perdeu?(mapa)
    perdeu = !encontra_jogador(mapa)
end

def game_over
    puts "\n\n\n\n\n\n"
    puts "Game Over"
end

def joga(nome)
    mapa = le_mapa(2)
    while true
        desenha mapa
        direcao = pede_movimento

        heroi = encontra_jogador mapa
        nova_posicao = heroi.calculaNovaPosicao direcao
				
        if !posicao_valida? mapa, nova_posicao.to_array
            next
        end		

        heroi.remove_do mapa
        nova_posicao.coloca_no mapa
                
		mapa = move_fantasmas mapa
        if jogador_perdeu?(mapa)
            game_over
            break
        end
    end
end

def inicia_fogefoge
    nome = da_boas_vindas
    joga nome
end

def soma(vetor1, vetor2)
    [vetor1[0] + vetor2[0], vetor1[1] + vetor2[1]]
end

def posicoes_validas_a_partir_de(mapa, novo_mapa, posicao)
    posicoes = []
    movimentos = [[-1, 0], [0, +1], [+1, 0], [0, -1]]
    #movimentos = [[-2, -1], [-2, +1], [+2, -1], [+2, +1],[-1, -2], [-1, +2], [+1, -2], [+1, +2]]
    movimentos.each do |movimento|
        nova_posicao = soma posicao,movimento
        if posicao_valida?(mapa, nova_posicao) && posicao_valida?(novo_mapa, nova_posicao)
            posicoes << nova_posicao
        end
    end
    posicoes
end

def move_fantasma(mapa, novo_mapa, linha, coluna)
    posicoes = posicoes_validas_a_partir_de mapa,novo_mapa, [linha, coluna]
    if posicoes.empty?
        return
    end
    aleatoria = rand posicoes.size
    posicao = posicoes[aleatoria]

    mapa[linha][coluna] = " "
    novo_mapa[posicao[0]][posicao[1]] = "F"
    
end

def copia_mapa(mapa)
  novo_mapa = mapa.join("\n").tr("F", " ").split("\n")
end

def move_fantasmas(mapa)
    caracter_do_fantasma = "F"
    novo_mapa = copia_mapa mapa
    mapa.each_with_index do |linha_atual, linha|
        linha_atual.chars.each_with_index do |caractere_atual, coluna|
            eh_fantasma = caractere_atual == caracter_do_fantasma
            if eh_fantasma
                move_fantasma mapa,novo_mapa, linha, coluna
            end
        end
    end
    novo_mapa
end

def posicao_valida? mapa, posicao
	linhas = mapa.size
    colunas = mapa[0].size

    estourou_linha = posicao[0] < 0 || posicao[0] >= linhas
    estourou_coluna = posicao[1] < 0 || posicao[1] >= colunas

    if estourou_linha || estourou_coluna
        return false
    end

    if mapa[posicao[0]][posicao[1]] == "X"
        return false
    end

    true
end

