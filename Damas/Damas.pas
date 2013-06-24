Program Damas(output);
	Uses Crt;
	var
		display: array[1..21,1..21] of Char;
		tabuleiro: array[0..10,0..10] of Integer;
		error: String;
		(*i, j: Integer;*)
	
	procedure JogadaDamas();
	var
		yCom, xCom, yFim, xFim, i, j, diagonal : integer;
		(*x e y são os valores das posições. i e j são indices. diagonal é usado na movimentação.*)
		jogadaEfetuada, aliadoNoCaminho, frcadoAComer, comeu, turnoJogadorB : boolean;(*Caso o turno seja do jogador 2, o resultado será falso*)
	begin
		(*tudo isso aqui é a area de entradas teste/debug*)
		writeln('yCom xCom yFim xFim, nessa ordem');
		readln(yCom, xCom, yFim, xFim);
			turnoJogadorB := true;
		(*area de entradas teste/debug termina aqui*)
		(*começo do codigo serio, parte de testes*)
		jogadaEfetuada := true;
		frcadoAComer := false;
		comeu := false;
		if ((yCom < 1) or (yCom > 10) or (xCom < 1) or (xCom > 10) or (yFim < 1) or (yFim > 10) or (xFim < 1) or (xFim > 10)) then
		begin		
			error := ' Erro 1 ';
			jogadaEfetuada := false;(*Checa se o Quadrado existe no Tabuleiro*)
		end
		else if (not ((turnoJogadorB) and ((tabuleiro[yCom,xCom] = 2) or (tabuleiro[yCom,xCom] = 4))) or ((not turnoJogadorB) and ((tabuleiro[yCom,xCom] = 1) or (tabuleiro[yCom,xCom] = 3)))) then
		begin		
			error := ' Erro 2 ';
			jogadaEfetuada := false;(*Checa se há peça no local de partida.*)
		end
		else if (tabuleiro[yFim,xFim] <> 0) then
		begin		
			error := ' Erro 3 ';
			jogadaEfetuada := false;(*Checa se há peça no local de final de jogada*)
		end
		else if ((tabuleiro[yCom,xCom] = 3) or (tabuleiro[yCom,xCom] = 4)) then(*Testar se irá ser forçado a comer, caso dama.*)
		begin
			i := yCom;
			j := xCom;
			repeat
				i := i+1;
				j := j+1;
				if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
					break;
				if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3)) then
					frcadoAComer := true;				
			until ((i = yFim) and (j = xFim)) or (j>=10) or (i>=10);
			i := yCom;
			j := xCom;	
			if not frcadoAComer then
			begin
				repeat
					i := i-1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
						break;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3)) then
						frcadoAComer := true;				
				until ((i = yFim) and (j = xFim)) or (j<=1) or (i<=1)
			end;
			i := yCom;
			j := xCom;
			if not frcadoAComer then
			begin
				repeat
					i := i+1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
						break;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3)) then
						frcadoAComer := true;				
				until ((i = yFim) and (j = xFim)) or (j<=1) or (i>=10)
			end;
			i := yCom;
			j := xCom;
			if not frcadoAComer then
			begin
				repeat
					i := i-1;
					j := j+1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
						break;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3)) then
						frcadoAComer := true;				
				until ((i = yFim) and (j = xFim)) or (j>=10) or (i<=1)
			end;
		(*Fim do teste se a dama é forçada a comer*)
		(*Testa para ver se a dama se moveu em alguma diagonal.
		As diagonais são dadas por seus valores em um numpad.*)
			i := yCom;
			j := xCom;
			diagonal := 5;
			aliadoNoCaminho := false;
			repeat
				i := i+1;
				j := j+1;
				if ((i = yFim) and (j = xFim)) then
					diagonal := 3;(*associa o movimento a uma diagonal*)	
			until ((i = yFim )and (j = xFim)) or (i>=10) or (j>=10);
			i := yCom;
			j := xCom;
			if diagonal = 5 then(*Checa se já não foi associada a alguma diagonal*)
			begin
				repeat
					i := i-1;
					j := j+1;
					if ((i = yFim) and (j = xFim)) then
							diagonal := 1;
				until ((i = yFim) and (j = xFim)) or (j>=10) or (i<=1);	
			i := yCom;
			j := xCom
			end;
			if diagonal = 5 then
			begin
				repeat
					i := i-1;
					j := j-1;
					if ((i = yFim) and (j = xFim)) then
						diagonal := 7;
				until ((i = yFim) and (j = xFim)) or (j<=1) or (i<=1);	
			i := yCom;
			j := xCom
			end;
			if diagonal = 5 then
			begin
				repeat
					i := i+1;
					j := j-1;
					if ((i = yFim) and (j = xFim)) then
						diagonal := 9;
				until ((i = yFim) and (j = xFim)) or (j<=1) or (i>=10);
			i := yCom;
			j := xCom
			end;
			if diagonal = 5 then(*Invalida o movimento não diagonal*)
			begin		
				error := ' Erro 4 ';
				jogadaEfetuada := false;
			end
		(*Começa a ver se a dama comeu alguma peça aliada no caminho, e cancela caso haja*)
			else if diagonal = 1 then
			begin
				repeat
					i := i-1;
					j := j+1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
						aliadoNoCaminho := true;			
				until ((i = yFim) and (j = xFim)) or (j>=10) or (i<=1);	
			end
			else if diagonal = 3 then
			begin
				repeat
					i := i+1;
					j := j+1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
						aliadoNoCaminho := true;				
				until ((i = yFim) and (j = xFim)) or (j>=10) or (i>=10);	
			end
			else if diagonal = 9 then
			begin
				repeat
					i := i+1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
						aliadoNoCaminho := true;				
				until ((i = yFim) and (j = xFim)) or (j<=1) or (i>=10);
			end
			else if diagonal = 7 then
			begin
				repeat
					i := i-1;
					j := j-1;
					if (((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 3)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 4)) then
						aliadoNoCaminho := true;				
				until ((i = yFim) and (j = xFim)) or (j<=1) or (i<=1)(*Termina de verificar se há aliado no caminho*)
			end;
			if aliadoNoCaminho then
			begin		
				error := 'Erro 5';
				jogadaEfetuada := false
			end
			else if diagonal = 1 then
			(*Começa a ver se a dama comeu alguma peça ou encontrou algum inimigo no caminho, e age de acordo*)
			begin
			i := yCom;
			j := xCom;
				repeat
					i := i-1;
					j := j+1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3))) and frcadoAComer then
					(*Só efetua a comilança se ele for forçado a comer. Caso contrário, será impossivel comer de qualquer forma.*)
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;
				until ((i = yFim) and (j = xFim)) or (j>=10) or (i<=1);
			end
			else if diagonal = 3 then
			begin
			i := yCom;
			j := xCom;
				repeat
					i := i+1;
					j := j+1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3))) and frcadoAComer then
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;	
				until ((i = yFim) and (j = xFim)) or (j>=10) or (i>=10);
			end
			else if diagonal = 9 then
			begin
			i := yCom;
			j := xCom;
				repeat
					i := i+1;
					j := j-1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3))) and frcadoAComer then
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;
				until ((i = yFim) and (j = xFim)) or (j<=1) or (i>=10);
			end
			else if diagonal = 7 then
			begin
			i := yCom;
			j := xCom;
				repeat
					i := i-1;
					j := j-1;
					if ((((tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3)) and (tabuleiro[yCom,xCom] = 4)) or (((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and (tabuleiro[yCom,xCom] = 3))) and frcadoAComer then
					begin
						comeu := true;
						tabuleiro[i,j] := -1
					end;
				until ((i = yFim) and (j = xFim)) or (i<=1) or (j<=1)
			end;(*termina de ver se a dama encontrou alguem no caminho, já efetuou as comilanças e etc.*)
			if frcadoAComer and (not comeu) then
			begin
				error := ' Erro 6 ';
				jogadaEfetuada := false
			end;
		end(*Inicia a checagem se a peça regular é forçada a comer*)
		else if (tabuleiro[yCom,xCom] = 2) and ((tabuleiro[yCom+1,xCom+1] = 1) or (tabuleiro[yCom+1,xCom+1] = 3) or (tabuleiro[yCom-1,xCom+1] = 1) or (tabuleiro[yCom-1,xCom+1] = 3) or (tabuleiro[yCom+1,xCom-1] = 1) or (tabuleiro[yCom+1,xCom-1] = 3) or (tabuleiro[yCom-1,xCom-1] = 1) or (tabuleiro[yCom-1,xCom-1] = 3)) then(*jogador de baixo*)
			frcadoAComer:=true
		else if (tabuleiro[yCom,xCom] = 1) and ((tabuleiro[yCom+1,xCom+1] = 2) or (tabuleiro[yCom+1,xCom+1] = 4) or (tabuleiro[yCom-1,xCom+1] = 2) or (tabuleiro[yCom-1,xCom+1] = 4) or (tabuleiro[yCom+1,xCom-1] = 2) or (tabuleiro[yCom+1,xCom-1] = 4) or (tabuleiro[yCom-1,xCom-1] = 2) or (tabuleiro[yCom-1,xCom-1] = 4)) then(*jogador de cima*)
			frcadoAComer:=true;
		if tabuleiro[yCom,xCom] = 2 then (*Agora,inicia a movimentação da peça regular. Jogador de baixo*)
		begin
			if ((yFim = yCom+2) and (xFim = xCom+2)) or ((yFim = yCom-2) and (xFim = xCom+2)) or ((yFim = yCom+2) and (xFim = xCom-2)) or ((yFim = yCom-2) and (xFim = xCom-2)) then(*Jogada comendo, 2 passsos*)
			begin
				i := (yCom+yFim) div 2;
				j := (xCom+xFim) div 2;
				if (tabuleiro[i,j] = 1) or (tabuleiro[i,j] = 3) and frcadoAComer then(*comilança*)
				begin
					tabuleiro[i,j] := -1;
					comeu := true
				end
			end
			else if (not (((yFim = yCom-1) and (xFim = xCom+1)) or ((yFim = yCom-1) and (xFim = xCom-1)))) or (frcadoAComer and (not comeu)) then
			(*Se também não for uma jogada de  de 1 passo ou se era forçado a comer e não comeu.*)
			begin
				error := ' Erro 7 ';
				jogadaEfetuada := false
			end
		end
		else if tabuleiro[yCom,xCom] = 1 then (*Segunda peça regular, jogador de cima*)
		begin
			if ((yFim = yCom+2) and (xFim = xCom+2)) or ((yFim = yCom-2) and (xFim = xCom+2)) or ((yFim = yCom+2) and (xFim = xCom-2)) or ((yFim = yCom-2) and (xFim = xCom-2)) then(*Jogada comendo, 2 passsos*)
			begin
			i := (yCom+yFim) div 2;
			j := (xCom+xFim) div 2;
				if ((tabuleiro[i,j] = 2) or (tabuleiro[i,j] = 4)) and frcadoAComer then(*comilança*)
				begin
					tabuleiro[i,j] := -1;
					comeu := true
				end
			end
		end
		else if (not (((yFim = yCom+1) and (xFim = xCom-1)) or ((yFim = yCom-1) and (xFim = xCom-1)))) or (frcadoAComer and (not comeu)) then
			(*Se também não for uma jogada de  de 1 passo ou se era forçado a comer e não comeu.*)
		begin
			error := ' Erro 8 ';
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
		error := 'No Error';
		tabuleiro[yFim,xFim] := tabuleiro[yCom,xCom];
		tabuleiro[yCom,xCom] := -1
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
				Write(display[i2,j2]);
			end;
			WriteLn('');
		end;
		GotoXY(27,13);
		Write('+--------+');
		GotoXY(27,14);
		Write('|',error,'|');
		GotoXY(27,15);
		Write('+--------+');
		GotoXY(1,26)
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
		error := 'Welcome!';
	end; (* Fim de Init *)
	
	
	(* Main *)
	begin
		Init();
		tabuleiro[10,1]:=2;
		tabuleiro[9,2]:=1;
		inserirTabuleiro();
		While (true) do
		begin
		jogadaDamas();
		inserirTabuleiro();
		end;
		ReadLn()
	end.
