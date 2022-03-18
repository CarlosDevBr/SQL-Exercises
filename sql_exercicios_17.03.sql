#4
delimiter &&
create procedure obterFilmes(genero varchar(60))
	begin
		select f.titulo, g.descricao, s.datahora from filme f inner join sessao s
        on f.idfilme = s.filme_idFilme
        inner join genero g
        on f.genero_idgenero = g.idgenero
        where g.descricao = genero;
    end;
&&
delimiter ;

call obterFilmes('aventura');

#5 - A
insert into genero values
        ('8','terror');

delimiter $
create procedure criarFilme(id int, titulo varchar(60), duracao int, genero int)
	begin
        insert into filme values
        (id,titulo,duracao,genero);
    end;
$
delimiter ;

call criarFilme(14,'O chamado',129,8);

#5 - B
select f.* from filme f left join sessao s
    on f.idFilme = s.filme_idFilme
    where s.filme_idFilme is null;

#5 - C
select g.* from genero g left join filme f
on g.idgenero = f.genero_idgenero
where f.genero_idgenero is null;

#6 - A
delimiter $
create procedure criarSala(id int, nome varchar(60), assentos int)
	begin
        insert into sala values
        (id,nome,assentos);
    end;
$
delimiter ;

call criarSala(10, 'HBO', 80);

#6 - B
delimiter $
create procedure criarSalaSe(id int, nome varchar(60))
    if(id < 50) then
		begin
			insert into sala values
            (id , nome , 70);
		end;
    else
		begin
			insert into sala values
            (id, nome, 90);
		end;
        end if
$ delimiter ;

call criarSalaSe(49, 'telecine');
call criarSalaSe(70, 'sbt');

#6 - C
delimiter $
create procedure criarSessaoNova(idsala int, idfilme int, dataHora datetime, qtdeVenda int)
	begin
		insert into sessao values
		(idsala, idfilme, dataHora, qtdeVenda);
    end;
$
delimiter ;

call criarSessaoNova(50, 12, '2021-08-21 23:59', 90);

select * from sessao;

-- Exemplo com IN
DELIMITER &&
CREATE PROCEDURE filmeGenero (varGenero VARCHAR(60))
BEGIN
	Select F.titulo, G.descricao, S.dataHora from sessao S 
	inner join filme F
	on S.filme_idFilme = F.idFilme 
	inner join genero G 
	on F.genero_idgenero = G.idgenero
    where G.descricao=varGenero;
END;
&&
DELIMITER ;

-- Exemplo com OUT
Exemplo out----------------------
delimiter //
CREATE PROCEDURE ObtemAtores (OUT qtdeAtores INT)
BEGIN
SELECT COUNT(*)
   INTO qtdeAtores
   FROM cinema.ator;
END
//


inout ----------------------------------
delimiter //
CREATE PROCEDURE aumento (INOUT valor DECIMAL(10,2), taxa DECIMAL(10,2))
BEGIN
	SET valor = valor +  valor * taxa /100;
END
//

-- criamos variavel valorinicial e usamos para pasar o parametro valor
-- aumento de 15%

set @variavelinicial = 20.00;
select @variavelinicial;

call aumento(@variavelinicial, 15.00);

-- verifique novamente o valor da variavel
select @variavelinicial;
delimiter ;

-- Criando função
delimiter $
create function fn_teste(a decimal(10, 2), b int)
	RETURNS int
    NO SQL
 BEGIN
	return a * b;
END$ 
delimiter ;

-- invocando a função
select fn_teste(5.2, 10) as result;


-- ATIVIDADE
#2
alter table sessao
add vlr_Ingresso decimal(4,2);

update sessao
set vlr_Ingresso = 30.00;

select * from sessao;

#3
select sessao.*, fn_teste(vlr_Ingresso, 5) as total 
from sessao
where filme_idFilme = 10;

#4
select s.sala_idsala,filme_idFilme,dataHora, fn_teste(vlr_Ingresso, 5) as total 
from sessao s
where s.sala_idsala = 50;

#5
select s.sala_idsala,filme_idFilme,dataHora, fn_teste(vlr_Ingresso, 5) as total 
from sessao s
where s.sala_idsala = 50 and filme_idFilme = 10;