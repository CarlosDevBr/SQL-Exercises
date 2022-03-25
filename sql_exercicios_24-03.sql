#3
select p.codigoproduto, p.descricaoproduto, p.preco_unitario, c.nomecliente, v.datavenda
from vendas v inner join produtosVendidos pv
on v.codigovenda = pv.vendas_codigovenda
inner join produto p
on pv.produto_codigoproduto = p.codigoproduto
inner join cliente c
on v.cliente_codigocliente = c.codigocliente;


#4.A
Delimiter $
create procedure exibirVendas(id int)
	BEGIN
		SELECT v.*, p.descricaoproduto FROM produto p 
        inner join produtosVendidos pv
        on pv.produto_codigoproduto = p.codigoproduto
        inner join vendas v
        on pv.vendas_codigovenda = v.codigovenda
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
        inner join produtosVendidos pv
        on pv.produto_codigoproduto = p.codigoproduto
        inner join vendas v
        on pv.vendas_codigovenda = v.codigovenda
        where v.codigovenda = id;
    END;
$
Delimiter ;

call exibirVProdutos(100);

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
create function valorVendaProduto(vlrProduto decimal(10,2), qnt int)
returns decimal(10,2)
no sql
	begin
    return vlrProduto * qnt;
    end;
$
delimiter ;

select qtde_vendida from produtosVendidos where produto_codigoproduto = 1 group by produto_codigoproduto;

delimiter $
create procedure valorVenda(id int)
	begin
		select p.codigoproduto, p.descricaoproduto, p.preco_unitario, sum(pv.qtde_vendida) as qtde_total, sum(valorVendaProduto(p.preco_unitario, pv.qtde_vendida)) as preco_total 
        from produto p inner join ProdutosVendidos pv
        on p.codigoproduto = pv.produto_codigoproduto
        where p.codigoproduto = id;
    end;
$
delimiter ;

call valorVenda(1);