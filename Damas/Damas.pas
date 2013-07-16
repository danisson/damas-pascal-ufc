Program Damas;
	{$mode objfpc} (* modo de Object Pascal para leitura de arquivos facil *)
	Uses Crt,sysutils; (* crt para gotoXY e clear screen, sysutils para tratamento de strings*)
	var
		display: array[1..21,1..21] of Char; (* matriz dos graficos do tabuleiro *)
		tabuleiro: array[1..10,1..10] of Integer; (* matriz das pecas *)
		tabuleiroMaior : array[ 1..14 , 1..14 ] of integer; (* matriz especial para checagem de fim de jogo *)
		jogada: array[0..3] of Integer; (* vetor com x/y do input de jogada*)
		error,input,escolha: String;
		linha,j,pcasA,pcasB: Integer;
		jogadorB, offline, novoJogo: boolean;
		Texto: TextFile;
		
	(* inicio de procedimentos e functions *)
	
	procedure Contagem; (* conta a quantidade de pecas no tabuleiro*)
	var
		i,j: integer;
	begin
		pcasA:=0; (* pecas de cima*)
		pcasB:=0; (* pecas de baixo*)
		for i:=1 to 10 do
			for j:=1 to 10 do
			begin
				if (tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3) then (* se 'o' ou 'O' adicione um no de cima*)
					pcasA:= pcasA + 1
				else if (tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4) then (* se '@' ou '&' adicione um no de cima*)
					pcasB:= pcasB + 1;
			end;
	end;
	
	procedure JogadaDamas(y0,x0,y1,x1: integer;forcadoComer: boolean); (*movimentacao das pecas*)
	var
		i, j, comeu : integer;
		jogadaEfetuada, aliadoNoCaminho: boolean;
	begin
		aliadoNoCaminho:= false;
		jogadaEfetuada:= false;
		comeu:= 0;
		if jogadorB then
		begin
			if (tabuleiro[y0,x0] = 2) then (*movimento da peca normal*)
			begin
				if (((y1 = y0-2) or (y1 = y0+2)) and ((x1 <> x0+2) or (x1 <> x0-2))) and ((tabuleiro[(y1+y0) div 2,(x1+x0) div 2] = 1) or (tabuleiro[(y1+y0) div 2,(x1+x0) div 2] = 3)) then (* movimento de comer*)
				begin
					tabuleiro[(y1+y0) div 2,(x1+x0) div 2]:= -1;
					comeu:= comeu+1;
					jogadaEfetuada:= true
				end;
				if (y1 <> y0-1) or ((x1 <> x0+1) and (x1 <> x0-1)) then (* Se movimento nao eh diagonal *)
					error:= 'Error 3b'
				else if forcadoComer then (* se forcado a comer e nao comeu *)
					error:= 'Error Cb'
				else 
					jogadaEfetuada:= true
			end
			else if (tabuleiro[y0,x0] = 4) then (* movimento da dama *)
			begin
				if ((x0-x1-y0+y1 <> 0) and (x1-x0+y1-y0 <> 0)) then (* Se movimento nao eh diagonal *)
					error:= 'Error 3b'
				else if (y1<y0) then (* sentido para cima *)
				begin
					if (x1>x0) then (* sentido para direita*)
					begin
						for i:= 1 to x1-x0 do
						begin
							if (tabuleiro[y0-i,i+x0] = 1) then (* se 'o' no meio do caminho *)
							begin
								tabuleiro[y0-i,i+x0]:= -2; (* coloque a peca como possivel peca comida*)
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,i+x0] = 3) then (* se 'O' no meio *)
							begin
								tabuleiro[y0-i,i+x0]:= -4;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,i+x0] = 2) or (tabuleiro[y0-i,i+x0] = 4) then (* se algum aliado no caminho*)
								aliadoNoCaminho:=true;
						end
					end
					else if (x1<x0) then (* sentido para a esquerda *)
					begin
						for i:= 1 to x0-x1 do
						begin
							if (not aliadoNoCaminho) then 
							if (tabuleiro[y0-i,x0-i] = 1) then
							begin
								tabuleiro[y0-i,x0-i]:= -2;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,x0-i] = 3) then
							begin
								tabuleiro[y0-i,x0-i]:= -4;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,x0-i] = 2) or (tabuleiro[y0-i,x0-i] = 4) then
								aliadoNoCaminho:=true;
						end	
					end;
					jogadaEfetuada:= true
				end
				else if (y1>y0) then (* sentido para baixo*)
				begin
					if (x1>x0) then
					begin
						for i:= 1 to x1-x0 do
						begin
							if (tabuleiro[y0+i,i+x0] = 1) then
							begin
								tabuleiro[y0+i,i+x0]:= -2;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,i+x0] = 3) then
							begin
								tabuleiro[y0+i,i+x0]:= -4;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,i+x0] = 2) or (tabuleiro[y0+i,i+x0] = 4) then
								aliadoNoCaminho:=true;
						end
					end
					else if (x1<x0) then
					begin
						for i:= 1 to x0-x1 do
						begin
							if (tabuleiro[y0+i,x0-i] = 1) then
							begin
								tabuleiro[y0+i,x0-i]:= -2;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,x0-i] = 3) then
							begin
								tabuleiro[y0+i,x0-i]:= -4;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,x0-i] = 2) or (tabuleiro[y0+i,x0-i] = 4) then
								aliadoNoCaminho:=true;
						end
					end;
					jogadaEfetuada:= true
				end;
				if forcadoComer then (* se forcado a comer e nao comeu *)
					begin
					jogadaEfetuada:= false;
					error:= 'Error Cb'
					end
			end;
			if (tabuleiro[y0,x0] <> 2) and (tabuleiro[y0,x0] <> 4) then (* se peca nao eh '@' ou '&' *)
			begin
				error:= 'Error 1b';
				jogadaEfetuada:= false
			end
			else if (tabuleiro[y1,x1] <> 0) and (tabuleiro[y1,x1] <> -1) then (* se o movimento nao vai para um espaco vazio*)
			begin
				error:= 'Error 2b';
				jogadaEfetuada:= false
			end
		end
		else (* inicio dos movimentos do jogador de cima *)
		begin
			if (tabuleiro[y0,x0] = 1) then
			begin
				if (((y1 = y0+2) or (y1 = y0-2)) and ((x1 <> x0+2) or (x1 <> x0-2))) and ((tabuleiro[(y1+y0) div 2,(x1+x0) div 2] = 2) or (tabuleiro[(y1+y0) div 2,(x1+x0) div 2] = 4)) then
				begin
					tabuleiro[(y1+y0) div 2,(x1+x0) div 2]:= -1;
					comeu:= comeu+1;
					jogadaEfetuada:= true
				end;
				if (y1 <> y0+1) or ((x1 <> x0+1) and (x1 <> x0-1)) then
					error:= 'Error 3a'
				else if forcadoComer then
					error:= 'Error Ca'
				else 
					jogadaEfetuada:= true
			end
			else if (tabuleiro[y0,x0] = 3) then
			begin
				if ((x0-x1-y0+y1 <> 0) and (x1-x0+y1-y0 <> 0)) then
					error:= 'Error 3a'
				else if (y1<y0) then
				begin
					if (x1>x0) then
					begin
						for i:= 1 to x1-x0 do
						begin
							if (tabuleiro[y0-i,i+x0] = 2) then
							begin
								tabuleiro[y0-i,i+x0]:= -3;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,i+x0] = 4) then
							begin
								tabuleiro[y0-i,i+x0]:= -5;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,i+x0] = 1) or (tabuleiro[y0-i,i+x0] = 3) then
								aliadoNoCaminho:=true;
						end
					end
					else if (x1<x0) then
					begin
						for i:= 1 to x0-x1 do
						begin
							if (not aliadoNoCaminho) then 
							if (tabuleiro[y0-i,x0-i] = 2) then
							begin
								tabuleiro[y0-i,x0-i]:= -3;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,x0-i] = 4) then
							begin
								tabuleiro[y0-i,x0-i]:= -5;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0-i,x0-i] = 1) or (tabuleiro[y0-i,x0-i] = 3) then
								aliadoNoCaminho:=true;
						end	
					end;
					jogadaEfetuada:= true
				end
				else if (y1>y0) then
				begin
					if (x1>x0) then
					begin
						for i:= 1 to x1-x0 do
						begin
							if (tabuleiro[y0+i,i+x0] = 2) then
							begin
								tabuleiro[y0+i,i+x0]:= -3;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,i+x0] = 4) then
							begin
								tabuleiro[y0+i,i+x0]:= -5;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,i+x0] = 1) or (tabuleiro[y0+i,i+x0] = 3) then
								aliadoNoCaminho:=true;
						end
					end
					else if (x1<x0) then
					begin
						for i:= 1 to x0-x1 do
						begin
							if (tabuleiro[y0+i,x0-i] = 2) then
							begin
								tabuleiro[y0+i,x0-i]:= -3;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,x0-i] = 4) then
							begin
								tabuleiro[y0+i,x0-i]:= -5;
								forcadoComer:= false;
								comeu:= comeu + 1
							end
							else if (tabuleiro[y0+i,x0-i] = 1) or (tabuleiro[y0+i,x0-i] = 3) then
								aliadoNoCaminho:=true;
						end
					end;
					jogadaEfetuada:= true
				end;
				if forcadoComer then
					begin
					jogadaEfetuada:= false;
					error:= 'Error Ca'
					end
			end;
			if (tabuleiro[y0,x0] <> 1) and (tabuleiro[y0,x0] <> 3) then
			begin
				error:= 'Error 1a';
				jogadaEfetuada:= false
			end
			else if (tabuleiro[y1,x1] <> 0) and (tabuleiro[y1,x1] <> -1) then
			begin
				error:= 'Error 2a';
				jogadaEfetuada:= false
			end
		end;
		if jogadaEfetuada and (not aliadoNoCaminho) and ((tabuleiro[y0,x0] = 3) or (tabuleiro[y0,x0] = 4)) then (* se nao tinha aliado no caminho e era dama*)
		begin
			for i:= 1 to 10 do
					for j:= 1 to 10 do
					begin
						if (tabuleiro[i,j]<-1) and ((tabuleiro[i+1,j+1]<-1) or (tabuleiro[i-1,j-1]<-1) or (tabuleiro[i-1,j+1]<-1) or (tabuleiro[i-1,j-1]<-1))  then
						begin (* checa se nas pecas comidas tinha alguma logo na diagonal da outra (movimento invalido) *)
							jogadaEfetuada:=false;
							error:='Error Ob'
						end;
					end;
		end;
		if not jogadaEfetuada and offline then (* se jogo era offline, mostre a linha de erro*)
		begin
			error:='ErL:'+Format('%*d',[4, linha]);
			offline:=false
		end;
		if jogadaEfetuada and (not aliadoNoCaminho) then (* se jogada efetuada e nenhum outro problmema*)
		begin
			for i:= 1 to 10 do
				for j:= 1 to 10 do
				begin
					if (tabuleiro[i,j]<-1) then (* comer as pecas *)
						tabuleiro[i,j]:= -1
				end;
			error := 'No error';
			if ((y1 = 1) or (y1 = 10)) and (tabuleiro[y0,x0] < 3) then (* se movimento for na primeira ou na ultima linha, virar dama*)
				tabuleiro[y1,x1]:= (tabuleiro[y0,x0]+2)
			else
				tabuleiro[y1,x1]:= tabuleiro[y0,x0];
			tabuleiro[y0,x0]:= -1;
			if jogadorB and (comeu = 0) then (* se era vez do jogador de baixo e ele nao comeu, trocar de jogador*)
				jogadorB := false
			else if (not jogadorB) and (comeu = 0) then (* se era vez do jogador de cima e ele nao comeu, trocar de jogador*)
				jogadorB := true;
			if (comeu > 0) then (* mostrar quantas pecas o jogador comeu *)
			begin
				str (comeu,error);
				Insert ('Comeu: ',error,0);
			end
		end
		else if aliadoNoCaminho then (* se aliado no caminho, desfazer comidas*)
		begin
			error:= 'Error FF';
			for i:= 1 to 10 do
				for j:= 1 to 10 do
				begin
					if (tabuleiro[i,j]<-1) then
						tabuleiro[i,j]:=(tabuleiro[i,j]*-1)-1;
				end;
		end;
	end;
	
	function Musteat(turnoJogadorB: boolean): boolean;
	var
	i, j, i2, j2 : integer;
	frcadoAComer : boolean;
	begin
        frcadoAComer:= false;
		for i := 3 to 12 do(*transforma o tabuleiro*)
		begin
			for j := 3 to 12 do
			begin
				if (tabuleiro[i-2,j-2]=0) then
					tabuleiroMaior[i,j] := -1
				else
					tabuleiroMaior[i,j] := tabuleiro[i-2,j-2];
			end;
		end;
		for i := 1 to 2 do(*transforma o tabuleiro*)
		begin
			for j := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;
		for i := 13 to 14 do(*transforma o tabuleiro*)
		begin
			for j := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;
		for j := 1 to 2 do(*transforma o tabuleiro*)
		begin
			for i := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;		
		for j := 13 to 14 do(*transforma o tabuleiro*)
		begin
			for i := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;
		for i := 3 to 12 do(*Percorre o tabuleiro verificando cada posição*)
		begin
			for j := 3 to 12 do
			begin
				if (tabuleiroMaior[i,j] = 1) and (not turnoJogadorB) then(*Checa se a peça regular de cima é forçada a comer*)
				begin
					if (tabuleiroMaior[i+1,j+1] = 2) or (tabuleiroMaior[i+1,j+1] = 4) then
						if (tabuleiroMaior[i+2,j+2] = -1) then
							frcadoAComer := true;
					if (tabuleiroMaior[i-1,j+1] = 2) or (tabuleiroMaior[i-1,j+1] = 4) then
						if (tabuleiroMaior[i-2,j+2] = -1) then
							frcadoAComer := true;
					if (tabuleiroMaior[i+1,j-1] = 2) or (tabuleiroMaior[i+1,j-1] = 4) then
						if (tabuleiroMaior[i+2,j-2] = -1) then
							frcadoAComer := true;
					if (tabuleiroMaior[i-1,j-1] = 2) or (tabuleiroMaior[i-1,j-1] = 4) then
						if (tabuleiroMaior[i-2,j-2] = -1) then
							frcadoAComer := true;
				end
				else if (tabuleiroMaior[i,j] = 2) and turnoJogadorB then(*Checa se a peça regular de baixo é forçada a comer*)
				begin
					if (tabuleiroMaior[i+1,j+1] = 3) or (tabuleiroMaior[i+1,j+1] = 1) then
						if (tabuleiroMaior[i+2,j+2] = -1) then
							frcadoAComer := true;
					if (tabuleiroMaior[i-1,j+1] = 3) or (tabuleiroMaior[i-1,j+1] = 1) then
						if (tabuleiroMaior[i-2,j+2] = -1) then
							frcadoAComer := true;
					 if (tabuleiroMaior[i+1,j-1] = 3) or (tabuleiroMaior[i+1,j-1] = 1) then
						if (tabuleiroMaior[i+2,j-2] = -1) then
							frcadoAComer := true;
					if (tabuleiroMaior[i-1,j-1] = 3) or (tabuleiroMaior[i-1,j-1] = 1) then
						if (tabuleiroMaior[i-2,j-2] = -1) then
							frcadoAComer := true;
				end
				else if ((tabuleiroMaior[i,j] = 3) and (not turnoJogadorB)) or ((tabuleiroMaior[i,j] = 4) and turnoJogadorB) then(*Checa se a dama é forçada a comer*)
				begin
					i2 := i;
					j2 := j;
					repeat(*Cada repeat é uma diagonal sendo checada*)
						i2 := i2+1;
						j2 := j2+1;
						if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 3)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 4)) then
							break;
						if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 4)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 3)) then
							if ((tabuleiroMaior[i2+1,j2+1] = 0) or (tabuleiroMaior[i2+1,j2+1] = -1)) and ((tabuleiroMaior[i2-1,j2-1] = 0) or (tabuleiroMaior[i2-1,j2-1] = -1)) then
								frcadoAComer := true;				
					until ((j2 = 14) or (i2 = 14));
					if not frcadoAComer then
					begin
						i2 := i;
						j2 := j;
						repeat
							i2 := i2-1;
							j2 := j2+1;
							if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 3)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 4)) then
								break;
							if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 4)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 3)) then
								if ((tabuleiroMaior[i2-1,j2+1] = 0) or (tabuleiroMaior[i2-1,j2+1] = -1)) and ((tabuleiroMaior[i2+1,j2-1] = 0) or (tabuleiroMaior[i2+1,j2-1] = -1)) then
								frcadoAComer := true;				
						until ((j2 = 14) or (i2 = 1));	
					end;
					if not frcadoAComer then
					begin
						i2 := i;
						j2 := j;
						repeat
							i2 := i2-1;
							j2 := j2-1;
							if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 3)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 4)) then
								break;
							if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 4)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 3)) then
								if ((tabuleiroMaior[i2-1,j2-1] = 0) or (tabuleiroMaior[i2-1,j2-1] = -1)) and ((tabuleiroMaior[i2+1,j2+1] = 0) or (tabuleiroMaior[i2+1,j2+1] = -1)) then
								frcadoAComer := true;				
						until ((j2 = 1) or (i2 = 1));	
					end;
					if not frcadoAComer then
					begin
						i2 := i;
						j2 := j;
						repeat
							i2 := i2+1;
							j2 := j2-1;
							if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 3)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 4)) then
								break;
							if (((tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3)) and (tabuleiroMaior[i,j] = 4)) or (((tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4)) and (tabuleiroMaior[i,j] = 3)) then
								if ((tabuleiroMaior[i2+1,j2-1] = 0) or (tabuleiroMaior[i2+1,j2-1] = -1)) and ((tabuleiroMaior[i2-1,j2+1] = 0) or (tabuleiroMaior[i2-1,j2+1] = -1)) then
								frcadoAComer := true;		
						until ((j2 = 1) or (i2 = 14));	
					end;
				end;
			end;
		end;			
	Musteat:=frcadoAComer;
	end;
	
	Procedure print(); (* funcao de printar o tabuleiro*)
	var
		i2, j2: Integer;
	begin
		clrscr;
		WriteLn('');
		For i2 := 1 to 22 do
		begin
			If (i2 mod 2 <> 0) or (i2=22) then
				Write('  ')
			Else
			begin
				Write((i2-1) div 2);
				Write(' ')
			end;
			for j2 := 1 to 21 do
			begin
				If ((i2=1) or (i2=22)) and (j2=1) then
				begin
				WriteLn(' A B C D E F G H I J');
				If (i2=1) then
					Write('  ')
				end;
				if (i2<22) then 
					Write(display[i2,j2]);
			end;
			WriteLn('');
		end;
		GotoXY(28,13);
		Write('+--------+');
		GotoXY(28,14);
		Write('|',error,'|');
		GotoXY(25,15);
		Write('+--+---+----+--+');
		GotoXY(25,16);
		Write('|');
		if jogadorB then
			Write(' ')
		else
			Write('*');
		Write('Cima |');
		if not jogadorB then
			Write(' ')
		else
			Write('*');
		Write('Baixo |');
		GotoXY(25,17);
		Write('|  ');
		Write(Format('%*d',[2, pcasA]));
		Write('  |   ');
		Write(Format('%*d',[2, pcasB]));
		Write('  |');
		GotoXY(25,18);
		Write('+------+-------+');
		GotoXY(1,24);
	end;
	
	Procedure inserirTabuleiro(); (* transforma o tabuleiro numerico no tabuleiro de display*)
	var
		i2, j2: Integer;
	begin
		For i2 := 1 to 10 do
		begin
			for j2 := 1 to 10 do
			begin
				if (tabuleiro[i2,j2] = 1) then
					display[i2*2,j2*2]:='o'
				Else if (tabuleiro[i2,j2] = 3) then
					display[i2*2,j2*2]:='O'
				Else if (tabuleiro[i2,j2] = 2) then
					display[i2*2,j2*2]:='@'
				Else if (tabuleiro[i2,j2] = 4) then
					display[i2*2,j2*2]:='&'
				Else if (tabuleiro[i2,j2] = -1) then
					display[i2*2,j2*2]:=' '
			end;
		end;
	end; (* Fim de inserirTabuleiro*)
	
	Procedure Init(); (* inicializa o jogo pela primeira vez*)
	var
		i2, j2: Integer;
	begin
		For i2 := 1 to 21 do (* desenha tabuleiro de graficos *)
		begin
			for j2 := 1 to 21 do
			begin
				display[i2,j2] := ' ';
				If (i2 mod 2 <> 0) then
					display[i2,j2] := '-';
				If (j2 mod 2 <> 0) then
					display[i2,j2] := '|';
				If (i2 mod 2 <> 0) and (j2 mod 2 <> 0) then
					display[i2,j2] := '+';
				If (i2 mod 4 = 0) and (j2 mod 4 = 0) then
					display[i2,j2] := '#'
				Else If (i2 mod 4 <> 0) and (i2 mod 2 = 0) and (j2 mod 2 = 0) and (j2 mod 4 <> 0) then
					display[i2,j2] := '#'
			end;
		end;
		for i2 :=1 to 10 do (* limpa tabuleiro*)
			for j2 := 1 to 10 do
					tabuleiro[i2,j2]:= 0;
		for i2 :=1 to 10 do (* insere posicoes inciais*)
		begin
			for j2 := 1 to 5 do
			begin
				if (i2 mod 2 = 0) and (i2<4) then
					tabuleiro[i2,(j2*2)-1]:= 1;
				if (i2 mod 2 <> 0) and (i2<4) then
					tabuleiro[i2,(j2*2)]:= 1;
				if (i2 mod 2 = 0) and (i2>7) then
					tabuleiro[i2,(j2*2)-1]:= 2;
				if (i2 mod 2 <> 0) and (i2>7) then
					tabuleiro[i2,(j2*2)]:= 2;
			end;
		end;
	error:= 'Welcome!';
	end; (* Fim de Init *)
	
	Procedure leia(); (* ler jogada*)
	var
		s: String;
		erro: boolean;
	begin
		erro:= true;
		while (erro) do
		begin
			if (not offline) then (* se nao esta offline, printe as instrucoes*)
			begin
				GotoXY(1,25);
				clreol();
				write('Entre com a jogada:');
				GotoXY(21,25);
				readLn(s)
			end
			else
				s:= input; (* se nao, a jogada eh a linha lida*)
			if (length(s) = 6) then (* se a string eh do tamanho certo *)
			begin
				jogada[1]:= Integer(s[1])-64;
				jogada[3]:= Integer(s[5])-64;
				jogada[0]:= Integer(s[2])-47;
				jogada[2]:= Integer(s[6])-47;
				if (jogada[0] < 1) or (jogada[0] > 10) or (jogada[1] < 1) or (jogada[1] > 10) or (jogada[2] < 1) or (jogada[2] > 10) or (jogada[3] < 1) or (jogada[3] > 10) then (* se jogada fora do tabuleiro *)
				begin
					erro:= true;
					if(not offline) then (* se nao esta offline, mostre que deu erro*)
					begin
						GotoXY(28,14);
						Write('|Input Er|');
						GotoXY(1,25);
						ClrEol()
					end;
					if(offline) then (* se nao, falei aonde dei problema na linha e troque pro modo normal *)
					begin
						offline:= false;
						inserirTabuleiro();
						print();
						GotoXY(28,14);
						Write('|ErL:',Format('%*d',[4, linha]),'|');
						GotoXY(1,25);
						leia();
						break;
					end;
				end
				else
					erro:= false;
			end
			else (* se nao, de erro *)
			begin
				erro:= true;
				if(not offline) then
				begin
					GotoXY(28,14);
					Write('|Input Er|');
					GotoXY(1,25);
					ClrEol()
				end;
				if(offline) then
				begin
					offline:= false;
					inserirTabuleiro();
					print();
					GotoXY(28,14);
					Write('|ErL:',Format('%*d',[4, linha]),'|');
					GotoXY(1,25);
					leia();
					break;
				end;
			end;
		end;
	end;
	
	Procedure escolhaJogador(); (* recebe escolha de jogador *)
	var
		s: char;
		erro: boolean;
	begin
		erro:= true;
		while (erro) do
		begin
			if(not offline) then (* se nao eh offline, printe as instrucoes *)
			begin
				GotoXY(1,25);
				write('Escolha o jogador inicial:');
				GotoXY(30,25);
				write('(C/B)');
				GotoXY(28,25);
				readLn(s);
			end
			else (* se nao, recebe a primeira letra do input*)
				s:= input[1];
			if (s <> 'C') and (s <> 'B') then (* se eh diferente de C ou B, de erro*)
			begin
				erro:= true;
				if (not offline) then
				begin
					GotoXY(1,23);
					Write('Input Error');
					GotoXY(1,24);
					ClrEol()
				end;
				if (offline) then
				begin
					offline:= false;
					GotoXY(1,24);
					Write('Erro na linha 1');
					escolhaJogador();
					break;
				end;
			end
			else (* se nao, escolha o jogador *)
			begin
				if (s = 'C') then
					jogadorB:=false
				else if (s = 'B') then
					jogadorB:=true;
				erro:= false;
				GotoXY(1,24)
			end;
		end;
	end;
	
	Function Finalchecker(turnoJogadorB: boolean) : boolean; (*trocadilho *)
	var
	jogadaValidaC, jogadavalidaB, i, j, i2, j2 : integer;
	fimDeJogo : boolean;
	begin
		jogadaValidaC := 0;
		jogadaValidaB := 0;
		fimDeJogo := false;
		for i := 3 to 12 do(*transforma o tabuleiro*)
		begin
			for j := 3 to 12 do
			begin
				if (tabuleiro[i-2,j-2] = 0) then
					tabuleiroMaior[i,j] := -1
				else
					tabuleiroMaior[i,j] := tabuleiro[i-2,j-2];
			end;
		end;
		for i := 1 to 2 do(*transforma o tabuleiro*)
		begin
			for j := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;
		for i := 13 to 14 do(*transforma o tabuleiro*)
		begin
			for j := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;
		for j := 1 to 2 do(*transforma o tabuleiro*)
		begin
			for i := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;		
		for j := 13 to 14 do(*transforma o tabuleiro*)
		begin
			for i := 1 to 14 do
			begin
				tabuleiroMaior[i,j] := 50;
			end;
		end;	
		for i := 3 to 12 do(*Percorre o tabuleiro verificando cada posição*)
		begin
			for j := 3 to 12 do
			begin
				if (tabuleiroMaior[i,j] = 1) then(*Checa se a jogada é válida caso a peça seja uma peça regular de cima*)
				begin
					if ((tabuleiroMaior[i+1,j+1] = -1) or (tabuleiroMaior[i+1,j+1] = 0) or (tabuleiroMaior[i+1,j-1] = -1) or (tabuleiroMaior[i+1,j-1] = 0)) then
							jogadaValidaC := jogadaValidaC +1
					(*Estes 4 ifs poderiam ser resumidos em um, mas foram separados para facilitar leitura.*)
					else if (tabuleiroMaior[i+1,j+1] = 2) or (tabuleiroMaior[i+1,j+1] = 4) then
						if (tabuleiroMaior[i+2,j+2] = -1) then
							jogadaValidaC := jogadaValidaC +1
					else if (tabuleiroMaior[i-1,j+1] = 2) or (tabuleiroMaior[i-1,j+1] = 4) then
						if (tabuleiroMaior[i-2,j+2] = -1) then
							jogadaValidaC := jogadaValidaC +1
					else if (tabuleiroMaior[i+1,j-1] = 2) or (tabuleiroMaior[i+1,j-1] = 4) then
						if (tabuleiroMaior[i+2,j-2] = -1) then
							jogadaValidaC := jogadaValidaC +1
					else if (tabuleiroMaior[i-1,j-1] = 2) or (tabuleiroMaior[i-1,j-1] = 4) then
						if (tabuleiroMaior[i-2,j-2] = -1) then
							jogadaValidaC := jogadaValidaC +1
				end;
				if (tabuleiroMaior[i,j] = 2) then(*Checa se a jogada é válida caso a peça seja uma peça regular de baixo*)
				begin
					if ((tabuleiroMaior[i-1,j+1] = -1) or (tabuleiroMaior[i-1,j-1] = -1)) then
						jogadaValidaB := jogadaValidaB +1
					(*Estes 4 ifs poderiam ser resumidos em um, mas foram separados para facilitar leitura.*)
					else if ((tabuleiroMaior[i+1,j+1] = 3) or (tabuleiroMaior[i+1,j+1] = 1)) and (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaB := jogadaValidaB +1
					else if ((tabuleiroMaior[i-1,j+1] = 3) or (tabuleiroMaior[i-1,j+1] = 1)) and (tabuleiroMaior[i-2,j+2] = -1) then
						jogadaValidaB := jogadaValidaB +1
					else if ((tabuleiroMaior[i+1,j-1] = 3) or (tabuleiroMaior[i+1,j-1] = 1)) and (tabuleiroMaior[i+2,j-2] = -1) then
						jogadaValidaB := jogadaValidaB +1
					else if ((tabuleiroMaior[i-1,j-1] = 3) or (tabuleiroMaior[i-1,j-1] = 1)) and (tabuleiroMaior[i-2,j-2] = -1) then
						jogadaValidaB := jogadaValidaB +1
				end
				else if (tabuleiroMaior[i,j] = 3) then (*Checa se a jogada é valida para uma dama de cima*)
				begin
					i2 := i;
					j2 := j;
					repeat
						i2 := i2+1;
						j2 := j2+1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaC := jogadaValidaC +1
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							if (tabuleiroMaior[i2+1,j2+1] = 2) or (tabuleiroMaior[i2+1,j2+2] = 4) then
								break
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							break;
					until ((j2 = 14) or (i2 = 14));
					i2 := i;
					j2 := j;
					repeat
						i2 := i2-1;
						j2 := j2+1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaC := jogadaValidaC +1
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							if (tabuleiroMaior[i2-1,j2+1] = 2) or (tabuleiroMaior[i2-1,j2+2] = 4) then
								break
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							break;
					until ((j2 = 14) or (i2 = 1));
					i2 := i;
					j2 := j;
					repeat
						i2 := i2-1;
						j2 := j2-1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaC := jogadaValidaC +1
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							if (tabuleiroMaior[i2-1,j2-1] = 2) or (tabuleiroMaior[i2-1,j2-2] = 4) then
								break
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							break;
					until ((j2 = 1) or (i2 = 1));
					i2 := i;
					j2 := j;
					repeat
						i2 := i2+1;
						j2 := j2-1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaC := jogadaValidaC +1
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							if (tabuleiroMaior[i2+1,j2-1] = 2) or (tabuleiroMaior[i2+1,j2-2] = 4) then
								break
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							break;
					until ((j2 = 1) or (i2 = 14));
				end
				else if (tabuleiroMaior[i,j] = 4) then(*Checa se a jogada é valida para uma dama de baixo*)
				begin
					i2 := i;
					j2 := j;
					repeat
						i2 := i2+1;
						j2 := j2+1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaB := jogadaValidaB +1
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							if (tabuleiroMaior[i2+1,j2+1] = 1) or (tabuleiroMaior[i2+1,j2+2] = 3) then
								break
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							break;
					until ((j2 = 14) or (i2 = 14));
					i2 := i;
					j2 := j;
					repeat
						i2 := i2-1;
						j2 := j2+1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaB := jogadaValidaB +1
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							if (tabuleiroMaior[i2-1,j2+1] = 1) or (tabuleiroMaior[i2-1,j2+2] = 3) then
								break
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							break;
					until ((j2 = 14) or (i2 = 1));
					i2 := i;
					j2 := j;
					repeat
						i2 := i2-1;
						j2 := j2-1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaB := jogadaValidaB +1
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							if (tabuleiroMaior[i2-1,j2-1] = 1) or (tabuleiroMaior[i2-1,j2-2] = 3) then
								break
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							break;
					until ((j2 = 1) or (i2 = 1));
					i2 := i;
					j2 := j;
					repeat
						i2 := i2+1;
						j2 := j2-1;
						if tabuleiroMaior[i2,j2] = 0 then
							jogadaValidaB := jogadaValidaB +1
						else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
							if (tabuleiroMaior[i2+1,j2-1] = 1) or (tabuleiroMaior[i2+1,j2-2] = 3) then
								break
						else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
							break;
					until ((j2 = 1) or (i2 = 14));
				end
			end;
		end;				
		if (pcasA = 0) or (pcasB = 0) then
			fimDeJogo:=true;
		(*Executa as ações necessárias, pois alguém tem de fazê-las*)
		if (jogadaValidaB > 0) and (jogadaValidaC <= 0) then
			jogadorB := true
		else if (jogadaValidaC > 0) and (jogadaValidaB <= 0) then
			jogadorB := false;
		if (jogadaValidaB <= 0) and (jogadaValidaC <= 0) then
			fimDeJogo := true;
		Finalchecker:= fimDeJogo;
	end;
	
(* Main *)

	begin
		novoJogo:= true;
		while (novoJogo) do
		begin
			clrscr;
			Init();
			contagem();
			inserirTabuleiro();
			if(ParamCount >1) then (* se foi inserido mais de um parametro*)
			begin
				WriteLn('Erro! Mais de um parametro utilizado');
				WriteLn('Faca no formato "damas arquivo.txt" para o modo offline');
				ReadLn();
			end
			else if (ParamCount = 0) then (* se modo normal*)
			begin
				escolhaJogador();
				offline:= false
			end
			else if (ParamCount = 1) then (* se modo offline*)
			begin
				offline:= true;
				jogadorB:= false
			end;
			while(not Finalchecker(jogadorB)) do (* enquanto o jogo nao acaba *)
			begin
				if (not offline) then (* se nao eh modo offline, mande as instrucoes normais *)
				begin
					print();
					leia();
					jogadaDamas(jogada[0],jogada[1],jogada[2],jogada[3],Musteat(jogadorB));
					contagem();
					inserirTabuleiro();
				end
				else (* se eh modo offfline*)
				begin
					linha:=1;
					AssignFile(Texto, ParamStr(1)); (* abra o arquivo *)
					Reset(texto); (* abra o arquivo *)
					while(not EOF(Texto) and offline) do (* se nao estamos no fim do arquivo e ainda esta no modo offline *)
					begin
						readln(Texto, input);
						if (linha=1) then (* se primeira linha lida *)
							escolhaJogador()
						else
						begin (* se nao, jogue o jogo*)
							leia();
							jogadaDamas(jogada[0],jogada[1],jogada[2],jogada[3],Musteat(jogadorB));
							contagem();
						end;
						linha:= linha +1
					end;
					CloseFile(Texto); (* feche o arquivo *)
					inserirTabuleiro(); (* insira os graficos do fim do jogo*)
					print();
					offline:= false;
				end;
			end;
			WriteLn('');
			Write('Fim de jogo! ');
			if (pcasA > pcasB) then (* se tem mais pecas do jogador de cima*)
				WriteLn('O jogador de cima ganhou a partida!')
			else if (pcasA < pcasB) then (* se tem mais pecas do jogador de baixo*)
				WriteLn('O jogador de baixo ganhou a partida!')
			else (* se nao *)
				WriteLn('Empate!');
			WriteLn('Deseja continuar? (s/n)');
			readln(escolha);
			if (escolha <> 's') then (* se escolha, diferente de 's', pare o jogo*)
				novoJogo:= false;
		end;
	end.