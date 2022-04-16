INSERT into usuario value
(null, "joaozinho@gmail.com", "joao", "alberto nogueira", "2002/02/02", "masculino", "joaozinho02", 1191245, null),
(null, "adalove@gmail.com", "ada", "lovelace", "1832/04/20", "feminino", "jd3sui5haif", 1150163497, null),
(null, "maria@gmail.com", "maria", "antonieta", "1954/01/08", "feminino", "dfsajne24", 120345678, null);

select * from usuario;

insert into viagem value
(null, "braganca", "campinas", "2022/04/15", "21:17", "8:15", default, default, default, 20.90, "não aceitamos fumantes e animais.", "gol", "cinza", "AJ10245DS"),
(null, "atibaia", "jundiai", "2022/12/14", "1:17", "14:02", 3, default, 0, 0.90, null, "uno", "azul", "UN15564DF"),
(null, "braganca", "são paulo", "2023/01/11", "12:17", "00:00", 2, 1, default, 170.10, "animais aceitos e fumantes tambem.", "sandero", "rosa", "AUH15456D");

select * from viagem;

insert into avaliacao value
(null, 1 , 2 , 4, "dirigiu muito devagar.", "2022/04/15", 1),
(null, 2 , 1 , 5, "muito educado, dirige muito bem.", "2022/01/15", 2),
(null, 3 , 2 , 1, "dirigiu muito rapido.", "2022/02/15", 3);

select * from avaliacao;