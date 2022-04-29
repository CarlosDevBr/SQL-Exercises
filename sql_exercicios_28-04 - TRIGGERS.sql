#EXERCICIO 1

create database mercado;
use mercado;

CREATE TABLE produtos (
referencia VARCHAR(3) PRIMARY KEY,
descricao VARCHAR(50) UNIQUE,
estoque INT NOT NULL
);

INSERT INTO Produtos VALUES ('1', 'Lasanha', 10);
INSERT INTO Produtos VALUES ('2', 'Morango', 5);
INSERT INTO Produtos VALUES ('3', 'Farinha', 15);

CREATE TABLE itensvenda (
venda INT,
produto VARCHAR(3),
quantidade INT
);

select * from produtos;
select * from itensvenda;

DELIMITER //
CREATE TRIGGER tgr_itensvenda_insert AFTER INSERT
ON itensvenda
FOR EACH ROW
BEGIN
UPDATE produtos SET estoque = estoque - NEW.quantidade
WHERE referencia = NEW.produto;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER tgr_itensvenda_delete AFTER DELETE
ON itensvenda
FOR EACH ROW
BEGIN
UPDATE produtos SET estoque = estoque + OLD.quantidade
WHERE referencia = OLD.produto;
END //
DELIMITER ; 

INSERT INTO itensvenda VALUES (1, '1',3);
INSERT INTO itensvenda VALUES (1, '2',1);
INSERT INTO itensvenda VALUES (1, '3',5);

DELETE FROM itensvenda WHERE venda = 1 AND produto = '1';



#EXERCICIO 2
insert into produto value
(1, 10.00, "telha", 100),
(2, 5.50, "cimento", 100),
(3, 10.20, "tinta", 100);

DELIMITER $
CREATE TRIGGER tgr_itenspedidos_insert after insert
on itempedido
for each row
begin
update produto set estoque_atual = estoque_atual - new.qtde
where cod = new.cod_prod;
end $
DELIMITER ;

DELIMITER $
CREATE TRIGGER tgr_itenspedido_delete after delete
on itempedido
for each row
begin
update produto set estoque_atual = estoque_atual + old.qtde
where cod = old.cod_prod;
end $
DELIMITER ;

insert into itempedido values (1,1,10,10.00,null,1);
delete from itempedido where id_item = 1 and cod_prod = 1;


select * from itempedido;
select * from produto;

Create trigger ins_sum before insert on account
for each row set sum=sum+NEW.total; 


