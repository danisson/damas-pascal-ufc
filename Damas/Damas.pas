Program Damas(output);
	Uses Crt;
	var
		display: array[1..21,1..21] of Char;
		tabuleiro: array[0..10,0..10] of Integer;
		erro: String;
		(*i, j: Integer;*)
	
	procedure JogadaDamas();
	var
		xCom, yCom, xFim, yFim, i, j, diagonal : integer;
		(*x e y são os valores das posições. i e j são indices. diagonal é usado na movimentação.*)
		jogadaEfetuada, aliadoNoCaminho, frcadoAComer, comeu, turnoJogadorB : boolean;(*Caso o turno seja do jogador 2, o resultado será falso*)
	begin
		writeln('xcom ycom xfim yfim, nessa ordem');
		readln(xCom, yCom, xFim, yFim);
		jogadaEfetuada := false;
		writeln('de quem é o turno?(B/C)');
			turnoJogadorB := true;
		(*area de entradas teste/debug termina aqui*)
		(*começo do codigo serio, parte de testes*)
		jogadaEfetuada := true;
		frcadoAComer := false;
		comeu := false;
		if ((xCom < 1) or (xCom > 10) or (yCom < 1) or (yCom > 10) or (xFim < 1) or (xFim > 10) or (yFim < 1) or (yFim > 10)) then
		begin		
			Erro := 'Error code: 1';
			jogadaEfetuada := false;(*Checa se o Quadrado existe no Tabuleiro*)
		end
		else if (((not turnoJogadorB) and ((tabuleiro[xCom,yCom] = 1) or (tabuleiro[xCom,yCom] = 3))) or ((turnoJogadorB) and ((tabuleiro[xCom,yCom] = 1) or (tabuleiro[xCom,yCom] = 3)))) then
		begin		
			Erro := 'Error code: 2';
			jogadaEfetuada := false;(*Checa se há peça no local de partida.*)
		end
		else if (tabuleiro[xFim,yFim] <> 0) then
		begin		
			Erro := 'Error code: 3';
			jogadaEfetuada := false;(*Checa se há peça no local de final de jogada*)
		end
		else if ((tabuleiro[xCom,yCom] = 3) or (tabuleiro[xCom,yCom] = 4)) then(*Testar se irá ser forçado a comer, caso dama.*)
		begin
			i := xCom;
			j := yCom;
			repeat
				i := i+1;
				j := j+1;
				if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
					break;
				if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3)) then
					frcadoAComer := true;				
			until ((i = xFim) and (j = yFim)) or (j>=10) or (i>=10);
			i := xCom;
			j := yCom;	
			if not frcadoAComer then
			begin
				repeat
					i := i-1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
						break;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3)) then
						frcadoAComer := true;				
				until ((i = xFim) and (j = yFim)) or (j<=1) or (i<=1)
			end;
			i := xCom;
			j := yCom;
			if not frcadoAComer then
			begin
				repeat
					i := i+1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
						break;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3)) then
						frcadoAComer := true;				
				until ((i = xFim) and (j = yFim)) or (j<=1) or (i>=10)
			end;
			i := xCom;
			j := yCom;
			if not frcadoAComer then
			begin
				repeat
					i := i-1;
					j := j+1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
						break;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3)) then
						frcadoAComer := true;				
				until ((i = xFim) and (j = yFim)) or (j>=10) or (i<=1)
			end;
		end(*Fim do teste se a dama é forçada a comer*)
		

		else if (tabuleiro[xCom,yCom] = 3) or (tabuleiro[xCom,yCom] = 4) then (*Checa se a peça é uma dama*)
		begin(*Testa para ver se a dama se moveu em alguma diagonal.
		As diagonais são dadas por seus valores em um numpad.*)
			i := xCom;
			j := yCom;
			diagonal := 5;
			aliadoNoCaminho := false;
			repeat
				i := i+1;
				j := j+1;
				if ((i = xFim) and (j = yFim)) then
					diagonal := 3;(*associa o movimento a uma diagonal*)	
			until ((i = xFim )and (j = yFim)) or (i>=10) or (j>=10);
			i := xCom;
			j := yCom;
			if diagonal = 5 then(*Checa se já não foi associada a alguma diagonal*)
			begin
				repeat
					i := i-1;
					j := j+1;
					if ((i = xFim) and (j = yFim)) then
							diagonal := 1;
				until ((i = xFim) and (j = yFim)) or (j>=10) or (i<=1);	
			i := xCom;
			j := yCom
			end;
			if diagonal = 5 then
			begin
				repeat
					i := i-1;
					j := j-1;
					if ((i = xFim) and (j = yFim)) then
						diagonal := 7;
				until ((i = xFim) and (j = yFim)) or (j<=1) or (i<=1);	
			i := xCom;
			j := yCom
			end;
			if diagonal = 5 then
			begin
				repeat
					i := i+1;
					j := j-1;
					if ((i = xFim) and (j = yFim)) then
						diagonal := 9;
				until ((i = xFim) and (j = yFim)) or (j<=1) or (i>=10);
			i := xCom;
			j := yCom
			end;
			if diagonal = 5 then(*Invalida o movimento não diagonal*)
			begin		
				Erro := 'Error code: 4';
				jogadaEfetuada := false;
			end
		(*Começa a ver se a dama comeu alguma peça aliada no caminho, e cancela caso haja*)
			else if diagonal = 1 then
			begin
				repeat
					i := i-1;
					j := j+1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
						aliadoNoCaminho := true;			
				until ((i = xFim) and (j = yFim)) or (j>=10) or (i<=1);	
			end
			else if diagonal = 3 then
			begin
				repeat
					i := i+1;
					j := j+1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
						aliadoNoCaminho := true;				
				until ((i = xFim) and (j = yFim)) or (j>=10) or (i>=10);	
			end
			else if diagonal = 9 then
			begin
				repeat
					i := i+1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
						aliadoNoCaminho := true;				
				until ((i = xFim) and (j = yFim)) or (j<=1) or (i>=10);
			end
			else if diagonal = 7 then
			begin
				repeat
					i := i-1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 4)) then
						aliadoNoCaminho := true;				
				until ((i = xFim) and (j = yFim)) or (j<=1) or (i<=1)(*Termina de verificar se há aliado no caminho*)
			end;
			if aliadoNoCaminho then
			begin		
				Erro := 'Error code: 5';
				jogadaEfetuada := false;
			end
			else if diagonal = 1 then
			(*Começa a ver se a dama comeu alguma peça ou encontrou algum inimigo no caminho, e age de acordo*)
			begin
			i := xCom;
			j := yCom;
				repeat
					i := i-1;
					j := j+1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3))) and frcadoAComer then
					(*Só efetua a comilança se ele for forçado a comer. Caso contrário, será impossivel comer de qualquer forma.*)
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;
				until ((i = xFim) and (j = yFim)) or (j>=10) or (i<=1);
			end
			else if diagonal = 3 then
			begin
			i := xCom;
			j := yCom;
				repeat
					i := i+1;
					j := j+1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3))) and frcadoAComer then
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;	
				until ((i = xFim) and (j = yFim)) or (j>=10) or (i>=10);
			end
			else if diagonal = 9 then
			begin
			i := xCom;
			j := yCom;
				repeat
					i := i+1;
					j := j-1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3))) and frcadoAComer then
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;
				until ((i = xFim) and (j = yFim)) or (j<=1) or (i>=10);
			end
			else if diagonal = 7 then
			begin
			i := xCom;
			j := yCom;
				repeat
					i := i-1;
					j := j-1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[xCom,yCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[xCom,yCom] = 3))) and frcadoAComer then
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;
				until ((i = xFim) and (j = yFim)) or (i<=1) or (j<=1)
			end;(*termina de ver se a dama encontrou alguem no caminho, já efetuou as comilanças e etc.*)
			if frcadoAComer and (not comeu) then
			begin
				Erro := 'Error code: 6';
				jogadaEfetuada := false
			end;
		end(*Inicia a checagem se a peça regular é forçada a comer*)
		else if (tabuleiro[xCom,yCom] = 2) and ((tabuleiro[xCom+1,yCom+1] = 1) or (tabuleiro[xCom+1,yCom+1] = 3) or (tabuleiro[xCom-1,yCom+1] = 1) or (tabuleiro[xCom-1,yCom+1] = 3) or (tabuleiro[xCom+1,yCom-1] = 1) or (tabuleiro[xCom+1,yCom-1] = 3) or (tabuleiro[xCom-1,yCom-1] = 1) or (tabuleiro[xCom-1,yCom-1] = 3)) then(*jogador de baixo*)
			frcadoAComer:=true
		else if (tabuleiro[xCom,yCom] = 1) and ((tabuleiro[xCom+1,yCom+1] = 2) or (tabuleiro[xCom+1,yCom+1] = 4) or (tabuleiro[xCom-1,yCom+1] = 2) or (tabuleiro[xCom-1,yCom+1] = 4) or (tabuleiro[xCom+1,yCom-1] = 2) or (tabuleiro[xCom+1,yCom-1] = 4) or (tabuleiro[xCom-1,yCom-1] = 2) or (tabuleiro[xCom-1,yCom-1] = 4)) then(*jogador de cima*)
			frcadoAComer:=true;
		if tabuleiro[xCom,yCom] = 2 then (*Agora,inicia a movimentação da peça regular. Jogador de baixo*)
		begin
			if ((xFim = xCom+2) and (yFim = yCom+2)) or ((xFim = xCom-2) and (yFim = yCom+2)) or ((xFim = xCom+2) and (yFim = yCom-2)) or ((xFim = xCom-2) and (yFim = yCom-2)) then(*Jogada comendo, 2 passsos*)
			begin
				i := (xCom+xFim) div 2;
				j := (yCom+yFim) div 2;
				if (tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3) and frcadoAComer then(*comilança*)
				begin
					tabuleiro[i,j] := -1;
					comeu := true
				end
			end
			else if (not (((xFim = xCom+1) and (yFim = yCom+1)) or ((xFim = xCom-1) and (yFim = yCom+1)))) or (frcadoAComer and (not comeu)) then
			(*Se também não for uma jogada de  de 1 passo ou se era forçado a comer e não comeu.*)
			begin
				Erro := 'Error code: 7';
				jogadaEfetuada := false
			end
		end
		else if tabuleiro[xCom,yCom] = 1 then (*Segunda peça regular, jogador de cima*)
		begin
			if ((xFim = xCom+2) and (yFim = yCom+2)) or ((xFim = xCom-2) and (yFim = yCom+2)) or ((xFim = xCom+2) and (yFim = yCom-2)) or ((xFim = xCom-2) and (yFim = yCom-2)) then(*Jogada comendo, 2 passsos*)
			begin
			i := (xCom+xFim) div 2;
			j := (yCom+yFim) div 2;
				if ((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and frcadoAComer then(*comilança*)
				begin
					tabuleiro[i,j] := -1;
					comeu := true
				end
			end
		end
		else if ((not (((xFim = xCom+1) and (yFim = yCom-1)) or ((xFim = xCom-1) and (yFim = yCom-1)))) or (frcadoAComer and (not comeu))) then
			(*Se também não for uma jogada de  de 1 passo ou se era forçado a comer e não comeu.*)
		begin
			Erro := 'Error code: 8';
			jogadaEfetuada := false
		end;
		(*A partir daqui, começa a mudança do turno do jogador*)
		if turnoJogadorB and ((not comeu) and jogadaEfetuada) then
			turnoJogadorB := false
		else if (not turnoJogadorB) and ((not comeu) and jogadaEfetuada) then
			turnoJogadorB := true;(*Fim da mudança de turnos*)
		(*A partir daqui, executa o deslocamento da peça*)
		if jogadaEfetuada then
		begin
		tabuleiro[xFim,yFim] := tabuleiro[xCom,yCom];
		tabuleiro[xCom,yCom] := -1
		end;
		(*area de teste final*)
		writeln(jogadaEfetuada, comeu, turnoJogadorB);
		(*Essas são as saídas que mudam. Se jogadaEfetuada for false, nada ocorreu. Se comeu for true, voltar à jogada do mesmo jogador que acabou de jogar. as posições no tabuleiro também são mudadas, mas dependem da peça e do movimento.*)
	end;
	
	(* Procedimentos e Funcs *)
	Procedure print();
	var
		i2, j2: Integer;
	begin
		clrscr;
		For i2 := 1 to 21 do
		begin
			for j2 := 1 to 21 do
			begin
				Write(display[i2,j2]);
			end;
			WriteLn('');
		end;
	end; (* Fim de print*)
	
	Procedure inserirTabuleiro();
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
		print();
	end; (* Fim de inserirTabuleiro*)
	
	Procedure Init();
	var
		i2, j2: Integer;
	begin
		For i2 := 1 to 21 do
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
	end; (* Fim de Init *)
	
	
	(* Main *)
	begin
		Erro := 'No Error';
		Init();
		tabuleiro[10,1]:=4;
		tabuleiro[9,2]:=1;
		inserirTabuleiro();
		jogadaDamas();
		inserirTabuleiro();
		Write(erro);
		ReadLn()
	end.