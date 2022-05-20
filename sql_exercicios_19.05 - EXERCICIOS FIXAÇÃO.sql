-- 4) Crie um TRIGGER para criar um log quando não existir a quantidade do ITEMPEDIDO em estoque; 
DELIMITER //
CREATE TRIGGER TGR_LOG_ITEMPEDIDO_SEMQUANTIDADE BEFORE INSERT
ON EX2_ITEMPEDIDO FOR EACH ROW
BEGIN
	set @qtd = (select quantidade from ex2_produto where codproduto = new.codproduto);
	IF(new.quantidade > @qtd) then
	insert into ex2_log values (null, now(), concat("QUANTIDADE INDISPONIVEL : ","QUANTIDADE PEDIDA", new.quantidade, " - ", "QUANTIDADE EM ESTOQUE", @qtd));
	END IF;
end //
DELIMITER ;



select * from ex2_pedido;
select * from ex2_itempedido;

-- caso queira 11 produtos 4 que só tem 10 em estoque
INSERT INTO EX2_PEDIDO VALUES (10, 1, '2012-04-01', '00001', 400.00); 
INSERT INTO EX2_ITEMPEDIDO VALUES (10, 1, 10.90, 11, 4); 
-- verificação
select * from ex2_produto;
SELECT * FROM EX2_LOG;

-- vende mas fica com estoque negativo

-- retorne para estoque 10 do produto 4
UPDATE EX2_PRODUTO SET quantidade = 10 WHERE CODPRODUTO = 4; 

-- drop trigger anterior e estabeleça uma condição 
drop TRIGGER TGR_LOG_ITEMPEDIDO_SEMQUANTIDADE;
-- verifique numeração do log 
SELECT * FROM EX2_LOG;

-- Exercicio 4 - Uma solução é criar 2 condições 
-- porem já tem a trigger do exercicio 1 atualizando
-- drop trigger exercico 1
drop TRIGGER ex2_baixar_estoque_trigger ;

drop trigger tgr_verifica_estoque;

DELIMITER //
CREATE TRIGGER tgr_verifica_estoque 
AFTER INSERT ON EX2_ITEMPEDIDO 
FOR EACH ROW
BEGIN
	set @qtde = (select p.quantidade from EX2_PRODUTO p where p.codproduto = new.codproduto);
    if (@qtde < new.quantidade) then
		insert into EX2_LOG (data, descricao)values (current_date(),concat("A quantidade do pedido não tem em estoque.Quantidade Estoque  ", @qtde, " Quantidade Pedido - ", new.quantidade));
        -- delete ultimo insert de itens_pedidos 
		delete from EX2_ITEMPEDIDO ip where ip.codpedido = new.codpedido and ip.numeroitem = new.numeroitem;
	else 
		update EX2_PRODUTO p set p.quantidade = p.quantidade - new.quantidade where p.codproduto = new.codproduto;
	end if;
END //
DELIMITER ;

-- insere o pedido 11
INSERT INTO EX2_PEDIDO VALUES (12, 5, '2022-04-01', '00002', 530.00); 
-- insere item COM estoque
INSERT INTO EX2_ITEMPEDIDO VALUES (12, 5, 15.00, 7, 5); 

select * from EX2_produto;
select * from EX2_ITEMPEDido;
select * from EX2_LOG;


-- EXERCICIO 5
drop trigger tgr_requisicao_compra;

DELIMITER //
CREATE TRIGGER tgr_requisicao_compra
AFTER UPDATE ON ex2_produto 
FOR EACH ROW
BEGIN
	set @qtde = (select p.quantidade from EX2_PRODUTO p where p.codproduto = new.codproduto);
    set @compra = 10-@qtde;
    if (@qtde <= 5) then
		insert into ex2_requisicao_compra values (6 , new.codproduto,  current_date(), @compra);
	end if;
END //
DELIMITER ;

select * from ex2_requisicao_compra;

drop trigger tgr_log_delete_itempedido;
-- EXERCICIO 6
DELIMITER //
CREATE TRIGGER tgr_log_delete_itempedido
AFTER DELETE ON ex2_itempedido
FOR EACH ROW
BEGIN
	insert into ex2_log values(null, current_date(), concat("ITEM PEDIDO : codigo ", old.codpedido, " e numero do item: ", old.numeroitem, " DELETADO!" ));
END //
DELIMITER ;

delete from ex2_itempedido where codpedido = 12 and numeroitem = 4;