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
