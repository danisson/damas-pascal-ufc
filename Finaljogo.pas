program Finalchecker; (*trocadilho*)
var
i, j, i2, j2 : integer;
jogadaValidaC, jogadavalidaB, turnoJogadorB, fimDeJogo : boolean;
tabuleiroMaior : array[ 1..14 , 1..14 ] of integer;
tabuleiro : array[ 1..10 , 1..10 ] of integer;
(*Algumas variáveis são na verdade necessarias no programa principal, tipo tabuleiro e turnoJogadorB*)
begin
(*area de teste*)
	for i := 1 to 10 do(*transforma o tabuleiro*)
	begin
		for j := 1 to 10 do
		begin
			tabuleiro[i,j] := -1;
		end;
	end;
(*Fim area de teste*)
	jogadaValidaC := false;
	jogadaValidaB := false;
	fimDeJogo := false;
	for i := 3 to 12 do(*transforma o tabuleiro*)
	begin
		for j := 3 to 12 do
		begin
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
				if ((tabuleiroMaior[i+1,j+1] = -1) or (tabuleiroMaior[i+1,j-1] = -1)) then
						jogadaValidaC := true
				(*Estes 4 ifs poderiam ser resumidos em um, mas foram separados para facilitar leitura.*)
				else if (tabuleiroMaior[i+1,j+1] = 2) or (tabuleiroMaior[i+1,j+1] = 4) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaC := true
				else if (tabuleiroMaior[i-1,j+1] = 2) or (tabuleiroMaior[i-1,j+1] = 4) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaC := true
				else if (tabuleiroMaior[i+1,j-1] = 2) or (tabuleiroMaior[i+1,j-1] = 4) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaC := true
				else if (tabuleiroMaior[i-1,j-1] = 2) or (tabuleiroMaior[i-1,j-1] = 4) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaC := true
			end;
			if (tabuleiroMaior[i,j] = 2) then(*Checa se a jogada é válida caso a peça seja uma peça regular de baixo*)
			begin
				if ((tabuleiroMaior[i-1,j+1] = -1) or (tabuleiroMaior[i-1,j-1] = -1)) then
					jogadaValidaB := true
				(*Estes 4 ifs poderiam ser resumidos em um, mas foram separados para facilitar leitura.*)
				else if (tabuleiroMaior[i+1,j+1] = 3) or (tabuleiroMaior[i+1,j+1] = 1) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaB := true
				else if (tabuleiroMaior[i-1,j+1] = 3) or (tabuleiroMaior[i-1,j+1] = 1) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaB := true
				else if (tabuleiroMaior[i+1,j-1] = 3) or (tabuleiroMaior[i+1,j-1] = 1) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaB := true
				else if (tabuleiroMaior[i-1,j-1] = 2) or (tabuleiroMaior[i-1,j-1] = 1) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						jogadaValidaB := true
			end
			else if (tabuleiroMaior[i,j] = 3) then (*Checa se a jogada é valida para uma dama de cima*)
			begin
				i2 := i;
				j2 := j;
				repeat
					i2 := i2+1;
					j2 := j2+1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaC := true
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						if (tabuleiroMaior[i2+1,j2+1] = 2) or (tabuleiroMaior[i2+1,j2+2] = 4) then
							break
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						break;
				until (tabuleiro[i2,j2] = 50);
								i2 := i;
				j2 := j;
				repeat
					i2 := i2-1;
					j2 := j2+1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaC := true
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						if (tabuleiroMaior[i2-1,j2+1] = 2) or (tabuleiroMaior[i2-1,j2+2] = 4) then
							break
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						break;
				until (tabuleiro[i2,j2] = 50);
								i2 := i;
				j2 := j;
				repeat
					i2 := i2-1;
					j2 := j2-1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaC := true
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						if (tabuleiroMaior[i2-1,j2-1] = 2) or (tabuleiroMaior[i2-1,j2-2] = 4) then
							break
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						break;
				until (tabuleiro[i2,j2] = 50);
								i2 := i;
				j2 := j;
				repeat
					i2 := i2+1;
					j2 := j2-1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaC := true
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						if (tabuleiroMaior[i2+1,j2-1] = 2) or (tabuleiroMaior[i2+1,j2-2] = 4) then
							break
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						break;
				until (tabuleiro[i2,j2] = 50);
			end
			else if (tabuleiroMaior[i,j] = 4) then(*Checa se a jogada é valida para uma dama de baixo*)
			begin
				i2 := i;
				j2 := j;
				repeat
					i2 := i2+1;
					j2 := j2+1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaB := true
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						if (tabuleiroMaior[i2+1,j2+1] = 1) or (tabuleiroMaior[i2+1,j2+2] = 3) then
							break
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						break;
				until (tabuleiro[i2,j2] = 50);
								i2 := i;
				j2 := j;
				repeat
					i2 := i2-1;
					j2 := j2+1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaB := true
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						if (tabuleiroMaior[i2-1,j2+1] = 1) or (tabuleiroMaior[i2-1,j2+2] = 3) then
							break
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						break;
				until (tabuleiro[i2,j2] = 50);
				i2 := i;
				j2 := j;
				repeat
					i2 := i2-1;
					j2 := j2-1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaB := true
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						if (tabuleiroMaior[i2-1,j2-1] = 1) or (tabuleiroMaior[i2-1,j2-2] = 3) then
							break
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						break;
				until (tabuleiro[i2,j2] = 50);
								i2 := i;
				j2 := j;
				repeat
					i2 := i2+1;
					j2 := j2-1;
					if tabuleiroMaior[i2,j2] = 0 then
						jogadaValidaB := true
					else if (tabuleiroMaior[i2,j2] = 1) or (tabuleiroMaior[i2,j2] = 3) then
						if (tabuleiroMaior[i2+1,j2-1] = 1) or (tabuleiroMaior[i2+1,j2-2] = 3) then
							break
					else if (tabuleiroMaior[i2,j2] = 2) or (tabuleiroMaior[i2,j2] = 4) then
						break;
				until (tabuleiro[i2,j2] = 50);
			end
		end;
	end;				
	(*Executa as ações necessárias, pois alguém tem de fazê-las*)
	if jogadaValidaB and (not jogadaValidaC) then
		turnoJogadorB := true
	else if jogadaValidaC and (not jogadaValidaB) then
		turnojogadorB := false;
	if (not jogadaValidaB) and (not jogadaValidaC) then
		fimDeJogo := true;
	(*retornar fim de jogo*)
end.
