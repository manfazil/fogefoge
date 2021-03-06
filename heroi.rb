class Heroi
    attr_accessor :linha, :coluna
    def calculaNovaPosicao direcao
        heroi=self.dup
        movimentos = {
            "W" => [-1,0],
            "S" => [1,0],
            "A" => [0,-1],
            "D" => [0,1]
        }
        movimento = movimentos[direcao]
        heroi.linha += movimento[0]
        heroi.coluna += movimento[1]
        heroi
    end
    
    def esquerda
        calculaNovaPosicao "A"
    end
    
    def direita
        calculaNovaPosicao "D"
    end
    
    def cima
        calculaNovaPosicao "W"
    end
    
    def baixo
        calculaNovaPosicao "S"
    end
    
    def to_array
        [linha,coluna]
    end
    
    def remove_do mapa
        mapa[linha][coluna] = " "
    end
    
    def coloca_no mapa
        mapa[linha][coluna] = "H"
    end
end