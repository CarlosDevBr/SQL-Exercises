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