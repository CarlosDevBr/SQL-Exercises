CREATE VIEW listausuario AS
SELECT nomeusuario
      ,apelidousuario
      ,nomeperfilOperacional
      ,email
      ,nomenacionalidade
      ,nomemunicipio
FROM  usuario U
join perfiloperacional PO
on U.idperfilOperacional =PO.idperfilOperacional
join perfilsocial PS
on U.idusuario =PS.idusuario
join nacionalidade N
on PS.idnacionalidade=N.idnacionalidade
join municipio M
on PS.naturalidade= M.idmunicipio;

select * from listausuario;


# ATIVIDADE 7
create VIEW usuarioPerfilSocial AS
Select nomeusuario,
		apelidousuario,
        email,
        estadocivil,
        datanascimento
From Usuario u
join perfilsocial ps
on u.idusuario = ps.idusuario;

select * from usuarioPerfilSocial;
select * from usuarioPerfilSocial where estadocivil = "solteiro";

# ATIVIDADE 8 - PT1
create view UsuarioPerfilProfissional as
select p.nomeprofissao, e.nomeempresa, c.descricaocargo,pp.* from Usuario u
join perfilprofissional pp
on u.idusuario = pp.idusuario
join cargo c
on pp.idcargo = c.idcargo
join profissao p
on pp.idprofissao = p.idprofissao
join empresa e
on pp.idempresa = e.idempresa;

select * from UsuarioPerfilProfissional;

# ATIVIDADE 8 - PT2

delimiter $
create procedure usuarioPpPorCodigo(cdgUsuario int)
begin
	select * from UsuarioPerfilProfissional where idusuario = cdgUsuario;
end;
$
delimiter ;

call usuarioPpPorCodigo(4);

# ATIVIDADE 9
CREATE VIEW usuarioPerfilAcademico as
select u.nomeusuario, c.nomecurso, pa.* from usuario u
join perfilacademico pa
on u.idusuario = pa.idusuario
join curso c
on pa.idcurso = c.idcurso;

select * from usuarioPerfilAcademico;

# ATIVIDADE 9 - PT2
delimiter $
create procedure usuarioPaPorCurso(id int)
begin
	select * from usuarioPerfilAcademico where idcurso = id;
end;
$
delimiter ;

call usuarioPaPorCurso(175);


# ATIVIDADE 2
select pp.*, u.nomeusuario from usuario u
join perfilprofissional pp
on u.idusuario = pp.idusuario
where pp.idusuario != '';

# ATIVIDADE 3
select u.idusuario, u.nomeusuario, u.apelidousuario, po.nomeperfilOperacional, ps.email, n.nomenacionalidade, m.nomemunicipio
from usuario u
inner join perfiloperacional po
on u.idperfiloperacional = po.idperfilOperacional
inner join perfilsocial ps
on u.idusuario = ps.idusuario
inner join nacionalidade n
on ps.idnacionalidade = n.idnacionalidade
inner join municipio m
on ps.naturalidade = m.idmunicipio;

delimiter $
create procedure UsuarioPorId(id int)
begin
	select u.idusuario, u.nomeusuario, u.apelidousuario, po.nomeperfilOperacional, ps.email, n.nomenacionalidade, m.nomemunicipio
	from usuario u
	inner join perfiloperacional po
	on u.idperfiloperacional = po.idperfilOperacional
	inner join perfilsocial ps
	on u.idusuario = ps.idusuario
	inner join nacionalidade n
	on ps.idnacionalidade = n.idnacionalidade
	inner join municipio m
	on ps.naturalidade = m.idmunicipio
    where u.idusuario = id;
end;
$
delimiter ;

call UsuarioPorId(4);

# ATIVIDADE 4
select u.nomeusuario, pa.*, c.nomecurso 
from usuario u
inner join perfilacademico pa
on u.idusuario = pa.idusuario
inner join curso c
on pa.idcurso = c.idcurso
where pa.idusuario != '';

delimiter $
create procedure alunoPorIdEcurso(idUser int, nomeCurso varchar(20)) # or idCurso int
begin
	select u.nomeusuario, pa.*, c.nomecurso 
	from usuario u
	inner join perfilacademico pa
	on u.idusuario = pa.idusuario
	inner join curso c
	on pa.idcurso = c.idcurso
	where pa.idusuario != '' and
    pa.idusuario = idUser and
    c.nomecurso = nomeCurso; # or c.idcurso = idCurso
end;
$
delimiter ;

call alunoPorIdECurso(1, 'Desenho industrial'); # or 169

# ATIVIDADE 5
alter table curso add valorCurso decimal(10,2);

update curso
set valorCurso = 500.00
where valorCurso = NULL;

delimiter $
create function descontoNoCurso(vlrCurso int, pctgm int)
returns decimal(10,2)
no sql
	begin
		return vlrCurso * (pctgm/100);
    end;
$
delimiter ;

select descontoNoCurso(500,50);

# ATIVIDADE 6 - PT1
delimiter $
create procedure alunoPorIdEcurso2(idUser int, nomeCurso varchar(20), desconto int) # or idCurso int
begin
	select u.nomeusuario, pa.*, c.nomecurso, descontoNocurso(c.valorCurso, desconto) as ValorCurso
	from usuario u
	inner join perfilacademico pa
	on u.idusuario = pa.idusuario
	inner join curso c
	on pa.idcurso = c.idcurso
	where pa.idusuario != '' and
    pa.idusuario = idUser and
    c.nomecurso = nomeCurso; # or c.idcurso = idCurso
end;
$
delimiter ;

call alunoPorIdEcurso2(1, 'Desenho industrial', 40);

# ATIVIDADE 6 - PT2

delimiter $
create function descontoNoCurso2(vlrCurso int, desconto int)
returns decimal(10,2)
no sql
	begin
		return vlrCurso - vlrCurso * (desconto/100);
    end;
$
delimiter ;

select descontoNoCurso2(500, 40);

