-- EXERCICIO 1

DELIMITER $
CREATE TRIGGER TRG_baixar_produto after insert
on ex2_itempedido
for each row
BEGIN

update ex2_produto set quantidade = quantidade - new.quantidade
where codproduto = new.codproduto;
END
$
DELIMITER ;

INSERT INTO EX2_PEDIDO VALUES (9, 1, '2012-04-01', '00001', 400.00);
INSERT INTO EX2_ITEMPEDIDO VALUES (9, 1, 10.90, 10, 1);
INSERT INTO EX2_ITEMPEDIDO VALUES (8, 2, 389.10, 1, 3);

select * from ex2_produto;

-- EXERCICIO 2

DELIMITER $
CREATE TRIGGER TRG_LOG_CLIENTE_INSERIR after insert
on ex2_cliente
for each row
BEGIN
insert into ex2_log values(null, now(), "NOVO CLIENTE FOI INSERIDO");
END
$
DELIMITER ;

INSERT INTO EX2_CLIENTE VALUES (9, 'José Adolfo', '1998-11-05', '55555555591');

select * from ex2_log;

-- EXERCICIO 3
DELIMITER %
CREATE TRIGGER TGR_LOG_PRODUTOS_ATUALIZAR AFTER UPDATE
ON ex2_produto
for each row
begin
insert into ex2_log values(null, now(), "PRODUTO ATUALIZADO");
end
%
DELIMITER ;

select * from ex2_log;

-- EXERCICIO 4
DELIMITER $
CREATE TRIGGER TGR_LOG_ITEMPEDIDO_SEMQUANTIDADE BEFORE INSERT
ON EX2_ITEMPEDIDO
FOR EACH ROW
BEGIN
set @qtd = (select quantidade from ex2_produto where codproduto = new.codproduto);
IF(new.quantidade > @qtd) then
insert into ex2_log values (null, now(), concat("QUANTIDADE INDISPONIVEL : ","QUANTIDADE PEDIDA", new.quantidade, " - ", "QUANTIDADE EM ESTOQUE", @qtd));
END IF;
end
$
DELIMITER ;

drop trigger TGR_LOG_ITEMPEDIDO_SEMQUANTIDADE;

select * from ex2_log;
