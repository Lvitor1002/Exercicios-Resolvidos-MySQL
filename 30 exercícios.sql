



create database livros;
	use livros;


create table cliente(
idcliente int primary key auto_increment,
nome varchar(20) not null,
cpf varchar(20) not null,
nascimento date not null,
email varchar(30) not null,
sexo enum('M','F') not null
);

create table endereco(
idendereco int primary key auto_increment,
rua varchar(50) not null,
bairro varchar(30) not null,
cidade varchar(30) not null,
estado char(2) not null,
id_cliente int 
);

create table telefone(
idtelefone INT PRIMARY KEY AUTO_INCREMENT, 
tipo enum('RES','COM','CEL') NOT NULL,
numero VARCHAR(15) NOT NULL,
id_cliente int
);


create table livros(
idlivros int primary key auto_increment,
nome varchar(50) not null,
publicacao date,
id_cliente int 
);


create table categorias(
idcategoria int primary key auto_increment,
generos varchar(20),
id_livros int
);

alter table endereco add constraint FK_endereco_cliente foreign key(id_cliente) references cliente(idcliente);
alter table telefone add constraint FK_telefone_cliente foreign key(id_cliente) references cliente(idcliente);
alter table livros add constraint FK_livros_cliente foreign key(id_cliente) references cliente(idcliente);
alter table categorias add constraint FK_categorias_livros foreign key(id_livros) references livros(idlivros);


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Exercício 1: Listar todos os clientes que possuem telefone celular:

select c.nome as Cliente,t.tipo
from cliente c
left join telefone t
on c.idcliente = t.id_cliente
where t.tipo = 'cel';





Exercício 2: Contar quantos clientes nasceram antes de 1980:

select count(idcliente) as 'Quantidade de clientes nascidos antes de 1980' from cliente where nascimento < '1980-01-01';




Exercício 3: Encontrar a média de idade dos clientes:

select round(avg(year(current_date) - year(nascimento)),2) as 'Média das idades' from cliente;





Exercício 4: Listar os clientes com endereço na cidade 'São Paulo':

select c.nome as Cliente, e.cidade as Cidade 
from cliente c
left join endereco e
on c.idcliente = e.id_cliente 
where e.cidade like '%são paulo%';





Exercício 5: Contar quantos livros cada cliente possui:


select c.nome as Clientes, count(l.idlivros) as 'Quantidade de livros' 
from cliente c
left join livros l 
on c.idcliente = l.id_cliente
group by(idcliente);




Exercício 6: Encontrar o cliente mais velho:


select nome as Cliente, floor(datediff(current_date(), nascimento) / 365.25) as 'Maior idade'
from cliente
where nascimento = (select min(nascimento) from cliente);





Encontrar o cliente mais novo: 

select nome as Cliente, floor(datediff(current_date(), nascimento) / 365.25) as 'Cliente mais novo'
from cliente 
where nascimento = (select max(nascimento) from cliente);




Exercício 7: Listar os livros publicados antes de 1880:

select nome as Livros, publicacao as Ano from livros where publicacao < '1880-01-01' order By(publicacao) desc;





Exercício 8: Calcular o número total de telefones cadastrados:

select count(idtelefone) as 'Total de telefones' from telefone;




Exercício 9: Encontrar o cliente que possui o maior número de telefones cadastrados:

select c.nome as Cliente, count(t.idtelefone) as Quantidade_Telefone
from cliente c 
left join telefone t 
on c.idcliente = t.id_cliente
group by c.idcliente order by Quantidade_Telefone desc limit 1;






Exercício 10: Listar os clientes com o mesmo CPF:

select c1.nome as Clientes1, c1.cpf as CPF1, c2.nome as Clientes2, c2.cpf as CPF2 
from cliente c1 
inner join cliente c2 
on c1.idcliente != c2.idcliente
where c1.CPF = c2.CPF;





Exercício 11: Listar os clientes que possuem livros publicados antes de 1852:

select c.nome as Clientes, l.nome as Livros, l.publicacao as Ano 
from cliente c  
inner join livros l
on c.idcliente = l.id_cliente
where l.publicacao < '1852-01-01' order by publicacao desc;





Exercício 12: Calcular a quantidade média de telefones por cliente:

select AVG(total) AS 'Quantidade média de telefones' from (select c.idcliente, COUNT(t.idtelefone) AS total 
from cliente c 
inner JOIN telefone t 
ON c.idcliente = t.id_cliente
GROUP BY c.idcliente) AS subquery;




Exercício 13: Encontrar os clientes que não possuem endereço cadastrado:

select c.nome as Clientes, e.* 
from cliente c 
left join endereco e 
on c.idcliente = e.id_cliente 
where c.idcliente not in (select id_cliente from endereco); 





Exercício 14: Listar os livros com mais de uma categoria associada:

select l.nome as Livros, count(c.generos) as Categorias
from livros l
left join categorias c
on l.idlivros = c.id_livros 
group by l.idlivros having Categorias >= 1;




Exercício 15: Calcular a idade média dos clientes por sexo:

select sexo as 'Sexo do Cliente', round(avg(year(current_date) - year(nascimento))) as 'Idade Média dos Clientes'
from cliente
group by sexo;




Exercício 16: Encontrar os clientes que não possuem telefone cadastrado:

select c.nome as Clientes, t.numero as Telefones
from cliente c
left join telefone t
on c.idcliente = t.id_cliente 
where c.idcliente not in(select id_cliente from telefone);



Exercício 17: Listar os livros com mais de 10 anos de publicação:

select nome as Livro, round(year(current_date) - year(publicacao)) as Anos
from livros
having Anos > 10
order by Anos asc;



Exercício 18: Contar quantos clientes são do sexo masculino e têm mais de 40 anos:

select sexo, 
	   count(sexo) as 'Quantidade de sexo', 
	   SUM(nascimento < DATE_SUB(CURDATE(), INTERVAL 40 YEAR)) AS `Maiores de 40 anos`
from cliente
where sexo = 'M'
group by sexo;


Exercício 19: Encontrar os clientes que possuem mais de um endereço cadastrado:

select c.nome as Clientes, count(e.id_cliente) as QTD_endereco 
from cliente c
left join endereco e
on c.idcliente = e.id_cliente
group by(c.nome) having QTD_endereco > 1;





Exercício 20: Calcular o número total de categorias de livros diferentes:

select count(distinct idcategoria) as 'Total de categorias' from categorias; 




Exercício 21: Listar os clientes que possuem todos os tipos de telefone (RES, COM e CEL):

 select c.nome as Clientes, t.tipo as Tipos 
 from cliente c
 inner join telefone t
 on c.idcliente = t.id_cliente where t.tipo in ('res','com','cel') order by tipos asc;




Exercício 22: Encontrar o cliente com a maior quantidade de livros publicados:

select c.nome as Cliente 
from cliente c
join(
	select id_cliente, count(*) as Quantidade_Livros
	from livros 
	group by id_cliente
	order by Quantidade_Livros desc limit 1
	) as subquery
on c.idcliente = subquery.id_cliente;






Exercício 23: Listar os clientes que possuem livros em todas as categorias disponíveis:

select c.nome as Clientes, l.nome as Livros, ca.generos as Categorias
from cliente c
inner join livros l 
on c.idcliente = l.id_cliente 
inner join categorias ca
on l.idlivros = ca.id_livros;




Exercício 24: Encontrar os clientes que têm a mesma data de nascimento:

select c1.nome as Cliente1, c2.nome as Cliente2, c2.nascimento as 'Data de Nascimento'
from cliente c1 
left join cliente c2
on c1.idcliente != c2.idcliente
where c1.nascimento = c2.nascimento;




Exercício 25: Calcular o número total de livros publicados por ano:

select publicacao as 'Ano de lançamento', count(idlivros) as 'Quantidade de livros por ano' 
from livros 
group by(publicacao) 
order by(publicacao) asc;




Exercício 26: Listar os clientes que possuem livros publicados em um ano bissexto:

select distinct c.nome as Clientes, l.nome as Livros, year(l.publicacao) as 'Lançamento no ano bissexto:'
from cliente c 
inner join livros l
on c.idcliente = l.id_cliente
where year(l.publicacao) % 4 = 0 and (year(l.publicacao) % 100 != 0 or year(l.publicacao) % 400 = 0); 





Exercício 27: Encontrar os clientes que não possuem livros cadastrados:

select c.nome as Clientes, ifnull(l.nome,'VAZIO') as Livros  
from cliente c
left join livros l
on c.idcliente = l.id_cliente 
where c.idcliente not in(select id_cliente from livros);





Exercício 28: Listar os clientes que possuem telefone residencial e comercial, mas não celular:

select c.nome as Cliente, t.tipo as Telefones
from cliente c
left join telefone t
on c.idcliente = t.id_cliente
where t.tipo in('res','com') and t.tipo not in('cel') order by Telefones;





Exercício 29: Calcular a diferença de idade entre o cliente mais novo e o cliente mais velho:

select  
max(year(current_date) - year(nascimento)) - 
min(year(current_date) - year(nascimento)) as 'Diferença de idades' 
from cliente;



select c1.nome as Cliente1, c2.nome as Cliente2, e1.rua as Rua
from cliente c1
inner join cliente c2
on c1.idcliente < c2.idcliente
inner join endereco e1
on c1.idcliente = e1.id_cliente
inner join endereco e2
on c2.idcliente = e2.id_cliente
where e1.rua = e2.rua;