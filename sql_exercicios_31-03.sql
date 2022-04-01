
-- ORDEM DOS PRODUTOS POR ORDEM CRESCENTE (PREÇO) | PROCEDURE OU FUNÇÃO
DELIMITER $$
CREATE PROCEDURE produtosCrescente ()
BEGIN
	select descricaoproduto, preco_unitario from produto
	order by preco_unitario;
END;
$$
DELIMITER ;

call produtosCrescente();


-- PRODUTOS VENDIDOS EM DETERMINADA DATA | PROCEDURE OU FUNÇÃO
DELIMITER $$
CREATE PROCEDURE produtoData (dia date)
BEGIN
	select p.descricaoproduto, p.preco_unitario, pv.qtde_vendida
	from produto as p inner join produtosvendidos pv
	on p.codigoproduto = pv.produto_codigoproduto
	inner join vendas v
	on pv.vendas_codigovenda = v.codigovenda
	where v.datavenda = dia;
END;
$$
DELIMITER ;

call produtoData ('2022-03-31');


-- CLIENTE QUE MAIS COMPROU | PROCEDURE OU FUNÇÃO
-- DUVIDA: MAIS COMPROU EM VALOR OU MAIS PRODUTOS, EM UMA VENDA OU EM TODAS AS VENDAS

-- valor total por produto em uma compra
CREATE FUNCTION valorTotalProduto (id int)
	return pv.qtde_vendida * p.preco_unitario
    
-- soma das vendas organizadas por cliente
DELIMITER $$
CREATE PROCEDURE melhorCliente()
BEGIN
	-- soma das compras de cada cliente
	select c.codigocliente, sum(pv.qtde_vendida * p.preco_unitario) as total
	from cliente c left join vendas v
	on c.codigocliente = v.cliente_codigocliente
	inner join produtosvendidos pv
	on v.codigovenda = pv.vendas_codigovenda
	inner join produto p 
	on pv.produto_codigoproduto = p.codigoproduto
	group by c.codigocliente;
END ;
$$
DELIMITER ;
    
	

-- GRUPO DE PRODUTOS COM MAIS VENDAS | PROCEDURE OU FUNÇÃO

-- PRODUTO COM MAIOR LUCRO DE VENDA | PROCEDURE OU FUNÇÃO

-- SEPARAR OS CLIENTES POR MENORES E MAIORES DE IDADE (USE IF AND ELSE) | PROCEDURE OU FUNÇÃO

