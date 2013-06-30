program Musteat;
var
i, j, i2, j2 : integer;
frcadoAComer, turnoJogadorB : boolean;(*Provavelmente recebe de entrada TurnojogadorB*)
tabuleiroMaior : array[ 1..14 , 1..14 ] of integer;
tabuleiro : array[ 1..10 , 1..10 ] of integer;
(*Algumas variáveis são na verdade necessarias no programa principal, tipo tabuleiro e turnoJogadorB*)
begin
(*area de teste*)
	turnoJogadorB := true;
	for i := 1 to 10 do(*Preenche o tabuleiro*)
	begin
		for j := 1 to 10 do
		begin
			tabuleiro[i,j] := -1;
		end;
	end;
(*Fim area de teste*)
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
			if (tabuleiroMaior[i,j] = 1) and (not turnoJogadorB) then(*Checa se a peça regular de cima é forçada a comer*)
			begin
				if (tabuleiroMaior[i+1,j+1] = 2) or (tabuleiroMaior[i+1,j+1] = 4) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						frcadoAComer := true
				else if (tabuleiroMaior[i-1,j+1] = 2) or (tabuleiroMaior[i-1,j+1] = 4) then
					if (tabuleiroMaior[i-2,j+2] = -1) then
						frcadoAComer := true
				else if (tabuleiroMaior[i+1,j-1] = 2) or (tabuleiroMaior[i+1,j-1] = 4) then
					if (tabuleiroMaior[i+2,j-2] = -1) then
						frcadoAComer := true
				else if (tabuleiroMaior[i-1,j-1] = 2) or (tabuleiroMaior[i-1,j-1] = 4) then
					if (tabuleiroMaior[i-2,j-2] = -1) then
						frcadoAComer := true
			end
			else if (tabuleiroMaior[i,j] = 2) and turnoJogadorB then(*Checa se a peça regular de baixo é forçada a comer*)
			begin
				if (tabuleiroMaior[i+1,j+1] = 3) or (tabuleiroMaior[i+1,j+1] = 1) then
					if (tabuleiroMaior[i+2,j+2] = -1) then
						frcadoAComer := true
				else if (tabuleiroMaior[i-1,j+1] = 3) or (tabuleiroMaior[i-1,j+1] = 1) then
					if (tabuleiroMaior[i-2,j+2] = -1) then
						frcadoAComer := true
				else if (tabuleiroMaior[i+1,j-1] = 3) or (tabuleiroMaior[i+1,j-1] = 1) then
					if (tabuleiroMaior[i+2,j-2] = -1) then
						frcadoAComer := true
				else if (tabuleiroMaior[i-1,j-1] = 2) or (tabuleiroMaior[i-1,j-1] = 1) then
					if (tabuleiroMaior[i-2,j-2] = -1) then
						frcadoAComer := true
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
						if (tabuleiroMaior[i2+1,j2+1] = -1) then
							frcadoAComer := true;				
				until (tabuleiro[i2,j2] = 50);
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
							if (tabuleiroMaior[i2-1,j2+1] = -1) then
							frcadoAComer := true;				
					until (tabuleiro[i2,j2] = 50);	
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
							if (tabuleiroMaior[i2-1,j2-1] = -1) then
							frcadoAComer := true;				
					until (tabuleiro[i2,j2] = 50);	
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
							if (tabuleiroMaior[i2+1,j2-1] = -1) then
							frcadoAComer := true;				
					until (tabuleiro[i2,j2] = 50);	
				end;
			end;
		end;
	end;				
end.
