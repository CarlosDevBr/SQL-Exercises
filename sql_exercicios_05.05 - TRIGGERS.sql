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

# ATIVIDADE
-- EXERCICIO 1
select pe.mesa, pd.nomeproduto, pe.quantidade from pedido ped
inner join produto prod
on prod.idproduto = ped.produto_idproduto;

-- EXERCICIO 2
select ped.mesa, prod.nomeproduto, cat.nomecategoria, ped.quantidade, ped.textoadicional, ped.status
from pedido ped inner join produto prod
on ped.produto_idproduto = prod.idproduto
inner join categoria cat
on prod.categoria_idcategoria = cat.idcategoria
order by ped.mesa;

select * from pedido;
drop table movimento;

-- EXERCICIO 3
create table if not exists movimento (
dtMovimento DATE NULL,
idproduto int null,
qtde int null,
foreign key(idproduto) references produto(idproduto)
);

select * from movimento;

-- EXERCICIO 4
DELIMITER $
create trigger tgr_atualizar_novatabela after insert
on pedido
for each row
begin
insert into movimento values (current_date(), new.produto_idProduto, new.quantidade);
end; $
DELIMITER ;

drop trigger tgr_atualizar_novatabela;

insert into pedido values(2, 12, 102, 3, null, 0);
insert into pedido values(3, 15, 102, 2, null, 0);

select * from movimento;
select * from pedido;

-- EXERCICIO 5
DELIMITER $
CREATE TRIGGER tgr_verificarDiaProduto after insert
on pedido
for each row
begin
    if((select idproduto from movimento where idproduto = new.produto_idproduto) = new.produto_idproduto and 
    (select dtMovimento from movimento where idproduto = new.produto_idproduto) = current_date()) then
			update movimento set qtde = qtde + new.quantidade
			where idproduto = new.produto_idproduto;
	else
		insert into movimento values (current_date(), new.produto_idProduto, new.quantidade);
	end if;
end $
DELIMITER ;

drop trigger tgr_verificarDiaProduto;

insert into pedido values(16, 15, 100, 3, null, 0);

select * from movimento;
select * from pedido;

=====================================================================
Exemplo 2:
==================================================================
DELIMITER $$
CREATE TRIGGER atualizaMovimentoA
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
IF (select count(*) from movimento 
	 where idproduto = NEW.produto_idproduto
       and datamovimento = current_date()) > 0 THEN  -- se achar qualquer valor quer dizer que o produto já está cadastrado no dia corrente
    UPDATE movimento
       SET qtde = qtde + NEW.quantidade
	 where idproduto = NEW.produto_idproduto
       and datamovimento = current_date();
ELSE
	INSERT INTO movimento
	VALUES(current_date(),NEW.produto_idproduto,NEW.quantidade);
END IF;
END $$
DELIMITER ;

-- EXERCICIO 6

CREATE TABLE IF NOT EXISTS `bdrest`.`exProduto` (
  `idproduto` INT(11) NOT NULL,
  `nomeproduto` VARCHAR(45) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NOT NULL);
  
  drop table exproduto;

select * from exproduto;

DELIMITER $
create trigger tgr_copia_excluidos after delete
on produto
for each row
begin
insert into exproduto values(old.idproduto, old.nomeproduto, old.categoria_idcategoria);
end; $
DELIMITER ;

drop trigger tgr_copia_excluidos;

delete from produto where idproduto = 108;

select * from exproduto;




