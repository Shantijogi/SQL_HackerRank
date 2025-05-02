select c.algorithm, q1.v,q2.v,q3.v,q4.v from coins c
join (select sum(volume) as v, coins.algorithm from transactions
left join coins on transactions.coin_code=coins.code
where month(dt) between '01' and '03' and year(dt)=2020
group by coins.algorithm) q1 on c.algorithm=q1.algorithm

join (select sum(volume) as v, coins.algorithm from transactions
left join coins on transactions.coin_code=coins.code
where month(dt) between '04' and '06' and year(dt)=2020
group by coins.algorithm) q2 on c.algorithm=q2.algorithm

join (select sum(volume) as v, coins.algorithm from transactions
left join coins on transactions.coin_code=coins.code
where month(dt) between '07' and '09' and year(dt)=2020
group by coins.algorithm) q3 on c.algorithm=q3.algorithm

join (select sum(volume) as v, coins.algorithm from transactions
left join coins on transactions.coin_code=coins.code
where month(dt) between '10' and '12' and year(dt)=2020
group by coins.algorithm) q4 on c.algorithm=q4.algorithm

group by c.algorithm
order by c.algorithm asc;