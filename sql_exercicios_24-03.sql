#3
select p.codigoproduto, p.descricaoproduto, p.preco_unitario, c.nomecliente, v.datavenda
from vendas v inner join produto p
on v.codigovenda = p.vendas_codigovenda
inner join cliente c
on v.cliente_codigocliente = c.codigocliente;


#4.A
Delimiter $
create procedure exibirVendas(id int)
	BEGIN
		SELECT v.*, p.descricaoproduto FROM produto p 
        inner join vendas v
        on p.vendas_codigovenda = v.codigovenda
        where codigoproduto = id;
    END;
$
Delimiter ;

call exibirVendas(2);

#4.B

Delimiter $
create procedure exibirVProdutos(id int)
	BEGIN
		SELECT p.* , v.datavenda FROM produto p 
        inner join vendas v
        on p.vendas_codigovenda = v.codigovenda
        where v.codigovenda = id;
    END;
$
Delimiter ;

call exibirVProdutos(102);

#4.C

Delimiter $
create procedure exibirVendasDeCliente(id int)
	BEGIN
		select v.*
		from vendas v inner join cliente c
		on v.cliente_codigocliente = c.codigocliente
        where c.codigocliente = id;
    END;
$
Delimiter ;

call exibirVendasDeCliente(501);

#5
Delimiter $
create function valorVendaProduto(id int)
returns decimal(10,2)
no sql
	begin
    declare vlrProduto decimal(10,2);
    declare qnt int;
    select preco_unitario from produto where codigoproduto = id into vlrProduto;
    select quantidade from produto where codigoproduto = id into qnt;
    
    return vlrProduto * qnt;
    end;
$
delimiter ;

delimiter $
create procedure 

delimiter $

select * from produto;
select * from vendas;
select * from cliente;
select * from grupo_produto;