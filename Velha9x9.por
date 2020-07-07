programa
{
	inclua biblioteca Teclado --> tl
	inclua biblioteca Tipos --> tp
	inclua biblioteca Texto --> txt
	inclua biblioteca Graficos --> g
	inclua biblioteca Mouse --> m
	inclua biblioteca Util --> u

	inteiro tabuleiro[9][9]
	
	const inteiro LARGURA_DA_TELA = 700, ALTURA_DA_TELA = 485
	inteiro centro_da_tela = LARGURA_DA_TELA / 2
	
	//CORES
	inteiro grade = g.criar_cor(13, 161, 146)
	inteiro fundo = g.criar_cor(20, 189, 172)
	inteiro Xcolor = g.criar_cor(84, 84, 84)
	inteiro Ocolor = g.criar_cor(242, 235, 211)

	inteiro tela_atual = 0
	
	//Tabuleiro:
	//Geral
	inteiro Larg = 5,  Tam = 405, Espa = 45
	//Vertical
	inteiro VDistLeft = 205, VDistTop = 30
	
	//Horizontal
	inteiro HDistTop = 70
	inteiro player = 1
	inteiro vencedor = 0
	inteiro diag = 0

	funcao inteiro CasasLivres(){
		inteiro count = 0
		para(inteiro i=0; i<9; i++){
			para(inteiro k=0; k<9; k++){
				se(tabuleiro[i][k] == 0){
					count++
				}
			}
		}
		retorne count
	}
	
	funcao inteiro ArtificialBrain(){
		inteiro score = 0
		logico jogou = falso
	
		para(inteiro i=0; i < 9; i++){
			para(inteiro x=0; x < 9; x++){
				para(inteiro c=0; c < 2; c++){
					se(tabuleiro[i][x] == 0){
						 //escreva("\nCasa X: "+x+" Y: "+i+" Valor: "+tabuleiro[i][x])
						 
						 se(c == 0){
						 	tabuleiro[i][x] = -1
						 	score = verificaVencedor()
						 	tabuleiro[i][x] = 0
						 }senao{
						 	tabuleiro[i][x] = 1
						 	score = verificaVencedor()
						 	tabuleiro[i][x] = 0
						 }

						 se(score == -1 ou score == 1){
						 	//escreva("\nJogada X: "+x+" Y: "+i+" Valor: "+tabuleiro[i][x])
						 	tabuleiro[i][x] = -1
						 	retorne 0
						 }
					}
				}
			}
		}

		para(inteiro i=0; i < 9; i++){
			para(inteiro x=0; x < 9; x++){	
				//Verifica vertical baixo para cima
				se(x > 1 e tabuleiro[i][x] == 1 e tabuleiro[i][x-1] == 1){
					se(tabuleiro[i][x-2] == 0){
						tabuleiro[i][x-2]=-1
						retorne 0
					}
				}
			
				//Verifica horizontal - Direita para esquerda
				se(x > 1 e tabuleiro[x][i] == 1 e tabuleiro[x-1][i] == 1){
					se(tabuleiro[x-2][i] == 0){
						tabuleiro[x-2][i]=-1
						retorne 0
					}
				}

			
				//Verifica vertical cima para baixo
				se(x < 7 e tabuleiro[i][x] == 1 e tabuleiro[i][x+1] == 1){
					se(tabuleiro[i][x+2] == 0){
						tabuleiro[i][x+2]= -1
						retorne 0
					}
				}
				
				//Verifica horizontal - Esquerda para direita
				se(x < 7 e tabuleiro[x][i] == 1 e tabuleiro[x+1][i] == 1){
					se(tabuleiro[x+2][i] == 0){
						tabuleiro[x+2][i]= -1
						retorne 0
					}
					
				}
				
			}
			
		}
		
		inteiro x = 0, y = 0
		
		enquanto(nao jogou){
			y = u.sorteia(0, 8)
			x = u.sorteia(0, 8)
			se(CasasLivres() == 0){
				pare
			}
			se(tabuleiro[y][x] == 0){	
				tabuleiro[y][x] = -1
				player = 1
				jogou = verdadeiro
			}
					
		}
	
		retorne 0
	}
	
	funcao desenhaEmpate(){
		g.definir_cor(fundo)
		g.limpar()
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(30.0)
		g.desenhar_texto(centro_da_tela - g.largura_texto("Pressione R para Resetar") / 2, 300, "Pressione R para Resetar")	
		g.definir_tamanho_texto(50.0)
		g.definir_cor(Xcolor)
		g.desenhar_texto(centro_da_tela+15 - g.largura_texto("X") / 2, 150, "X")	
		g.definir_cor(Ocolor)
		g.desenhar_texto(centro_da_tela-15- g.largura_texto("O") / 2, 150, "O")		
		g.definir_tamanho_texto(30.0)
		g.definir_cor(Xcolor)
		g.desenhar_texto(centro_da_tela - g.largura_texto("EMPATOU!") / 2, 200, "EMPATOU!")	
		g.renderizar()

		se(tl.alguma_tecla_pressionada()){
			se(tl.tecla_pressionada(tl.TECLA_R)){
				para(inteiro i = 0; i < 9; i++){
					para(inteiro x = 0; x < 9; x++){
						tabuleiro[x][i] = 0
					}
				}
				tela_atual = 0
			}
		}
	}
	
	funcao desenhaVencedor()
	{
		g.definir_cor(fundo)
		g.limpar()
		g.definir_cor(g.COR_PRETO)
		g.definir_tamanho_texto(30.0)
		g.desenhar_texto(centro_da_tela - g.largura_texto("Pressione R para Resetar") / 2, 300, "Pressione R para Resetar")	
		g.definir_tamanho_texto(50.0)
		
		se(vencedor == 1){
			g.definir_cor(Xcolor)
			g.desenhar_texto(centro_da_tela - g.largura_texto("X") / 2, 150, "X")	
			g.desenhar_texto(centro_da_tela - g.largura_texto("VENCEDOR!") / 2, 200, "VENCEDOR!")	
			g.renderizar()
		}senao se(vencedor == -1){
			g.definir_cor(Ocolor)
			g.desenhar_texto(centro_da_tela - g.largura_texto("O") / 2, 150, "O")		
			g.desenhar_texto(centro_da_tela - g.largura_texto("VENCEDOR!") / 2, 200, "VENCEDOR!")	
			g.renderizar()
		}

		se(tl.alguma_tecla_pressionada()){
			se(tl.tecla_pressionada(tl.TECLA_R)){
				para(inteiro i = 0; i < 9; i++){
					para(inteiro x = 0; x < 9; x++){
						tabuleiro[x][i] = 0
					}
				}
				tela_atual = 0
			}
		}

	}
	
	funcao inteiro verificaVencedor()
	{
		inteiro soma, soma2
		inteiro lin=0,col=0

		//Diagonais
		para(lin=4;lin<9;lin++){
			para(col=4;col<9;col++){
				//Sentido principal
				soma = tabuleiro[lin][col]+tabuleiro[lin-1][col-1]+tabuleiro[lin-2][col-2]+tabuleiro[lin-3][col-3]+tabuleiro[lin-4][col-4]
				//Sentido Secundária
				soma2 = tabuleiro[lin][col-4]+tabuleiro[lin-1][col-3]+tabuleiro[lin-2][col-2]+tabuleiro[lin-3][col-1]+tabuleiro[lin-4][col]
				se (soma == 5 ou soma2 == 5){
					retorne 1
				}senao se(soma == -5 ou soma2 == -5){
					retorne -1
				}
			}
		}
		
		//Horizontal/Vertical
		para (inteiro z = 0; z < 9; z++){
			para(inteiro x = 0; x < 5; x++){
				soma = 0, soma2=0
				para(inteiro i = 0; i < 5; i++){
					soma += tabuleiro[z][i+x]	
					soma2 += tabuleiro[i+x][z]	
					se(soma == 5 ou soma2 == 5){
						retorne 1
					}senao se(soma == -5 ou soma2 == -5){
						retorne -1
					}
				}
				
			}
		}	
			
		//Se houver casas vazias, o jogo pode continuar
	     para(inteiro i =0; i < 9; i++){
	     	para(inteiro x = 0; x < 9; x++){
	     		se(tabuleiro[i][x] == 0){
	     			retorne 3	  
	     		}
	     	}
	     }
	
	     //Se não for nenhuma das opções anteriores retorne 0
		retorne 0	
	}
	
	funcao desenha_jogada(){
		para(inteiro i = 0; i < 9; i++){
			para(inteiro x = 0; x < 9; x++){
				se(tabuleiro[i][x] == 1){
					g.definir_cor(Xcolor)
					g.definir_tamanho_texto(48.0)
					g.desenhar_texto(168+(45*i), 30+(45*x), "X")
				}senao se(tabuleiro[i][x] == -1){
					g.definir_cor(Ocolor)
					g.definir_tamanho_texto(48.0)
					g.desenhar_texto(168+(45*i), 30+(45*x), "O")
				}
			}
		}
		
	}

	funcao tela_jogo(){
		inteiro score = verificaVencedor()
		vencedor = score
		se(score == 3){
			g.definir_cor(fundo)
			g.limpar()
			desenhar_quadro()
			MouseDetectClick()
			desenha_jogada()
			g.renderizar()
		}senao se(score == 0){
			tela_atual = 2
		}senao se(score == 1 ou score == -1){
			desenha_jogada()
			tela_atual = 1
		}
	}
	
	funcao desenhar_quadro(){
		g.definir_cor(grade)
		
		para(inteiro i = 0; i < 8; i++){
			//VERTICAL
			g.desenhar_retangulo(VDistLeft+i*Espa, VDistTop, Larg, Tam, falso, verdadeiro)
			
			//HORIZONTAL
			g.desenhar_retangulo(VDistLeft-Espa, HDistTop+i*Espa, Tam, Larg, falso, verdadeiro)
		}
		
	}

	funcao MouseDetectClick(){
		inteiro posX, posY
		
		se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
			posX = (m.posicao_x()-160)/45
			posY = (m.posicao_y()-VDistTop)/45)
			
			se(posX >= 0 e posX <= 8 e posY >= 0 e posY <= 8){
				se(tabuleiro[posX][posY]  == 0){
					tabuleiro[posX][posY] = player	
					
					se(player == 1){
						ArtificialBrain()	
					}senao{
						player = 1
					}
					u.aguarde(300)		
					
				}	
			}	
		}
	}
	
	funcao inicializar(){
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_titulo_janela("Jogo da Velha")
		g.definir_dimensoes_janela(LARGURA_DA_TELA, ALTURA_DA_TELA)
	}
	
	funcao inicio()
	{	
		inicializar()
		enquanto (tela_atual != 3){
			escolha (tela_atual)
			{
				caso 0		          : 	tela_jogo()      		pare
				caso 1    			:	desenhaVencedor()		pare
				caso 2  				:    desenhaEmpate()          pare
			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 231; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */